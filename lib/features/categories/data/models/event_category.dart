class EventCategory {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  EventCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory EventCategory.fromJson(Map<String, dynamic> json) {
    return EventCategory(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory EventCategory.sampleData() {
    return EventCategory(id: 'id', name: 'name', description: 'description', imageUrl: 'imageUrl',);
  }
}