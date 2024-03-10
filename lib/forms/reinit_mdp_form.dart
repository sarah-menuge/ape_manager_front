// La réinitialisation d'un mot de passe est effectuée après envoi d'un mail
// avec un lien vers le formulaire de réinitialisation
class ReinitMdpForm {
  String? email;
  String? nouveauMdp;
  String? encoreNouveauMdp;

  ReinitMdpForm({
    this.email = "",
    this.nouveauMdp = "",
    this.encoreNouveauMdp = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'newPassword': nouveauMdp,
      'encoreNouveauMdp': encoreNouveauMdp,
    };
  }
}
