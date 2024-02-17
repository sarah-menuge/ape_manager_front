class SignupForm {
  String? email;
  String? username;
  String? password;

  SignupForm({
    this.email,
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'username': username, 'password': password};
  }
}
