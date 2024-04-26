import 'package:ecommerce/data/controllers/home/products_controller.dart';
import 'package:ecommerce/presentation/screens/navigation_menu/shop/sub_shop/brand_products_screen.dart';
import 'package:ecommerce/presentation/widgets/navigation_menu/shop/brand_card.dart';
import 'package:ecommerce/presentation/widgets/common/custom_gridview.dart';
import 'package:ecommerce/presentation/widgets/common/custom_appbar.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatefulWidget {
  const AllBrandsScreen({super.key});

  @override
  State<AllBrandsScreen> createState() => _AllBrandsScreenState();
}

class _AllBrandsScreenState extends State<AllBrandsScreen> {
  @override
  Widget build(BuildContext context) {
    final productsController = ProductsController.instance;
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("All Brands"),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
        child: CustomGridView(
            itemCount: productsController.allBrandList.length,
            mainAxisExtent: 55,
            itemBuilder: (context, index) {
              final brand = productsController.allBrandList[index];
              return BrandCard(
                brand: brand,
                onPressed: () =>
                    Get.to(() => BrandProductsScreen(brandModel: brand)),
              );
            }),
      ),
    );
  }
}
