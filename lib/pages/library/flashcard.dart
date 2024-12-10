import 'dart:developer';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../models/library/Word.dart';
import '../../services/library/sv_word.dart';
import '../../services/text_to_speech.dart';


class flashcardPage extends StatefulWidget {
  final int notebookId;

  const flashcardPage({super.key, required this.notebookId});

  @override
  State<flashcardPage> createState() => _flashcardPageState();
}

class _flashcardPageState extends State<flashcardPage> {
  String? notebookName;
  final WordService _wordService = WordService();

  @override
  void initState() {
    super.initState();
    _fetchNotebookName();
  }

  Future<void> _fetchNotebookName() async {
    _wordService.getName(widget.notebookId).then((value) {
      setState(() {
        notebookName = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A2D37),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 56, 16, 146),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 24),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Flexible(
                      child: Text(
                        textAlign: TextAlign.center,
                        notebookName?? "...",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Noto Sans',
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, size: 24),
                    color: Colors.white.withOpacity(0),
                    onPressed: () {
                      // showMenu(context: context, position: RelativeRect.fromLTRB(100, 100, 100, 100), items: []);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Expanded(
                child: Lesson(notebookId: widget.notebookId),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class Lesson extends StatefulWidget {
  final int notebookId;
  final TextToSpeech textToSpeech = TextToSpeech();

  Lesson({Key? key, required this.notebookId}) : super(key: key);

  @override
  _LessonState createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  final WordService _wordService = WordService();
  late Future<List<Word>> _wordListFuture;
  List<Word> _words = [];

  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;

  Future<void> _fetchWordList() async {
    setState(() {
      _wordListFuture = _wordService.getWord(widget.notebookId);
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchWordList();
    _wordListFuture.then((value) {
      setState(() {
        _words = value;
        for (int i = 0; i < _words.length; i++) {
          log("Word: ${_words[i].word}, Meaning: ${_words[i].meaning}");
          _swipeItems.add(SwipeItem(
              content: Word(word: _words[i].word, meaning: _words[i].meaning, id: _words[i].id),
              // content: Content(text: _names[i], color: _colors[i]),
              likeAction: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green, // Set the background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Set the border radius
                  ),
                  content: Text("Đã nhớ từ ${_words[i].word}"),
                  duration: Duration(milliseconds: 500),
                ));
              },
              nopeAction: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.yellow, // Set the background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Set the border radius
                  ),
                  content: Text("Chưa nhớ từ ${_words[i].word}", style: TextStyle(color: Colors.black)),
                  duration: Duration(milliseconds: 500),
                ));
              },
              superlikeAction: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.pinkAccent, // Set the background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Set the border radius
                  ),
                  content: Text("Siêu yêu thích từ ${_words[i].word}"),
                  duration: Duration(milliseconds: 500),
                ));
              },
              onSlideUpdate: (SlideRegion? region) async {
                print("Region $region");
              }));
        }
        // log("Words: ${_words.length}");
        // log("Word: ${_words[0].word}, Meaning: ${_words[0].meaning}");
      });
    });



    _matchEngine = MatchEngine(swipeItems: _swipeItems);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(children: [
          Transform.rotate(
            angle: 0.12,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 295, maxHeight: 485),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 196),
              decoration: BoxDecoration(
                color: Color(0xFF8980F0).withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          Transform.rotate(
            angle: -0.12,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 295, maxHeight: 485),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 196),
              decoration: BoxDecoration(
                color: Color(0xFF8980F0).withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          Container(
            height: 485,
            width: 295,
            decoration: BoxDecoration(
              // color: const Color(0xFF8980F0),
              borderRadius: BorderRadius.circular(16),
            ),

            child: SwipeCards(
              matchEngine: _matchEngine!,
              itemBuilder: (BuildContext context, int index) {
                return FlipCard(
                  direction: FlipDirection.HORIZONTAL,
                  front: Container(
                    height: 485,
                    width: 295,
                    decoration: BoxDecoration(
                      color: Color(0xFF8980F0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            _swipeItems[index].content.word,
                            style: TextStyle(fontSize: 50, color: Colors.white),
                          ),
                          SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),

                            child: IconButton(
                              icon: const Icon(Icons.volume_up, size: 24),
                              color: Colors.white,
                              onPressed: () {
                                widget.textToSpeech.processTTS(_swipeItems[index].content.word);
                                log("Voice pressed");
                              },
                            ),
                          ),
                          SizedBox(height: 30),

                        ],
                      ),
                    ),
                  ),
                  back: Container(
                    height: 485,
                    width: 295,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            _swipeItems[index].content.meaning,
                            style: TextStyle(fontSize: 50, color: Colors.black),
                          ),
                          SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.volume_up, size: 24),
                              color: Colors.black,
                              onPressed: () {
                                widget.textToSpeech.processTTS(_swipeItems[index].content.meaning);
                                log("Voice pressed");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              onStackFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Stack Finished"),
                  duration: Duration(milliseconds: 500),
                ));
              },
              itemChanged: (SwipeItem item, int index) {
                print("item: ${item.content.word}, index: $index");
              },
              leftSwipeAllowed: true,
              rightSwipeAllowed: true,
              upSwipeAllowed: true,
              fillSpace: true,
            ),
          ),

        ]
        ),

      ],
    );
  }
}
