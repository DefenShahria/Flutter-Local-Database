import 'dart:core';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../data/card_model.dart';


class DatabaseHelper{
  static const int _version = 1;

  static const String _dbName = "Cart.db";

  static Future<Database> _getDb() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Cart(id INTEGER PRIMARY KEY,title TEXT NOT NULL,price TEXT NOT NULL,description TEXT NOT NULL,quantity TEXT NOT NULL);"),
        version: _version);
  }

 static Future<int> addData(Cart cart) async{
    final db = await _getDb();
    return await db.insert("Cart",cart.toJson(),
    conflictAlgorithm:  ConflictAlgorithm.replace
    );
 }


 static Future<int> updateData(Cart cart)async{
   final db = await _getDb();
   return await db.update("Cart",cart.toJson(),
       where: 'id = ?',
       whereArgs: [cart.id],
       conflictAlgorithm:  ConflictAlgorithm.replace
   );
 }

  static Future<int> deleteData(int id) async {
    final db = await _getDb();
    return await db.delete(
      "Cart",
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  static Future<List<Cart>?> getAllData() async{
    final db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query("Cart");

    if(maps.isEmpty){
      return null;
    }
    return List.generate(maps.length, (index)=> Cart.fromJson(maps[index]));

  }


}
