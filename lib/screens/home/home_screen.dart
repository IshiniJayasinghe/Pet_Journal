import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import '../../models/product.dart';
import '../details/details_screen.dart';
import 'components/categorries.dart';
import 'components/item_card.dart';

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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 171, 19),
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
                "Pet Shop", // ✅ Now "Pet Shop" is in the AppBar
                style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
              ),
        leading: showSearchBar
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: kDefaultPaddin / 2),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!showSearchBar) const Categories(), // ✅ Keep categories only if search is not active
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
}
