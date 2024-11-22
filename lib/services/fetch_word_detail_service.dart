import 'package:nihongo/models/word_detail_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchWordDetailService {

  Future<WordDetailModel?> getWordExplainDetail({required String searchWord}) async {
    var uri = Uri.https(
      'nihongobenkyou.online',
      'api/dictionary/search/word/$searchWord',
    );

    try {
      var response = await http
          .get(uri, headers: {"Accept": "application/json"})
          .timeout(Duration(seconds: 30));

      if (response.statusCode != 200) {
        print("Error: ${response.statusCode} ${response.reasonPhrase}");
        return null;
      }

      String jsonString = utf8.decode(response.bodyBytes, allowMalformed: true);
      var data = jsonDecode(jsonString);

      // print("Fetched Data: $data");

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
      return WordDetailModel(
        meaning: meaning!,
        examples: examples,
        comments: comments,
      );
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }
}
