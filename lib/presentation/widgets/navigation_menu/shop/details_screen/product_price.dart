import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../common/custom_rounded_container.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({super.key, required this.price, this.discount});

  final double? price, discount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // -- Discount Padg
        if (discount != 0)
          CustomRoundedContainer(
            radius: MySizes.sm,
            backgroundColor: MyColors.secondary.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(
                vertical: MySizes.xs, horizontal: MySizes.sm),
            child: Text(
              "$discount %",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: Colors.black),
            ),
          ),
        if (discount != 0) const SizedBox(width: MySizes.spaceBtwItems),

        // -- Real price
        if (discount != 0)
          Text(
            price != null ? "\$$price" : "",
            style: Theme.of(context).textTheme.titleMedium!.apply(
                decoration: TextDecoration.lineThrough, color: Colors.pink),
          ),
        if (discount != 0) const SizedBox(width: MySizes.spaceBtwItems),

        // -- After Discount
        Text(
          "\$${(price! - (price! * (discount! / 100))).toStringAsFixed(2)}",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(color: Colors.green),
        ),
      ],
    );
  }
}
