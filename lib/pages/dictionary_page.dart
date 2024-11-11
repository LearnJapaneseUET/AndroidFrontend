import 'package:flutter/material.dart';
import 'package:nihongo/components/my_textfield.dart';
import 'package:nihongo/components/nav_bar.dart';
import 'package:nihongo/components/search_field.dart';
import 'package:nihongo/models/word_suggestion_model.dart';
import 'package:nihongo/services/fetch_word_suggestion_service.dart';
class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFF8980F0),
          ),
          child: NavBar(),
        ),
        Expanded(
          child: Text('Hehe')
        )
      ],
    );
  }
}
