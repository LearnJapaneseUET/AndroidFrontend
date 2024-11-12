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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kanji'] = this.writing;
    data['reading'] = this.furigana;
    data['meaning'] = this.meaning;
    return data;
  }
}