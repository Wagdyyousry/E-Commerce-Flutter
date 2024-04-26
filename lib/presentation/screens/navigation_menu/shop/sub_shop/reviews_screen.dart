import 'package:ecommerce/data/controllers/home/details_controller.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/models/review_model.dart';
import 'package:ecommerce/presentation/widgets/common/custom_rating_indicator.dart';
import 'package:ecommerce/presentation/widgets/common/custom_appbar.dart';
import 'package:ecommerce/presentation/widgets/navigation_menu/shop/user_review.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    final detailsController = DetailsController.instance;
    ProductModel product = widget.product;
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Rating & Reviews"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
        child: Column(
          children: [
            const Text(MyTexts.reviewAndRatingText),
            const SizedBox(height: MySizes.spaceBtwItems),

            // -- Ratings
            Row(
              children: [
                // -- Ratings
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // -- Avarage rating
                      Text(
                        detailsController.calcAverageRating(product),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),

                      // -- Rating bar
                      RatingBarIndicator(
                        itemCount: 5,
                        itemSize: 20,
                        rating: product.productReviews!.isNotEmpty
                            ? double.parse(
                                detailsController.calcAverageRating(product))
                            : 0.0,
                        unratedColor: Colors.grey,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star_rounded,
                          color: Colors.blue,
                        ),
                      ),

                      // -- rating count
                      Text(
                          product.productReviews!.isNotEmpty
                              ? product.productReviews!.length.toString()
                              : "0",
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(width: MySizes.spaceBtwItems),

                // -- Rating indicators
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      CustomRatingIndicator(
                        text: "5",
                        value: detailsController.calcRatingPercentage(
                            product, "5"),
                      ),
                      CustomRatingIndicator(
                        text: "4",
                        value: detailsController.calcRatingPercentage(
                            product, "4"),
                      ),
                      CustomRatingIndicator(
                        text: "3",
                        value: detailsController.calcRatingPercentage(
                            product, "3"),
                      ),
                      CustomRatingIndicator(
                        text: "2",
                        value: detailsController.calcRatingPercentage(
                            product, "2"),
                      ),
                      CustomRatingIndicator(
                        text: "1",
                        value: detailsController.calcRatingPercentage(
                            product, "1"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            // -- Users Review
            ListView.separated(
              itemCount: product.productReviews!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: MySizes.spaceBtwItems / 2),
              itemBuilder: (context, index) => UserReview(
                review: ReviewModel.fromMap(product.productReviews![index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
