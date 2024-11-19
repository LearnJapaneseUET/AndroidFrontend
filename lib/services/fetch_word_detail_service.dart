import 'package:nihongo/models/word_detail_model.dart';

class FetchWordDetailService {
  List<dynamic> data = [];
  Meaning? meaning;
  List<ExampleSimple> examples = [];
  List<Comment> comments = [];

  List<WordDetail> results = [];

  Future<List<WordDetail>> getWordExpandedDetail({required String searchWord}) async {
    var data = {
      "mobileId": null,
      "meaning": {
        "short_mean": "số; chữ số",
        "mobileId": 101041,
        "word": "数",
        "phonetic": "かず すう",
        "means": [
          {
            "kind": "n, n-suf",
            "examples": [],
            "mean": "số."
          },
          {
            "examples": [
              {
                "content": "数字の1010には０が2つある",
                "mean": "Trong số 1010 có hai chữ số 0 .",
                "transcription": "すうじの1010にはぜろが2つある"
              }
            ],
            "field": "math",
            "mean": "chữ số"
          },
          {
            "examples": [
              {
                "content": "数字は天文学的なものだろう。",
                "mean": "Con số sẽ là thiên văn。",
                "transcription": "すうじはてんもんがくてきなものだろう。"
              },
              {
                "content": "数人の客が応接室で待っていた。",
                "mean": "Có một số khách đang đợi trong phòng vẽ。",
                "transcription": "すうにんのきゃくがおうせつしつでまっていた。"
              },
              {
                "content": "数人の学生が図書館へやってきた。",
                "mean": "Một số sinh viên đến thư viện。",
                "transcription": "すうにんのがくせいがとしょかんへやってきた。"
              }
            ],
            "field": "math",
            "mean": "số"
          }
        ]
      },
      "example": {
        "0": {
          "transcription": "すうがくオタク",
          "content": "数学オタク",
          "mean": "người tâm huyết với môn toán học"
        },
        "1": {
          "transcription": "すうがくのきさい",
          "content": "数学の鬼才",
          "mean": "người có tài xuất chúng về toán học (thần đồng toán học)"
        },
        "2": {
          "transcription": "じゅずをくる",
          "content": "数珠を繰る",
          "mean": "lần tràng hạt"
        }
      },
      "comment": {
        "0": {
          "mean": "読み方は「すう」じゃなくて、「かず」です。",
          "like": 58,
          "dislike": 3,
          "username": "vvungocquang18091989"
        },
        "1": {
          "mean": "「すう」と 「かず」の読み方、どちらもいい。",
          "like": 22,
          "dislike": 3,
          "username": "Pham Minh Nguyet"
        },
        "2": {
          "mean": "すう",
          "like": 19,
          "dislike": 6,
          "username": "peinpein611991"
        }
      }
    };
    
    print("data1:${data["meaning"]}");
    print("data2:${data["example"]}");
    print("data3:${data["comment"]}");
    meaning = Meaning.fromJson(data["meaning"]!);
    print("1");
    examples = (data["example"] as Map<String, dynamic>)
                .values
                .map((e) => ExampleSimple.fromJson(e))
                .toList();
    print("2");
    comments = (data["comment"] as Map<String, dynamic>)
                .values
                .map((c) => Comment.fromJson(c))
                .toList();
    print("3");
    var wordDetail = WordDetail(
              meaning: meaning!,
              examples: examples,
              comments: comments,
            );
    results.add(wordDetail);
    print("wordDetail:$wordDetail");
    print(results);
    return results;
    // var uri = Uri.https(
    //   'supreme-cod-j6vp47rwjg725776-8000.app.github.dev',
    //   'api/dictionary/search/word/$searchWord',
    // );
    
    // try {
    //   var response = await http.get(uri, headers: {"Accept": "application/json"});
      
      // if (response.statusCode == 200) {
        // Decode and clean JSON response
        // String jsonString = utf8.decode(response.bodyBytes);        
        // Attempt to parse JSON into a Map
        // var parsedJson = jsonDecode(jsonString);
        // print(parsedJson);
        // Parse 'Meaning' object
        // if (parsedJson is Map<String, dynamic>) {
          // meaning = Meaning.fromJson(response);
        // } else {
        //   print('Unexpected JSON format');
        // }
      // } else {
      //   print('API Error with status code: ${response.statusCode}');
      // }
    // } catch (e) {
    //   print('Error fetching or parsing data: $e');
    // }

    // return results; // Return Meaning object
  }
}
