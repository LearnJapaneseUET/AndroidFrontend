import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nihongo/components/library/show_snackbar.dart';
import 'package:nihongo/models/library/notebook.dart';
import 'package:nihongo/services/library/sv_notebook.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../components/library/notebook.dart';
import '../../services/library/sv_word.dart';
import 'add_notebook_panel.dart';
import 'edit_notebook_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final NotebookService _notebookService = NotebookService();
  late Future<List<Notebook>> _notebookListFuture;

  @override
  void initState() {
    super.initState();
    _fetchNotebookList();
  }

  void _fetchNotebookList() {
    setState(() {
      _notebookListFuture = _notebookService.getNotebook();
    });
  }

  final PanelController _panelController = PanelController();

  // List<NotebookComponent> notebookList = [];

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
        panel: AddNotebookPanel(panelController: _panelController),
        body: const LibraryBody(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Row(
        children: [
          Icon(Icons.book, color: Colors.white, size: 28),
          SizedBox(width: 10),
          Text(
            "Library",
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Noto Sans',
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF8980F0),
      actions: [
        IconButton(
          icon: const Icon(Icons.add, size: 24),
          color: Colors.white,
          onPressed: () {
            if (_panelController.isAttached) {
              _panelController.open();
            }
            _fetchNotebookList();
          },
        ),
        IconButton(
          icon: const Icon(Icons.download_rounded, size: 24),
          color: Colors.white,
          onPressed: () => _fetchNotebookList(),
        ),
      ],
    );
  }
}

class LibraryBody extends StatefulWidget {
  const LibraryBody({super.key});

  @override
  _LibraryBodyState createState() => _LibraryBodyState();
}

class _LibraryBodyState extends State<LibraryBody> {
  final NotebookService _notebookService = NotebookService();
  final WordService _wordService = WordService();

  late Future<List<Notebook>> _notebookListFuture;

  @override
  void initState() {
    super.initState();
    _fetchNotebookList();
  }

  void _fetchNotebookList() {
    setState(() {
      _notebookListFuture = _notebookService.getNotebook();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _fetchNotebookList();
      },
      child: FutureBuilder<List<Notebook>>(
        future: _notebookListFuture,
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
                padding: const EdgeInsets.only(bottom: 170),
                // physics: const BouncingScrollPhysics(),

                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final notebook = snapshot.data![index];

                  return FutureBuilder<int>(
                    future: _getWordCount(notebook.id),
                    builder: (context, wordCountSnapshot) {
                      if (wordCountSnapshot.hasError) {
                        return Center(child: Text('Error: ${wordCountSnapshot.error}'));
                      } else {
                        return NotebookComponent(
                          index: index + 1,
                          id: notebook.id,
                          name: notebook.name,
                          wordCount: wordCountSnapshot.data ?? 0,
                          deletePressed: () => _deleteNotebook(notebook.id),
                          editPressed: () => navigateToEditNotebook(notebook),
                        );
                      }
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> navigateToEditNotebook(Notebook notebook) async {
    final route = MaterialPageRoute(builder: (context) => EditNotebookPage(notebook: notebook));
    await Navigator.push(context, route);
    _fetchNotebookList();
  }

  Future<void> _deleteNotebook(int id) async {
    showSuccessMessage("Xóa notebook thành công", context);
    await _notebookService.deleteNotebook(id);
    _fetchNotebookList();
  }

  Future<int> _getWordCount(int id) async {
    return  _wordService.getWordCount(id);
  }
}
