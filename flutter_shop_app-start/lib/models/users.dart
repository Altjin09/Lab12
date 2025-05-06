class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phone;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['name']['firstname'],
      lastName: json['name']['lastname'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
    );
  }

  String get fullName => "$firstName $lastName";
}
