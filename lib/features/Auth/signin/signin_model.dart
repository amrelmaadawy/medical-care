class SigninRequest {
  final String email;
  final String password;

  SigninRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class SigninResponse {
  final bool success;
  final String message;
  final SigninData data;
  final dynamic errors;

  SigninResponse({
    required this.success,
    required this.message,
    required this.data,
    this.errors,
  });

  factory SigninResponse.fromJson(Map<String, dynamic> json) {
    return SigninResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: SigninData.fromJson(json['data'] ?? {}),
      errors: json['errors'],
    );
  }
}

class SigninData {
  final SigninUser user;
  final String token;

  SigninData({
    required this.user,
    required this.token,
  });

  factory SigninData.fromJson(Map<String, dynamic> json) {
    return SigninData(
      user: SigninUser.fromJson(json['user'] ?? {}),
      token: json['token'] ?? '',
    );
  }
}

class SigninUser {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String type;
  final String createdAt;
  final String updatedAt;

  SigninUser({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SigninUser.fromJson(Map<String, dynamic> json) {
    return SigninUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      type: json['type'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}