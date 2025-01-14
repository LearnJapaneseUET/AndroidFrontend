import 'package:flutter/material.dart';
import 'package:nihongo/components/library/show_snackbar.dart';

import '../../components/library/create_button.dart';
import '../../components/library/input_field.dart';
import '../../services/library/sv_word.dart';

class AddWordPage extends StatefulWidget {
  final int notebookId;

  const AddWordPage({super.key, required this.notebookId});

  @override
  State<AddWordPage> createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  final WordService _wordService = WordService();

  TextEditingController wordController = TextEditingController();
  TextEditingController furiganaController = TextEditingController();
  TextEditingController meaningController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: _appBar(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/appbar.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter, // Align the image to the top
            ),
          ),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(32, 12, 16, 0),
                child: Text(
                  'Từ vựng',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A2D37),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
                child: InputField(
                  hintText: 'Nhập từ',
                  textController: wordController,
                ),
              ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: CreateButton(
                  text: 'Thêm',
                  onPressed: _handleAddWord,
                ),
              ),
            ],
          )),
        ));
  }

  Future<void> _handleAddWord() async {
    if (wordController.text.isEmpty || meaningController.text.isEmpty) {
      showErrorMessage("Điền đầy đủ thông tin từ vựng!", context);
      return;
    }
    await _wordService.addWord(
      widget.notebookId,
      wordController.text,
      furiganaController.text,
      meaningController.text,
    );
    wordController.clear();
    furiganaController.clear();
    meaningController.clear();
    Navigator.pop(context);
    showSuccessMessage("Tạo từ vựng mới thành công", context);
  }

  AppBar _appBar() {
    return AppBar(
      // flexibleSpace: Image.asset('assets/images/bb.png', fit: BoxFit.cover),
      leading: const BackButton(color: Colors.white),
      title: const Text(
        "Thêm từ vựng",
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
