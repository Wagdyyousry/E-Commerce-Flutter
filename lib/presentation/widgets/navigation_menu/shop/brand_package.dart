import 'package:ecommerce/presentation/screens/navigation_menu/shop/sub_shop/brand_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/controllers/home/products_controller.dart';
import '../../../../data/models/brand_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../screens/navigation_menu/shop/sub_shop/details_screen.dart';
import '../../common/custom_rounded_container.dart';
import '../../common/custom_rounded_image.dart';
import 'brand_card.dart';

class BrandPackage extends StatelessWidget {
  const BrandPackage({super.key, this.brand});
  final BrandModel? brand;

  @override
  Widget build(BuildContext context) {
    final productController = ProductsController.instance;
    final product1 = productController.getAllBrandProduct(brand!.brandId!)[0];
    final product2 = productController.getAllBrandProduct(brand!.brandId!)[1];
    final product3 = productController.getAllBrandProduct(brand!.brandId!)[2];
    return CustomRoundedContainer(
      onTap: () => Get.to(() => BrandProductsScreen(brandModel: brand)),
      borderColor: Colors.grey,
      enableBorder: true,
      padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          // -- The Brand with it's product count
          BrandCard(brand: brand!, enableBorder: false),

          // -- Top 3 product of the brand
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRoundedImage(
                borderColor: Colors.grey.withOpacity(0.6),
                borderRadius: 10,
                height: 80,
                width: 80,
                isNetworkImage: true,
                boxFit: BoxFit.fill,
                image: product1.productImages![0],
                onPressed: () =>
                    Get.to(() => DetailsScreen(productData: product1)),
              ),
              CustomRoundedImage(
                borderColor: Colors.grey.withOpacity(0.4),
                borderRadius: 10,
                height: 80,
                width: 80,
                isNetworkImage: true,
                boxFit: BoxFit.fill,
                image: product2.productImages![0],
                onPressed: () =>
                    Get.to(() => DetailsScreen(productData: product2)),
              ),
              CustomRoundedImage(
                borderColor: Colors.grey.withOpacity(0.6),
                borderRadius: 10,
                height: 80,
                width: 80,
                boxFit: BoxFit.fill,
                isNetworkImage: true,
                image: product3.productImages![0],
                onPressed: () =>
                    Get.to(() => DetailsScreen(productData: product3)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
