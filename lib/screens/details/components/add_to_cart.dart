import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import '../../cart/cart_screen.dart'; // ✅ Import CartScreen

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

// ✅ Ensure cartItems is globally accessible
List<CartItem> cartItems = [];  

class AddToCart extends StatefulWidget {
  const AddToCart({super.key, required this.product, required this.quantity});

  final Product product;
  final int quantity; // ✅ Get quantity from product details

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  void addToCart() {
    bool productExists = false;

    for (var item in cartItems) {
      if (item.product.id == widget.product.id) {
        item.quantity = widget.quantity; // ✅ Update quantity in cart
        productExists = true;
        break;
      }
    }

    if (!productExists) {
      cartItems.add(CartItem(product: widget.product, quantity: widget.quantity)); // ✅ Add new product
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: widget.product.color,
              ),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/add_to_cart.svg",
                colorFilter: ColorFilter.mode(widget.product.color, BlendMode.srcIn),
              ),
              onPressed: () {
                setState(() {
                  addToCart();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Cart!")),
                );
              },
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  addToCart();
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(cartItems: cartItems),
                  ),
                ); // ✅ Navigate to Cart Page
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                backgroundColor: widget.product.color,
              ),
              child: Text(
                "Buy Now".toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
