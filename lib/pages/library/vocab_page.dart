import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nihongo/pages/library/flashcard.dart';
import 'package:nihongo/services/library/sv_word.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/library/show_snackbar.dart';
import '../../components/library/word_card.dart';
import '../../models/library/Word.dart';
import '../../services/text_to_speech.dart';
import 'add_word_page.dart';
import 'edit_word_page.dart';

class VocabPage extends StatefulWidget {
  final int notebookId;

  const VocabPage({super.key, required this.notebookId});

  @override
  State<VocabPage> createState() => _VocabPageState();
}

class _VocabPageState extends State<VocabPage> {
  final WordService _wordService = WordService();
  late Future<List<Word>> _wordListFuture;
  final TextToSpeech textToSpeech = TextToSpeech();


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
        appBar: _appBar(context, widget.notebookId),
        // color: const Color(0xFFF5F6FA),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/appbar.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter, // Align the image to the top
            ),
          ),
          child: RefreshIndicator(
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
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return ListView(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 140),
                                Image.asset('assets/images/Empty Set.png', width: 200),
                                const SizedBox(height: 10),
                                const Text('No words available', style: TextStyle(fontSize: 18, color: Color(0xFF9B9CB8))),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SlidableAutoCloseBehavior(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final word = snapshot.data![index];
                                // final word_id = word.id;
                                return WordCard(
                                  index: "${index + 1}",
                                  word: word.word,
                                  meaning: word.meaning,
                                  furigana: word.furigana,
                                  voicePressed: () {
                                    textToSpeech.processTTS(word.word);
                                    log("Voice pressed");
                                  },

                                  editPressed: () async {
                                    final route = MaterialPageRoute(builder: (context) => EditWordPage(word: word));
                                    await Navigator.push(context, route);
                                    _fetchWordList();
                                  },

                                  deletePressed:() => _handleDeleteWord(word.id),

                                  // do something
                                );
                              }
                          )
                      );
                    }
                  }
              )
          ),
        )
    );
  }

  AppBar _appBar(context, int notebook_id) {
    return AppBar(
      leading: const BackButton(color: Colors.white),
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

          onPressed: () async {
            final route = MaterialPageRoute(builder: (context) => AddWordPage(notebookId: notebook_id));
            await Navigator.push(context, route);
            _fetchWordList();
          },
        ),
        IconButton(
          icon: Image.asset('assets/images/Flash Card.png'),
          iconSize: 24,
          // icon: const Icon(Icons.card_membership, size: 24),
          color: Colors.white,
          onPressed: () async {
            final route = MaterialPageRoute(builder: (context) => flashcardPage(notebookId: notebook_id));
            // final route = MaterialPageRoute(builder: (context) => flashcardPage());
            await Navigator.push(context, route);
            _fetchWordList();
          },
        ),
        IconButton(
          icon: const Icon(Icons.download_rounded, size: 24),
          color: Colors.white,
          onPressed: () => _exportToFile(),
        ),
      ],
    );
  }

  Future<void> _exportToFile() async {
    String content = await _getContent();
    try {
      // Request storage permissions
      if (await Permission.storage.request().isGranted) {
        // Let the user choose the directory
        String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

        if (selectedDirectory == null) {
          print("No directory selected.");
          return; // User canceled the picker
        }

        // Define the file path and name
        final filePath = '$selectedDirectory/notebooks.txt';
        final file = File(filePath);

        // Write the content to the file
        await file.writeAsString(content);

        // Show a success message and open the file
        print('File saved to: $filePath');
        OpenFile.open(filePath);
      } else {
        print("Storage permission denied.");
      }
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  Future<String> _getContent() async {
    return await _wordService.exportNotebook(widget.notebookId);
  }


  Future<void> _handleDeleteWord (String wordId) async {
    log("Delete word $wordId, notebook ${widget.notebookId}");
    showSuccessMessage("Xóa từ thành công", context);

    await _wordService.deleteWord(wordId, widget.notebookId);
    _fetchWordList();
  }
}
