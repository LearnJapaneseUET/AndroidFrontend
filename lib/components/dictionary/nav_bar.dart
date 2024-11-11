import 'package:flutter/material.dart';
import 'package:nihongo/components/dictionary/search_field.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: const Color(0xFF8980F0)),
            ),
            child: GestureDetector(
              onTap: () => {
                showSearch(context: context, delegate: searchWord())
              },
              child: Row(
                children: [
                  // First Row with search icon and text
                  const SizedBox(width: 10.0),
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 5.0),
                  Text('Tìm kiếm...', style: Theme.of(context).textTheme.bodySmall)                  ],
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 10.0),
        const Icon(Icons.cloud, color: Colors.white),
        const SizedBox(width: 5.0), // Gap between icons
        const Icon(Icons.edit, color: Colors.white),
        const SizedBox(width: 5.0), // Gap between icons
        const Icon(Icons.mic, color: Colors.white),
        const SizedBox(width: 5.0), // Gap between icons
        const Icon(Icons.camera_alt, color: Colors.white),
      ],
    );
  }
}
