import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models/product.dart';
import 'cart_counter.dart';

class CounterWithFavBtn extends StatefulWidget {
  const CounterWithFavBtn({
    super.key,
    required this.product,
    required this.onQuantityChanged, // ✅ Accept quantity update function
  });

  final Product product;
  final Function(int) onQuantityChanged; // ✅ Callback function

  @override
  State<CounterWithFavBtn> createState() => _CounterWithFavBtnState();
}

class _CounterWithFavBtnState extends State<CounterWithFavBtn> {
  int numOfItems = 1; // ✅ Track quantity

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
            color: widget.product.color, // ✅ Matches product background color
          ),
        ),
        const SizedBox(height: 5), // ✅ Small spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                buildOutlinedButton(
                  icon: Icons.remove,
                  press: () {
                    setState(() {
                      if (numOfItems > 1) {
                        numOfItems--;
                        widget.onQuantityChanged(numOfItems); // ✅ Update quantity in details screen
                      }
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    numOfItems.toString().padLeft(2, "0"),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                buildOutlinedButton(
                  icon: Icons.add,
                  press: () {
                    setState(() {
                      numOfItems++;
                      widget.onQuantityChanged(numOfItems); // ✅ Update quantity in details screen
                    });
                  },
                ),
              ],
            ),
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
        const SizedBox(height: 5), // ✅ Space between counter and subtotal
        Text(
          "Subtotal: Rs. ${widget.product.price * numOfItems}", // ✅ Subtotal Calculation
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: widget.product.color, // ✅ Match product color
          ),
        ),
      ],
    );
  }

  Widget buildOutlinedButton({required IconData icon, required VoidCallback press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
