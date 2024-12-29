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
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TypeAheadField<WordSuggestion>(
        suggestionsCallback: (search) => _suggestionService.getSugesstionList(searchWord: search),
        builder: (context, controller, focusNode) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Tìm kiếm...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                // borderSide: BorderSide(color: Color(0xFF8980F0)),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0), 
              prefixIcon: Icon(Icons.search, color: Color(0xFF8980F0)),
              fillColor: Colors.white,
              filled: true,
            ),
            style: const TextStyle(fontSize: 18.0),
            maxLines: 1,
          );
        },
        itemBuilder: (BuildContext context, WordSuggestion suggestion) {
          if (suggestion.writing == null || suggestion.writing!.isEmpty) {
            return const SizedBox.shrink(); // Không hiển thị gì cả
          }
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
