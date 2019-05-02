import 'package:devicelocale/devicelocale.dart';
import 'package:fact_of_day/data/fact.dart';
import 'package:fact_of_day/data/repository.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel {
  static const String FAVORITE_LIST = "pref_favorite_list";
  static const String FAV_PREFIX = "pref_fav_";

  Future<String> getLanguageCode() async {
    String myLanguage;
    try {
      String language = await Devicelocale.currentLocale;

      if (language == null) {
        myLanguage = "en";
      } else if (language.startsWith("de")) {
        myLanguage = "de";
      } else {
        myLanguage = "en";
      }
    } on PlatformException {
      print("Error obtaining current locale");

      myLanguage = "en";
    }

    return myLanguage;
  }

  Future<Fact> getFact() async {
    String languageCode = await getLanguageCode();
    return await Repository().getRandom(languageCode);
  }

  void toggleFavorite(String text) async {
    final String key = FAV_PREFIX + text.hashCode.toString();
    print(key);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey(key)) {
      await prefs.remove(key);
      return;
    }
    await prefs.setString(key, text);
  }

  Future<List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> favoritesList = new List();
    final Set<String> keys = prefs.getKeys();

    keys.forEach((key) {
      if (key.startsWith(FAV_PREFIX)) {
        favoritesList.add(prefs.getString(key));
      }
    });

    return favoritesList;
  }

  Future<bool> isFavorite(String text) async {
    final String key = FAV_PREFIX + text.hashCode.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<bool> removeFavorite(String text) async {
    final String key = FAV_PREFIX + text.hashCode.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}