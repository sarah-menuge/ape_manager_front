# APE Manager - Front

Ce projet, basé sur Flutter, servira de fondation pour le déploiement d'une application
multiplateforme (iOS, web, Android, etc.) dans le cadre du projet de Mobilité et de JEE.

## Pré-Requis

* Flutter
    * [Installation de Flutter](https://docs.flutter.dev/get-started/install)
* Android Studio
    * Cet outil de développement offre également la possibilité d'installer les packages nécessaires
      au bon fonctionnement de Flutter.

## Démarrage de Flutter

Pour vérifier si Flutter et ses dépendances sont correctement installés, utilisez la commande
```flutter doctor```. Au départ, vous pouvez ignorer les avertissements concernant les certificats
Android.

Lorsque vous ouvrez votre projet dans Android Studio, celui-ci devrait automatiquement détecter la
présence de Flutter et proposer l'installation des plugins Flutter et Dart. Si ce n'est pas le cas,
vous pouvez les installer manuellement depuis l'interface des plugins d'Android Studio. N'oubliez
pas de redémarrer le logiciel pour activer ces plugins.

Pour utiliser Flutter sous le web, assurez-vous que Chrome est bien détecté
par ```flutter doctor```.
Si ce n'est pas le cas, il suffit de faire (sous Linux):

```wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
```

### Run de l'application en version mobile

Cela fonctionne de la même manière qu'un projet Android standard : vous devez choisir un émulateur
pour simuler l'application sur un smartphone. Une fois l'émulateur lancé, pour lancer l'application,
utilisez la commande ```flutter run```.

### Run de l'application en version web

L'application web peut également être lancée via Android Studio, mais pour un traitement plus
rapide, la commande flutter run -d chrome permet d'émuler automatiquement le projet et d'ouvrir une
fenêtre Chrome.

De plus, Flutter propose une fonctionnalité
appelée [```Hot Reload/Hot Restart```](https://docs.flutter.dev/tools/hot-reload) qui permet de
visualiser les modifications en temps réel dans le rendu émulé.

## Quelques guides sympas

Voici quelques références en la matière pour comprendre le fonctionnement de flutter et les
possibilités du langage Dart qu'utilise Flutter:

* [Codelabs de Google](https://codelabs.developers.google.com/codelabs/flutter-codelab-first?hl=fr#0) :
  Un tutoriel pour faire une première application avec Flutter.
* [Flutter Gallery](https://flutter-gallery-archive.web.app/) : Liste de projets possibles et des
  différents composants existants.
