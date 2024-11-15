import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nihongo/models/word_detail_model.dart';

class FetchWordDetailService {
  Meaning? meaning;

  Future<Meaning?> getWordExpandedDetail({required String searchWord}) async {
    var uri = Uri.https(
      'supreme-cod-j6vp47rwjg725776-8000.app.github.dev',
      'api/dictionary/search/word/$searchWord',
    );
    
    try {
      var response = await http.get(uri, headers: {"Accept": "application/json"});
      
      if (response.statusCode == 200) {
        // Decode and clean JSON response
        String jsonString = utf8.decode(response.bodyBytes);        
        // Attempt to parse JSON into a Map
        var parsedJson = jsonDecode(jsonString);
        print(parsedJson);
        // Parse 'Meaning' object
        if (parsedJson is Map<String, dynamic>) {
          meaning = Meaning.fromJson(parsedJson);
        } else {
          print('Unexpected JSON format');
        }
      } else {
        print('API Error with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching or parsing data: $e');
    }

    return meaning; // Return Meaning object
  }
}
