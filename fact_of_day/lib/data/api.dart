import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://randomuselessfact.appspot.com";

class API {
  static Future getRandomFact(String language) {
    var url = baseUrl + "/random.json?language=";
    return http.get(url);
  }

  static Future getTodaysFact(String language) {
    var url = baseUrl + "/today.json?language=";
    return http.get(url);
  }
}