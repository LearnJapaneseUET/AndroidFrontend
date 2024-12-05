import 'package:flutter/material.dart';

import '../../components/library/create_button.dart';
import '../../components/library/input_field.dart';

class AddWordPage extends StatefulWidget {
  const AddWordPage({super.key});

  @override
  State<AddWordPage> createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  TextEditingController wordController = TextEditingController();
  TextEditingController furiganaController = TextEditingController();
  TextEditingController hanVietController = TextEditingController();
  TextEditingController meaningController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F6FA),
        appBar: _appBar(),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
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
              child: InputField(hintText: 'Nhập từ', textController: wordController,),
            ),
            Padding(
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
              padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: InputField(hintText: 'Nhập furigana', textController: furiganaController,),
            ),

            Padding(
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
              padding: EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: InputField(hintText: 'Nhập ý nghĩa', textController: meaningController,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: CreateButton(
                text: 'Thêm',
                onPressed: () {},
              ),
            ),
          ],
        )));
  }
}

AppBar _appBar() {
  return AppBar(
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
