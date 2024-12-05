import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:nihongo/models/library/Word.dart';

class WordService {
  final User user = FirebaseAuth.instance.currentUser!;

  Future<List<Word>> getWord(int listId) async {
    // var url = 'http://192.168.1.6:8000/api/flashcard/all/1';
    // var url = 'https://refactored-meme-r9wpgj6jrjvcprw7-8000.app.github.dev/api/flashcard/all/1';

    var url = 'https://nihongobenkyou.online/api/flashcard/$listId/';

    var uri = Uri.parse(url);

    var response = await http.get(uri, headers: {"accept": "application/json"});

    if (response.statusCode == 200) {
      log("oke \n ${response.body}");
      return Word.fromJsonList(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      log("deo duoc \n ${response.body}");
      throw Exception('Failed to load Word');
    }

    /*
      {
      "words": [
          {
              "id": "62606",
              "w": "Hello Nhà1n",
              "p": "Hello Hoàng 1Anh",
              "m": "Hello Thả1o",
              "h": ""
          }
      ],
      "name": "Thanh basc"
    }*/
  }

  Future<void> addWord(
      int listId, String word, String furigana, String meaning) async {
    var url = 'https://nihongobenkyou.online/api/flashcard/word/create/';
    var uri = Uri.parse(url);

    var body = {"w": word, "p": furigana, "m": meaning, "listId": listId};
// w: từ mới
// p: furigana
// m: Nghĩa

    log("Request body: ${jsonEncode(body)}");

    var response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    log("${response.statusCode}");
    log("${response.headers}");
    log(response.body);
    /*{
    "meaning": "Hello Thả1o",
    "furigana": "Hello Hoàng 1Anh"
}
       */
  }

  Future<void> editWord(int id, String furigana, String meaning) async {
    var url = "https://nihongobenkyou.online/api/flashcard/word/$id/update/";
    var uri = Uri.parse(url);

    var body = {
      "furigana": furigana,
      "meaning": meaning,
    };

    var response = await http.put(uri,
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));

    log("${response.statusCode}");
    log("${response.headers}");
    log(response.body);

    /*{
        "id": 10,
        "name": "hello"
      }
       */
  }

  Future<void> deleteWord(int wordId, int listId) async {
    var url = 'https://nihongobenkyou.online/api/flashcard/word/delete/';
    var uri = Uri.parse(url);

    var body = {"wordId": wordId, "listId": listId};

    var response = await http.delete(uri,
        headers: {"accept": "application/json"}, body: jsonEncode(body));

    log("${response.statusCode}");
    log("${response.headers}");
    log(response.body);
  }
}
