# APE Manager - Front

Ce projet, basé sur Flutter, servira de fondation pour le déploiement d'une application
multiplateforme (iOS, web, Android, etc.) dans le cadre du projet de Mobilité et de JEE.

## Pré-Requis

* Flutter
    * [Installation de Flutter](https://docs.flutter.dev/get-started/install)
* Android Studio
    * Cet outil de développement offre également la possibilité d'installer les packages nécessaires
      au bon fonctionnement de Flutter.

Pour vérifier si Flutter et ses dépendances sont correctement installés, utilisez la commande
`flutter doctor`.

Lorsque vous ouvrez votre projet dans Android Studio, celui-ci devrait automatiquement détecter la
présence de Flutter et proposer l'installation des plugins Flutter et Dart. Si ce n'est pas le cas,
vous pouvez les installer manuellement depuis l'interface des plugins d'Android Studio. N'oubliez
pas de redémarrer le logiciel pour activer ces plugins.

### Run de l'application avec un émulateur

Pour lancer une application sur un émulateur, il suffit de démarrer l'émulateur puis d'exécuter la
commande suivante :
`flutter run`

### Run de l'application avec chrome

L'application web peut également être lancée via Android Studio, mais pour un traitement plus
rapide, la commande flutter run -d chrome permet d'émuler automatiquement le projet et d'ouvrir une
fenêtre Chrome.

De plus, Flutter propose une fonctionnalité
appelée [`Hot Reload/Hot Restart`](https://docs.flutter.dev/tools/hot-reload) qui permet de
visualiser les modifications en temps réel dans le rendu émulé.

Pour utiliser Flutter sous le web, assurez-vous que Chrome est bien détecté avec la commande
`flutter doctor`. Si ce n'est pas le cas, il suffit de faire (sous Linux):

```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
```

### Run de l'application avec un Android

Pour lancer une application sur un smartphone réel, les manipulations sont plus complexes.
Lorsque l'on teste l'application sur un appareil Android, celui-ci ne peut pas accéder directement
au serveur local en utilisant localhost ou 10.0.2.2.

1. S'assurer que le téléphone et la machine hébergeant le serveur sont sur le même réseau local.

2. Lancer l'API en indiquant d'ouvrir les ports sur le réseau local :
   `./mvnw quarkus:dev -Dquarkus.http.host=0.0.0.0`

3. S'il n'existe pas, créer un fichier .env à l'image du fichier .env_template

4. Rediriger les requêtes provenant de l'appareil Android vers le serveur local, en
   contournant les restrictions habituelles d'accès aux ressources locales.

   Pour ce faire, la commande à utiliser est la suivante :
   `adb reverse tcp:8080 tcp:8080`
   Le premier tcp:8080 fait référence au port 8080 du smartphone ; le second à celui de la machine
   hôte.

   Si une erreur est rencontrée à cette étape : "adb server version (41) doesn't match this client (
   39); killing..."
   Cela signifie que la version d'adb n'est pas la bonne pour cela il suffit d'exécuter les
   commandes suivantes dans un terminal :
    ```
    wget https://developer.android.com/studio/releases/platform-tools.html
    unzip platform-tools_r35.0.0-linux.zip
   sudo cp -r ~/Téléchargements/platform-tools/* /usr/bin/
   adb version
   ```

   Pour vérifier que cela a fonctionné, lancer la commande suivante :
   `adb reverse --list` -> cela affiche une ligne avec le port et le smartphone
   Si besoin, pour relancer : `adb kill-server; adb start-server`

5. Lancer l'application Flutter sur le smartphone.

## Quelques guides sympas

Voici quelques références en la matière pour comprendre le fonctionnement de flutter et les
possibilités du langage Dart qu'utilise Flutter:

* [Codelabs de Google](https://codelabs.developers.google.com/codelabs/flutter-codelab-first?hl=fr#0) :
  Un tutoriel pour faire une première application avec Flutter.
* [Flutter Gallery](https://flutter-gallery-archive.web.app/) : Liste de projets possibles et des
  différents composants existants.
