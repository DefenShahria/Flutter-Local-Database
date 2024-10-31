import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaphy/ui/auth/auth_service.dart';
import 'package:ghaphy/ui/auth/login.dart';
import 'package:ghaphy/ui/homeScreen/widgets/homapage_card.dart';
import '../../statemanager/all_Product_Controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // For testing
  final bool icheck = true;
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (icheck) {
        Get.find<ProductController>().fetchAndStoreProductData();
      } else {
        Get.find<ProductController>().loadProductDataFromDb();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Product List'),
          actions: [
            IconButton(onPressed: ()async{
              await authService.signOut();
              Get.to(const LoginPage());

            }, icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: GetBuilder<ProductController>(
          builder: (productController) {
            if (productController.inProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // if (productController.errorMessage.isNotEmpty) {
            //   return Center(
            //     child: Text(productController.errorMessage),
            //   );
            // }
            return Column(
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     // Printing all product data from the database
                //     for (var product in productController.productData) {
                //       print('ID: ${product.id}');
                //       print('Title: ${product.title}');
                //       print('Price: ${product.price}');
                //       print('Description: ${product.description}');
                //       print('Category: ${product.category}');
                //       print('Image: ${product.image}');
                //       if (product.rating != null) {
                //         print('Rating: ${product.rating!.rate}');
                //         print('Rating Count: ${product.rating!.count}');
                //       }
                //       print('--------------------------------------------------');
                //     }
                //   },
                //   child: const Text("Check"),
                // ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: productController.productData.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        title: '${productController.productData[index].title}',
                        imageUrl: '${productController.productData[index].image}',
                        price: '${productController.productData[index].price}',
                        id: productController.productData[index].id ?? 0,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
