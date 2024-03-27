import 'package:ape_manager_front/forms/login_form.dart';
import 'package:ape_manager_front/proprietes/constantes.dart';
import 'package:ape_manager_front/providers/authentification_provider.dart';
import 'package:ape_manager_front/providers/utilisateur_provider.dart';
import 'package:ape_manager_front/responsive/responsive_layout.dart';
import 'package:ape_manager_front/utils/afficher_message.dart';
import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:ape_manager_front/utils/logs.dart';
import 'package:ape_manager_front/utils/routage.dart';
import 'package:ape_manager_front/utils/stockage_hardware.dart';
import 'package:ape_manager_front/views/accueil/accueil_view.dart';
import 'package:ape_manager_front/views/authentification/login/demande_reinit_form_view.dart';
import 'package:ape_manager_front/views/authentification/signup/signup_view.dart';
import 'package:ape_manager_front/views/commandes/details/detail_commande_view.dart';
import 'package:ape_manager_front/views/commandes/liste/mes_commandes_view.dart';
import 'package:ape_manager_front/views/evenements/details/detail_evenement_view.dart';
import 'package:ape_manager_front/widgets/button_appli.dart';
import 'package:ape_manager_front/widgets/conteneur/popup.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_email.dart';
import 'package:ape_manager_front/widgets/formulaire/champ_mdp.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire.dart';
import 'package:ape_manager_front/widgets/formulaire/formulaire_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import 'StockageIdentifiants.dart';
import 'biometrique.dart';

class LoginFormView extends StatefulWidget {
  final String? lienRedirection;

