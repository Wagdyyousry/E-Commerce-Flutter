import 'package:ecommerce/presentation/screens/display_image_screen.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../common/custom_circular_image.dart';
import '../../common/custom_rounded_image.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key, this.order});
  final ProductModel? order;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        // -- Product Image
        CustomRoundedImage(
          width: 80,
          height: 100,
          borderRadius: 10,
          onPressed: () => DispalyImageScreen(image: order!.productImages![0]),
          enableBorder: true,
          isNetworkImage: true,
          image: order!.productImages![0],
        ),
        const SizedBox(width: MySizes.spaceBtwItems),

        // -- Description
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // -- Brand Name And Logo
              if (order!.productBrand != null)
                Row(
                  children: [
                    // -- brand name
                    Text(
                      "${order!.productBrand!.brandName}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: MySizes.xs),

                    // -- brand logo
                    CustomCircularImage(
                      width: 20,
                      height: 20,
                      enableBorder: true,
                      borderColor: Colors.grey,
                      isNetworkImage: true,
                      image: "${order!.productBrand!.brandImageUri}",
                    )
                  ],
                ),

              // -- Product Title
              Text(
                "${order!.productTitle}",
                style: Theme.of(context).textTheme.titleMedium,
              ),

              // -- product description
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: " Color ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: "${order!.selectedColor}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: " Size ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: "${order!.selectedSize}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
