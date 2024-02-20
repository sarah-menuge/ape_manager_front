class LoginForm {
  String? email;
  String? password;

  LoginForm({this.email, this.password});

  @override
  String toString() {
    return "$email : $password";
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