  const LoginFormView({super.key, this.lienRedirection});

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends FormulaireState<LoginFormView> {
  late AuthentificationProvider authentificationProvider;
  late LoginForm loginForm = LoginForm();
  bool passerVerification = false;
  bool afficherBoutonBiometrique = false;

  @override
  void initState() {
    super.initState();
    authentificationProvider =
        Provider.of<AuthentificationProvider>(context, listen: false);
    verifierBiometriqueEtIdentifiants();
    if (PROD == "false" && AUTO_LOGIN_TEST == "true") {
      loginForm.email = EMAIL_AUTO_LOGIN_TEST;
      loginForm.password = PASSWORD_AUTO_LOGIN_TEST;
      passerVerification = true;
      appuiBoutonLogin();
    }
  }

  Future<void> verifierBiometriqueEtIdentifiants() async {
    final Biometrique _biometrique = Biometrique();
    final StockageIdentifiants _stockageIdentifiants = StockageIdentifiants();
    bool isBiometriqueDisponible = await _biometrique.isBiometricAvailable();
    Map<String, String> credentials =
        await _stockageIdentifiants.getIdentifiants();
    bool hasCredentials = credentials['email']!.isNotEmpty &&
        credentials['motDePasse']!.isNotEmpty;
    bool onMobile = UniversalPlatform.isAndroid || UniversalPlatform.isIOS;

    setState(() {
      afficherBoutonBiometrique =
          isBiometriqueDisponible && hasCredentials && onMobile;
    });
  }

  @override
  Formulaire setFormulaire(BuildContext context) {
    bool isLoggedIn = authentificationProvider.isLoggedIn;
    return Formulaire(
      formKey: formKey,
      erreur: erreur,
      contenuManuel: getTexteMdpOublie(),
      forcerBoutonsEnColonneSurMobile: false,
      champs: [
        [
          ChampEmail(
            label: "Votre email",
            onSavedMethod: (value) => loginForm.email = value!,
          ),
        ],
        [
          ChampMdp(
            label: "Votre mot de passe",
            onSavedMethod: (value) => loginForm.password = value!,
            controlerRobustesse: false,
          ),
        ],
      ],
      boutons: [
        BoutonAction(
          text: "Se connecter",
          fonction: () => appuiBoutonLogin(),
          disable: desactiverBoutons || isLoggedIn,
        ),
        if (estMobile(context, 600))
          BoutonNavigationGoRouter(
            text: "S'inscrire",
            themeCouleur: ThemeCouleur.rouge,
            routeName: SignupView.routeURL,
            disable: desactiverBoutons || isLoggedIn,
          ),
        //if mobile et biometrique non vide
        if (afficherBoutonBiometrique)
          BoutonIcon(
            icon: const Icon(Icons.fingerprint),
            onPressed: () => ConnexionBiometrique(context),
          ),
      ],
    );
  }

  void appuiBoutonLogin() {
    if (!chargement &&
        (passerVerification == true || formKey.currentState!.validate())) {
      if (passerVerification == false) {
        formKey.currentState!.save();
      } else {
        passerVerification = false;
      }
      appelMethodeAsynchrone(() {
        envoiFormulaireLogin();
      });
    }
  }

  Future<void> envoiFormulaireLogin() async {
    final response = await authentificationProvider.signin(
      loginForm,
      Provider.of<UtilisateurProvider>(context, listen: false),
    );
    if (response["statusCode"] == 200 && mounted) {
      final StockageIdentifiants _stockageIdentifiants = StockageIdentifiants();
      await _stockageIdentifiants.persistIdentifiants(
        loginForm.email,
        loginForm.password,
      );
      // Gestion de la perspective par défaut
      if (utilisateurProvider.estAdmin) {
        utilisateurProvider.setPerspective(Perspective.ADMIN);
      } else if (utilisateurProvider.estOrganisateur) {
        utilisateurProvider.setPerspective(Perspective.ORGANIZER);
      } else {
        utilisateurProvider.setPerspective(Perspective.PARENT);
      }

      afficherMessageSucces(
          context: context, message: "Connexion établie avec succès.");

      // Cas particulier de gestion de la perspective quand on veut aller sur partage évent
      if (widget.lienRedirection != null &&
          widget.lienRedirection!.isNotEmpty) {
        afficherLogInfo("Redirection vers '${widget.lienRedirection}'");

        // Redirection vers l'URL initialement interrogé
        if (DetailEvenementView.routeURL.contains(widget.lienRedirection!)) {
          utilisateurProvider.setPerspective(Perspective.PARENT);
        }
        naviguerVersPage(context, widget.lienRedirection!);
        //}
      } else {
        afficherLogInfo("Redirection vers '${AccueilView.routeURL}'");
        naviguerVersPage(context, AccueilView.routeURL);
      }
    } else {
      setMessageErreur(response['message']);
    }
  }

  Widget getTexteMdpOublie() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => getPopupMdpOublie(),
              );
            },
            child: Text(
              'Mot de passe oublié ?',
              style: FontUtils.getFontApp(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> ConnexionBiometrique(BuildContext context) async {
    final Biometrique _biometrique = Biometrique();
    final StockageIdentifiants _stockageIdentifiants = StockageIdentifiants();
    bool isAuthenticated = await _biometrique.isAuthenticated();
    if (isAuthenticated) {
      Map<String, String> credentials =
          await _stockageIdentifiants.getIdentifiants();
      if (credentials['email']!.isNotEmpty &&
          credentials['motDePasse']!.isNotEmpty) {
        final response = await authentificationProvider.signinWithEmailPassword(
          email: credentials['email']!,
          password: credentials['motDePasse']!,
          utilisateurProvider: utilisateurProvider,
        );
        if (response["statusCode"] == 200) {
          naviguerVersPage(context, AccueilView.routeURL);
          afficherMessageSucces(
              context: context, message: "Connexion établie avec succès.");
          if (utilisateurProvider.estAdmin) {
            utilisateurProvider.setPerspective(Perspective.ADMIN);
          } else if (utilisateurProvider.estOrganisateur) {
            utilisateurProvider.setPerspective(Perspective.ORGANIZER);
          } else {
            utilisateurProvider.setPerspective(Perspective.PARENT);
          }
        } else {
          if (response['message'] == "Mot de passe incorrect !") {
            afficherMessageErreur(
                context: context,
                message:
                    "Échec de l'authentification. Si vous avez changé de mot de passe sur une autre plateforme, veuillez vous connecter manuellement afin de mettre à jour vos identifiants.");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Erreur de connexion: ${response['message']}")));
          }
          ;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Aucun identifiant stocké pour la connexion biométrique.")));
      }
    }
  }

  Widget getPopupMdpOublie() {
    return const Popup(
      titre: "Mot de passe oublié",
      sousTitre:
          "Veuillez renseigner votre adresse email afin de recevoir un mail de réinitialisation du mot de passe.",
      body: DemandeReinitMdpFormView(),
    );
  }
}
