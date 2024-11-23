import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nihongo/services/fetch_kanji_detail_service.dart';
import 'package:xml/xml.dart' as xml;

String cleanSvg(String rawSvg) {
  // Loại bỏ namespace
  return rawSvg.replaceAll(RegExp(r'ns\d+:'), '');
}

String changeStrokeColor(String svgData) {
  List<String> strokeColors = [
    "#1E90FF",  
    "#0000FF",  
    "#FF1493",  
    "#FF4500",  
    "#DAA520",  
    "#32CD32",  
    "#008000",  
    "#20B2AA",  
    "#9370DB",  
  ];

  final document = xml.XmlDocument.parse(svgData);
  final elements = document.findAllElements('ns0:path'); // Lọc các phần tử path

  // Thay đổi màu stroke cho từng path
  for (int i = 0; i < elements.length; i++) {
    elements.elementAt(i).setAttribute('stroke', strokeColors[i % strokeColors.length]);
  }

  // Trả về dữ liệu SVG sau khi thay đổi
  return document.toXmlString(pretty: true);
}

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
              return Column(
                children: [
                  if (kanjiDetail.kanjiArt != null)
                    Center(
                      child: SvgPicture.string(
                        cleanSvg(changeStrokeColor(kanjiDetail.kanjiArt!)),
                        width: 200, // Đặt kích thước tùy ý
                        height: 200,
                      ),
                    )
                  else
                    const Center(
                      child: Text("Không có dữ liệu hình ảnh", style: TextStyle(color: Colors.red)),
                    ),
                ],
              );
            }
          }
        ),
      ],
    );
  }
}
