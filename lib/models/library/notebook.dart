class Notebook {
  final String name;
  final int id;

  Notebook({
    required this.name,
    required this.id,
  });

  factory Notebook.fromJson(Map<String, dynamic> json) {
    return Notebook(
      name: json['name'],
      id: json['id'],
    );
  }

  static List<Notebook> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Notebook.fromJson(item)).toList();
  }
}