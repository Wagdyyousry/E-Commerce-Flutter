import '../../../../widgets/navigation_menu/home/product_card_vertical.dart';
import '../../../../../data/controllers/home/products_controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../widgets/common/custom_appbar.dart';
import '../../../../widgets/common/custom_dropdown_menu.dart';
import '../../../../widgets/common/custom_gridview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'details_screen.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    final productController = ProductsController.instance;
    final allProducts = productController.allProductsList.value.obs;
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("All Products"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
          child: Column(
            children: [
              // -- Filter
              CustomDropDownMenu(
                hint: "Choose Filter",
                onChanged: (filter) {
                  allProducts.value = [];
                  if (filter == "Name") {
                    for (var product in productController.filterProductName) {
                      allProducts.add(product);
                    }
                  } else if (filter == "Discount") {
                    for (var product
                        in productController.filterProductDiscount) {
                      allProducts.add(product);
                    }
                  } else if (filter == "Higher Price") {
                    for (var product
                        in productController.filterProductHighPrice) {
                      allProducts.add(product);
                    }
                  } else if (filter == "Lower Price") {
                    for (var product
                        in productController.filterProductLowPrice) {
                      allProducts.add(product);
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

              const SizedBox(height: MySizes.spaceBtwSections / 2),
              Obx(
                () => CustomGridView(
                  itemCount: allProducts.length,
                  itemBuilder: (context, index) => ProductCardVertical(
                    productData: allProducts[index],
                    onPressed: () => Get.to(
                      () => DetailsScreen(
                        productData: allProducts[index],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
