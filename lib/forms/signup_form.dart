class SignupForm {
  String? nom;
  String? prenom;
  String? email;
  String? telephone;
  String? password;
  String? confirmerPassword;

  SignupForm({
    this.nom = "",
    this.prenom = "",
    this.email = "",
    this.telephone = "",
    this.password = "",
    this.confirmerPassword = "",
  });

  @override
  String toString() {
    return "$prenom $nom [$telephone] ($email - $password)";
  }

  Map<String, dynamic> toJson() {
    return {
      'surname': nom,
      'firstname': prenom,
      'email': email,
      'phone': telephone,
      'password': password
    };
  }
}
