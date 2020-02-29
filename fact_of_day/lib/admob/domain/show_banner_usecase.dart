import 'package:fact_of_day/admob/domain/get_ad_unit_id_usecase.dart';
import 'package:fact_of_day/admob/domain/get_target_info_usecase.dart';
import 'package:firebase_admob/firebase_admob.dart';

class ShowBannerUseCase {
  final GetTargetInfoUseCase _getTargetInfoUseCase;
  final GetAdUniIdUseCase _adUniIdUseCase;

  ShowBannerUseCase(this._getTargetInfoUseCase, this._adUniIdUseCase);

  void execute() {
    BannerAd banner = BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: _adUniIdUseCase.execute(),
      size: AdSize.banner,
      targetingInfo: _getTargetInfoUseCase.execute(),
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
        anchorType: AnchorType.top,
      );
  }
}
