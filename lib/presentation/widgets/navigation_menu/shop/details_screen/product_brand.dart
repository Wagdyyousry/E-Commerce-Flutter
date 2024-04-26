import 'package:ecommerce/presentation/screens/display_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/models/product_model.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../common/custom_circular_image.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // -- brand icon
        if (product.productBrand!.brandImageUri != null)
          CustomCircularImage(
            enableBorder: true,
            borderColor: Colors.grey,
            image: product.productBrand!.brandImageUri!,
            width: 30,
            height: 30,
            onPressed: () => Get.to(
              () => DispalyImageScreen(
                image: product.productBrand!.brandImageUri!,
                isNetwork: true,
              ),
            ),
          ),
        const SizedBox(width: MySizes.spaceBtwItems / 3),

        // -- brand name
        if (product.productBrand!.brandName != null)
          Text(
            "${product.productBrand!.brandName}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
      ],
    );
  }
}
