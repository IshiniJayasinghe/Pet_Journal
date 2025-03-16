import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/product.dart';
import '../details/components/add_to_cart.dart'; // ✅ Import cartItems

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.cartItems});

  final List<CartItem> cartItems;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: kTextColor,
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
                final cartItem = widget.cartItems[index];

                return ListTile(
                  leading: Image.asset(
                    cartItem.product.image,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(cartItem.product.title),
                  subtitle: Text(
                    "Rs. ${cartItem.product.price * cartItem.quantity}", // ✅ Correct total price
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "x${cartItem.quantity}", // ✅ Show correct quantity
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            widget.cartItems.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
