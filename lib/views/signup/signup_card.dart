import 'package:ape_manager_front/proprietes/couleurs.dart';
import 'package:ape_manager_front/views/signup/signup_form_view.dart';
import 'package:flutter/material.dart';

class SignUpCard extends StatelessWidget {
  const SignUpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: BEIGE_CLAIR,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              getHeader(),
              SignupFormView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getHeader(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Image.asset('assets/images/logoEcole.png',
              width: 80, height: 80),
        ),
        const SizedBox(width: 12),
        const Flexible(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'Association des parents d\'élèves \n',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'École et Collège\nSte Marie Perenchies',
                    style: TextStyle(fontWeight: FontWeight.normal)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
