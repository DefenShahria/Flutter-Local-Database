import 'package:flutter/material.dart';
import '../../data/card_model.dart';
import '../../service/database_helper.dart';
import 'cart_card.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  late Future<List<Cart>> cartListFuture;

  @override
  void initState() {
    super.initState();
    _refreshCartList();
  }

  void _refreshCartList() {
    setState(() {
      cartListFuture = DatabaseHelper.getAllData().then((value) => value ?? []);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart Screen")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Cart>>(
              future: cartListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No items in the cart'));
                } else {
                  final cartList = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartList[index];
                      return NewAdded_Cart(
                        id: cartItem.id!,
                        title: cartItem.title,
                        description: cartItem.description,
                        price: cartItem.price,
                        quantity: cartItem.quantity,
                        onDelete: _refreshCartList, // Pass the refresh function to the cart item
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
