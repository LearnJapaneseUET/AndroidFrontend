import 'package:flutter/material.dart';
import 'package:nihongo/components/dictionary/example_detail.dart';
import 'package:nihongo/components/dictionary/kanji_list.dart';
import 'package:nihongo/components/dictionary/nav_bar.dart';
import 'package:nihongo/components/dictionary/quick_search.dart';
import 'package:nihongo/components/dictionary/word_detail.dart';
import 'package:nihongo/components/dictionary/detail_nav_bar.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  int selectedIndex = 0;
  String _receivedValue = ""; // Hàm sẽ nhận giá trị từ component con

  void updateSearchWord(String value) {
    setState(() {
      _receivedValue = value;
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      // Center(child: Text('Từ vựng')),
      WordDetailPage(word: _receivedValue),
      KanjiList(searchWord: _receivedValue),
      // Center(child: Text('Chữ Hán')),
      WordExamplePage(word: _receivedValue),
    ];

    return Column(
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xFF8980F0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                NavBar(onValueChanged: updateSearchWord),
                const SizedBox(height: 10.0),
                if (_receivedValue.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      NavBarButton(
                        text: 'Từ vựng',
                        isSelected: selectedIndex == 0,
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                      ),
                      NavBarButton(
                        text: 'Chữ Hán',
                        isSelected: selectedIndex == 1,
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                      ),
                      NavBarButton(
                        text: 'Ví dụ',
                        isSelected: selectedIndex == 2,
                        onTap: () {
                          setState(() {
                            selectedIndex = 2;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
        Expanded( // Ensure this is inside Expanded for the Scrollable content to fit
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/appbar.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            child: SingleChildScrollView(  // Wrapping with SingleChildScrollView to avoid overflow
              child: tabs[selectedIndex],  // Your content here
            ),
          ),
        ),
      ],
    );
  }
}
