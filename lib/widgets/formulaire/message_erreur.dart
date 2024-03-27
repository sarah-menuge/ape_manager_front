import 'package:flutter/material.dart';

class MessageErreur extends StatelessWidget {
  final String? erreur;

  const MessageErreur({super.key, this.erreur});

  @override
  Widget build(BuildContext context) {
    if (erreur == null) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
        child: Text(
          erreur!,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red[900]),
        ),
      );
    }
  }
}
