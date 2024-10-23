import 'package:flutter/material.dart';
import '../../service/database_helper.dart';

class NewAdded_Cart extends StatefulWidget {
  final int id; // Add id field
  final String title;
  final String description;
  final String price;
  final String quantity;
  final Function onDelete; // Callback to refresh cart list after deletion

  const NewAdded_Cart({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    required this.onDelete,
  });

  @override
  _NewAddedCartState createState() => _NewAddedCartState();
}

class _NewAddedCartState extends State<NewAdded_Cart> {
  int quantity = 1; // Initial quantity

  void _incrementQuantity() {
    setState(() {
      quantity++; // Increase quantity
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--; // Decrease quantity, prevent going below 1
      }
    });
  }

  void _deleteItem() async {
    await DatabaseHelper.deleteData(widget.id);
    widget.onDelete(); // Call the callback to refresh the cart list
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(const PostDetails());
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Card(
          color: Colors.grey.shade100,
          shadowColor: Colors.black,
          elevation: 5,
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      image: NetworkImage(widget.description),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded( // Use Expanded to take remaining space
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 1,
                          style: const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          widget.description,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          'Price: ${widget.price}',
                          maxLines: 1,
                          style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4), // Remove padding around the Row
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min, // Minimize size to only what's needed
                        children: [
                          GestureDetector(
                            onTap: _decrementQuantity,
                            child: const Icon(Icons.remove, size: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              quantity.toString(), // Display the current quantity
                              style: const TextStyle(fontSize: 16), // Adjust font size as needed
                            ),
                          ),
                          GestureDetector(
                            onTap: _incrementQuantity,
                            child: const Icon(Icons.add, size: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      GestureDetector(
                        onTap: _deleteItem,
                        child: const Icon(Icons.delete, size: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
