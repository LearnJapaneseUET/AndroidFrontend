import 'package:flutter/material.dart';
import 'package:nihongo/services/fetch_word_detail_service.dart';
import 'package:nihongo/models/word_detail_model.dart';

class WordDetailPage extends StatelessWidget {
  final FetchWordDetailService _wordExpandedDetailList = FetchWordDetailService();
  final String? word;

  WordDetailPage({super.key, this.word});

  @override
  Widget build(BuildContext context) {
    if (word == null) {
      return const Center(child: Text('Từ vựng'));
    }

    return FutureBuilder<List<WordDetail>>(
      future: _wordExpandedDetailList.getWordExpandedDetailList(searchWord: word!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Lấy danh sách từ snapshot
        List<WordDetail> data = snapshot.data!;

        // Xử lý khi không có dữ liệu
        if (data.isEmpty) {
          return const Center(child: Text('No data available.'));
        }

        // Lấy thông tin từ WordDetail đầu tiên
        WordDetail wordDetail = data[0];

        return Scaffold(
          appBar: AppBar(
            title: Text(wordDetail.meaning.word),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(wordDetail.meaning.word),
                Text(wordDetail.meaning.phonetic),
                Text(wordDetail.meaning.shortMean),
                ...wordDetail.examples.map((example) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('${example.content} - ${example.mean}'),
                  );
                }).toList(),
                // Hiển thị các bình luận tương tự
              ],
            ),
          ),
        );
      },
    );

  }
}
