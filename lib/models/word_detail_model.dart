class WordDetailModel {
  final Meaning? meaning;
  final List<ExampleSimple>? examples;
  final List<Comment>? comments;

  WordDetailModel({
    this.meaning,
    this.examples,
    this.comments,
  });

  factory WordDetailModel.fromJson(Map<String, dynamic> json) {
    return WordDetailModel(
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
    );
  }
}

class Meaning {
  final String? shortMean;
  final int? mobileId; // Có thể null
  final String? word;
  final String? phonetic;
  final List<MeanDetail>? means;

  Meaning({
    this.shortMean,
    this.mobileId,
    this.word,
    this.phonetic,
    this.means,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      shortMean: json['short_mean'],
      mobileId: json['mobileId'],
      word: json['word'],
      phonetic: json['phonetic'],
      means: json['means'] != null
          ? (json['means'] as List)
              .map((item) => MeanDetail.fromJson(item))
              .toList()
          : null,
    );
  }
}

class MeanDetail {
  final String? mean;
  final String? kind;
  final List<Example>? examples;

  MeanDetail({
    this.mean,
    this.kind,
    this.examples,
  });

  factory MeanDetail.fromJson(Map<String, dynamic> json) {
    return MeanDetail(
      mean: json['mean'],
      kind: json['kind'],
      examples: json['examples'] != null
          ? (json['examples'] as List)
              .map((item) => Example.fromJson(item))
              .toList()
          : null,
    );
  }
}

class Example {
  final String? content;
  final String? mean;
  final String? transcription;

  Example({
    this.content,
    this.mean,
    this.transcription,
  });

  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(
      content: json['content'],
      mean: json['mean'],
      transcription: json['transcription'],
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
