import 'dart:core';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../data/product_modelData.dart';

class ProductDatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Product.db";

  static Future<Database> _getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        // Updated table schema to include rating and ratingCount
        await db.execute(
            "CREATE TABLE Product("
                "id INTEGER PRIMARY KEY, "
                "title TEXT, "
                "price REAL, "
                "description TEXT, "
                "category TEXT, "
                "image TEXT, "
                "rating REAL, " // Change to REAL to match the ProductDataModel
                "ratingCount INTEGER" // Assuming this is the intended type
                ");"
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE Product ADD COLUMN rating REAL;");
          await db.execute("ALTER TABLE Product ADD COLUMN ratingCount INTEGER;"); // Add the ratingCount column
        }
      },
      version: _version,
    );
  }

  static Future<int> addOrUpdateProduct(ProductDataModel product) async {
    final db = await _getDb();
    return await db.insert(
      "Product",
      {
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'category': product.category,
        'image': product.image,
        'rating': product.rating?.rate, // Store the rate
        'ratingCount': product.rating?.count // Store the count
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<ProductDataModel>> getAllProducts() async {
    final db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query("Product");

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(
      maps.length,
          (index) {
        final product = ProductDataModel.fromJson(maps[index]);
        // Reconstruct the Rating object
        if (maps[index]['rating'] != null && maps[index]['ratingCount'] != null) {
          product.rating = Rating(
            rate: maps[index]['rating'],
            count: maps[index]['ratingCount'],
          );
        }
        return product;
      },
    );
  }

  // Method to print all products in the database
  static Future<void> printAllProducts() async {
    final products = await getAllProducts();
    for (var product in products) {
      print("ID: ${product.id}, Title: ${product.title}, Price: ${product.price}, "
          "Rating: ${product.rating?.rate}, Count: ${product.rating?.count}");
    }
  }
}
