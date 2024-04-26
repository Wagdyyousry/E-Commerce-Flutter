import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/loaders/loaders.dart';
import '../models/brand_model.dart';

class ProductsRepo {
  late final FirebaseFirestore mFireStore;
  late final FirebaseStorage mStorage;
  late final String currentUserID;

  ProductsRepo() {
    mFireStore = FirebaseFirestore.instance;
    mStorage = FirebaseStorage.instance;
    currentUserID = FirebaseAuth.instance.currentUser!.uid;
  }

  // -- Upload New Brand
  Future<void> uploadNewBrand(BrandModel newBrand) async {
    try {
      MyLoaders.openLoadingDialog();

      // -- Uploading To brand image first
      final storageReference =
          mStorage.ref().child("Brands").child(newBrand.brandId!);
      await storageReference.putFile(File(newBrand.brandImageUri!));

      // -- Uploading To FireStore
      String url = await storageReference.getDownloadURL();
      await mFireStore.collection('Brands').doc(newBrand.brandId!).set({
        "brandName": newBrand.brandName,
        "brandImageUri": url,
        "brandId": newBrand.brandId,
      }).then((value) {
        MyLoaders.stopLoading();

        MyLoaders.successSnackBar(
          title: "Success",
          message: "Brand Added Successfully",
        );
      });
    } catch (e) {
      MyLoaders.errorSnackBar(title: "Error", message: e);
    }
  }

  // -- Upload Product
  Future addNewProduct(ProductModel product) async {
    try {
      MyLoaders.openLoadingDialog();

      await mFireStore
          .collection('Products')
          .doc("LrJC26PrJJSDjRnz51BfYFyd8M62")
          .collection(product.productCategory!)
          .doc(product.productId)
          .set(product.toMap());
      MyLoaders.stopLoading();
      MyLoaders.successSnackBar(message: "New Product Added");
    } catch (e) {
      MyLoaders.errorSnackBar(title: "Error", message: e);
    }
  }

  // -- Product Image
  Future<List<String>> uploadProductImages(
    List<XFile> productImages,
    String category,
    String productId,
  ) async {
    List<String> productImagesUrls = [];
    try {
      MyLoaders.openLoadingDialog();

      for (var image in productImages) {
        final storageReference = mStorage
            .ref()
            .child("products_images")
            .child(category)
            .child(productId)
            .child(image.name);
        await storageReference.putFile(File(image.path));

        String imageUrl = await storageReference.getDownloadURL();
        productImagesUrls.add(imageUrl);
      }
      MyLoaders.stopLoading();
      return productImagesUrls;
    } catch (e) {
      MyLoaders.errorSnackBar(title: "Error", message: e);
    }
    return [];
  }

  // -- Add Order
  Future<void> addUserOrder(List<ProductModel> products) async {
    List<Map<String, dynamic>> productListData =
        products.map((product) => product.toMap()).toList();

    try {
      MyLoaders.openLoadingDialog();

      await mFireStore
          .collection('Orders')
          .doc(currentUserID)
          .set({"orderList": productListData});
      MyLoaders.stopLoading();
      MyLoaders.successSnackBar(message: "New Order Added");
    } catch (e) {}
  }

  ///////////----------->>>> [ Retreiving all Data ] <<<<---------------////////

  // -- Get All Brands
  Future<List<BrandModel>> getAllBrands() async {
    final querySnapshot = await mFireStore.collection('Brands').get();
    List<BrandModel> brands = querySnapshot.docs
        .map((brand) => BrandModel.fromMap(brand.data()))
        .toList();

    return brands;

    // -- Another Way
    /*  List<BrandModel> brands = [];
    final brandsMapList = querySnapshot.docs;

    if (brandsMapList.isNotEmpty) {
      for (var brand in brandsMapList) {
        BrandModel brandModel = BrandModel.fromMap(brand.data());
        brands.add(brandModel);
        print("=========${brandModel.brandName}");
      }
    } */
  }

