import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              color: isSelected ? Colors.white : Colors.grey[50],
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 3.0), // Space between the triangle and the text
              height: 10,  // Height of the triangle
              width: 20,   // Width of the triangle
              child: SvgPicture.asset(
                'assets/images/triangle.svg',  // Path to your SVG triangle
                color: Colors.white,            // Set color if needed
                fit: BoxFit.contain,
              ),
            )
        ],
      ),
    );
  }
}
