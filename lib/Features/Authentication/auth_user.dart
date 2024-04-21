class User {
  final int? userId;
  final String phoneNumber;
  final String password;

  User({
    required this.userId,
    required this.phoneNumber,
    required this.password,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}
