import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/controllers/home/user_controller.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/models/review_model.dart';
import 'package:ecommerce/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../../../data/controllers/home/details_controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helpers.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    //final controller = DetailsController.instance;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
      children: [
        // -- Rating & rating count
        if (product.productReviews!.isNotEmpty)
          Row(
            children: [
              const Icon(
                Icons.star_border_outlined,
                color: Colors.amber,
              ),
              const SizedBox(width: MySizes.spaceBtwItems / 2),

              // -- rating count
              Text.rich(
                TextSpan(
                  children: [
                    // -- avarage rating

                    TextSpan(
                      text:
                          DetailsController.instance.calcAverageRating(product),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    // -- Number of ratings
                    TextSpan(
                      text: product.productReviews!.isNotEmpty
                          ? " ( ${product.productReviews!.length.toString()} ) "
                          : "0",
                    ),
                  ],
                ),
              ),
            ],
          ),
        IconButton(
          onPressed: () => showRatingDialog(),
          icon: const Icon(Icons.star, size: 35, color: Colors.orange),
        ),
      ],
    );
  }

  void showRatingDialog() {
    final detailsController = DetailsController.instance;
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => Dialog(
        elevation: 15,
        child: Container(
          height: 250,
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          decoration: BoxDecoration(
            color: MyHelpers.isDarkMode(context) ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              // -- Rating Bar
              RatingBar(
                itemCount: 5,
                itemSize: 30,
                glowRadius: 15,
                onRatingUpdate: (newRate) {
                  if (newRate != detailsController.rating.value) {
                    detailsController.rating.value = newRate;
                  }
                },
                initialRating: detailsController.rating.value,
                ratingWidget: RatingWidget(
                  full: const Icon(Icons.star, color: Colors.orange),
                  half: const Icon(Icons.star_half, color: Colors.orange),
                  empty: const Icon(Icons.star_border, color: Colors.grey),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems),

              // -- Rating Review
              TextFormField(
                controller: detailsController.reviewController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  label: const Text("Your comment on the product"),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              // -- Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // -- Cancel
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                    ),
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: MySizes.spaceBtwItems),

                  // -- Confirm
                  ElevatedButton(
                    onPressed: () async => await updateProductRating(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: MySizes.lg),
                      child: Text('Confirm'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateProductRating() async {
    final detailsController = DetailsController.instance;
    final userController = UserController.instance;
    final reviewDate = DateTime.now().millisecondsSinceEpoch.toDouble();
    final reviewModel = ReviewModel(
      rating: detailsController.rating.value,
      review: detailsController.reviewController.text,
      reviewDate: reviewDate,
      userImageUri: userController.userData.value.profileImageUri,
      userId: userController.userData.value.userId,
      userName: userController.userData.value.name,
      shopImageUri: product.shopImageUri,
      shopName: product.shopName,
      shopId: product.shopId,
    );
    if (product.productReviews != null) {
      product.productReviews!.add(reviewModel.toMap());
    } else {
      product.productReviews = [reviewModel.toMap()];
    }

    await FirebaseFirestore.instance
        .collection("Products")
        .doc("LrJC26PrJJSDjRnz51BfYFyd8M62")
        .collection(product.productCategory!)
        .doc(product.productId!)
        .update({"productReviews": product.productReviews});
    Get.back();
    MyLoaders.successSnackBar(message: "Your review has been sent, thank you!");
    //detailsController.reviewController.text = "";
  }
}
