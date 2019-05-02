import 'dart:async';
import 'dart:convert';

import 'api.dart';
import 'fact.dart';

class Repository {
  Future<Fact> getRandom(String languageCode) async {
    final response = await API.getRandomFact(languageCode);
    print(languageCode);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Fact.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load fact');
    }
  }
}
