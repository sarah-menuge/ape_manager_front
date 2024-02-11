import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Écran de connexion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEED9C4),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: LoginCard(),
          ),
        ),
      ),
    );
  }
}

class LoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFF6ED),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: LoginForm(),
            ),
            VerticalDivider(
              color: Colors.grey,
              thickness: 1,
            ),
            Expanded(
              flex: 1,
              child: SignUpSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LogoHeader(),
        SizedBox(height: 50),
        EmailFormField(),
        SizedBox(height: 20),
        PasswordFormField(),
        SizedBox(height: 20),
        ForgotPasswordButton(),
        SizedBox(height: 20),
        LoginButton(),
      ],
    );
  }
}

class SignUpSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 50),
        SignUpPrompt(),
        SignUpButton(),
      ],
    );
  }
}

class LogoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/LogoEcole.jpg', width: 100, height: 100);
  }
}

class EmailFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class PasswordFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Mot de passe',
        border: OutlineInputBorder(),
      ),
      obscureText: true,
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
        },
        child: Text('Mot de passe oublié'),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
      },
      child: Text('Se connecter'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class SignUpPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Pas de compte ?',
      style: TextStyle(color: Colors.black),
    );
  }
}

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
      },
      child: Text('S\'inscrire'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    );
  }
}
