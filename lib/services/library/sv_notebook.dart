import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:nihongo/models/library/notebook.dart';

class NotebookService {
  Future<List<Notebook>> getNotebook() async {
    // var url = 'http://192.168.1.6:8000/api/flashcard/all/1';
    var url =
        'https://refactored-meme-r9wpgj6jrjvcprw7-8000.app.github.dev/api/flashcard/all/1';
    var uri = Uri.parse(url);

    var response = await http.get(uri, headers: {"accept": "application/json"});

    if (response.statusCode == 200) {
      log("oke \n ${response.body}");
      return Notebook.fromJsonList(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      log("deo duoc \n ${response.body}");
      throw Exception('Failed to load notebook');
    }
  }

  Future<void> addNotebook(String name, String description) async {
    log("Inside addNotebook - name: $name, description: $description");

    var url =
        'https://refactored-meme-r9wpgj6jrjvcprw7-8000.app.github.dev/api/flashcard?user_id=1';
    var uri = Uri.parse(url);

    var body = {
      "name": name,
      "description": description,
    };

    log("Request body: ${jsonEncode(body)}");

    var response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json"
      },
      body: jsonEncode(body),
    );

    print(response.statusCode);
    print(response.headers);
    print(response.body);
    print(response.isRedirect);
  }

  Future<void> editNotebook(int id, String name, String description) async {
    var url =
        'https://refactored-meme-r9wpgj6jrjvcprw7-8000.app.github.dev/api/flashcard/$id';
    var uri = Uri.parse(url);

    var body = {
      "name": name,
      "description": description,
    };

    var response = await http.put(
        uri,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(body));

    print(response.statusCode);
    print(response.headers);
    print(response.body);
  }

  Future<void> deleteNotebook(int id) async {
    log("Inside deleteNotebook - id: $id");
    var url =
        'https://refactored-meme-r9wpgj6jrjvcprw7-8000.app.github.dev/api/flashcard/$id';
    var uri = Uri.parse(url);

    var response =
        await http.delete(uri, headers: {"accept": "application/json"});
    print(response.statusCode);
    print(response.headers);
    print(response.body);
  }
}
