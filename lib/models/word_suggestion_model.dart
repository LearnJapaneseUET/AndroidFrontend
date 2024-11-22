class WordSuggestion {
  String? writing;
  String? furigana;
  String? meaning;

  WordSuggestion({this.writing, this.furigana, this.meaning});

  WordSuggestion.fromJson(Map<String, dynamic> json) {
    writing = json['kanji'];
    furigana = json['reading'];
    meaning = json['meaning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kanji'] = writing;
    data['reading'] = furigana;
    data['meaning'] = meaning;
    return data;
  }
}
