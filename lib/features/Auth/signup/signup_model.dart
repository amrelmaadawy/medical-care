class UserModel {
  final String fullname;
  final String email;
  final String password;
  final String phoneNumber;
  final String? image;

  UserModel({
    required this.fullname,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullname: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phoneNumber: json['phone_number'] ?? json['phoneNumber'] ?? '',
      image: json['image'],
    );
  }


}