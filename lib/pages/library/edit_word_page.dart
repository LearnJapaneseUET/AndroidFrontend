import 'package:flutter/material.dart';
import 'package:nihongo/components/library/show_snackbar.dart';

import '../../components/library/create_button.dart';
import '../../components/library/input_field.dart';
import '../../models/library/Word.dart';
import '../../services/library/sv_word.dart';

class EditWordPage extends StatefulWidget {
  final Word word;

  const EditWordPage({super.key, required this.word});

  @override
  State<EditWordPage> createState() => _EditWordPageState();
}

class _EditWordPageState extends State<EditWordPage> {
  final WordService _wordService = WordService();

  TextEditingController furiganaController = TextEditingController();
  TextEditingController meaningController = TextEditingController();

  @override
  void initState() {
    super.initState();
    furiganaController.text = widget.word.furigana!;
    meaningController.text = widget.word.meaning;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: _appBar(),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 12, 16, 0),
              child: Text(
                'Furigana',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2A2D37),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: InputField(
                hintText: 'Nhập furigana',
                textController: furiganaController,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 12, 16, 0),
              child: Text(
                'Ý nghĩa',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2A2D37),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: InputField(
                hintText: 'Nhập ý nghĩa',
                textController: meaningController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: CreateButton(
                text: 'Sửa',
                onPressed: _handleEditWord,
              ),
            ),
          ],
        )));
  }

  Future<void> _handleEditWord() async {
    if (meaningController.text.isEmpty) {
      showErrorMessage("Điền đầy đủ nghĩa từ vựng!", context);
      return;
    }

    await _wordService.editWord(
      widget.word.id,
      furiganaController.text,
      meaningController.text
    );

    showSuccessMessage("Đổi thông tin từ vựng thành công", context);
    furiganaController.clear();
    meaningController.clear();
  }

  AppBar _appBar() {
    return AppBar(
      leading: const BackButton(color: Colors.white),
      title: const Text(
        "Sửa từ vựng",
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'Noto Sans',
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xFF8980F0),
    );
  }
}
