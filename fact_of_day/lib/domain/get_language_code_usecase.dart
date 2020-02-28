import '../data/device_local_repository.dart';

class GetLanguageCodeUseCase {
  final DeviceLocalRepository _deviceLocalRepository;

  GetLanguageCodeUseCase(this._deviceLocalRepository);

  Future<String> getLanguageCode() async {
    String currentLang = await this._deviceLocalRepository.getDeviceLocal();

    if (currentLang == null) {
      return "en";
    } else if (currentLang.startsWith("de")) {
      return "de";
    } else {
      return "en";
    }
  }
}
