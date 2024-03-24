import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StockageIdentifiants {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> persistIdentifiants(String email, String motDePasse) async {
    await _storage.write(key: 'emailUtilisateur', value: email);
    await _storage.write(key: 'motDePasseUtilisateur', value: motDePasse);
  }

  Future<Map<String, String>> getIdentifiants() async {
    String? email = await _storage.read(key: 'emailUtilisateur');
    String? motDePasse = await _storage.read(key: 'motDePasseUtilisateur');
    return {'email': email ?? '', 'motDePasse': motDePasse ?? ''};
  }
}
