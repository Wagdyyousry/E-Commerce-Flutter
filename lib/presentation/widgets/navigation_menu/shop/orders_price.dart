import 'package:flutter/material.dart';

import '../../../../data/controllers/home/products_controller.dart';
import '../../../../utils/constants/sizes.dart';

class OrderPrice extends StatelessWidget {
  const OrderPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = ProductsController.instance;
    final fullPrice =
        productController.getProductsPrice(productController.userOrderList);
    return Column(
      children: [
        // -- SubTotal price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "SubTotal",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$ ${fullPrice.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),

        // -- Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Shipping Fee",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$ 5.00",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),

        // -- Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tax Fee",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "10%",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),

        // -- Total price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "\$ ${productController.getOrdersPrice(fullPrice)}",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(color: const Color.fromARGB(255, 55, 144, 58)),
            ),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems),
      ],
    );
  }
}
