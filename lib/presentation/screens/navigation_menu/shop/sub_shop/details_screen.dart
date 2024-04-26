import 'package:ecommerce/presentation/screens/navigation_menu/shop/sub_shop/cart_screen.dart';

import '../../../../../data/controllers/database_controller.dart';
import '../../../../../data/controllers/home/details_controller.dart';
import '../../../../widgets/navigation_menu/shop/details_screen/add_product_bottom_nav.dart';
import '../../../../widgets/navigation_menu/shop/details_screen/product_brand.dart';
import '../../../../widgets/navigation_menu/shop/details_screen/product_colors.dart';
import '../../../../widgets/navigation_menu/shop/details_screen/product_images.dart';
import '../../../../widgets/navigation_menu/shop/details_screen/product_price.dart';
import '../../../../widgets/navigation_menu/shop/details_screen/product_rating.dart';
import '../../../../widgets/navigation_menu/shop/details_screen/product_sizes.dart';
import '../../../../../data/models/product_model.dart';
import '../../../../widgets/common/custom_header.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helpers.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'reviews_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, this.productData});
  final ProductModel? productData;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final dbController = DatabaseController.instance;
    final detailsController = DetailsController.instance;
    final product = widget.productData;
    detailsController.selectedImageIndex.value = 0;
    detailsController.selectedImage.value = product!.productImages![0];
    final productCount =
        dbController.checkProductCountInCart(product.productId!).obs;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // -- Product Images Part
            ProductImages(product: product),

            // -- Details part
            Padding(
              padding: const EdgeInsets.all(MySizes.defaultSpace),
              child: Column(
                children: [
                  // -- Rating
                  ProductRating(product: product),
                  const SizedBox(height: MySizes.spaceBtwItems),

                  // -- Price
                  ProductPrice(
                    price: product.productPrice,
                    discount: product.productDiscount,
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems),

                  const Divider(),

                  // -- Product title
                  Text(
                    "${product.productTitle} ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems),

                  // -- Brand
                  if (product.productBrand != null)
                    ProductBrand(product: product),
                  const SizedBox(height: MySizes.spaceBtwSections / 2),

                  // -- Colors
                  if (product.productColors!.isNotEmpty)
                    const Text(
                      "Colors",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  // -- Colors
                  if (product.productColors!.isNotEmpty)
                    ProductColors(productColors: product.productColors!),
                  const SizedBox(height: MySizes.spaceBtwSections / 2),

                  // -- Sizes
                  if (product.productSizes!.isNotEmpty)
                    const Text(
                      "Sizes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  // -- Sizes
                  if (product.productSizes!.isNotEmpty)
                    ProductSizes(productSizes: product.productSizes!),

                  const Divider(),
                  const SizedBox(height: MySizes.spaceBtwSections),

                  // -- CheckOut Button
                  SizedBox(
                    width: MyHelpers.getScreenWidth(context) * 0.8,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const CartScreen()),
                      child: const Text("Checkout"),
                    ),
                  ),
                  const SizedBox(height: MySizes.spaceBtwSections),

                  // -- Product Descreption Title
                  Text(
                    "Descreption ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems / 2),

                  // -- Product Descreption
                  ReadMoreText(
                    "${product.productDescription}",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Read More",
                    trimExpandedText: "Show Less",
                    moreStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue.withOpacity(0.8),
                    ),
                    lessStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems),

                  const Divider(),
                  const SizedBox(height: MySizes.spaceBtwSections / 2),

                  // -- Reviews
                  CustomHeader(
                      title: product.productReviews!.isNotEmpty
                          ? "Reviews (${product.productReviews!.length})"
                          : "Reviews (0)",
                      showActionButton: true,
                      onPressed: () {
                        if (product.productReviews == null ||
                            product.productReviews!.isNotEmpty) {
                          Get.to(() => ReviewsScreen(product: product));
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => AddProductBottomNav(
          count: productCount.value.toString(),
          onMinusPressed: () async {
            productCount.value--;
            if (productCount.value > 0) {
              product.productCount = productCount.value;
              product.selectedColor = product.productColors![0];
              product.selectedSize = product.productSizes![0];
              await dbController.removeFromCart(product.productId!);
              await dbController.addToCart(product);
            } else {
              await dbController.removeFromCart(product.productId!);
              productCount.value = 0;
              product.productCount = productCount.value;
            }
          },
          onPlusPressed: () async {
            productCount.value++;
            product.productCount = productCount.value;
            product.selectedColor = product
                .productColors![detailsController.selectedColorIndex.value];
            product.selectedSize = product
                .productSizes![detailsController.selectedSizeIndex.value];
            await dbController.removeFromCart(product.productId!);
            await dbController.addToCart(product);

            // await dbController.addToCart(product);
            // productCount.value++;
          },
        ),
      ),
    );
  }
}
