import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:flutter/material.dart';
import 'package:ape_manager_front/utils/font_utils.dart';

class ForgotPasswordButton extends StatelessWidget {
  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BEIGE_FONCE.withOpacity(1.0),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Veuillez entrer votre mail pour demander une réinitialisation du mot de passe",style: FontUtils.getFontApp(fontSize: 15),),
                SizedBox(height: 20,),
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 450),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.mail),
                            ),
                            style: const TextStyle(height: 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BLEU,
                          ),
                          child: Text("Envoyer",style: TextStyle(color: BLANC),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            _showForgotPasswordDialog(context);
          },
          child: Text(
            'Mot de passe oublié ?',
            style: FontUtils.getFontApp(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
