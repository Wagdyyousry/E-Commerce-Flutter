import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/loaders/loaders.dart';
import '../../models/brand_model.dart';
import '../../models/product_model.dart';
import '../../repository/products_repo.dart';
import '../../services/database_helper.dart';
import 'user_controller.dart';

class ProductsController extends GetxController {
  // -- Instance
  static ProductsController get instance => Get.find();
  late final ProductsRepo productsRepo;
  late final DatabaseHelper productsDatabase;

  ///// ------ Add product screen Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final price = TextEditingController();
  final quantity = TextEditingController();
  final title = TextEditingController();
  final discreption = TextEditingController();
  final discount = TextEditingController();
  BrandModel? productBrand;
  String productCategory = "";
  List<XFile> productImages = [];
  List<String> productImagesUrls = [], selectedColors = [], selectedSizes = [];

  ///  --- Getting Data Lists
  final allProductsList = [].obs,
      menProductsList = [].obs,
      allBrandList = [].obs,
      womenProductsList = [].obs,
      childrenProductsList = [].obs,
      groceryProductsList = [].obs,
      sportsProductsList = [].obs,
      bestOfferProductsList = [].obs,
      userOrderList = [ProductModel.emptyClass()].obs;

  List<ProductModel> filterBrandName = [],
      filterBrandHighPrice = [],
      filterBrandLowPrice = [],
      filterBrandDiscount = [],
      filterProductName = [],
      filterProductHighPrice = [],
      filterProductLowPrice = [],
      filterProductDiscount = [];

  ProductsController() {
    productsRepo = ProductsRepo();
    productsDatabase = DatabaseHelper();
    getAllBrands();
    getAllProducts();
    getUserOrders();
    getBestOfferProducts();
    
  }

  // -- Upload New Brand
  Future<void> uploadNewBrand(BrandModel newBrand) async {
    await productsRepo.uploadNewBrand(newBrand);
  }

  // -- Add New Product
  Future<void> addNewProduct() async {
    try {
      // -- Check Form Validation
      if (!formKey.currentState!.validate()) return;

      // -- Check Product images
      if (productImages.isEmpty) {
        MyLoaders.warningSnackBar(message: "You have to add product images");
        return;
      }
      // -- Check Product Colors
      if (selectedColors.isEmpty) {
        MyLoaders.warningSnackBar(
            message: "You have to add product Colors atleast 1 color");
        return;
      }
      // -- Check Product Sizes
      if (selectedSizes.isEmpty) {
        MyLoaders.warningSnackBar(
            message: "You have to add product Sizes atleast 1 size");
        return;
      }
      // -- Check Product Category
      if (productCategory == "") {
        MyLoaders.warningSnackBar(
            message: "You have to Choose product Category");
        return;
      }

      // -- Create New User
      await uploadNewProduct();
    } catch (e) {
      MyLoaders.errorSnackBar(title: "Error : ", message: e.toString());
    }
  }

  // -- Upload New Product
  Future<void> uploadNewProduct() async {
    // -- Upload Product Images First
    final userController = UserController.instance;
    String productId = DateTime.now().millisecondsSinceEpoch.toString();
    productImagesUrls = await uploadProductImages(productId);

    // -- Upload Products
    ProductModel product = ProductModel(
      productTitle: title.text,
      productId: productId,
      productBrand: productBrand,
      productQuantity: double.parse(quantity.text),
      productDiscount: double.parse(discount.text),
      productDescription: discreption.text,
      productPrice: double.parse(price.text),
      productImages: productImagesUrls,
      productCategory: productCategory,
      productColors: selectedColors,
      productSizes: selectedSizes,
      shopId: userController.userData.value.userId,
      shopName: userController.userData.value.name,
      shopImageUri: userController.userData.value.profileImageUri,
    );

    await productsRepo.addNewProduct(product);
  }

  // -- Upload Product Images to firebase first
  Future<List<String>> uploadProductImages(String productId) async {
    return await productsRepo.uploadProductImages(
      productImages,
      productCategory,
      productId,
    );
  }

