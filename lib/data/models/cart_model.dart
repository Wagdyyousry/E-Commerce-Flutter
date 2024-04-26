import 'dart:convert';

import 'package:ecommerce/data/models/brand_model.dart';

class CartModel {
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
  List<String>? productImages;

  CartModel({
    required this.productTitle,
    this.productDescription,
    required this.productId,
    this.productBrand,
    this.productQuantity = 1,
    required this.productPrice,
    this.productDiscount = 0,
    required this.productImages,
    required this.productCategory,
    this.selectedColor,
    this.selectedSize,
    this.productCount = 0,
    this.shopId,
    this.shopName,
    this.shopImageUri,
    this.productType,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productBrand: map['productBrand'] != null
          ? BrandModel.fromMap(map['productBrand'])
          : BrandModel(),
      productCategory: map['productCategory'] ?? "",
      productDescription: map['productDescription'] ?? "",
      productDiscount: map['productDiscount'] ?? 0,
      productId: map['productId'] ?? "",
      productImages:
          (map['productImages'] as List<dynamic>?)?.cast<String>() ?? [],
      productPrice: map['productPrice'] ?? 0,
      productQuantity: map['productQuantity'] ?? 0,
      productTitle: map['productTitle'] ?? "",
      shopId: map['shopId'] ?? "",
      shopName: map['shopName'] ?? "",
      shopImageUri: map['shopImageUri'] ?? "",
      productType: map['productType'] ?? "",
      selectedSize: map['selectedSize'] ?? "",
      selectedColor: map['selectedColor'] ?? "",
      productCount: map['productCount'] ?? "",
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
      'productImages': productImages,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'productCount': productCount,
      'shopId': shopId,
      'shopName': shopName,
      'shopImageUri': shopImageUri,
      'productType': productType,
    };
  }

  // Convert Cart Model to JSON
  String toJson() {
    return json.encode(toMap());
  }

  // Create a factory method to create Cart Model b   from JSON
  factory CartModel.fromJson(String jsonStr) {
    return CartModel.fromMap(json.decode(jsonStr));
  }
}
