import 'package:flutter/material.dart';
import 'package:nihongo/components/library/addFlashcard_panel.dart';
import 'package:nihongo/pages/library/vocab_page.dart';
// import 'notebook_detail_page.dart';

class Notebook extends StatelessWidget {
  final String title;
  final String wordCount;
  final String updateDate;

  const Notebook({
    super.key,
    required this.title,
    required this.wordCount,
    required this.updateDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VocabPage(),
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
                side: const BorderSide(width: 1, color: Color(0xFFD3D9EA)),
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
                      title,
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
                      wordCount,
                      style: const TextStyle(
                        color: Color(0xFF8980F0),
                        fontSize: 16,
                        fontFamily: 'Noto Sans',
                        height: 0.2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    updateDate,
                    style: const TextStyle(
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
    );
  }
}
