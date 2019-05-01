import 'fact.dart';
import 'api.dart';
import 'dart:async';
import 'dart:convert';

class Repository {
  Future<Fact> getRandom() async {
    final response = await API.getRandomFact("de");

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Fact.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load fact');
    }
  }
}
