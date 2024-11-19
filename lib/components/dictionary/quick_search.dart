import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nihongo/models/word_suggestion_model.dart';
import 'package:nihongo/services/fetch_word_suggestion_service.dart';

class QuickSearchScreen extends StatefulWidget {
  final Function(String) onValueChanged;  // Thêm callback vào constructor

  const QuickSearchScreen({super.key, required this.onValueChanged});

  @override
  _QuickSearchScreenState createState() => _QuickSearchScreenState();
}

class _QuickSearchScreenState extends State<QuickSearchScreen> {
  final FetchWordSuggesstionService _suggestionService = FetchWordSuggesstionService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: TypeAheadField<WordSuggestion>(
        suggestionsCallback: (search) => _suggestionService.getSugesstionList(searchWord: search),
        builder: (context, controller, focusNode) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            autofocus: true,
            style: const TextStyle(fontSize: 18.0),
          );
        },
        itemBuilder: (BuildContext context, WordSuggestion suggestion) {
          return ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    suggestion.writing ?? '',
                    style: const TextStyle(
                      fontFamily: 'NotoSansJP',
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    suggestion.furigana ?? '',
                    style: const TextStyle(
                      fontFamily: 'NotoSansJP',
                      color: Colors.red,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              suggestion.meaning ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        onSelected: (WordSuggestion suggestion) {
          setState(() {
            // Gọi callback khi một giá trị được chọn
            widget.onValueChanged(suggestion.writing ?? '');
          });
        },
      ),
    );
  }
}
