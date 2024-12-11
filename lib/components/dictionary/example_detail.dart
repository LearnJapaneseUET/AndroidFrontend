import 'package:flutter/material.dart';
import 'package:nihongo/services/fetch_word_detail_service.dart';
import 'package:nihongo/models/word_detail_model.dart';

class WordExamplePage extends StatelessWidget {
  final FetchWordDetailService _wordExpandedDetailList = FetchWordDetailService();
  final String? word;

  WordExamplePage({super.key, this.word});

  @override
  Widget build(BuildContext context) {
    if (word == null) {
      return const Center(child: Text('Từ vựng'));
    }

    return FutureBuilder<WordDetailModel?>(
      future: _wordExpandedDetailList.getWordExplainDetail(searchWord: word!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Hiển thị trạng thái loading khi dữ liệu đang được tải
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Hiển thị lỗi nếu quá trình fetch dữ liệu thất bại
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          // Hiển thị thông báo nếu không có dữ liệu hoặc kết quả là null
          return const Center(child: Text(''));
        } else {
          // Hiển thị danh sách dữ liệu khi fetch thành công
          var wordDetail = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Hiển thị danh sách example với thông tin chi tiết
                ...?wordDetail.examples?.map(
                  (example) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          example.transcription ?? '',
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey
                          ),
                        ),
                        Text(
                          example.content ?? '',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.red
                          ),
                        ),
                        Text(
                          '- ${example.mean}',
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        };
      }
    );
  }
}
