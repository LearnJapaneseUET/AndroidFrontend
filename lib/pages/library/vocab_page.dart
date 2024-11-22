import 'package:flutter/material.dart';

import '../../components/library/word_card.dart';
import 'add_word_page.dart';

class VocabPage extends StatelessWidget {
  const VocabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        color: const Color(0xFFF5F6FA),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: const [
                    WordCard(
                      number: '001',
                      word: '猫',
                      pronunciation: 'ねこ',
                      meaning: 'Con mèo',
                      note: 'Rất dễ thương =))',
                    ),
                    SizedBox(height: 12),
                    WordCard(
                      number: '002',
                      word: '国会',
                      pronunciation: 'こっかい',
                      meaning: 'Quốc hội',
                    ),
                    SizedBox(height: 12),
                    WordCard(
                      number: '003',
                      word: '学生',
                      pronunciation: 'がくせい',
                      meaning: 'Học sinh',
                    ),
                    SizedBox(height: 12),
                    WordCard(
                      number: '004',
                      word: '一',
                      pronunciation: 'yī',
                      meaning:
                          '"one" radical in Chinese characters; a (article); all; also; as soon as; entire; one (numeric); single; throughout; whole...',
                    ),
                    SizedBox(height: 12),
                    WordCard(
                      number: '005',
                      word: '喜欢',
                      pronunciation: 'xǐ huan',
                      meaning: 'to be fond of; to like',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar _appBar(context) {
  return AppBar(
    title: const Text(
      "Từ vựng",
      style: TextStyle(
        fontSize: 24,
        fontFamily: 'Noto Sans',
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    backgroundColor: const Color(0xFF8980F0),
    actions: [
      IconButton(
        icon: const Icon(Icons.search, size: 24),
        color: Colors.white,
        onPressed: () {
          // do something
        },
      ),
      IconButton(
        icon: const Icon(Icons.add, size: 24),
        color: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddWordPage()),
          );
        },
      ),
      IconButton(
        icon: const Icon(Icons.upload_rounded, size: 24),
        color: Colors.white,
        onPressed: () {
          // do something
        },
      ),
      IconButton(
        icon: const Icon(Icons.card_membership, size: 24),
        color: Colors.white,
        onPressed: () {
          // do something
        },
      ),
    ],
  );
}
