import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';

String URL_API = "${dotenv.env['URL_API']}";
String PROD = "${dotenv.env['PROD']}";
String AUTO_LOGIN_TEST = "${dotenv.env['AUTO_LOGIN_TEST']}";
String EMAIL_AUTO_LOGIN_TEST = "${dotenv.env['EMAIL_AUTO_LOGIN_TEST']}";
String PASSWORD_AUTO_LOGIN_TEST = "${dotenv.env['PASSWORD_AUTO_LOGIN_TEST']}";

// HEADER
const double HEADER_HEIGHT = 80;
const double HEADER_HEIGHT_MOBILE = 60;
const double HEADER_HEIGHT_DESKTOP = 80;

const double FOOTER_HEIGHT = 80;
const double EXPANDED_TILE_WIDTH = 1750;
const double PAGE_WIDTH = 1600;
const double BOUTON_WIDTH = 90;
const double POLICE_DESKTOP_H1 = 60.0;
const double POLICE_DESKTOP_H2 = 30.0;
const double POLICE_DESKTOP_NORMAL_1 = 22.0;
const double POLICE_DESKTOP_NORMAL_2 = 18.0;
const double POLICE_MOBILE_H1 = 30.0;
const double POLICE_MOBILE_H2 = 20.0;
const double POLICE_MOBILE_NORMAL_1 = 18.0;
const double POLICE_MOBILE_NORMAL_2 = 15.0;
const FontWeight FONT_WEIGHT_NORMAL = FontWeight.w200;
