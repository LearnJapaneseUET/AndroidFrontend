import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final String number;
  final String word;
  final String pronunciation;
  final String meaning;
  final String? note;

  const WordCard({
    super.key,
    required this.number,
    required this.word,
    required this.pronunciation,
    required this.meaning,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                number,
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
                        Text(
                          word,
                          style: const TextStyle(
                            color: Color(0xFF2A2D37),
                            fontSize: 22,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          pronunciation,
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
                            // TODO: Implement pronunciation playback
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {
                            // TODO: Implement favorite functionality
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
          if (note != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.note, color: Color(0xFFE87A6D)),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6FA),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      note!,
                      style: const TextStyle(
                        color: Color(0xFF2A2D37),
                        fontSize: 14,
                        fontFamily: 'Noto Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
