import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WordCard extends StatelessWidget {
  final String index;
  final String word;
  final String meaning;
  final String? furigana;
  final VoidCallback voicePressed;
  final VoidCallback deletePressed;
  final VoidCallback editPressed;

  const WordCard({
    super.key,
    required this.word,
    required this.meaning,
    this.furigana,
    required this.index,
    required this.voicePressed,
    required this.editPressed,
    required this.deletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.35,
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  deletePressed();
                },
                icon: Icons.delete,
                backgroundColor: Color(0xFFF5F6FA),
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
                backgroundColor: Color(0xFFF5F6FA),
                foregroundColor: Colors.green,
                label: "Edit",
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      index.toString(),
                      style: const TextStyle(
                        color: Color(0xFF9B9CB8),
                        fontSize: 12,
                        fontFamily: 'Noto Sans',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 1,
                      height: 24,
                      color: const Color(0xFFE0E0E0),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  word,
                                  style: const TextStyle(
                                    color: Color(0xFF2A2D37),
                                    fontSize: 22,
                                    fontFamily: 'Noto Sans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                furigana ?? '',
                                // if furigana is null, use empty string
                                style: const TextStyle(
                                  color: Color(0xFFE87A6D),
                                  fontSize: 14,
                                  fontFamily: 'Noto Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.volume_up),
                                onPressed: () {
                                  voicePressed();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            meaning,
                            style: const TextStyle(
                              color: Color(0xFF2A2D37),
                              fontSize: 14,
                              fontFamily: 'Noto Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
