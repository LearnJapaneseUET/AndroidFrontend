import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bottom_indicator.dart';
import 'input_field.dart';
import 'create_button.dart';

// Widget _addFlashcardPanel() {
//   return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Add New Flashcard",
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         // Add your form or input fields here
//       ],
//     ),
//   );
// }

class AddFlashcardPanel extends StatelessWidget {
  const AddFlashcardPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: BottomIndicator(),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
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
