class Notebook {
  final String name;
  final String description;
  final int userId;
  final int id;

  Notebook({
    required this.name,
    required this.description,
    required this.userId,
    required this.id,
  });

  factory Notebook.fromJson(Map<String, dynamic> json) {
    return Notebook(
      name: json['name'],
      description: json['description'],
      userId: json['user_id'],
      id: json['id'],
    );
  }

  static List<Notebook> fromJsonList(Map<String, dynamic> json) {
    var list = json['list'] as List;
    return list.map((item) => Notebook.fromJson(item)).toList();
  }
}