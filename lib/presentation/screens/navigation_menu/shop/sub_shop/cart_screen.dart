import 'package:ecommerce/presentation/widgets/common/custom_rounded_image.dart';
import 'package:ecommerce/utils/constants/my_images.dart';

import '../../../../../data/controllers/database_controller.dart';
import '../../../../../data/controllers/home/products_controller.dart';
import '../../../../../utils/helpers/helpers.dart';
import '../../../../widgets/common/custom_listview.dart';
import '../../../../widgets/navigation_menu/shop/cart_item.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../widgets/common/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final dbController = DatabaseController.instance;
    final productController = ProductsController.instance;
    return Scaffold(
      appBar: const CustomAppBar(title: Text("Cart"), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
        child: dbController.allCartProducts.isNotEmpty
            ? Obx(
                () => CustomListView(
                  itemCount: dbController.allCartProducts.length,
                  separatorBuilder: (c, i) => const SizedBox(height: 10),
                  itemBuilder: (context, index) =>
                      CartItem(product: dbController.allCartProducts[index]),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cart empty !!, Add some product",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: MySizes.spaceBtwItems),
                    CustomRoundedImage(
                      image: MyImages.logo2,
                      isNetworkImage: false,
                      width: MyHelpers.getResponsiveWidth(200),
                      height: MyHelpers.getResponsiveHeight(170),
                    )
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Container(
        height: MyHelpers.getResponsiveHeight(80),
        padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
        child: ElevatedButton(
          onPressed: () async {
            if (dbController.allCartProducts.isNotEmpty) {
              await productController
                  .addUserOrder(dbController.allCartProducts);
              await dbController.removeAllCartProduct();
            }
            Get.to(() => const CheckoutScreen());
          },
          child: Obx(
            () => Text(
              "Order ( \$${productController.getProductsPrice(dbController.allCartProducts).toStringAsFixed(2)} )",
            ),
          ),
        ),
      ),
    );
  }
}
