import 'model/credit.dart';

class GetCreditsUseCase {
  Future<List<Credit>> execute() {
    List<Credit> creditList = new List();
    creditList.add(Credit("chucknorris.io", "https://api.chucknorris.io/"));
    creditList.add(Credit("Chuck Approved PSD",
        "https://www.vectorhq.com/psd/chuck-approved-psd-432875"));
    creditList.add(Credit(
        "Icons delivered by www.flaticon.com", "https://www.flaticon.com/"));
    creditList.add(Credit("Flutter", "https://flutter.dev"));
    creditList
        .add(Credit("dart-lang/http", "https://github.com/dart-lang/http"));
    creditList.add(Credit(
        "leisim/auto_size_text", "https://github.com/leisim/auto_size_text"));
    creditList.add(Credit("magnatronus/flutter-devicelocale",
        "https://github.com/magnatronus/flutter-devicelocale"));
    creditList.add(Credit("flutter/plugins/share",
        "https://github.com/flutter/plugins/tree/master/packages/share"));
    creditList.add(Credit("flutter/plugins/shared_preferences",
        "https://github.com/flutter/plugins/tree/master/packages/shared_preferences"));
    creditList.add(Credit("flutter/plugins/url_launcher",
        "https://github.com/flutter/plugins/tree/master/packages/url_launcher"));

    return Future.value(creditList);
  }
}
