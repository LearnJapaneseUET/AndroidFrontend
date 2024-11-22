import 'package:flutter/material.dart';
import 'package:nihongo/components/dictionary/kanji_detail.dart';
import 'package:nihongo/models/kanji_detail_model.dart';

class KanjiList extends StatefulWidget {
  final String? searchWord;
  const KanjiList({super.key, this.searchWord});

  @override
  State<KanjiList> createState() => _KanjiListState();
}

class _KanjiListState extends State<KanjiList> {
  String? selectedKanji; // Chữ Hán được chọn

  @override
  Widget build(BuildContext context) {
    // Nếu đã chọn Kanji, hiển thị màn hình chi tiết
    if (selectedKanji != null) {
      return KanjiDetailPage(
        kanji: selectedKanji,
        onBack: () {
          // Trở về danh sách Kanji
          setState(() {
            selectedKanji = null;
          });
        },
      );
    }

    // Tách searchWord thành danh sách ký tự
    final kanjiList = widget.searchWord?.split('') ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách Kanji'),
      ),
      body: ListView.builder(
        itemCount: kanjiList.length,
        itemBuilder: (context, index) {
          final kanji = kanjiList[index];
          return ListTile(
            title: Text(
              kanji,
              style: const TextStyle(fontSize: 24),
            ),
            onTap: () {
              // Chuyển sang chi tiết Kanji
              setState(() {
                selectedKanji = kanji;
              });
            },
          );
        },
      ),
    );
  }
}
