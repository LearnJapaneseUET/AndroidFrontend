import 'package:flutter/material.dart';
import 'package:nihongo/components/dictionary/example_detail.dart';
import 'package:nihongo/components/dictionary/word_detail.dart';
import 'package:nihongo/components/my_button.dart';
import 'package:nihongo/components/my_textfield.dart';
import 'package:nihongo/components/dictionary/nav_bar.dart';
import 'package:nihongo/components/dictionary/detail_nav_bar.dart';
import 'package:nihongo/components/dictionary/search_field.dart';
import 'package:nihongo/models/word_detail_model.dart';
import 'package:nihongo/models/word_suggestion_model.dart';
import 'package:nihongo/services/fetch_word_detail_service.dart';
import 'package:nihongo/services/fetch_word_suggestion_service.dart';
class DictionaryPage extends StatefulWidget {
  final String? word;
  const DictionaryPage({super.key,  this.word});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {  
    final tabs = [
      // Center(child: Text('Từ vựng')),
      WordDetailPage(word: widget.word),
      Center(child: Text('Chữ Hán')),
      WordExamplePage(word: widget.word),
    ];

    return Column(
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xFF8980F0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Column(
              children: [
                const NavBar(),
                const SizedBox(height: 10.0),
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
            ),
          ),
        ),
        Expanded(
          // // child: Text('Hehe')
          // child: widget.word != null 
          //   ? Text(widget.word!)
          //   : const Text('Không có từ nào được cung cấp'),  
          child: tabs[selectedIndex],
        )
      ],
    );
  }
}
