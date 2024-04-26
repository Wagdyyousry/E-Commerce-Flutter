import 'package:ecommerce/data/controllers/home/products_controller.dart';
import 'package:ecommerce/data/models/brand_model.dart';
import 'package:ecommerce/presentation/widgets/common/custom_listview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/helpers/helpers.dart';
import '../../../../../utils/validators/validators.dart';
import '../../../../widgets/common/custom_appbar.dart';
import '../../../../widgets/common/custom_dropdown_menu.dart';
import '../../../../widgets/common/custom_rounded_container.dart';
import '../../../../widgets/common/custom_rounded_image.dart';
import '../../../display_image_screen.dart';

class UploadProductsScreen extends StatefulWidget {
  const UploadProductsScreen({super.key});

  @override
  State<UploadProductsScreen> createState() => _UploadProductsScreenState();
}

class _UploadProductsScreenState extends State<UploadProductsScreen> {
  List<XFile> productImages = [];
  final controller = ProductsController.instance;

  @override
  Widget build(BuildContext context) {
    final isDark = MyHelpers.isDarkMode(context);
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text("Upload Products"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
        child: Column(
          children: [
            // -- Choose Product Category and Brand
            Row(
              children: [
                // -- Brand Menu
                Expanded(
                  child: FutureBuilder<List<BrandModel>>(
                    future: controller.getAllBrands(),
                    builder: (context, snapshot) {
                      List<String> brandsNames = [];
                      snapshot.data?.forEach(
                          (element) => brandsNames.add(element.brandName!));
                      return CustomDropDownMenu(
                        hint: "Brand",
                        onChanged: (brandName) {
                          int index = brandsNames.indexOf(brandName!);
                          controller.productBrand = snapshot.data?[index];
                        },
                        items: brandsNames,
                      );
                    },
                  ),
                ),
                const SizedBox(width: MySizes.spaceBtwItems),

                // -- Category Menu
                Expanded(
                  child: CustomDropDownMenu(
                    items: const [
                      "Best Offer",
                      "Men",
                      "Women",
                      "Children",
                      "Grocery",
                      "Sports",
                    ],
                    hint: "Category",
                    onChanged: (category) =>
                        controller.productCategory = category!,
                  ),
                ),
              ],
            ),
            const SizedBox(height: MySizes.spaceBtwItems),

            // -- Choose Product Image
            CustomRoundedContainer(
                width: double.infinity,
                height: 120,
                child: productImages.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Text(
                              "Choose Product Images",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: MySizes.spaceBtwItems),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5)),
                                color: isDark ? Colors.black : Colors.white,
                              ),
                              child: IconButton(
                                onPressed: () async =>
                                    await pickImagesFromGallery(),
                                icon: const Icon(
                                  Icons.add_photo_alternate,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: CustomListView(
                          separatorBuilder: (c, i) =>
                              const SizedBox(width: MySizes.spaceBtwItems / 2),
                          itemCount: controller.productImages.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => CustomRoundedImage(
                            height: 120,
                            width: 100,
                            onPressed: () => Get.to(() => DispalyImageScreen(
                                  image: controller.productImages[index].path,
                                  isfile: true,
                                )),
                            enableBorder: true,
                            borderColor: Colors.grey,
                            isFileImage: true,
                            boxFit: BoxFit.fill,
                            image: controller.productImages[index].path,
                          ),
                        ),
                      )),

            const SizedBox(height: MySizes.spaceBtwSections),

            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  // -- Title
                  TextFormField(
                    controller: controller.title,
                    validator: (email) =>
                        MyValidators.validateEmpty(email, "Title"),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      prefixIcon: Icon(Icons.title),
                      labelText: MyTexts.title,
                    ),
                  ),
                  const SizedBox(height: MySizes.spaceBtwInputFields),

                  // -- Product Size and Colors
                  Row(
                    children: [
                      // -- Product Size
                      Expanded(
                        flex: 7,
                        child: CustomDropDownMenu(
                          selectedItems: controller.selectedSizes,
                          hint: "Size",
                          onChanged: (size) {
                            setState(() {
                              if (controller.selectedSizes.contains(size)) {
                                controller.selectedSizes.remove(size);
                              } else {
                                controller.selectedSizes.add(size!);
                              }
                            });
                          },
                          items: MyTexts.productSizes(),
                        ),
                      ),
                      const SizedBox(width: MySizes.spaceBtwItems),

                      // -- Product Colors
                      Expanded(
                        flex: 10,
                        child: CustomDropDownMenu(
                          selectedItems: controller.selectedColors,
                          items: MyTexts.productColors,
                          hint: "Color",
                          onChanged: (color) {
                            setState(() {
                              if (controller.selectedColors.contains(color)) {
                                controller.selectedColors.remove(color);
                              } else {
                                controller.selectedColors.add(color!);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems),

                  // -- Discount
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        MyValidators.validateEmpty(value, "Discount"),
                    controller: controller.discount,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      prefixIcon: Icon(Iconsax.discount_shape),
                      suffixIcon: Icon(Icons.percent),
                      labelText: MyTexts.discount,
                    ),
                  ),
                  const SizedBox(height: MySizes.spaceBtwInputFields),

                  // -- Price And Quantity
                  Row(
                    children: [
                      // -- Product Price
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              MyValidators.validateEmpty(value, "Price"),
                          controller: controller.price,
                          expands: false,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.attach_money_rounded),
                            labelText: MyTexts.price,
                          ),
                        ),
                      ),
                      const SizedBox(width: MySizes.spaceBtwItems),

                      // -- Product Quantity
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              MyValidators.validateEmpty(value, "Quantity"),
                          controller: controller.quantity,
                          expands: false,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.add_shopping_cart_rounded),
                            labelText: MyTexts.quantity,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: MySizes.spaceBtwInputFields),

                  // -- Description
                  TextFormField(
                    validator: (value) =>
                        MyValidators.validateEmpty(value, "Description"),
                    controller: controller.discreption,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      prefixIcon: Icon(Icons.description),
                      labelText: MyTexts.discreption,
                    ),
                  ),
                  const SizedBox(height: MySizes.spaceBtwSections),

                  // -- Add button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.addNewProduct();
                        emptyTheFields();
                      },
                      child: const Text(MyTexts.addProduct),
                    ),
                  ),
                  const SizedBox(height: MySizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickImagesFromGallery() async {
    final pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages.isNotEmpty) {
      setState(() {
        productImages = pickedImages;
        controller.productImages = pickedImages;
      });
    }
  }

  // -- Empty All Fields
  void emptyTheFields() {
    setState(() {
      controller.price.text = "";
      controller.quantity.text = "";
      controller.discount.text = "";
      controller.discreption.text = "";
      controller.title.text = "";
      controller.productImages = [];
      controller.productImagesUrls = [];
      controller.selectedColors = [];
      controller.selectedSizes = [];
      productImages = [];
    });
  }
}
