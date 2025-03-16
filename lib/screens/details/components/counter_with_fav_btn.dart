import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models/product.dart';
import 'cart_counter.dart';

class CounterWithFavBtn extends StatelessWidget {
  const CounterWithFavBtn({super.key, required this.product});

  final Product product; // ✅ Get product details for color

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // ✅ Align text to the left
      children: [
        Text(
          "Quantity", // ✅ Label above counter
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: product.color, // ✅ Set text color to match product background
          ),
        ),
        const SizedBox(height: 5), // ✅ Small spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const CartCounter(),
            Container(
              padding: const EdgeInsets.all(8),
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                color: Color(0xFFFF6464),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset("assets/icons/heart.svg"),
            ),
          ],
        ),
      ],
    );
  }
}
