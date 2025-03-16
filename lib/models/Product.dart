import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, id;
  final Color color;

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.color,
  });
}

// ✅ Pet Food Products with detailed descriptions
List<Product> products = [
  Product(
    id: 1,
    title: "Premium Dog Food",
    price: 1200,
    description:
        "A high-quality, protein-rich dog food made with real chicken and wholesome grains to support healthy digestion and muscle development. Enriched with essential vitamins and minerals for a shiny coat, strong bones, and an active lifestyle. Suitable for adult dogs of all breeds.",
    image: "assets/images/dogfood_6.png",
    color: const Color(0xFF3D82AE),
  ),
  Product(
    id: 2,
    title: "Grain-Free Cat Food",
    price: 1500,
    description:
        "A nutritious, grain-free cat food formula made with fresh salmon and natural ingredients. Packed with Omega-3 fatty acids for a healthy coat, prebiotics for digestion, and taurine to support heart and vision health. Ideal for cats with sensitive stomachs.",
    image: "assets/images/dogfood_2.png",
    color: const Color(0xFFD3A984),
  ),
  Product(
    id: 3,
    title: "Organic Bird Feed",
    price: 800,
    description:
        "A premium blend of organic seeds, dried fruits, and nuts specially formulated for parrots, finches, and other pet birds. Contains no artificial preservatives, ensuring a natural and balanced diet. Fortified with calcium and essential nutrients to promote feather health and strong bones.",
    image: "assets/images/dogfood_3.png",
    color: const Color.fromARGB(255, 90, 160, 221),
  ),
  Product(
    id: 4,
    title: "Rabbit & Guinea Pig Pellets",
    price: 950,
    description:
        "A specially formulated blend of hay, vegetables, and essential fibers to support digestive health and dental care in rabbits and guinea pigs. High in natural antioxidants to strengthen immunity, with a delicious taste your small pets will love!",
    image: "assets/images/dogfood_5.png",
    color: const Color.fromARGB(255, 152, 230, 181),
  ),
  Product(
    id: 5,
    title: "Tropical Fish Flakes",
    price: 600,
    description:
        "A complete and balanced diet for tropical fish, rich in high-quality proteins, vitamins, and natural color-enhancing ingredients. Designed to improve immunity, energy levels, and vibrant colors in your fish. Doesn't cloud the water and is easy to digest.",
    image: "assets/images/dogfood_6.png",
    color: const Color.fromARGB(255, 251, 179, 120),
  ),
  Product(
    id: 6,
    title: "Puppy Growth Formula",
    price: 1800,
    description:
        "A specially crafted puppy food designed to support rapid growth, brain development, and a strong immune system. Contains DHA for cognitive function, high-quality chicken protein for muscle growth, and calcium for healthy bones. Perfect for puppies up to 12 months old.",
    image: "assets/images/dogfood_2.png",
    color: const Color.fromARGB(255, 173, 88, 225),
  ),
];
