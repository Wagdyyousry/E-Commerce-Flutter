import 'dart:convert';
import 'package:ecommerce/data/models/brand_model.dart';

class ProductModel {
  String? productTitle,
      productDescription,
      productId,
      productCategory,
      shopName,
      shopId,
      shopImageUri,
      productType,
      selectedColor,
      selectedSize;
  double? productQuantity, productPrice, productDiscount;
  int productCount;
  BrandModel? productBrand;
  List<Map<dynamic, dynamic>>? productReviews;
  List<String>? productImages, productColors, productSizes;

  ProductModel({
    required this.productTitle,
    required this.productId,
    required this.productPrice,
    required this.productImages,
    required this.productCategory,
    this.productDescription,
    this.productBrand,
    this.productQuantity = 1,
    this.productDiscount = 0,
    this.productColors,
    this.productSizes,
    this.productReviews,
    this.shopId,
    this.shopName,
    this.shopImageUri,
    this.productType,
    this.productCount = 0,
    this.selectedColor,
    this.selectedSize,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productBrand: map['productBrand'] != null
          ? BrandModel.fromMap(map['productBrand'])
          : BrandModel(),
      productCategory: map['productCategory'] ?? "",
      productDescription: map['productDescription'] ?? "",
      productDiscount: map['productDiscount'] ?? 0,
      productId: map['productId'] ?? "",
      productImages:
          (map['productImages'] as List<dynamic>?)?.cast<String>() ?? [],
      //productReviews: map['productReviews'],
      productReviews:
          (map['productReviews'] as List<dynamic>?)?.cast<Map>() ?? [],
      productPrice: map['productPrice'] ?? 0,
      productQuantity: map['productQuantity'] ?? 0,
      productTitle: map['productTitle'] ?? "",
      shopId: map['shopId'] ?? "",
      shopName: map['shopName'] ?? "",
      shopImageUri: map['shopImageUri'] ?? "",
      productType: map['productType'] ?? "",
      selectedColor: map['selectedColor'] ?? "",
      selectedSize: map['selectedSize'] ?? "",
      productCount: map['productCount'] ?? 0,
      productSizes:
          (map['productSizes'] as List<dynamic>?)?.cast<String>() ?? [],
      productColors:
          (map['productColors'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productTitle': productTitle,
      'productDescription': productDescription,
      'productId': productId,
      'productCategory': productCategory,
      'productQuantity': productQuantity,
      'productPrice': productPrice,
      'productDiscount': productDiscount,
      'productBrand': productBrand?.toMap(),
      'productReviews': productReviews,
      'productImages': productImages,
      'productColors': productColors,
      'productSizes': productSizes,
      'shopId': shopId,
      'shopName': shopName,
      'shopImageUri': shopImageUri,
      'productType': productType,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'productCount': productCount,
    };
  }

  // Convert UserModel to JSON
  String toJson() {
    return json.encode(toMap());
  }

  // Create a factory method to create ProductModel from JSON
  factory ProductModel.fromJson(String jsonStr) {
    return ProductModel.fromMap(json.decode(jsonStr));
  }

  factory ProductModel.emptyClass() {
    return ProductModel(
      productTitle: "",
      productId: "",
      productPrice: 0.0,
      productImages: [],
      productCategory: "",
    );
  }
}
