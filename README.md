# APE Manager - Front

Ce projet est basé sur flutter et servira de base pour déployer une application multi-plateformes (iOS,web,android...) dans le cadre du projet de Mobilité.

## Pré-Requis

* Flutter
    * [Installation de Flutter](https://docs.flutter.dev/get-started/install)
* Android Studio
    * Outil de développement, permet aussi d'installer les paquets nécessaires au bon fonctionnement de Flutter


## Démarrage de Flutter

La commande ```flutter doctor``` permet de voir si Flutter et ses dépendances sont correctement installé.
Dans un premier temps le point sur les certificats Android peut être ignoré.

À l'ouverture du projet dans Android Studio ce dernier devrait automatiquement détecter Flutter dans le projet et proposer les plugins Flutter et Dart, il faut les installer manuellement si ce n'est pas le cas dans l'interface des plugins d'Android Studio. Il est nécessaire de redémarrer le logiciel pour qu'ils soient actifs. 

### Run de l'application en version mobile

Cela reste similaire à un projet Android classique, sélectionner l'émulateur choisi pour émuler l'application sur un smartphone (après avoir installé les plugins sus-cités).

### Run de l'application en version web

L'application web peut être également lancée via Android Studio mais la commande ```bash flutter run -d chrome``` permet d'émuler automatiquement le projet et d'ouvrir une fenètre Chrome, le traitement est plus rapide.

Flutter possède également une fonctionnalité [```Hot Reload/Hot Restart```](https://docs.flutter.dev/tools/hot-reload) permettant de voir les modifications en temps réel dans le rendu émulé.

## Quelques guides sympa

Voici quelques références en la matière pour comprendre le fonctionnement de flutter et les possibilités du langage Dart qu'utilise Flutter:

* [Codelabs de Google](https://codelabs.developers.google.com/codelabs/flutter-codelab-first?hl=fr#0) : petit tutoriel de A à Z.
* [Flutter Gallery](https://flutter-gallery-archive.web.app/) : Liste de projets possibles et des différents composants existants.
