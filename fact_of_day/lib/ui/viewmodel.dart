import 'package:devicelocale/devicelocale.dart';
import 'package:fact_of_day/data/fact.dart';
import 'package:fact_of_day/data/repository.dart';
import 'package:flutter/services.dart';

class ViewModel {
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
}
