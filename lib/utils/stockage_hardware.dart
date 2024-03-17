import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage storage = FlutterSecureStorage();

// Permet de récupérer une valeur sur la mémoire du hardware
Future<String?> getValueInHardwareMemory({required String key}) async {
  return storage.read(key: key);
}

// Permet d'enregistrer une valeur sur la mémoire du hardware
void setValueInHardwareMemory(
    {required String key, required dynamic value}) async {
  storage.write(key: key, value: value);
}
