import 'package:ape_manager_front/views/signup_page/signup_form_card.dart';
import 'package:flutter/material.dart';
import 'package:ape_manager_front/proprietes/couleurs.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BEIGE_FONCE,
      body: Center(
        child: SingleChildScrollView(
          child: SignUpFormCard(formKey: _formKey),
        ),
      ),
    );
  }
}

