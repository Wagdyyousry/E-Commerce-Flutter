import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/controllers/home/products_controller.dart';
import '../../../../../data/models/brand_model.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../widgets/common/custom_appbar.dart';
import '../../../../widgets/common/custom_dropdown_menu.dart';
import '../../../../widgets/common/custom_gridview.dart';
import '../../../../widgets/navigation_menu/home/product_card_vertical.dart';
import '../../../../widgets/navigation_menu/shop/brand_card.dart';
import 'details_screen.dart';

class BrandProductsScreen extends StatefulWidget {
  const BrandProductsScreen({super.key, this.brandModel});
  final BrandModel? brandModel;

  @override
  State<BrandProductsScreen> createState() => _BrandProductsScreenState();
}

class _BrandProductsScreenState extends State<BrandProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final productController = ProductsController.instance;
    productController.filterBrandProducts(widget.brandModel!.brandId!);
    final brandProducts =
        productController.getAllBrandProduct(widget.brandModel!.brandId!).obs;
    return Scaffold(
      appBar:  CustomAppBar(
        title: Text("Brand ${widget.brandModel!.brandName}"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
        child: Column(
          children: [
            // -- Brand logo
            BrandCard(brand: widget.brandModel),
            const SizedBox(height: MySizes.spaceBtwItems),

            // -- Filter the products
            CustomDropDownMenu(
              hint: "Choose Filter",
              onChanged: (filter) {
                brandProducts.value = [];
                if (filter == "Name") {
                  for (var product in productController.filterBrandName) {
                    brandProducts.add(product);
                  }
                } else if (filter == "Discount") {
                  for (var product in productController.filterBrandDiscount) {
                    brandProducts.add(product);
                  }
                } else if (filter == "Higher Price") {
                  for (var product in productController.filterBrandHighPrice) {
                    brandProducts.add(product);
                  }
                } else if (filter == "Lower Price") {
                  for (var product in productController.filterBrandLowPrice) {
                    brandProducts.add(product);
                  }
                }
              },
              items: const [
                "Name",
                "Discount",
                "Newest",
                "Higher Price",
                "Lower Price",
              ],
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            // -- Brand Product

            Obx(
              () => CustomGridView(
                itemCount: brandProducts.length,
                itemBuilder: (c, i) => ProductCardVertical(
                  productData: brandProducts[i],
                  onPressed: () => Get.to(
                      () => DetailsScreen(productData: brandProducts[i])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
