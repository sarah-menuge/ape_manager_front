import 'dart:collection';
import 'dart:convert';
import 'package:ape_manager_front/models/Article.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArticleProvider with ChangeNotifier {
  List<Article> _articles = [];

  UnmodifiableListView<Article> get articles => UnmodifiableListView(_articles);

  fetchData() async {
    try {
      http.Response response =
          await http.get(Uri.parse("http://10.0.2.2:8080/articles"));

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        _articles = (json.decode(response.body) as List)
            .map((articleJson) => Article.fromJson(articleJson))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }
}
