class AuthUser {
  String? phone;
  String? firstName;
  String? lastName;
  String? password;
  bool? isVerified = false;

  AuthUser({
    this.phone,
    this.firstName,
    this.lastName,
    this.password,
    this.isVerified,
  });
}
