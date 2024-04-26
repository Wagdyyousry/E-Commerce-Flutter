import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../data/controllers/home/products_controller.dart';
import '../../../../data/models/brand_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../common/custom_circular_image.dart';
import '../../common/custom_rounded_container.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    this.enableBorder = true,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.grey,
    this.width = 200,
    this.height = 55,
    this.radius = 10,
    this.onPressed,
    this.brand,
  });
  final BrandModel? brand;
  final double width, height, radius;
  final bool enableBorder;
  final VoidCallback? onPressed;

  final Color backgroundColor, borderColor;
  @override
  Widget build(BuildContext context) {
    final productController = ProductsController.instance;
    return InkWell(
      onTap: onPressed,
      child: CustomRoundedContainer(
        width: width,
        height: height,
        radius: radius,
        padding: const EdgeInsets.all(MySizes.sm),
        enableBorder: enableBorder,
        borderColor: borderColor.withOpacity(0.6),
        backgroundColor: backgroundColor,
        child: brand != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // -- Brand Icon
                  if (brand!.brandImageUri != null)
                    CustomCircularImage(
                      isNetworkImage: true,
                      image: brand!.brandImageUri!,
                      width: 40,
                      height: 40,
                    ),
                  const SizedBox(width: MySizes.spaceBtwItems / 2),

                  // -- Details
                  Column(
                    children: [
                      // -- Brand Name And Logo
                      Row(
                        children: [
                          // -- brand name
                          if (brand!.brandName != null)
                            Text(
                              brand!.brandName!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          const SizedBox(width: MySizes.xs),

                          // -- brand logo
                          const Icon(
                            Iconsax.verify5,
                            color: Colors.blue,
                            size: MySizes.iconXs,
                          ),
                        ],
                      ),

                      // -- product count
                      Text(
                        "${productController.getAllBrandProduct(brand!.brandId!).length} products",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
