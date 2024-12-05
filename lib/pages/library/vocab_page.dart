import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nihongo/pages/library/flashcard.dart';
import 'package:nihongo/services/library/sv_word.dart';

import '../../components/library/word_card.dart';
import '../../models/library/Word.dart';
import 'add_word_page.dart';

class VocabPage extends StatefulWidget {
  final int notebookId;

  const VocabPage({super.key, required this.notebookId});

  @override
  State<VocabPage> createState() => _VocabPageState();
}

class _VocabPageState extends State<VocabPage> {
  final WordService _wordService = WordService();
  late Future<List<Word>> _wordListFuture;

  @override
  void initState() {
    super.initState();
    _fetchWordList();
  }

  Future<void> _fetchWordList() async {
    setState(() {
      _wordListFuture = _wordService.getWord(widget.notebookId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),

        appBar: _appBar(context),
        // color: const Color(0xFFF5F6FA),
        body: RefreshIndicator(
            onRefresh: () => _fetchWordList(),

            child: FutureBuilder(
                future: _wordListFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text('No data available'));
                  } else {
                    return SlidableAutoCloseBehavior(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(16),

                            itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final word = snapshot.data![index];
                            return WordCard(
                              number: "${index + 1}",
                              word: word.word,
                              meaning: word.meaning,
                              furigana: word.furigana,
                              voicePressed: () {
                                // do something
                              },
                              editPressed: () {
                                // do something
                              },
                              deletePressed: () {
                                // do something
                              },
                            );
                          }
                        )
                    );
                  }
                }
            )
        )

    );
  }

  // Future<void> navigateToEditNotebook(Notebook notebook) async {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => EditNotebookPage(notebook: notebook),
  //     ),
  //   );
  // }

  Future<void> _deleteNotebook(int id) async {
    // await _wordService.deleteWord(id);
    // _fetchNotebookList();
  }

}

AppBar _appBar(context) {
  return AppBar(
    leading: const BackButton(
        color: Colors.white
    ),
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
        icon: Image.asset('assets/images/Flash Card.png'),
        iconSize: 24,
        // icon: const Icon(Icons.card_membership, size: 24),
        color: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const flashcardPage()),
          );
        },
      ),
    ],
  );
}
