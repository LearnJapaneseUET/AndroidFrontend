import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../components/library/addFlashcard_panel.dart';
import '../../components/library/notebook.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final PanelController _panelController = PanelController();
  List<Notebook> notebookList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: _appBar(),
      body: SlidingUpPanel(
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        backdropEnabled: true,
        color: Colors.transparent,
        minHeight: 20,
        maxHeight: MediaQuery.of(context).size.height * 0.5,
        controller: _panelController,
        panel: const AddFlashcardPanel(),
        body: const libraryBody(),

      ),
    );
  }

  AppBar _appBar() {
    return AppBar(

      title: const Text(
        "Library",
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
            _panelController.open();
          },
        ),
        IconButton(
          icon: const Icon(Icons.download_rounded, size: 24),
          color: Colors.white,
          onPressed: () {
            // do something
          },
        ),
      ],
    );
  }
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
      child: ListView(
        physics: const BouncingScrollPhysics(),
        //children: notebookList,
        children:  [
          Notebook(
            title: "Notebook 1",
            description: "100 words",
            updateDate: "Last updated 2 days ago",
          ),
          Notebook(
            title: "Notebook 2",
            description: "200 words",
            updateDate: "Last updated 3 days ago",
          ),
          Notebook(
            title: "Notebook 3",
            description: "300 words",
            updateDate: "Last updated 4 days ago",
          ),
          Notebook(
            title: "Notebook 4",
            description: "400 words",
            updateDate: "Last updated 5 days ago",
          ),
          Notebook(
            title: "Notebook 5",
            description: "500 words",
            updateDate: "Last updated 6 days ago",
          ),
          Notebook(
            title: "Notebook 6",
            description: "600 words",
            updateDate: "Last updated 7 days ago",
          ),
          Notebook(
            title: "Notebook 7",
            description: "700 words",
            updateDate: "Last updated 8 days ago",
          ),
          Notebook(
            title: "Notebook 8",
            description: "800 words",
            updateDate: "Last updated 9 days ago",
          ),
        ],
      ),
    );
  }
}
