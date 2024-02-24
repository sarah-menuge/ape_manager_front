import 'package:ape_manager_front/utils/font_utils.dart';
import 'package:flutter/material.dart';

import 'login_form_view.dart';

class LoginSection extends StatelessWidget {
  const LoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getLogo(),
                getLibelleLogo(),
              ],
            ),
            LoginFormView(),
          ],
        ),
      ),
    );
  }

  Widget getLogo() {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Image.asset('assets/images/logoEcole.png', width: 80, height: 80),
    );
  }

  Widget getLibelleLogo() {
    return Flexible(
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Association des parents d\'élèves \n',
              style: FontUtils.getFontApp(
                fontSize: 15,
              ),
            ),
            TextSpan(
              text: 'École et Collège\nSte Marie Perenchies',
              style: FontUtils.getFontApp(
                fontWeight: FontWeight.w100,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
