import 'package:flutter/material.dart';

class BottomIndicator extends StatelessWidget {
  const BottomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(75, 8, 75, 8),
      // color: Colors.black.withOpacity(0.005),
      child: Center(
        child: Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xFFD3D9EB),
          ),
        ),
      ),
    );
  }
}