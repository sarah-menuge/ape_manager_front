// La réinitialisation d'un mot de passe est effectuée après envoi d'un mail
// avec un lien vers le formulaire de réinitialisation
class ReinitMdpForm {
  String? token;
  String? nouveauMdp;
  String? confirmerNouveauMdp;

  ReinitMdpForm({
    this.token = "",
    this.nouveauMdp = "",
    this.confirmerNouveauMdp = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'newPassword': nouveauMdp,
    };
  }
}
