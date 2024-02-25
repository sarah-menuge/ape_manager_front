import 'package:flutter_dotenv/flutter_dotenv.dart';

String URL_API = "${dotenv.env['URL_API']}";
String PROD = "${dotenv.env['PROD']}";

const String HOST_URL = "http://10.0.2.2";
const double HEADER_HEIGHT = 80;
const double FOOTER_HEIGHT = 80;
const double EXPANDED_TILE_WIDTH = 1750;

