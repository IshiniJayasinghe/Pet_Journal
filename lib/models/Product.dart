import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
  final Color color;

  Product(
      {required this.image,
      required this.title,
      required this.description,
      required this.price,
      required this.size,
      required this.id,
      required this.color});
}

List<Product> products = [
  Product(
      id: 1,
      title: "Bairo food",
      price: 1500,
      size: 12,
      description: dummyText,
      image: "assets/images/dogfood_3.png",
      color: const Color.fromARGB(255, 119, 139, 235)),
  Product(
      id: 2,
      title: "Adult food",
      price: 1999,
      size: 8,
      description: dummyText,
      image: "assets/images/dogfood_2.png",
      color: const Color.fromARGB(255, 227, 158, 241)),
  Product(
      id: 3,
      title: "abc",
      price: 234,
      size: 10,
      description: dummyText,
      image: "assets/images/dogfood_4.png",
      color: const Color.fromARGB(255, 190, 147, 110)),
  Product(
      id: 4,
      title: "Old Fashion",
      price: 234,
      size: 11,
      description: dummyText,
      image: "assets/images/dogfood_5.png",
      color: const Color.fromARGB(255, 236, 201, 43)),
  Product(
      id: 5,
      title: "Office Code",
      price: 234,
      size: 12,
      description: dummyText,
      image: "assets/images/dogfood_6.png",
      color: const Color.fromARGB(255, 169, 186, 241)),
  Product(
    id: 6,
    title: "Office Code",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/bag_6.png",
    color: const Color(0xFFAEAEAE),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
