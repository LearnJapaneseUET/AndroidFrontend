import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final String text;
  const CreateButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Implement create functionality
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8980F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}