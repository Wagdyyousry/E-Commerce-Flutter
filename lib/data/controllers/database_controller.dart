import 'package:get/get.dart';
import '../models/product_model.dart';
import '../repository/products_repo.dart';
import '../services/database_helper.dart';

class DatabaseController {
  // -- Instancees
  static DatabaseController get instance => Get.find();
  late final ProductsRepo productsRepo;
  late final DatabaseHelper productsDatabase;

  // -- All Favrites
  final allFavoritesProducts = [ProductModel.emptyClass()].obs,
      allCartProducts = [ProductModel.emptyClass()].obs;
  final fullPrice = 0.0.obs;

  DatabaseController() {
    productsRepo = ProductsRepo();
    productsDatabase = DatabaseHelper();
    getAllFavoritesProducts();
    getAllCartProducts();
  }

  // -- Get favorites products
  Future<void> getAllFavoritesProducts() async {
    allFavoritesProducts.value = await productsDatabase.getFavoriteProducts();
  }

  // -- Get Cart products
  Future<void> getAllCartProducts() async {
    allCartProducts.value = await productsDatabase.getCartProducts();
  }

  // -- Remove from favorites
  Future<void> removeFromFavorites(String productId) async {
    final List<ProductModel> newList = [];
    await productsDatabase.removeFavoriteProduct(productId);
    for (ProductModel product in allFavoritesProducts) {
      if (productId != product.productId!) {
        newList.add(product);
      }
    }
    allFavoritesProducts.value = newList;
  }

  // -- Remove from Cart
  Future<void> removeFromCart(String productId) async {
    final List<ProductModel> newList = [];
    await productsDatabase.removeCartProduct(productId);
    for (ProductModel product in allCartProducts) {
      if (productId != product.productId!) {
        newList.add(product);
      }
    }
    allCartProducts.value = newList;
  }

  // -- Remove All Cart Products
  Future<void> removeAllCartProduct() async {
    await productsDatabase.removeAllCartProducts();
  }

  // -- Add to favorites
  Future<void> addToFavorites(ProductModel product) async {
    await productsDatabase.addFavoriteProduct(product);
    allFavoritesProducts.add(product);
  }

  // -- Add to Cart
  Future<void> addToCart(ProductModel cartProduct) async {
    await productsDatabase.addCartProduct(cartProduct);
    allCartProducts.add(cartProduct);
  }

  // -- Check product in favorites
  bool checkFavoritesList(String productId) {
    for (ProductModel favProduct in allFavoritesProducts) {
      if (productId == favProduct.productId!) {
        return true;
      }
    }
    return false;
  }

  // -- Check product in Cart
  bool checkCartProductsList(String productId) {
    for (ProductModel product in allCartProducts) {
      if (productId == product.productId!) {
        return true;
      }
    }
    return false;
  }

  // -- Product count in cart
  int checkProductCountInCart(String productId) {
    int productCount = 0;
    if (allCartProducts.isNotEmpty) {
      for (ProductModel product in allCartProducts) {
        if (productId == product.productId) {
          productCount = product.productCount;
        }
      }
    }
    return productCount;
  }

 
}
