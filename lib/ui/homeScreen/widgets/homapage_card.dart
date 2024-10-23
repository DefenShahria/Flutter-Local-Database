import 'package:flutter/material.dart';

import '../../../data/card_model.dart';
import '../../../service/database_helper.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String price;
  final int id;


  const ProductCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(10),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 55,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blue, // Set the background color for the container
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set the button's background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Match the button's radius with the container
                ),
              ),
              onPressed: () async{
                var orderData = Cart(
                  id: id,
                  title: title,
                  price: price ,
                  description: imageUrl,
                  quantity: '1',
                );

                await DatabaseHelper.addData(orderData);

              },
              child: const Text("Add to Cart",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
            ),
          ),

        )
      ],
    );
  }
}
