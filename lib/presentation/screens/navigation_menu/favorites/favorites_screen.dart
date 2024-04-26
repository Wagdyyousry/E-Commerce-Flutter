import 'package:ecommerce/data/controllers/database_controller.dart';
import 'package:ecommerce/presentation/screens/navigation_menu/shop/sub_shop/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../widgets/common/custom_appbar.dart';
import '../../../widgets/common/custom_gridview.dart';
import '../../../widgets/navigation_menu/home/product_card_vertical.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final dbController = DatabaseController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Favorites",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Obx(
            () => CustomGridView(
              itemCount: dbController.allFavoritesProducts.length,
              itemBuilder: (context, index) {
                final product = dbController.allFavoritesProducts[index];
                return ProductCardVertical(
                  onPressed: () =>
                      Get.to(() => DetailsScreen(productData: product)),
                  productData: product,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
