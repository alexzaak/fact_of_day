import 'package:url_launcher/url_launcher.dart';

class OpenUrlRepository {
  Future openUrl(String url) async {
    if (await canLaunch(url)) {
      return launch(url);
    } else {
      return Future.error(Exception('Could not launch $url'));
    }
  }
}
