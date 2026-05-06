class AuthModel {
  final String id;
  final String token;
  final String name;
  final String email;

  AuthModel({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
  });

  /// API response shape:
  /// { "token": "abc...", "user": { "id": 1, "name": "...", "email": "..." } }
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? json;
    return AuthModel(
      id: user['id']?.toString() ?? '',
      token: json['token']?.toString() ?? '',
      name: user['name']?.toString() ?? '',
      email: user['email']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'token': token,
        'name': name,
        'email': email,
      };

  @override
  String toString() => 'AuthModel(id: $id, name: $name, email: $email)';
}
