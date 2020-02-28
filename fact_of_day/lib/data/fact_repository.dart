import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/model/fact.dart';

const baseUrl = "http://randomuselessfact.appspot.com";

class FactRepository {
  Future<Fact> getRandomFact(String language) async {
    var url = baseUrl + "/random.json?language=$language";

    final response = await http.get(url);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Fact.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      return Future.error(Exception('Failed to load fact'));
    }
  }

  Future<Fact> getTodaysFact(String language) async {
    var url = baseUrl + "/today.json?language=$language";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Fact.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      return Future.error(Exception('Failed to load fact'));
    }
  }
}
