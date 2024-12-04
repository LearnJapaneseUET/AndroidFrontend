import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nihongo/pages/library/addFlashcard_panel.dart';
import 'package:nihongo/pages/library/vocab_page.dart';
// import 'notebook_detail_page.dart';

class notebookComponent extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final VoidCallback onPressed;

  const notebookComponent({
    super.key,
    required this.name,
    required this.description,
    required this.onPressed,
    required this.id,

  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onPressed();
            },
            icon: Icons.delete,
            backgroundColor: Color(0xFFF5F6FA),
            foregroundColor: Colors.red,
            label: 'Delete',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VocabPage(notebookId: id),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              width: double.infinity,
              height: 144,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  // side: const BorderSide(width: 1, color: Color(0xFFD3D9EA)),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Color(0xFF2A2D37),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Noto Sans',
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        description,
                        style: const TextStyle(
                          color: Color(0xFF8980F0),
                          fontSize: 16,
                          fontFamily: 'Noto Sans',
                          height: 0.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      // updateDate,
                      "",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: 'Noto Sans',
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
