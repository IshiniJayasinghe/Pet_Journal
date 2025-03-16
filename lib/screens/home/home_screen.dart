import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import '../../models/product.dart';
import '../details/details_screen.dart';
import '../cart/cart_screen.dart';
import 'components/item_card.dart';
import 'components/categorries.dart'; // ✅ Import Categories if used
import '../details/components/add_to_cart.dart'; // ✅ Import cartItems

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSearchBar = false; // ✅ Track if search bar is active
  TextEditingController searchController = TextEditingController();
  List<Product> displayedProducts = List.from(products); // ✅ Copy of product list

  void updateSearch(String query) {
    setState(() {
      displayedProducts = products
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(), // ✅ Restored AppBar with search functionality
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!showSearchBar) const Categories(), // ✅ Show categories only if search is not active
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                itemCount: displayedProducts.length, // ✅ Use filtered list
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                  product: displayedProducts[index],
                  press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(product: displayedProducts[index]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Restored Original AppBar with Working Search Icon
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 249, 213, 54),
      elevation: 0,
      title: showSearchBar
          ? TextField(
              controller: searchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Search Products...",
                border: InputBorder.none,
              ),
              onChanged: updateSearch, // ✅ Filter products as user types
            )
          : const Text(
              "Pet Shop", // ✅ "Pet Shop" text restored in AppBar
              style: TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
      leading: showSearchBar
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: kTextColor),
              onPressed: () {
                setState(() {
                  showSearchBar = false;
                  searchController.clear();
                  displayedProducts = List.from(products); // ✅ Reset product list
                });
              },
            )
          : IconButton(
              icon: SvgPicture.asset("assets/icons/back.svg"),
              onPressed: () {},
            ),
      actions: <Widget>[
        if (!showSearchBar)
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
            ),
            onPressed: () {
              setState(() {
                showSearchBar = true; // ✅ Show search bar inside AppBar
              });
            },
          ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg",
            colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(cartItems: cartItems),
              ),
            );
          },
        ),
        const SizedBox(width: kDefaultPaddin / 2),
      ],
    );
  }
}
