import '../../../../../data/controllers/home/products_controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helpers.dart';
import '../../../../widgets/common/custom_appbar.dart';
import '../../../../widgets/common/custom_rounded_container.dart';
import '../../../../widgets/common/custom_rounded_image.dart';
import 'package:ecommerce/data/models/brand_model.dart';
import 'package:ecommerce/utils/constants/my_images.dart';
import 'package:ecommerce/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../display_image_screen.dart';

class UploadBrandsScreen extends StatefulWidget {
  const UploadBrandsScreen({super.key});

  @override
  State<UploadBrandsScreen> createState() => _UploadBrandsScreenState();
}

class _UploadBrandsScreenState extends State<UploadBrandsScreen> {
  Rx<String> brandImage = "".obs;
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isDark = MyHelpers.isDarkMode(context);
    ProductsController controller = Get.put(ProductsController());
    controller.getAllBrands();
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text("Upload Brands"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: MySizes.spaceBtwSections),

            // -- Brand Image
            CustomRoundedContainer(
              width: 120,
              height: 120,
              child: Stack(
                children: [
                  Obx(
                    () => CustomRoundedImage(
                      height: 120,
                      width: 120,
                      onPressed: () => Get.to(
                          () => DispalyImageScreen(image: brandImage.value)),
                      enableBorder: true,
                      isFileImage: brandImage.value != "" ? true : false,
                      borderColor: Colors.grey,
                      image: brandImage.value != ""
                          ? brandImage.value
                          : MyImages.onBordingScreenImage5,
                      isNetworkImage: false,
                      isSvg: false,
                    ),
                  ),

                  // -- Edit button
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(MySizes.cardRadiusLg),
                          bottomRight: Radius.circular(MySizes.cardRadiusLg),
                        ),
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        color: isDark ? Colors.black : Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () async => await pickImageFromGallery(),
                        icon: const Icon(
                          Icons.add,
                          size: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            // -- Brand Name
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                label: Text("Brand Name"),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwSections * 1.5),

            // -- Add Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async => await uploadBrand(),
                child: const Text("Add"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final croppedImage = await MyHelpers.pickImageFromGallery(true);
    setState(() {
      brandImage.value = croppedImage;
    });
  }

  Future<void> uploadBrand() async {
    // -- Product Id
    String brandId = DateTime.now().millisecondsSinceEpoch.toString();
    BrandModel newBrand = BrandModel(
      brandId: brandId,
      brandImageUri: brandImage.value,
      brandName: nameController.text,
    );
    ProductsController controller = ProductsController.instance;
    controller.getAllBrands();

    if (nameController.text.isEmpty) {
      MyLoaders.warningSnackBar(message: "You Have to Add Brand Name");
    }
    if (brandImage.value == "") {
      MyLoaders.warningSnackBar(message: "You Have to Add Brand Image");
    } else {
      await controller.uploadNewBrand(newBrand);
      setState(() {
        brandImage.value == "";
        nameController.text = "";
      });
    }
  }
}
