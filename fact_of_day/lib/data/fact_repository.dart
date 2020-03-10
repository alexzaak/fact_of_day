import 'dart:async';
import 'dart:convert';

import 'package:fact_of_day/domain/model/fact.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.chucknorris.io";

class FactRepository {
  Future<Fact> getRandomFact(String language) async {
    var url = baseUrl + "/jokes/random";

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
