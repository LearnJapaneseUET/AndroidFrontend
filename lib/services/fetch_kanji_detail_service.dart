import 'package:nihongo/models/kanji_detail_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchKanjiDetailService {

  Future<KanjiDetailModel?> getKanjiExpandedDetail({required String searchWord}) async {
    var uri = Uri.https(
      'nihongobenkyou.online',
      'api/dictionary/search/kanji/$searchWord',
    );
    var response = await http.get(uri, headers: {"Accept": "application/json"}).timeout(Duration(seconds: 30));
    String jsonString = utf8.decode(response.bodyBytes,  allowMalformed: true);        
    var data = jsonDecode(jsonString);
    // print(data['meaning']);

    // Parse art
    String? kanjiArt;
    if (data["kanjiArt"] != null) {
      kanjiArt = data["kanjiArt"];
    }

    // Parse Meaning
    Meaning? meaning;
    if (data["meaning"] != null) {
      meaning = Meaning.fromJson(data["meaning"]);
    }
    
    // Parse Examples
    List<ExampleSimple> examples = [];
    if (data["example"] != null) {
      examples = (data["example"] as Map<String, dynamic>)
          .values
          .map((e) => ExampleSimple.fromJson(e))
          .toList();
    }

    // Parse Comments
    List<Comment> comments = [];
    if (data["comment"] != null) {
      comments = (data["comment"] as Map<String, dynamic>)
          .values
          .map((c) => Comment.fromJson(c))
          .toList();
    }

    // Create and return WordDetail Object
    return KanjiDetailModel(
      meaning: meaning!,
      examples: examples,
      comments: comments,
      kanjiArt: kanjiArt
    );
  }
}
