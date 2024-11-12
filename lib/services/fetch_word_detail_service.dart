import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nihongo/models/word_detail_model.dart';

String cleanJsonString(String jsonString) {
  // Replace any invalid UTF-8 characters with a valid placeholder
  return jsonString.replaceAll(RegExp(r'[^\x00-\x7F\u0100-\uFFFF]'), '');
}

class FetchWordDetailService {
  List<dynamic> data = [];
  Meaning? meaning;
  List<ExampleSimple> examples = [];
  List<Comment> comments = [];

  List<WordDetail> results = [];
  final String fetchUrl = "https://supreme-cod-j6vp47rwjg725776-8000.app.github.dev/api/dictionary/suggestion/";

  Future<List<WordDetail>> getWordExpandedDetailList({required String searchWord}) async {
    var uri = Uri.https(
      'supreme-cod-j6vp47rwjg725776-8000.app.github.dev',
      'api/dictionary/search/word/$searchWord',
    );
    try {
      var response = await http.get(uri, headers: {"Accept": "application/json"});
      
      if (response.statusCode == 200) {
        // Decode and clean JSON response
        String jsonString = utf8.decode(response.bodyBytes);
        jsonString = cleanJsonString(jsonString); 
        print(jsonString);
        // Attempt to parse JSON
        data = jsonDecode(jsonString);
        
        // Ensure data is a list and has enough elements
        if (data is List && data.length >= 4) {
          print('Data successfully parsed.');
          
          // Extract and parse meaning, examples, and comments safely
          if (data[1] is Map<String, dynamic>) {
            meaning = Meaning.fromJson(data[1]);
          } else {
            print('Unexpected format for meaning');
          }

          if (data[2] is Map<String, dynamic>) {
            examples = (data[2] as Map<String, dynamic>)
                .values
                .map((e) => ExampleSimple.fromJson(e))
                .toList();
          } else {
            print('Unexpected format for examples');
          }

          if (data[3] is Map<String, dynamic>) {
            comments = (data[3] as Map<String, dynamic>)
                .values
                .map((c) => Comment.fromJson(c))
                .toList();
          } else {
            print('Unexpected format for comments');
          }

          // Only add WordDetail if `meaning` is successfully parsed
          if (meaning != null) {
            var wordDetail = WordDetail(
              meaning: meaning!,
              examples: examples,
              comments: comments,
            );
            results.add(wordDetail);
          } else {
            print('Meaning data is null. Cannot create WordDetail.');
          }
        } else {
          print('Data format unexpected or insufficient data.');
        }
      } else {
        print('API Error with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching or parsing data: $e');
    }

    return results;
  }
}
