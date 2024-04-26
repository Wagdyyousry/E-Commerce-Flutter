import 'package:ecommerce/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/review_model.dart';

class DetailsController extends GetxController {
  static DetailsController get instance => Get.find();

  final selectedImageIndex = 0.obs;
  final selectedColorIndex = 0.obs;
  final selectedSizeIndex = 0.obs;
  final selectedColor = Colors.red.obs;
  final selectedImage = "".obs;
  final rating = 0.0.obs;
  final reviewController = TextEditingController();

  double calcRatingPercentage(ProductModel product, String rateNumber) {
    int fiveRate = 0, fourRate = 0, threeRate = 0, twoRate = 0, oneRate = 0;

    if (product.productReviews == null || product.productReviews!.isEmpty) {
      return 0.0; // Return 0 if there are no reviews
    }

    for (var review in product.productReviews!) {
      final rev = ReviewModel.fromMap(review);
      switch (rev.rating) {
        case 5.0:
          fiveRate++;
        case 4.0:
          fourRate++;
        case 3.0:
          threeRate++;
        case 2.0:
          twoRate++;
        case 1.0:
          oneRate++;
      }
    }
    switch (rateNumber) {
      case "5":
        return fiveRate / product.productReviews!.length;
      case "4":
        return fourRate / product.productReviews!.length;
      case "3":
        return threeRate / product.productReviews!.length;
      case "2":
        return twoRate / product.productReviews!.length;
      case "1":
        return oneRate / product.productReviews!.length;
      default:
        return 0.0;
    }
    // Calculate average
  }

  String calcAverageRating(ProductModel product) {
    if (product.productReviews == null || product.productReviews!.isEmpty) {
      return "0"; // Return 0 if there are no reviews
    }

    double totalRating = 0.0;
    for (var review in product.productReviews!) {
      final rev = ReviewModel.fromMap(review);
      totalRating += rev.rating ?? 0.0; // Add each rating to the total
    }

    return (totalRating / product.productReviews!.length)
        .toStringAsFixed(1); // Calculate average
  }
}
