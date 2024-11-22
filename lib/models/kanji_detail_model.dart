class KanjiDetailModel {
  final Meaning? meaning;
  final List<ExampleSimple>? examples;
  final List<Comment>? comments;
  final String? kanjiArt;

  KanjiDetailModel({
    this.meaning,
    this.examples,
    this.comments,
    this.kanjiArt
  });

  factory KanjiDetailModel.fromJson(Map<String, dynamic> json) {
    return KanjiDetailModel(
        //meaning: json['meaning'] != null ? Meaning.fromJson(json['meaning']) : null,
        meaning: json['meaning'] != null ? Meaning.fromJson(json['meaning']) : null,
        examples: json['example'] != null
            ? (json['example'] as Map<String, dynamic>)
                .values
                .map((e) => ExampleSimple.fromJson(e))
                .toList()
            : null,
        comments: json['comment'] != null
            ? (json['comment'] as Map<String, dynamic>)
                .values
                .map((c) => Comment.fromJson(c))
                .toList()
            : null,
        kanjiArt: json['kanjiArt']
    );
  }
}

class Meaning {
    final String? kanji;
    final String? mean;
    final String? kun;
    final String? on;
    final String? detail;
    final String? strokeCount;
    final List<ExampleDetail>? examples;
    final List<PhoneticExample>? exampleOn;
    final List<PhoneticExample>? exampleKun;
    final List<String>? level;

    Meaning({
        this.kanji,
        this.mean,
        this.kun,
        this.on,
        this.detail,
        this.strokeCount,
        this.examples,
        this.exampleOn,
        this.exampleKun,
        this.level
    });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
        kanji: json['kanji'],
        mean: json['mean'],
        on: json['on'],
        kun: json['kun'],
        detail: json['detail'],
        examples: json['examples'] != null
          ? (json['examples'] as List)
              .map((item) => ExampleDetail.fromJson(item))
              .toList()
          : null,
        exampleOn: json['example_on'] != null
            ? (json['example_on'] as Map<String, dynamic>)
                .entries
                .map((entry) => PhoneticExample.fromJson(entry.key, entry.value))
                .toList()
            : null,
        exampleKun: json['example_kun'] != null
            ? (json['example_kun'] as Map<String, dynamic>)
                .entries
                .map((entry) => PhoneticExample.fromJson(entry.key, entry.value))
                .toList()
            : null,
        level: List<String>.from(json['level'])
    );
  }
}

class ExampleDetail {
  final String? content;
  final String? mean;
  final String? transcription;
  final String? hanviet;
  ExampleDetail({
    this.content,
    this.mean,
    this.transcription,
    this.hanviet
  });

  factory ExampleDetail.fromJson(Map<String, dynamic> json) {
    print(json);
    return ExampleDetail(
      content: json['w'],
      mean: json['m'],
      transcription: json['p'],
      hanviet: json['h'],
    );
  }
}

class PhoneticExample {
  final String? phonetic;
  final List<ExampleDetail>? examples;

  PhoneticExample({
    this.phonetic,
    this.examples
  });

  factory PhoneticExample.fromJson(String phonetic, List<dynamic> examplesJson) {
    print(examplesJson);
    return PhoneticExample(
      phonetic: phonetic,
      examples: examplesJson.map((e) => ExampleDetail.fromJson(e)).toList()
    );
  }
}

class ExampleSimple {
  final String? content;
  final String? mean;
  final String? transcription;

  ExampleSimple({
    this.content,
    this.mean,
    this.transcription,
  });

  factory ExampleSimple.fromJson(Map<String, dynamic> json) {
    return ExampleSimple(
      content: json['content'],
      mean: json['mean'],
      transcription: json['transcription'],
    );
  }
}

class Comment {
  final String? mean;
  final int? like;
  final int? dislike;
  final String? username;

  Comment({
    this.mean,
    this.like,
    this.dislike,
    this.username,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      mean: json['mean'],
      like: json['like'],
      dislike: json['dislike'],
      username: json['username'],
    );
  }
}
