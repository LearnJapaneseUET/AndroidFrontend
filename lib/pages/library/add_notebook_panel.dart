import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nihongo/services/library/sv_notebook.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../components/library/input_field.dart';
import '../../components/library/create_button.dart';
import '../../models/library/notebook.dart';

class AddNotebookPanel extends StatefulWidget {
  final PanelController panelController;

  const AddNotebookPanel({super.key, required this.panelController});

  @override
  State<AddNotebookPanel> createState() => _AddNotebookPanelState();
}

class _AddNotebookPanelState extends State<AddNotebookPanel> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final NotebookService _notebookService = NotebookService();

  late Future<List<Notebook>> _notebookListFuture;

  @override
  void initState() {
    super.initState();
  }

  void _fetchNotebookList() {
    setState(() {
      _notebookListFuture = _notebookService.getNotebook();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: BottomIndicator(),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: Text(
                    'Thêm Notebook mới',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A2D37),
                    ),
                  ),
                ),
                const Divider(
                  color: Color(0xFFEDEFF5),
                  thickness: 1,
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  child: InputField(
                      hintText: 'Nhập tên', textController: nameController),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  child: InputField(
                      hintText: 'Nhập chú thích',
                      textController: descriptionController),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: CreateButton(
                    text: 'Thêm',
                    onPressed: _handleAddNotebook,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleAddNotebook() async {
    log("Inside _handleAddNotebook");
    widget.panelController.close();
    await _notebookService.addNotebook(nameController.text, descriptionController.text);
    nameController.clear();
    descriptionController.clear();
    _fetchNotebookList();
  }


}

class BottomIndicator extends StatelessWidget {
  const BottomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: 80,
        height: 4,
        decoration: const BoxDecoration(
          color: Color(0xFFD3D9EB),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}