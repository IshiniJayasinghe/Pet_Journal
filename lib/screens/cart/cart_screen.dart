import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.cartItems});

  final List<Product> cartItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: const Color.fromARGB(255, 247, 205, 114),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    cartItems[index].image,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(cartItems[index].title),
                  subtitle: Text("\$${cartItems[index].price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      cartItems.removeAt(index);
                      (context as Element).markNeedsBuild(); // Refresh UI
                    },
                  ),
                );
              },
            ),
    );
  }
}
