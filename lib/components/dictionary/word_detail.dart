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

    return FutureBuilder<Meaning?>(
      future: _wordExpandedDetailList.getWordExpandedDetail(searchWord: word!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Lấy Meaning từ snapshot
        Meaning? meaning = snapshot.data;

        // Xử lý khi không có dữ liệu
        if (meaning == null) {
          return const Center(child: Text('No data available.'));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(meaning.word),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(meaning.phonetic),
                Text(meaning.shortMean),
                // Hiển thị các thông tin trong 'means'
                ...meaning.means.map((meanDetail) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hiển thị 'mean' và 'kind'
                        Text(meanDetail.kind),
                        Text(meanDetail.mean),

                        // Hiển thị các ví dụ
                        ...meanDetail.examples.map((example) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('${example.content} - ${example.mean}'),
                          );
                        }).toList(),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
