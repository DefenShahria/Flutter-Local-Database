import 'dart:developer';
import 'package:get/get.dart';
import '../data/product_modelData.dart';
import '../data/urls.dart';
import '../network/networkcaller.dart';
import '../network/networkresponse.dart';
import '../service/productdatabaseHelper.dart';

class ProductController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  List<ProductDataModel> _productData = [];

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  List<ProductDataModel> get productData => _productData;

  Future<bool> fetchAndStoreProductData() async {
    _inProgress = true;
    update();
    final NetworkResponse response = await Networkcall.getRequest(Urls.Product);
    _inProgress = false;
    update();
    log(response.statusCode.toString());

    if (response.isSuccess) {
      List<ProductDataModel> products = (response.responseList as List)
          .map((data) => ProductDataModel.fromJson(data as Map<String, dynamic>))
          .toList();

      _productData = products;

      // Create a list of futures for saving products
      List<Future> insertFutures = products.map((product) async {
        log("Adding product to database: ${product.title}");
        await ProductDatabaseHelper.addOrUpdateProduct(product);
      }).toList();

      // Wait for all insert operations to complete
      await Future.wait(insertFutures);

      // Log saved products in the database
      List<ProductDataModel> savedProducts = await ProductDatabaseHelper.getAllProducts();
      log("##########################################################################################");
      log("Saved products in database:");

      for (var savedProduct in savedProducts) {
        log(savedProduct.toJson().toString());
      }

      update();
      return true;
    } else {
      _errorMessage = 'Fetch data failed';
      log(_errorMessage);
      update();
      return false;
    }
  }

  Future<void> loadProductDataFromDb() async {
    _inProgress = true;
    update();
    try {
      _productData = await ProductDatabaseHelper.getAllProducts();
    } catch (e) {
      _errorMessage = e.toString();
      log("Error loading data from database: $_errorMessage");
    } finally {
      _inProgress = false;
      update();
    }
  }
}
