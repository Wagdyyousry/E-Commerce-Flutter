import 'package:ecommerce/data/controllers/home/products_controller.dart';
import 'package:ecommerce/data/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/sizes.dart';
import '../../common/custom_gridview.dart';
import '../../common/custom_header.dart';
import '../home/product_card_vertical.dart';
import 'brand_package.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, this.brandZara, this.brandNike});
  final BrandModel? brandNike, brandZara;

  @override
  Widget build(BuildContext context) {
    final productController = ProductsController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(height: MySizes.spaceBtwItems),

              // -- Viewing Two of the top brands
              BrandPackage(brand: brandNike),
              const SizedBox(height: MySizes.spaceBtwItems),

              BrandPackage(brand: brandZara),
              const SizedBox(height: MySizes.spaceBtwSections),

              // -- Header title
              CustomHeader(
                title: "You Might Like",
                showTextButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: MySizes.spaceBtwItems),

              // -- Items you might like
              Obx(
                () => CustomGridView(
                  itemCount: productController.allProductsList.length,
                  itemBuilder: (context, index) => ProductCardVertical(
                      productData: productController.allProductsList[index]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
