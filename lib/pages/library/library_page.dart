import 'package:flutter/material.dart';
import 'package:nihongo/models/library/notebook.dart';
import 'package:nihongo/services/library/sv_notebook.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'addFlashcard_panel.dart';
import '../../components/library/notebook.dart';

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
  List<notebookComponent> notebookList = [];

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
        panel: AddFlashcardPanel(panelController: _panelController),
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
          onPressed: _fetchNotebookList,
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final notebook = snapshot.data![index];
                return notebookComponent(
                  id: notebook.id,
                  name: notebook.name,
                  description: notebook.description,
                  onPressed: () => _deleteNotebook(notebook.id)
                );
              },
            );
          }
        },
      ),
    );
  }
  Future<void> _deleteNotebook(int id) async {
    await _notebookService.deleteNotebook(id);
    _fetchNotebookList();
  }
}