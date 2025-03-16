import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.cartItems});

  final List<Product> cartItems;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: const Color.fromARGB(255, 241, 171, 19),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    widget.cartItems[index].image,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(widget.cartItems[index].title),
                  subtitle: Text(
                    "Rs. ${widget.cartItems[index].price}", // ✅ Changed from $ to Rs.
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        widget.cartItems.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
