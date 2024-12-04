import 'package:flutter/material.dart';
import 'package:nihongo/models/library/notebook.dart';

import '../../components/library/create_button.dart';
import '../../components/library/input_field.dart';
import '../../services/library/sv_notebook.dart';

class EditNotebookPage extends StatefulWidget {
  final Notebook notebook;
  const EditNotebookPage({super.key, required this.notebook});

  @override
  State<EditNotebookPage> createState() => _EditNotebookPageState();
}

class _EditNotebookPageState extends State<EditNotebookPage> {

  @override
  void initState() {
    super.initState();
    nameController.text = widget.notebook.name;
    descriptionController.text = widget.notebook.description;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final NotebookService _notebookService = NotebookService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F6FA),
        appBar: _appBar(),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(32, 12, 16, 0),
                  child: Text(
                    'Tên Notebook',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A2D37),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                  child: InputField(hintText: 'Nhập tên', textController: nameController,),
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(32, 12, 16, 0),
                  child: Text(
                    'Chú thích',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A2D37),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                  child: InputField(hintText: 'Nhập chú thích', textController: descriptionController,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: CreateButton(
                    text: 'Sửa',
                    onPressed: () => _handleEditNotebook(widget.notebook.id),
                  ),
                ),
              ],
            )));
  }

  Future<void> _handleEditNotebook(int id) async {
    await _notebookService.editNotebook(id, nameController.text, descriptionController.text);
    Navigator.pop(context);

  }
}

AppBar _appBar() {
  return AppBar(
    leading: const BackButton(color: Colors.white),
    title: const Text(
      "Sửa Notebook",
      style: TextStyle(
        fontSize: 24,
        fontFamily: 'Noto Sans',
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    backgroundColor: const Color(0xFF8980F0),
  );
}