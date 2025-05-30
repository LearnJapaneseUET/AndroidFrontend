import 'package:flutter/material.dart';
import 'package:nihongo/services/fetch_word_detail_service.dart';
import 'package:nihongo/models/word_detail_model.dart';

class WordDetailPage extends StatelessWidget {
  final FetchWordDetailService _wordExpandedDetailList =
      FetchWordDetailService();
  final String? word;

  WordDetailPage({super.key, this.word});

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
          // Hiển thị chi tiết từ vựng khi fetch thành công
          var wordDetail = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề từ vựng
                  Text(
                    wordDetail.meaning?.word ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    wordDetail.meaning?.phonetic ?? '',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 4.0), // Thêm khoảng cách giữa phonetic và nghĩa
                  
                  // Hiển thị nghĩa ngắn
                  Text(
                    wordDetail.meaning?.shortMean ?? 'Không có nghĩa',
                    style: const TextStyle(color: Colors.blue),
                  ),
            
                  // Hiển thị các thông tin trong 'means'
                  ...?wordDetail.meaning?.means?.map(
                    (meanDetail) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hiển thị 'kind' và 'mean'
                        Text(
                          meanDetail.kind ?? '',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "◆ ${meanDetail.mean}",
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 14.0,
                          ),
                        ),
                        
                        // Hiển thị các ví dụ
                        if (meanDetail.examples?.isNotEmpty ?? false) ...[
                          const SizedBox(height: 8.0),
                          ...?meanDetail.examples?.map<Widget>((example) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  example.transcription ?? '',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  example.content ?? '',
                                  style: const TextStyle(color: Colors.red),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  example.mean ?? '',
                                ),
                              ],
                            );
                          }),
                        ]
                      ],
                    ),
                  ),
                  
                  // Khoảng cách trước Divider
                  const SizedBox(height: 20.0),
                  Divider(color: Colors.grey[300], thickness: 2),
            
                  const Text(
                    'Comments:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  
                  // Hiển thị danh sách comments
                  ...?wordDetail.comments?.map(
                    (comment) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '- ${comment.mean}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(Icons.thumb_up, size: 16.0, color: Colors.green),
                              const SizedBox(width: 4.0),
                              Text('${comment.like}'),
                              const SizedBox(width: 16.0),
                              const Icon(Icons.thumb_down, size: 16.0, color: Colors.red),
                              const SizedBox(width: 4.0),
                              Text('${comment.dislike}'),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'By: ${comment.username}',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }    
      },
    );
  }
}
