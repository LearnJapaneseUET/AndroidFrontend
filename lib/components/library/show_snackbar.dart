import 'package:flutter/material.dart';


void showSuccessMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green, // Set the background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Set the border radius
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
  );
}

void showErrorMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red, // Set the background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Set the border radius
      ),
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    ),
  );
}