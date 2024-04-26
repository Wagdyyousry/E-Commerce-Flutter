import 'package:ecommerce/presentation/widgets/navigation_menu/shop/orders_price.dart';

import '../../../../../data/controllers/home/products_controller.dart';
import '../../../../../utils/constants/my_images.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../widgets/common/custom_appbar.dart';
import '../../../../widgets/common/custom_circular_image.dart';
import '../../../../widgets/common/custom_header.dart';
import '../../../../widgets/common/custom_listview.dart';
import '../../../../widgets/common/custom_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/navigation_menu/shop/order_view.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final productController = ProductsController.instance;
    final fullPrice =
        productController.getProductsPrice(productController.userOrderList);
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("CheckOut Products"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              // -- product
              CustomListView(
                scroll: false,
                itemCount: productController.userOrderList.length,
                separatorBuilder: (c, i) =>
                    const SizedBox(height: MySizes.spaceBtwItems / 2),
                itemBuilder: (context, index) {
                  return OrderView(
                      order: productController.userOrderList[index]);
                },
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              // -- Promo code
              CustomRoundedContainer(
                padding: const EdgeInsets.all(MySizes.defaultSpace / 3),
                enableBorder: true,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Have a promo code ? Enter here",
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text("Apply"))
                  ],
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              // -- total Price
              CustomRoundedContainer(
                padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
                enableBorder: true,
                child: Column(
                  children: [
                    // -- Calc All Total price
                    const OrderPrice(),

                    const Divider(),
                    const SizedBox(height: MySizes.spaceBtwItems),

                    // -- Payment Method
                    CustomHeader(
                      title: "Payment Method",
                      showTextButton: true,
                      titleButton: "change",
                      onPressed: () {},
                    ),

                    const Row(
                      children: [
                        CustomCircularImage(
                          width: 30,
                          height: 30,
                          isNetworkImage: false,
                          image: MyImages.googleIcon,
                        ),
                        SizedBox(width: MySizes.spaceBtwItems),
                        Text("Google Pay"),
                      ],
                    ),
                    const SizedBox(height: MySizes.spaceBtwItems * 2),

                    // -- Shipping Address
                    CustomHeader(
                      title: "Shipping Address",
                      showTextButton: true,
                      titleButton: "change",
                      onPressed: () {},
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // -- User Name
                        Text(
                          "Wagdy yousri",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        // -- Phone number
                        const Row(
                          children: [
                            Icon(Icons.call),
                            SizedBox(width: MySizes.spaceBtwItems / 2),
                            Text("+20121321312"),
                          ],
                        ),
                        // -- Address
                        const Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: MySizes.spaceBtwItems / 2),
                            Text("Assuit-BaniGhaleb west of the village "),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: MySizes.spaceBtwItems / 2),
                  ],
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => const CheckoutScreen()),
          child: Text("Checkout (\$$fullPrice)"),
        ),
      ),
    );
  }
}
