class TicketType {
  final String id;
  final double price;
  final String name;
  final String description;
  final String codePrefix;
  final String createdBy;

  TicketType({
    required this.id,
    required this.price,
    required this.name,
    required this.description,
    required this.codePrefix,
    required this.createdBy,
  });

  factory TicketType.fromJson(Map<String, dynamic> json) {
    return TicketType(
      id: json['_id'] as String,
      price: (json['price'] as num).toDouble(),
      name: json['name'] as String,
      description: json['description'] as String,
      codePrefix: json['codePrefix'] as String,
      createdBy: json['createdBy'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'price': price,
      'name': name,
      'description': description,
      'codePrefix': codePrefix,
      'createdBy': createdBy,
    };
  }

  factory TicketType.sampleData() {
    return TicketType(id: '0',
      price: 20.00,
      name: 'name',
      description: 'description',
      codePrefix: 'codePrefix',
      createdBy: 'createdBy',
    );
  }
}
