import 'package:flutter/material.dart';
import 'package:nihongo/models/library/notebook.dart';

import '../../components/library/create_button.dart';
import '../../components/library/input_field.dart';
import '../../components/library/show_snackbar.dart';
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
  }

  TextEditingController nameController = TextEditingController();

  final NotebookService _notebookService = NotebookService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: _appBar(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/appbar.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter, // Align the image to the top
            ),
          ),
          child: SingleChildScrollView(
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: CreateButton(
                      text: 'Sửa',
                      onPressed: () => _handleEditNotebook(widget.notebook.id),
                    ),
                  ),
                ],
              )),
        ));
  }

  Future<void> _handleEditNotebook(int id) async {
    if (nameController.text.isEmpty) {
      showErrorMessage("Nhập tên notebook!", context);
      return;
    }
    showSuccessMessage("Đổi tên notebook thành công", context);

    await _notebookService.editNotebook(id, nameController.text);
    Navigator.pop(context);

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
}

