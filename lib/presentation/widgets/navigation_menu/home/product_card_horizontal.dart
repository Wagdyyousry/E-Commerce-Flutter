import '../../../../data/controllers/database_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/my_images.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helpers.dart';
import '../../../../utils/shadows/card_shadows.dart';
import '../../common/custom_circular_image.dart';
import '../../common/custom_rounded_container.dart';
import '../../common/custom_rounded_image.dart';
import '../../../../data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({super.key, this.onPressed, this.productData});
  final VoidCallback? onPressed;
  final ProductModel? productData;

  @override
  Widget build(BuildContext context) {
    final isDark = MyHelpers.isDarkMode(context);
    final dbController = DatabaseController.instance;
    final productCount =
        dbController.checkProductCountInCart(productData!.productId!).obs;
    final isFavorite =
        dbController.checkFavoritesList(productData!.productId!).obs;
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MyHelpers.getScreenWidth(context) * .75,
        height: MyHelpers.getResponsiveHeight(120),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(MySizes.cardRadiusLg),
          boxShadow: [CardShadows.verticalProductShadow],
          color: isDark ? MyColors.darkerGrey : MyColors.light,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // -- Product Image, favorites, discount tag
            CustomRoundedContainer(
              height: 125,
              backgroundColor: isDark ? Colors.black : Colors.white,
              child: Stack(
                children: [
                  // -- product image
                  CustomRoundedImage(
                    width: 135,
                    height: 125,
                    enableBorder: true,
                    borderRadius: MySizes.cardRadiusLg,
                    image: productData!.productImages!.isNotEmpty
                        ? productData!.productImages![0]
                        : MyImages.onBordingScreenImage5,
                    boxFit: BoxFit.fill,
                    isNetworkImage:
                        productData!.productImages!.isNotEmpty ? true : false,
                    borderColor: Colors.grey.withOpacity(0.6),
                  ),

                  // -- Discount padg
                  if (productData!.productDiscount != null &&
                      productData!.productDiscount != 0.0)
                    Positioned(
                      top: 7,
                      left: 7,
                      child: CustomRoundedContainer(
                        radius: MySizes.sm,
                        backgroundColor: MyColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            vertical: MySizes.xs, horizontal: MySizes.sm),
                        child: Text(
                          "${productData!.productDiscount}%",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: Colors.black),
                        ),
                      ),
                    ),

                  // -- favorites button
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: isDark
                            ? Colors.black.withOpacity(0.9)
                            : Colors.white,
                      ),
                      child: Obx(
                        () => IconButton(
                          onPressed: () async {
                            if (isFavorite.value) {
                              dbController
                                  .removeFromFavorites(productData!.productId!);
                              isFavorite.value = false;
                            } else {
                              await dbController.addToFavorites(productData!);
                              isFavorite.value = true;
                            }
                          },
                          icon: Icon(
                            isFavorite.value
                                ? Icons.favorite_rounded
                                : Icons.favorite_outline_rounded,
                            size: MySizes.iconMd,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // -- Deatails
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // -- Description
                    Text(
                      productData!.productDescription != null
                          ? productData!.productDescription!
                          : "",
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),

                    // -- Brand name & brand logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // -- brand name
                        Text(
                          productData!.productBrand != null
                              ? productData!.productBrand!.brandName != null
                                  ? productData!.productBrand!.brandName!
                                  : ""
                              : "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(width: MySizes.xs),

                        // -- brand logo
                        CustomCircularImage(
                          width: 15,
                          height: 15,
                          image: productData!.productBrand != null
                              ? productData!.productBrand!.brandImageUri != null
                                  ? productData!.productBrand!.brandImageUri!
                                  : ""
                              : "",
                        ),

                        const Icon(
                          Iconsax.verify5,
                          color: MyColors.primary,
                          size: MySizes.iconSm,
                        ),
                      ],
                    ),

                    // -- Price and Add to cart Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // -- Real Price
                        if (productData!.productDiscount != 0)
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "\$${productData!.productPrice!}",
                            style: const TextStyle(
                              color: Colors.pink,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                            ),
                          ),
                        if (productData!.productDiscount != 0)
                          const SizedBox(width: MySizes.spaceBtwItems / 3),

                        // -- Price After Discount
                        Text(
                          overflow: TextOverflow.ellipsis,
                          "\$${(productData!.productPrice! - (productData!.productPrice! * (productData!.productDiscount! / 100))).toStringAsFixed(2)}",
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),

                        // -- Button add to cart
                        Obx(
                          () => InkWell(
                            onTap: () async {
                              productCount.value++;
                              productData!.productCount = productCount.value;
                              productData!.selectedColor =
                                  productData!.productColors![0];
                              productData!.selectedSize =
                                  productData!.productSizes![0];
                              await dbController
                                  .removeFromCart(productData!.productId!);
                              await dbController.addToCart(productData!);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: MyColors.dark,
                                borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(MySizes.cardRadiusLg),
                                  bottomRight:
                                      Radius.circular(MySizes.cardRadiusLg),
                                ),
                              ),
                              child: SizedBox(
                                width: MySizes.iconLg * 1.1,
                                height: MySizes.iconLg * 1.1,
                                child: Center(
                                  child: productCount.value > 0
                                      ? Text(
                                          "$productCount",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .apply(color: Colors.white),
                                        )
                                      : const Icon(
                                          Iconsax.add,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
