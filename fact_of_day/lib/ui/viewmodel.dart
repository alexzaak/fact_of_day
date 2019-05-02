import 'package:devicelocale/devicelocale.dart';
import 'package:fact_of_day/data/fact.dart';
import 'package:fact_of_day/data/repository.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel {
  static const String FAVORITE_LIST = "pref_favorite_list";

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

  void saveAsFavorite(String text) async {
    List<String> favorites = new List();
    favorites.add(text);

    List<String> storedList = await getFavorites();
    if (storedList != null) {
      storedList.add(text);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(FAVORITE_LIST, storedList);
    }
  }

  Future<List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(FAVORITE_LIST);
    if (list == null) {
      return new List();
    }

    return list;
  }
}
