class ReinitialisationForm {
  String? email;

  ReinitialisationForm({required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}