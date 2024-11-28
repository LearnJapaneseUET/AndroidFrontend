import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input_field.dart';
import 'create_button.dart';

class AddFlashcardPanel extends StatelessWidget {
  const AddFlashcardPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: BottomIndicator(),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                    child: Text(
                      'Thêm flashcard mới',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A2D37),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xFFEDEFF5),
                    thickness: 1,
                    height: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: InputField(hintText: 'Nhập tên'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CreateButton(text: 'Thêm'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class BottomIndicator extends StatelessWidget {
  const BottomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: 80, height: 4,
        decoration: BoxDecoration(
          color: Color(0xFFD3D9EB),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}