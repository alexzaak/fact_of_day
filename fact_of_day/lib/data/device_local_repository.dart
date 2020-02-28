import 'package:devicelocale/devicelocale.dart';

class DeviceLocalRepository {
  Future<String> getDeviceLocal() {
    return Devicelocale.currentLocale;
  }
}