  // -- Get All Products
  Future<List<ProductModel>> getAllProducts() async {
    List<ProductModel> allProducts = [];
    allProducts.addAll(await getMenProducts());
    allProducts.addAll(await getWomenProducts());
    allProducts.addAll(await getChildrenProducts());
    allProducts.addAll(await getGroceryProducts());
    allProducts.addAll(await getSportsProducts());
    return allProducts;
  }

  // -- Get Men Products
  Future<List<ProductModel>> getMenProducts() async {
    List<ProductModel> products = [];
    try {
      final querySnapshot = await mFireStore
          .collection("Products")
          .doc("LrJC26PrJJSDjRnz51BfYFyd8M62")
          .collection("Men")
          .get();

      products = querySnapshot.docs
          .map((product) => ProductModel.fromMap(product.data()))
          .toList();

      return products;
    } catch (e) {
      MyLoaders.errorSnackBar(message: e);
    }
    return [];
  }

  // -- Get Women Products
  Future<List<ProductModel>> getWomenProducts() async {
    try {
      final querySnapshot = await mFireStore
          .collection("Products")
          .doc("LrJC26PrJJSDjRnz51BfYFyd8M62")
          .collection("Women")
          .get();

      List<ProductModel> products = querySnapshot.docs
          .map((product) => ProductModel.fromMap(product.data()))
          .toList();

      return products;
    } catch (e) {
      MyLoaders.errorSnackBar(message: e);
    }
    return [];
  }

  // -- Get Children Products
  Future<List<ProductModel>> getChildrenProducts() async {
    try {
      final querySnapshot = await mFireStore
          .collection("Products")
          .doc("LrJC26PrJJSDjRnz51BfYFyd8M62")
          .collection("Children")
          .get();

      List<ProductModel> products = querySnapshot.docs
          .map((product) => ProductModel.fromMap(product.data()))
          .toList();

      return products;
    } catch (e) {
      MyLoaders.errorSnackBar(message: e);
    }
    return [];
  }

  // -- Get Grocery Products
  Future<List<ProductModel>> getGroceryProducts() async {
    try {
      final querySnapshot = await mFireStore
          .collection("Products")
          .doc("LrJC26PrJJSDjRnz51BfYFyd8M62")
          .collection("Grocery")
          .get();

      List<ProductModel> products = querySnapshot.docs
          .map((product) => ProductModel.fromMap(product.data()))
          .toList();

      return products;
    } catch (e) {
      MyLoaders.errorSnackBar(message: e);
    }
    return [];
  }

  // -- Get Sports Products
  Future<List<ProductModel>> getSportsProducts() async {
    try {
      final querySnapshot = await mFireStore
          .collection('Products')
          .doc("LrJC26PrJJSDjRnz51BfYFyd8M62")
          .collection("Sports")
          .get();

      List<ProductModel> products = querySnapshot.docs
          .map((product) => ProductModel.fromMap(product.data()))
          .toList();

      return products;
    } catch (e) {
      MyLoaders.errorSnackBar(message: e);
    }
    return [];
  }
  
  
  // -- Get Best offer Products
  Future<List<ProductModel>> getBestOffersProducts() async {
    try {
      final querySnapshot = await mFireStore
          .collection('Products')
          .doc("LrJC26PrJJSDjRnz51BfYFyd8M62")
          .collection("Best Offer")
          .get();

      List<ProductModel> products = querySnapshot.docs
          .map((product) => ProductModel.fromMap(product.data()))
          .toList();

      return products;
    } catch (e) {
      MyLoaders.errorSnackBar(message: e);
    }
    return [];
  }
  // -- Get User Orders
  Future<List<ProductModel>> getUserOrders() async {
    try {
      final querySnapshot = await mFireStore.collection('Orders').doc(currentUserID).get();
      final orderList = querySnapshot.data();
      List<ProductModel> orders = [];
      for (var item in orderList!["orderList"]) {
        final product = ProductModel.fromMap(item);
        orders.add(product);
      }

      return orders;
    } catch (e) {
      MyLoaders.errorSnackBar(message: e);
    }
    return [];
  }
}
