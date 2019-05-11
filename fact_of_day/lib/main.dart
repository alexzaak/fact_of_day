import 'package:auto_size_text/auto_size_text.dart';
import 'package:fact_of_day/data/fact.dart';
import 'package:fact_of_day/generated/i18n.dart';
import 'package:fact_of_day/ui/colors.dart';
import 'package:fact_of_day/ui/screens/credits.dart';
import 'package:fact_of_day/ui/screens/fact_of_day.dart';
import 'package:fact_of_day/ui/screens/favorite_page.dart';
import 'package:fact_of_day/ui/viewmodel.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  String _locale = 'en';

  Future<void> _setLocale() async {
    final String lang = await ViewModel().getLanguageCode();
    print(lang);
    setState(() {
      _locale = lang;
    });
  }

  initState() {
    super.initState();
    _setLocale();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      locale: Locale(_locale, ""),
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback:
          S.delegate.resolution(fallback: new Locale("en", "")),
      home: AppBody(
        analytics: analytics,
        observer: observer,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
    );
  }
}

class AppBody extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  AppBody({Key key, this.analytics, this.observer}) : super(key: key);

  @override
  _AppBody createState() => _AppBody(analytics, observer);
}

class _AppBody extends State<AppBody> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  Fact fact;
  Icon favoriteIcon = Icon(Icons.favorite_border);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;

  _AppBody(this.analytics, this.observer);

  Future<void> _getFact() async {
    ViewModel().getFact().then((response) {
      setState(() {
        fact = response;
        _setFavoriteIcon(fact.text);
        animationController.reset();
        animationController.forward();
      });
    });
  }

  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  _setFavoriteIcon(String text) async {
    if (await ViewModel().isFavorite(text)) {
      setState(() {
        favoriteIcon = Icon(Icons.favorite);
      });
      return;
    }

    setState(() {
      favoriteIcon = Icon(Icons.favorite_border);
    });
  }

  initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.linearToEaseOut);
    animation.addListener(() {
      this.setState(() {});
    });
    animationController.forward();
    _getFact();
  }

  dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> _sendEvent(String name) async {
    await analytics.logEvent(
      name: name,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (fact == null) {
      return new Scaffold(
          backgroundColor: dispcolor,
          body: new Center(
            child: new AutoSizeText(
              S.of(context).hello,
              minFontSize: 60.0,
              maxFontSize: 120.0,
              style: new TextStyle(color: Colors.white, fontSize: 120.0),
            ),
          ));
    } else {
      return new Scaffold(
        backgroundColor: dispcolor,
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: dispcolor.withOpacity(0.5),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Colors.teal,
                ),
                title: Text(S.of(context).favorites,
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300)),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FavoriteScreen()));
                  _sendEvent("FAVORITE_SCREEN_OPENED");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.today,
                  color: Colors.teal,
                ),
                title: Text(S.of(context).fact_of_day,
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300)),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FactOfDayScreen()));
                  _sendEvent("FACT_OF_DAY_SCREEN_OPENED");
                },
              ),
              ListTile(
                leading: Icon(Icons.star, color: Colors.teal),
                title: Text(S.of(context).rate_me,
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300)),
                onTap: () {
                  _launchURL(
                      "https://play.google.com/store/apps/details?id=codes.zaak.fact_of_day");
                  _sendEvent("RATE_ME_OPENED");
                },
              ),
              ListTile(
                leading: Icon(Icons.assignment, color: Colors.teal),
                title: Text(S.of(context).credits,
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300)),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => CreditsScreen()));
                  _sendEvent("CREDITS_OPENED");
                },
              ),
            ],
          ),
        ),
        body: Builder(
          builder: (context) => new Column(
                children: <Widget>[
                  new Expanded(
                      child: new Align(
                          alignment: Alignment.topLeft,
                          child: new Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: new AutoSizeText(
                              S.of(context).title,
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 45.0),
                            ),
                          )),
                      flex: 2),
                  new Expanded(
                      child: new InkWell(
                        onTap: () {
                          _getFact();
                          _sendEvent("NEXT_FACT_TAP");
                        },
                        child: new Container(
                          margin: EdgeInsets.only(top: 20),
                          child: new Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: new Opacity(
                              opacity: animation.value * 1,
                              child: new Transform(
                                  transform: new Matrix4.translationValues(
                                      0.0, animation.value * -50.0, 0.0),
                                  child: new AutoSizeText(
                                    fact.text,
                                    minFontSize: 15.0,
                                    maxFontSize: 45.0,
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 45.0,
                                        fontWeight: FontWeight.w300),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      flex: 4),
                  new Expanded(
                      child: new Container(
                        margin: EdgeInsets.only(top: 10),
                        child: new Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new InkWell(
                                    onTap: () {
                                      _launchURL(fact.sourceUrl);
                                      _sendEvent("FACT_SOURCE_OPENED");
                                    },
                                    child: new AutoSizeText(
                                      S.of(context).source(fact.source),
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w100),
                                    )),
                                new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      new IconButton(
                                          icon: Icon(Icons.share),
                                          tooltip: S.of(context).share_the_fact,
                                          onPressed: () {
                                            Share.share(fact.text);
                                            _sendEvent("SHARE_BUTTON_CLICKED");
                                          }),
                                      new IconButton(
                                          icon: favoriteIcon,
                                          tooltip:
                                              S.of(context).add_to_favorite,
                                          onPressed: () {
                                            ViewModel()
                                                .toggleFavorite(fact.text);
                                            _setFavoriteIcon(fact.text);
                                            _sendEvent(
                                                "FAVORITE_BUTTON_CLICKED");
                                          }),
                                    ]),
                              ],
                            )),
                      ),
                      flex: 1),
                ],
              ),
        ),
      );
    }
  }
}
