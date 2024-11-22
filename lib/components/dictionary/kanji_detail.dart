import 'package:flutter/material.dart';
import 'package:nihongo/services/fetch_kanji_detail_service.dart';

class KanjiDetailPage extends StatelessWidget {
  final String? kanji;
  final VoidCallback? onBack;
  final FetchKanjiDetailService _kanjiExpandedDetailList = FetchKanjiDetailService();

  KanjiDetailPage({super.key, this.kanji, this.onBack});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onBack, // Gọi hàm quay lại
          ),
        ),
        FutureBuilder(
          future: _kanjiExpandedDetailList.getKanjiExpandedDetail(searchWord: kanji!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Hiển thị trạng thái loading khi dữ liệu đang được tải
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Hiển thị lỗi nếu quá trình fetch dữ liệu thất bại
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              // Hiển thị thông báo nếu không có dữ liệu hoặc kết quả là null
              return const Center(child: Text('No data available'));
            } else {
              // Hiển thị chi tiết từ vựng khi fetch thành công
              var kanjiDetail = snapshot.data!;
              return Center(
                child: Text(kanji ?? ''),
              );
            }
          }
        ),
      ],
    );
  }
}
