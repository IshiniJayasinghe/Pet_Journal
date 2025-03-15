import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, id;
  final Color color;

  Product({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.id,
    required this.color,
  });
}

List<Product> products = [
  Product(
    id: 1,
    title: "Bairo food",
    price: 1500,
    description: dummyText,
    image: "assets/images/dogfood_3.png",
    color: const Color.fromARGB(255, 241, 171, 19),
  ),
  Product(
    id: 2,
    title: "Adult food",
    price: 1999,
    description: dummyText,
    image: "assets/images/dogfood_2.png",
    color: const Color.fromARGB(255, 241, 171, 19),
  ),
  Product(
    id: 3,
    title: "abc",
    price: 234,
    description: dummyText,
    image: "assets/images/dogfood_4.png",
    color: const Color.fromARGB(255, 241, 171, 19),
  ),
  Product(
    id: 4,
    title: "Old Fashion",
    price: 234,
    description: dummyText,
    image: "assets/images/dogfood_5.png",
    color: const Color.fromARGB(255, 241, 171, 19),
  ),
  Product(
    id: 5,
    title: "Office Code",
    price: 234,
    description: dummyText,
    image: "assets/images/dogfood_6.png",
    color: const Color.fromARGB(255, 241, 171, 19),
  ),
  Product(
    id: 6,
    title: "Office Code",
    price: 234,
    description: dummyText,
    image: "assets/images/dogfood_6.png",
    color: const Color.fromARGB(255, 241, 171, 19),
  ),
];

String dummyText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
