import 'package:ape_manager_front/utils/logs.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Biometrique {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isAuthenticated() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Veuillez vous authentifier pour accéder à cette section',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } on PlatformException catch (e) {
      afficherLogError(e.toString());
      return false;
    }
  }

  Future<bool> isBiometricAvailable() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

}
