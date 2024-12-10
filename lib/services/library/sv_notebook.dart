import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:nihongo/models/library/notebook.dart';

class NotebookService {
  final User user = FirebaseAuth.instance.currentUser!;

  Future<List<Notebook>> getNotebook() async {
    // var url = 'http://192.168.1.6:8000/api/flashcard/all/1';
    // var url = 'https://refactored-meme-r9wpgj6jrjvcprw7-8000.app.github.dev/api/flashcard/all/1';

    var url = 'https://nihongobenkyou.online/api/flashcard/all/${user.uid}/';

    var uri = Uri.parse(url);

    var response = await http.get(uri, headers: {"accept": "application/json"});
    String jsonString = utf8.decode(response.bodyBytes,  allowMalformed: true);

    if (response.statusCode == 200) {
      log("oke \n ${jsonString }");
      if (jsonString == '""') {
        return [];
      }
      return Notebook.fromJsonList(jsonDecode(jsonString ) as List);
    } else {
      log("deo duoc \n ${jsonString }");
      throw Exception('Failed to load notebook');
    }

    /*
    [
      {
          "id": 6,
          "name": "Thanh Nhàn"
      },
      {
          "id": 7,
          "name": "Thanh Nhồn"
      },
      {
          "id": 8,
          "name": "Thanh a"
      }
    ]*/
  }

  Future<void> addNotebook(String name) async {
    var url = 'https://nihongobenkyou.online/api/flashcard/list/create/';
    var uri = Uri.parse(url);

    var body = {
      "name": name,
      "uid": user.uid,
    };

    log("Request body: ${jsonEncode(body)}");

    var response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    String jsonString = utf8.decode(response.bodyBytes,  allowMalformed: true);

    if (response.statusCode != 201) {
      log("Failed to add notebook");

      throw Exception('Failed to add notebook');
    }

    log("add notebook code ${response.statusCode}");
    log("${response.headers}");
    log(jsonString );
    /*{
        "id": 10,
        "name": "hello"
      }
       */
  }

  Future<void> editNotebook(int id, String name) async {
    var url = "https://nihongobenkyou.online/api/flashcard/list/$id/update/";
    var uri = Uri.parse(url);

    var body = {
      "name": name,
    };

    var response = await http.put(uri,
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));

    String jsonString = utf8.decode(response.bodyBytes,  allowMalformed: true);

    log("${response.statusCode}");
    log("${response.headers}");
    log(jsonString );

    /*{
        "id": 10,
        "name": "hello"
      }
       */
  }

  Future<void> deleteNotebook(int id) async {
    log("Inside deleteNotebook - id: $id");
    var url = 'https://nihongobenkyou.online/api/flashcard/list/$id/delete/';
    var uri = Uri.parse(url);

    var response = await http.delete(uri, headers: {"accept": "application/json"});

    String jsonString = utf8.decode(response.bodyBytes,  allowMalformed: true);

    log("${response.statusCode}");
    log("${response.headers}");
    log(jsonString );
  }


}
