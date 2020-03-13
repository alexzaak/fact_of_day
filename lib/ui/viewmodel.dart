import 'dart:async';

import 'package:fact_of_day/domain/get_credits_usecase.dart';
import 'package:fact_of_day/domain/get_language_code_usecase.dart';
import 'package:fact_of_day/domain/get_random_fact_usecase.dart';
import 'package:fact_of_day/domain/model/credit.dart';
import 'package:fact_of_day/domain/model/fact.dart';
import 'package:fact_of_day/domain/url_launcher_usecase.dart';

class ViewModel {
  final GetLanguageCodeUseCase _getLanguageCodeUseCase;
  final GetRandomFactUseCase _getRandomFactUseCase;
  final GetCreditsUseCase _getCreditsUseCase;
  final UrlLauncherUseCase _urlLauncherUseCase;

  static const String FAVORITE_LIST = "pref_favorite_list";
  static const String FAV_PREFIX = "pref_fav_";

  ViewModel(this._getLanguageCodeUseCase, this._getRandomFactUseCase,
      this._getCreditsUseCase, this._urlLauncherUseCase);

  Future<Fact> getRandomFact() {
    return this._getRandomFactUseCase.getRandom();
  }

  Future<List<Credit>> getCredits() {
    return _getCreditsUseCase.execute();
  }

  Future<void> onUrlLaunch(String url) {
    return _urlLauncherUseCase.execute(url);
  }
}
