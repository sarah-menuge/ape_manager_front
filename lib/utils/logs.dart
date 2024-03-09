import 'package:ape_manager_front/proprietes/constantes.dart';

List<String> logLevels = ["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"];

void _afficherLog(String message) {
  if (PROD == "false") {
    print("$message");
  }
}

void afficherLogDebug(String message) {
  if (logLevels.sublist(0, 1).contains(LOG_LEVEL)) {
    _afficherLog("\x1B[36m[DEBUG] :\x1B[0m $message");
  }
}

void afficherLogInfo(String message) {
  if (logLevels.sublist(0, 2).contains(LOG_LEVEL)) {
    _afficherLog("\x1B[34m[INFO] :\x1B[0m $message");
  }
}

void afficherLogWarning(String message) {
  if (logLevels.sublist(0, 3).contains(LOG_LEVEL)) {
    _afficherLog("\x1B[33m[WARNING] :\x1B[0m $message");
  }
}

void afficherLogError(String message) {
  if (logLevels.sublist(0, 4).contains(LOG_LEVEL)) {
    _afficherLog("\x1B[31m[ERROR] :\x1B[0m $message");
  }
}

// Permet d'afficher un log erreur
void afficherLogCritical(String message) {
  if (logLevels.contains(LOG_LEVEL)) {
    _afficherLog("\x1B[91m[CRITICAL] :\x1B[0m $message");
  }
}
