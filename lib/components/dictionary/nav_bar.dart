import 'package:flutter/material.dart';
import 'package:nihongo/components/dictionary/quick_search.dart';

class NavBar extends StatefulWidget {
  final Function(String) onValueChanged;  // Callback vào constructor

  const NavBar({super.key, required this.onValueChanged});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: const Color(0xFF8980F0)),
            ),
            child: QuickSearchScreen(
              onValueChanged: widget.onValueChanged,  // Truyền callback vào QuickSearchScreen
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        const Icon(Icons.cloud, color: Colors.white),
        const SizedBox(width: 5.0),
        const Icon(Icons.edit, color: Colors.white),
        const SizedBox(width: 5.0),
        const Icon(Icons.mic, color: Colors.white),
        const SizedBox(width: 5.0),
        const Icon(Icons.camera_alt, color: Colors.white),
      ],
    );
  }
}
