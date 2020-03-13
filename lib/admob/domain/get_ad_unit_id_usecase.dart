import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';

const BANNER_ANDROID_AD_UNIT_ID = 'ca-app-pub-8496096161933357/8432255067';

class GetAdUniIdUseCase {
  String execute() {
    if (kReleaseMode) {
      return BANNER_ANDROID_AD_UNIT_ID;
    }
    return BannerAd.testAdUnitId;
  }
}
