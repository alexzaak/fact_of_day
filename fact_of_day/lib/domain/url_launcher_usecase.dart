import '../data/open_url_repository.dart';

class UrlLauncherUseCase {
  final OpenUrlRepository _openUrlRepository;

  UrlLauncherUseCase(this._openUrlRepository);

  Future execute(String url) {
    return _openUrlRepository.openUrl(url);
  }
}
