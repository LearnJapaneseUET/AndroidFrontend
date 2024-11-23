import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nihongo/pages/dictionary_page.dart';
import 'package:nihongo/pages/chatbot_page.dart';
import 'package:nihongo/pages/library/library_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User user = FirebaseAuth.instance.currentUser!;
  int _currentIndex = 0;
  final tabs = [
    const DictionaryPage(),
    const Center(child: Text('Translate')),
    const LibraryPage(),
    const ChatbotPage(),
    const Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    print("id");
    print(user.uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8980F0),
        toolbarHeight: 10.0,
      ),
      body: Navigator(onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => tabs[_currentIndex],
        );
      }),
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

  List<Object> get newMethod => tabs;
}
