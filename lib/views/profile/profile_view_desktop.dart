import 'package:flutter/material.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/widgets/header_appli.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../widgets/TextTitre.dart';
import 'AllFields.dart';
import 'BoutonAjouterEnfant.dart';
import 'TableEnfants.dart';
import 'change_password.dart';

class ProfileViewDesktop extends StatefulWidget {
  const ProfileViewDesktop({Key? key, this.initialReadOnly = true})
      : super(key: key);
  final bool initialReadOnly;

  @override
  _ProfileViewDesktopState createState() => _ProfileViewDesktopState();
}

class _ProfileViewDesktopState extends State<ProfileViewDesktop> {
  late bool readOnly;

  @override
  void initState() {
    super.initState();
    readOnly = widget.initialReadOnly;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppli(titre: ''),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                TextTitre(titre: 'Mon Profil'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        AllFields(readOnly: readOnly),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  readOnly = !readOnly;
                                });
                              },
                              child:
                                  Text(readOnly ? 'Modifier' : 'Sauvegarder'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: BLEU,
                                foregroundColor: BLANC,
                              ),
                            ),
                            SizedBox(width: 30),
                            ElevatedButton(
                              onPressed: () {
                                if (readOnly) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            BEIGE_FONCE.withOpacity(1.0),
                                        title: Text('Suppression du compte'),
                                        content: Text(
                                            'Êtes-vous sûr de vouloir supprimer votre compte ?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Annuler',
                                              style: TextStyle(color: NOIR),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Supprimer',
                                              style: TextStyle(color: ROUGE),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  setState(() {
                                    readOnly = !readOnly;
                                  });
                                }
                              },
                              child: Text(readOnly ? 'Supprimer' : 'Annuler'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ROUGE,
                                foregroundColor: BLANC,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(child: BoutonChangerMDP()),
                      ],
                    ),
                    Container(
                        color: Colors.grey,
                        child: const SizedBox(height: 500, width: 3)),
                    Column(
                      children: [
                        TableEnfants(),
                        SizedBox(height: 20),
                        BoutonAjouterEnfant(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end, children: [Footer()]),
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      height: 80,
      color: GRIS_FONCE,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () =>
                launchUrlString('https://www.saintemarieperenchies.fr/'),
            child: Row(
              children: [
                Image(
                    image: AssetImage("assets/images/logoEcole.png"),
                    width: 40),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                        "Site de l'école / collège \nSainte Marie Pérenchies")),
              ],
            ),
          ),
          InkWell(
            onTap: () => launchUrlString('https://www.apel.fr/'),
            child: Row(
              children: [
                Image(
                    image: AssetImage("assets/images/APELogo.png"), width: 40),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Site de l'APEL national")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
