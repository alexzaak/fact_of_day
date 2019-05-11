import 'dart:async';
import 'dart:convert';

import 'package:fact_of_day/data/credit.dart';

import 'api.dart';
import 'fact.dart';

class Repository {
  Future<Fact> getRandom(String languageCode) async {
    final response = await API.getRandomFact(languageCode);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Fact.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load fact');
    }
  }

  Future<Fact> getFactOfDay(String languageCode) async {
    final response = await API.getTodaysFact(languageCode);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Fact.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load fact');
    }
  }

  List<Credit> getCreditList() {
    List<Credit> creditList = new List();
    creditList.add(Credit("Random Useless Facts - API", "http://randomuselessfact.appspot.com"));
    creditList.add(Credit("Icons made by Icon Pond",
        "https://www.flaticon.com/authors/popcorns-arts"));
    creditList.add(Credit(
        "Icons delivered by www.flaticon.com", "https://www.flaticon.com/"));
    creditList.add(Credit("Flutter", "https://flutter.dev"));
    creditList.add(Credit("dart-lang/http", "https://github.com/dart-lang/http"));
    creditList.add(Credit("leisim/auto_size_text", "https://github.com/leisim/auto_size_text"));
    creditList.add(Credit("magnatronus/flutter-devicelocale", "https://github.com/magnatronus/flutter-devicelocale"));
    creditList.add(Credit("flutter/plugins/share", "https://github.com/flutter/plugins/tree/master/packages/share"));
    creditList.add(Credit("flutter/plugins/shared_preferences", "https://github.com/flutter/plugins/tree/master/packages/shared_preferences"));
    creditList.add(Credit("flutter/plugins/url_launcher", "https://github.com/flutter/plugins/tree/master/packages/url_launcher"));

    return creditList;
  }
}
