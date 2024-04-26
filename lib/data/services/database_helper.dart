import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product_model.dart';

class DatabaseHelper {
  static Database? _database;
  static const _productTable = 'favoriteProducts';
  static const _cartTable = 'cartProducts';
  static const _dbName = 'productDatabase.db';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, _dbName);

    return openDatabase(databasePath, version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE $_productTable(id INTEGER PRIMARY KEY, data TEXT)');
      db.execute('CREATE TABLE $_cartTable(id TEXT, data TEXT)');
    });
  }

  // -- Favorites Products
  Future<void> addFavoriteProduct(ProductModel product) async {
    final db = await database;
    await db.insert(_productTable,
        {'id': int.parse(product.productId!), 'data': product.toJson()});
  }

  Future<List<ProductModel>> getFavoriteProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_productTable);

    return List.generate(maps.length, (i) {
      final data = maps[i]['data'] as String;
      return ProductModel.fromJson(data);
    });
  }

  Future<void> removeFavoriteProduct(String productId) async {
    final db = await database;
    await db.delete(
      _productTable,
      where: 'id = ?',
      whereArgs: [int.parse(productId)],
    );
  }

  // -- Cart Products
  Future<void> addCartProduct(ProductModel cartProduct) async {
    final db = await database;
    await db.insert(
      _cartTable,
      {'id': cartProduct.productId!, 'data': cartProduct.toJson()},
    );
  }

  Future<List<ProductModel>> getCartProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_cartTable);

    return List.generate(maps.length, (i) {
      final data = maps[i]['data'] as String;
      return ProductModel.fromJson(data);
    });
  }

  Future<void> removeCartProduct(String productId) async {
    final db = await database;
    await db.delete(
      _cartTable,
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  Future<void> removeAllCartProducts() async {
    final db = await database;
    await db.delete(_cartTable);
  }
}
