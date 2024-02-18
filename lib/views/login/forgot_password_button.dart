import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {},
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
