import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import '../../cart/cart_screen.dart'; // ✅ Import CartScreen

List<Product> cartItems = []; // ✅ Global list to store cart items

class AddToCart extends StatelessWidget {
  const AddToCart({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          // ✅ "Add to Cart" button (only adds product, doesn't navigate)
          Container(
            margin: const EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: product.color,
              ),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/add_to_cart.svg",
                colorFilter: ColorFilter.mode(product.color, BlendMode.srcIn),
              ),
              onPressed: () {
                cartItems.add(product); // ✅ Add product to cart
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Cart!")),
                );
              },
            ),
          ),
          // ✅ "Buy Now" button (adds product & navigates to cart)
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (!cartItems.contains(product)) {
                  cartItems.add(product); // ✅ Add product if not already in cart
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(cartItems: cartItems),
                  ),
                ); // ✅ Navigate to cart page
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                backgroundColor: product.color,
              ),
              child: Text(
                "Buy Now".toUpperCase(), // ✅ Text remains unchanged
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
