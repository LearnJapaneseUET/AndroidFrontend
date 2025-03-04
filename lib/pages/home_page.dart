import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nihongo/pages/dictionary_page.dart';
import 'package:nihongo/pages/chatbot_page.dart';
import 'package:nihongo/pages/library/library_page.dart';
import 'package:nihongo/pages/profile_page.dart';
import 'package:nihongo/pages/translation_page.dart';
import 'package:nihongo/pages/socket_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User user = FirebaseAuth.instance.currentUser!;
  int _currentIndex = 0;
  List<Widget> tabs = [
    const DictionaryPage(),
    const TranslationPage(),
    const LibraryPage(),
    const ChatbotPage(),
    const ChatRoomPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    log("User ID: ${user.uid}");
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF8980F0),
        toolbarHeight: 10.0,
      ),
      body: tabs[_currentIndex], // Display the selected tab
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: '',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: '',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wechat),
            label: '',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
            backgroundColor: Colors.purple,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
