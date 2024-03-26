import 'package:ape_manager_front/utils/logs.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const FlutterSecureStorage storage = FlutterSecureStorage();

// Permet de récupérer une valeur sur la mémoire du hardware
Future<String?> getValueInHardwareMemory({required String key}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString(key);
  afficherLogDebug("Type de valeur de '$key': ${value.runtimeType}");
  if (value == "") value = null;
  afficherLogDebug("Récupération de la valeur de '$key' : $value");
  return value;
  /*try {
    String? value = await storage.read(key: key);
    afficherLogDebug("Récupération de la valeur de '$key' : $value");
    return value;
  } catch (e) {
    afficherLogCritical("La récupération de la valeur '$key' a échouée.");
    return null;
  }*/
}

// Permet d'enregistrer une valeur sur la mémoire du hardware
Future<void> setValueInHardwareMemory(
    {required String key, required dynamic value}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  afficherLogDebug("Enregistrement de '$key' avec la valeur suivante : $value");
  await prefs.setString(key, value);
  /*try {
    afficherLogDebug(
        "Enregistrement de '$key' avec la valeur suivante : $value");
    await storage.write(key: key, value: value);
  } catch (e) {
    afficherLogCritical("L'initialisation de la valeur '$key' a échouée.");
  }*/
}

Future<void> unsetValueInHardwareMemory({required String key}) async {
  afficherLogDebug("Réinitialisation de la clé '$key'");
  setValueInHardwareMemory(key: key, value: "");
  /*try {
    afficherLogDebug("Réinitialisation de la clé '$key'");
    setValueInHardwareMemory(key: key, value: null);
  } catch (e) {
    afficherLogCritical("La réinitialisation de la valeur '$key' a échouée.");
  }*/
}
