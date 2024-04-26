import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/controllers/database_controller.dart';
import '../../../../data/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helpers.dart';
import '../../common/custom_circular_icon.dart';
import '../../common/custom_circular_image.dart';
import '../../common/custom_rounded_container.dart';
import '../../common/custom_rounded_image.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dbController = DatabaseController.instance;
    final productCount = product.productCount.obs;
    return CustomRoundedContainer(
      padding: const EdgeInsets.all(10),
      radius: 10,
      backgroundColor: Colors.grey.withOpacity(0.3),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          
          // -- Product Image
          CustomRoundedImage(
            width: MyHelpers.getResponsiveWidth(90),
            height: MyHelpers.getResponsiveHeight(100),
            borderRadius: 10,
            boxFit: BoxFit.fill,
            enableBorder: true,
            isNetworkImage: true,
            image: product.productImages![0],
          ),
          const SizedBox(width: MySizes.spaceBtwItems / 2),

          // -- Description
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MyHelpers.getResponsiveHeight(28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // -- Brand Name And Logo
                      Row(
                        children: [
                          // -- brand name
                          if (product.productBrand != null)
                            Text(
                              "${product.productBrand!.brandName}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          const SizedBox(width: MySizes.spaceBtwItems / 2),

                          // -- brand logo
                          if (product.productBrand != null)
                            CustomCircularImage(
                              width: 25,
                              height: 25,
                              image: product.productBrand!.brandImageUri!,
                            ),
                        ],
                      ),

                      // -- Delete Product Button
                      IconButton(
                        onPressed: () async {
                          productCount.value = 0;
                          await dbController.removeFromCart(product.productId!);
                        },
                        icon: const Icon(Icons.delete_forever),
                      ),
                    ],
                  ),
                ),

                // -- Product Title
                Text(
                  "${product.productTitle}",
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
                        text: product.selectedColor != ""
                            ? product.selectedColor
                            : " Red ",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: " Size ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: product.selectedSize != ""
                            ? product.selectedSize
                            : " 32 ",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // -- Buttons
                    Row(
                      children: [
                        // -- Remove Button
                        CustomCircularIcon(
                          width: 30,
                          height: 30,
                          onPressed: () async {
                            productCount.value--;
                            if (productCount.value > 0) {
                              product.productCount = productCount.value;
                              product.selectedColor = product.productColors![0];
                              product.selectedSize = product.productSizes![0];
                              await dbController
                                  .removeFromCart(product.productId!);
                              await dbController.addToCart(product);
                            } else {
                              await dbController
                                  .removeFromCart(product.productId!);
                              productCount.value = 0;
                              product.productCount = productCount.value;
                            }
                          },
                          size: 15,
                          icon: Icons.remove,
                          iconColor: Colors.white,
                          backgroundColor: Colors.blueGrey,
                        ),
                        const SizedBox(width: MySizes.spaceBtwItems / 2),

                        // -- Product Count
                        Obx(() => Text("${productCount.value}")),
                        const SizedBox(width: MySizes.spaceBtwItems / 2),

                        // -- Add Button
                        CustomCircularIcon(
                          width: 30,
                          height: 30,
                          size: 15,
                          onPressed: () async {
                            productCount.value++;
                            product.productCount = productCount.value;
                            product.selectedColor = product.productColors![0];
                            product.selectedSize = product.productSizes![0];
                            await dbController
                                .removeFromCart(product.productId!);
                            await dbController.addToCart(product);
                          },
                          icon: Icons.add,
                          iconColor: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                      ],
                    ),

                    // -- price
                    Row(
                      children: [
                        // -- Real Price
                        if (product.productDiscount != 0)
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "\$${product.productPrice!}",
                            style: const TextStyle(
                              color: Colors.pink,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                            ),
                          ),

                        if (product.productDiscount != 0)
                          const SizedBox(width: MySizes.spaceBtwItems / 2),

                        // -- Price After Discount
                        Text(
                          overflow: TextOverflow.ellipsis,
                          "\$${(product.productPrice! - (product.productPrice! * (product.productDiscount! / 100))).toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
