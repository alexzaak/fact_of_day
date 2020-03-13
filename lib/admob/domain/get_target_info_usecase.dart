import 'package:firebase_admob/firebase_admob.dart';

class GetTargetInfoUseCase {
  MobileAdTargetingInfo execute() {
    return new MobileAdTargetingInfo(
      keywords: ['game', 'blocks', 'platformer', 'action', 'fast'],
    );
  }
}