  // -- Add New Order
  Future<void> addUserOrder(List<ProductModel> products) async {
    await productsRepo.addUserOrder(products);
  }

  //---------->>>>> [  Getting Data  ] <<<<<-----------//

  // -- Get All Brands
  Future<List<BrandModel>> getAllBrands() async {
    allBrandList.value = await productsRepo.getAllBrands();
    return await productsRepo.getAllBrands();
  }

  // -- Get All Brand Products
  List<ProductModel> getAllBrandProduct(String brandId) {
    List<ProductModel> allProducts = [];
    for (ProductModel product in allProductsList) {
      if (product.productBrand!.brandId! == brandId) {
        allProducts.add(product);
      }
    }
    return allProducts;
  }

  // -- Get All Products
  Future<void> getAllProducts() async {
    allProductsList.value = await productsRepo.getAllProducts();
    menProductsList.value = await productsRepo.getMenProducts();
    womenProductsList.value = await productsRepo.getWomenProducts();
    groceryProductsList.value = await productsRepo.getGroceryProducts();
    childrenProductsList.value = await productsRepo.getChildrenProducts();
    sportsProductsList.value = await productsRepo.getSportsProducts();
    bestOfferProductsList.value = await productsRepo.getBestOffersProducts();
    filterAllProducts();
  }

  // -- Get Best Offer Products
  Future<void> getBestOfferProducts() async {
    bestOfferProductsList.value = await productsRepo.getBestOffersProducts();
  }

  // -- Get All Brand Products
  Future<void> getUserOrders() async {
    userOrderList.value = await productsRepo.getUserOrders();
  }

  // -- Filter Brand products
  void filterBrandProducts(String brandId) {
    filterBrandName = [];
    filterBrandDiscount = [];
    filterBrandHighPrice = [];
    filterBrandLowPrice = [];
    if (getAllBrandProduct(brandId).isNotEmpty) {
      for (ProductModel product in getAllBrandProduct(brandId)) {
        filterBrandName.add(product);
        filterBrandDiscount.add(product);
        filterBrandHighPrice.add(product);
        filterBrandLowPrice.add(product);
      }
      filterBrandName
          .sort((a, b) => a.productTitle!.compareTo(b.productTitle!));

      filterBrandHighPrice
          .sort((a, b) => b.productPrice!.compareTo(a.productPrice!));

      filterBrandLowPrice
          .sort((a, b) => a.productPrice!.compareTo(b.productPrice!));

      filterBrandDiscount
          .sort((a, b) => b.productDiscount!.compareTo(a.productDiscount!));
    }
  }

  // -- Filter All products
  void filterAllProducts() {
    filterProductName = [];
    filterProductDiscount = [];
    filterProductHighPrice = [];
    filterProductLowPrice = [];
    if (allProductsList.isNotEmpty) {
      for (ProductModel product in allProductsList) {
        filterProductName.add(product);
        filterProductDiscount.add(product);
        filterProductHighPrice.add(product);
        filterProductLowPrice.add(product);
      }
      filterProductName
          .sort((a, b) => a.productTitle!.compareTo(b.productTitle!));

      filterProductHighPrice
          .sort((a, b) => b.productPrice!.compareTo(a.productPrice!));

      filterProductLowPrice
          .sort((a, b) => a.productPrice!.compareTo(b.productPrice!));

      filterProductDiscount
          .sort((a, b) => b.productDiscount!.compareTo(a.productDiscount!));
    }
  }

  // -- Product Price
  double getProductsPrice(List<ProductModel> products) {
    double fullPrice = 0.0;
    for (var product in products) {
      double discountedPrice = product.productPrice! -
          (product.productPrice! * product.productDiscount! / 100);
      fullPrice += discountedPrice * product.productCount;
    }
    return fullPrice;
  }

  String getOrdersPrice(double subTotalPrice) {
    double shippingFee = 5.0, taxFee = 0.1;

    double fullPrice = subTotalPrice + shippingFee + (taxFee * subTotalPrice);

    return fullPrice.toStringAsFixed(2);
  }
}
