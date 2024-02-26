import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';

String URL_API = "${dotenv.env['URL_API']}";
String PROD = "${dotenv.env['PROD']}";
String AUTO_LOGIN_TEST = "${dotenv.env['AUTO_LOGIN_TEST']}";
String EMAIL_AUTO_LOGIN_TEST = "${dotenv.env['EMAIL_AUTO_LOGIN_TEST']}";
String PASSWORD_AUTO_LOGIN_TEST = "${dotenv.env['PASSWORD_AUTO_LOGIN_TEST']}";

// HEADER
const double HEADER_HEIGHT = 80;
const double HEADER_HEIGHT_MOBILE = 100;
const double HEADER_HEIGHT_DESKTOP = 200;

const double FOOTER_HEIGHT = 80;
const double EXPANDED_TILE_WIDTH = 1750;
const double PAGE_WIDTH = 1600;
const double BOUTON_WIDTH = 90;
const double POLICE_DESKTOP_TITRE = 60.0;
const double POLICE_DESKTOP_NORMAL = 22.0;
const double POLICE_MOBILE_TITRE = 30.0;
const double POLICE_MOBILE_NORMAL = 18.0;
const FontWeight FONT_WEIGHT_NORMAL = FontWeight.w200;
