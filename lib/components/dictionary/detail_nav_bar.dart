import 'package:flutter/material.dart';

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
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
          color: isSelected ? Colors.white : Colors.grey[50],
        ),
      ),
    );
  }
}
