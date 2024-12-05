class Word{
  final String word;
  final String meaning;
  final String id;
  final String? furigana;

  Word({
    required this.word,
    required this.meaning,
    required this.id,
    this.furigana,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json['w'],
      meaning: json['m'],
      id: json['id'],
      furigana: json['p'],
    );
  }

  static List<Word> fromJsonList(Map<String, dynamic> json) {
    var list = json['words'] as List;
    return list.map((item) => Word.fromJson(item)).toList();
  }
}