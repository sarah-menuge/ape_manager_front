import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../forms/signup_form.dart';
import '../proprietes/constantes.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<dynamic> signup(SignupForm signupForm) async {}
}
