import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import '../../models/product.dart';
import 'components/add_to_cart.dart';
import 'components/counter_with_fav_btn.dart';
import 'components/description.dart';
import 'components/product_title_with_image.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1; // ✅ Track selected quantity

  void updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: widget.product.color,
      appBar: AppBar(
        backgroundColor: widget.product.color,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white), // ✅ Profile Icon
            onPressed: () {
              // TODO: Connect to Profile Page later
            },
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/cart.svg"),
            onPressed: () {
              // TODO: Navigate to Cart Page if needed
            },
          ),
          const SizedBox(width: kDefaultPaddin / 2),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: kDefaultPaddin / 2),
                        Description(product: widget.product),
                        const SizedBox(height: kDefaultPaddin / 2),
                        CounterWithFavBtn(
                          product: widget.product,
                          onQuantityChanged: updateQuantity, // ✅ Pass quantity update
                        ),
                        const SizedBox(height: kDefaultPaddin / 2),
                        AddToCart(
                          product: widget.product,
                          quantity: quantity, // ✅ Pass correct quantity
                        ),
                      ],
                    ),
                  ),
                  ProductTitleWithImage(product: widget.product), // ✅ Correct placement of title & image
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
