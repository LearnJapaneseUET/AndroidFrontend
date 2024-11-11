import 'package:flutter/material.dart';
import 'package:nihongo/models/word_suggestion_model.dart';
import 'package:nihongo/services/fetch_word_suggestion_service.dart';

class searchWord extends SearchDelegate {
  final FetchWordSuggesstion _suggesstionList = FetchWordSuggesstion();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<WordSuggestion>>(
        future: _suggesstionList.getSugesstionList(searchWord: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<WordSuggestion>? data = snapshot.data;
          return ListView.builder(
            itemCount: data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  children: [
                    Text(
                      '${data?[index].writing}',
                      style: const TextStyle(
                        fontFamily: 'NotoSansJP',
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${data?[index].furigana}',
                      style: const TextStyle(
                        fontFamily: 'NotoSansJP',
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  '${data?[index].meaning}',
                  style: const TextStyle(
                    fontFamily: 'NotoSansJP',
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              );
            },
          );

        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search...'),
    );
  }
}