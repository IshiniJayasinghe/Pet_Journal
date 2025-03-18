import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final Widget
  icon; // ✅ Changed to Widget to accept both Image.asset() & Icon()
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  const CategoryButton({
    Key? key,
    required this.icon, // ✅ Now supports images & icons
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: Center(child: icon), // ✅ Ensures the icon is centered
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
