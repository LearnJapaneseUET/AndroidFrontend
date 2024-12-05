import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nihongo/pages/library/add_notebook_panel.dart';
import 'package:nihongo/pages/library/vocab_page.dart';
// import 'notebook_detail_page.dart';

class NotebookComponent extends StatelessWidget {
  final int id;
  final String name;
  final int wordCount;
  final VoidCallback deletePressed;
  final VoidCallback editPressed;

  const NotebookComponent({
    super.key,
    required this.name,
    required this.deletePressed,
    required this.id,
    required this.editPressed,
    required this.wordCount,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              deletePressed();
            },
            icon: Icons.delete,
            backgroundColor: const Color(0xFFF5F6FA),
            foregroundColor: Colors.red,
            label: 'Delete',
          ),
        ],
      ),
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              editPressed();
            },
            icon: Icons.edit,
            backgroundColor: const Color(0xFFF5F6FA),

            foregroundColor: Colors.green,
            label: 'Edit',
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
              height: 80,
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

                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      // updateDate,
                      "$wordCount words",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
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
