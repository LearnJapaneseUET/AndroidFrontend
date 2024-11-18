import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nihongo/models/word_suggestion_model.dart';

class FetchWordSuggesstionService{
  var data = [];
  List<WordSuggestion> results = [];
  
  Future<List<WordSuggestion>> getSugesstionList({required String searchWord}) async{
    var uri = Uri.https('nihongobenkyou.online', 'api/dictionary/suggestion/$searchWord');
    var response = await http.get(uri, headers: {"Accept": "application/json"});
    try {
      if (response.statusCode == 200) {
        data = jsonDecode(utf8.decode(response.bodyBytes));
        print(data);
        results = data.map((e) => WordSuggestion.fromJson(e)).toList();
      } else {
        print('api error');
      }
    } on Exception catch (e) {
      print('Error fetching word suggestion: $e');
    }
    return results;
  }
}
