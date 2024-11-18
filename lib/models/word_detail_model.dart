class WordDetail {
  final Meaning meaning;
  final List<ExampleSimple> examples;
  final List<Comment> comments;

  WordDetail({
    required this.meaning,
    required this.examples,
    required this.comments,
  });

  factory WordDetail.fromJson(Map<String, dynamic> json) {
    return WordDetail(
      meaning: Meaning.fromJson(json['meaning']),
      examples: (json['example'] as Map<String, dynamic>)
          .values
          .map((e) => ExampleSimple.fromJson(e))
          .toList(), // Đảm bảo xử lý đúng kiểu dữ liệu
      comments: (json['comment'] as Map<String, dynamic>)
          .values
          .map((c) => Comment.fromJson(c))
          .toList(),
    );
  }
}

class Meaning {
  final String shortMean;
  final int? mobileId; // Có thể null
  final String word;
  final String phonetic;
  final List<MeanDetail> means;

  Meaning({
    required this.shortMean,
    required this.mobileId,
    required this.word,
    required this.phonetic,
    required this.means,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      shortMean: json['short_mean'] ?? '',
      mobileId: json['mobileId'],
      word: json['word'] ?? '',
      phonetic: json['phonetic'] ?? '',
      means: (json['means'] as List)
          .map((item) => MeanDetail.fromJson(item))
          .toList(),
    );
  }
}

class MeanDetail {
  final String mean;
  final String kind;
  final List<Example> examples;

  MeanDetail({
    required this.mean,
    required this.kind,
    required this.examples,
  });

  factory MeanDetail.fromJson(Map<String, dynamic> json) {
    return MeanDetail(
      mean: json['mean'] ?? '',
      kind: json['kind'] ?? '',
      examples: (json['examples'] as List)
          .map((item) => Example.fromJson(item))
          .toList(),
    );
  }
}

// Model cho Example
class Example {
  final String content;
  final String mean;
  final String transcription;

  Example({
    required this.content,
    required this.mean,
    required this.transcription,
  });

  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(
      content: json['content'],
      mean: json['mean'],
      transcription: json['transcription'],
    );
  }
}

// Model cho Example ngoài
class ExampleSimple {
  final String content;
  final String mean;
  final String transcription;

  ExampleSimple({
    required this.content,
    required this.mean,
    required this.transcription,
  });

  factory ExampleSimple.fromJson(Map<String, dynamic> json) {
    return ExampleSimple(
      content: json['content'],        // 'content' field from JSON
      mean: json['mean'],              // 'mean' field from JSON
      transcription: json['transcription'], // 'transcription' field from JSON
    );
  }
}


// Model cho Comment
class Comment {
  final String mean;
  final int like;
  final int dislike;
  final String username;

  Comment({
    required this.mean,
    required this.like,
    required this.dislike,
    required this.username,
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
