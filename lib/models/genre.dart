class Genre {
  Genre({required this.id, required this.name});
  final int id;
  final String name;

  factory Genre.fromMap(Map<String, dynamic> genre) {
    return Genre(id: genre['id'], name: genre['name']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
