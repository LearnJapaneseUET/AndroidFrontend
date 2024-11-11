import 'package:flutter/material.dart';
import 'package:nihongo/models/word_suggestion_model.dart';
import 'package:nihongo/pages/dictionary_page.dart';
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
        return Expanded(
          child: ListView.builder(
            itemCount: data?.length ?? 0, // Đảm bảo itemCount không null
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
                        fontWeight: FontWeight.w900
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
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                subtitle: Text(
                  '${data?[index].meaning}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis, // Thêm nếu bạn muốn cắt bớt văn bản
                ),
                onTap: () {
                  // Điều hướng đến trang mới khi nhấp vào ListTile
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DictionaryPage(word: '${data?[index].writing}'), // Truyền dữ liệu nếu cần
                    ),
                  );
                },
              );
            },
          ),
        );
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search...'),
    );
  }
}