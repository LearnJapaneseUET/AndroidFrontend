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
        // Wrap QuickSearchScreen in Expanded to avoid layout issues
        Expanded(
          child: QuickSearchScreen(
            onValueChanged: widget.onValueChanged,
          ),
        ),
        const SizedBox(width: 5.0),
        const Icon(Icons.mic, color: Colors.white),
      ],
    );
  }
}
