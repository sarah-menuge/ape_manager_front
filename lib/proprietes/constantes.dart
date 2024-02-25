import 'package:flutter_dotenv/flutter_dotenv.dart';

String URL_API = "${dotenv.env['URL_API']}";
String PROD = "${dotenv.env['PROD']}";
String AUTO_LOGIN_TEST = "${dotenv.env['AUTO_LOGIN_TEST']}";
String EMAIL_AUTO_LOGIN_TEST = "${dotenv.env['EMAIL_AUTO_LOGIN_TEST']}";
String PASSWORD_AUTO_LOGIN_TEST = "${dotenv.env['PASSWORD_AUTO_LOGIN_TEST']}";

const double HEADER_HEIGHT = 80;
const double FOOTER_HEIGHT = 80;
const double EXPANDED_TILE_WIDTH = 1750;

