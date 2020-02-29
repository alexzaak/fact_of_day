import 'package:firebase_admob/firebase_admob.dart';

class AdmobUseCase {
  static String appId = "ca-app-pub-1451557002406313~7960207117";
  static String appUnitId = "ca-app-pub-1451557002406313/3618896211";

  static bool get enableAds => false;

  static Function(RewardedVideoAdEvent) listener;
  static bool loaded;

  static void show() {
    if (!enableAds) {
      return;
    }
    loaded = false;
    RewardedVideoAd.instance.show();
  }

  static void handle(RewardedVideoAdEvent evt) {
    if (evt == RewardedVideoAdEvent.loaded) {
      print('Ad: loaded an ad succesfully');
      loaded = true;
    } else if (evt == RewardedVideoAdEvent.failedToLoad) {
      print('Ad: failed to loaded an ad');
      loaded = false;
    } else {
      listener(evt);
    }
  }

  static Future<bool> startup() async {
    if (!enableAds) {
      return false;
    }
    bool result = await FirebaseAdMob.instance.initialize(appId: appId);
    loaded = false;
    return result;
  }

  static Future loadAd() async {
    if (!enableAds || loaded) {
      return;
    }
    MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
      keywords: ['game', 'blocks', 'guns', 'platformer', 'action', 'fast'],
    );
    loaded = false;
    RewardedVideoAd.instance.listener = (RewardedVideoAdEvent event,
            {String rewardType, int rewardAmount}) =>
        handle(event);
    await RewardedVideoAd.instance
        .load(adUnitId: appUnitId, targetingInfo: targetingInfo);
  }

  static void showBanner() {
    MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
      keywords: ['game', 'blocks', 'guns', 'platformer', 'action', 'fast'],
    );

    BannerAd banner = BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    banner
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 0.0,
        // Positions the banner ad 10 pixels from the center of the screen to the right
        horizontalCenterOffset: 0.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }
}
