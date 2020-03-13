import 'package:firebase_admob/firebase_admob.dart';

const ANDROID_AD_UNIT_ID = 'ca-app-pub-8496096161933357~6494349255';

class SetupAdmobUseCase {
  Future<bool> execute() async {
    bool result =
        await FirebaseAdMob.instance.initialize(appId: ANDROID_AD_UNIT_ID);
    return result;
  }
}
