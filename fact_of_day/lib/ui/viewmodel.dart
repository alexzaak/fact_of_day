import 'dart:async';

import 'package:fact_of_day/domain/get_credits_usecase.dart';
import 'package:fact_of_day/domain/get_language_code_usecase.dart';
import 'package:fact_of_day/domain/get_random_fact_usecase.dart';
import 'package:fact_of_day/domain/model/credit.dart';
import 'package:fact_of_day/domain/model/fact.dart';
import 'package:fact_of_day/domain/url_launcher_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel {
  final GetLanguageCodeUseCase _getLanguageCodeUseCase;
  final GetRandomFactUseCase _getRandomFactUseCase;
  final GetCreditsUseCase _getCreditsUseCase;
  final UrlLauncherUseCase _urlLauncherUseCase;

  StreamController<Fact> factEvent;
  static const String FAVORITE_LIST = "pref_favorite_list";
  static const String FAV_PREFIX = "pref_fav_";

  ViewModel(this._getLanguageCodeUseCase, this._getRandomFactUseCase,
      this._getCreditsUseCase, this._urlLauncherUseCase) {
    factEvent = StreamController();
  }

  void close() {
    print("close");
    factEvent.close();
  }

  Future<Fact> getRandomFact() {
    return this._getRandomFactUseCase.getRandom();
  }

  Future<List<Credit>> getCredits() {
    return _getCreditsUseCase.execute();
  }

  Future<void> onUrlLaunch(String url) {
    return _urlLauncherUseCase.execute(url);
  }

  void toggleFavorite(String text) async {
    final String key = FAV_PREFIX + text.hashCode.toString();
    print(key);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(key)) {
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
