import 'package:flutter/material.dart';

import '../components/library/notebook.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<Notebook> notebookList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: libraryBody(),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: const Text(
      "Library",
      style: TextStyle(
        fontSize: 28,
        fontFamily: 'Noto Sans',
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    backgroundColor: Color(0xFF8980F0),
    actions: [
      IconButton(
        icon: Icon(Icons.search, size: 28),
        color: Colors.white,
        onPressed: () {
          // do something
        },
      ),
      IconButton(
        icon: Icon(Icons.add, size: 28),
        color: Colors.white,
        onPressed: () {
          // do something
        },
      ),
      IconButton(
        icon: Icon(Icons.download_rounded, size: 28),
        color: Colors.white,
        onPressed: () {
          // do something
        },
      ),
    ],
  );
}

class libraryBody extends StatefulWidget {
  const libraryBody({super.key});

  @override
  _libraryBodyState createState() => _libraryBodyState();
}

class _libraryBodyState extends State<libraryBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: Colors.blue,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Notebook(
            title: "Notebook 1",
            wordCount: "100 words",
            updateDate: "Last updated 2 days ago",
          ),
          Notebook(
            title: "Notebook 2",
            wordCount: "200 words",
            updateDate: "Last updated 3 days ago",
          ),
          Notebook(
            title: "Notebook 3",
            wordCount: "300 words",
            updateDate: "Last updated 4 days ago",
          ),

        ],
      ),
    );
  }
}