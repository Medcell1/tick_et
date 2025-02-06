class User {
  final String id;
  final String name;
  final String email;
  final int age;
  final String username;
  final String avatarUrl;
  final String bio;
  final bool isOnline;
  final String lastSeen;
  final int? followingsCount;
  final int? followersCount;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.username,
    required this.avatarUrl,
    required this.bio,
    required this.isOnline,
    required this.lastSeen,
    this.followingsCount,
    this.followersCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String,
      bio: json['bio'] as String,
      isOnline: json['isOnline'] as bool,
      lastSeen: json['lastSeen'] as String,
      followingsCount: json['followingsCount'] as int?,
      followersCount: json['followersCount'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'age': age,
      'username': username,
      'avatarUrl': avatarUrl,
      'bio': bio,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
      'followingsCount': followingsCount,
      'followersCount': followersCount,
    };
  }
}
