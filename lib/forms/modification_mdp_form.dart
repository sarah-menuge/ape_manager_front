// La modification d'un mot de passe est effectuée lorsque l'utilisateur est déjà authentifié
class ModificationMdpForm {
  late String email = "";
  late String oldPassword = "";
  late String newPassword = "";
  late String confirmerNewPassword = "";

  ModificationMdpForm({required this.email});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
  }
}
