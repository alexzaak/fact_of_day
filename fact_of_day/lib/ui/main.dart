import 'package:auto_size_text/auto_size_text.dart';
import 'package:fact_of_day/data/fact.dart';
import 'package:fact_of_day/generated/i18n.dart';
import 'package:fact_of_day/ui/colors.dart';
import 'package:fact_of_day/ui/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

void main() async {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
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
        home: AppBody());
  }
}

class AppBody extends StatefulWidget {
  @override
  _AppBody createState() => _AppBody();
}

class _AppBody extends State<AppBody> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  Fact fact;

  Future<void> _getFact() async {
    ViewModel().getFact().then((response) {
      setState(() {
        fact = response;
        animationController.reset();
        animationController.forward();
      });
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
        body: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 75.0),
          child: new Center(
            child: new Column(
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
                      onTap: () => _getFact(),
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
                              new AutoSizeText(
                                fact.source,
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w100),
                              ),
                              new Row(
                                mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    new IconButton(
                                        icon: Icon(Icons.favorite),
                                        tooltip: 'Increase volume by 10',
                                        onPressed: () => ViewModel()
                                            .saveAsFavorite(fact.text)),
                                    new IconButton(
                                        icon: Icon(Icons.share),
                                        tooltip: 'Increase volume by 10',
                                        onPressed: () => Share.share(fact.text))
                                  ]),
                            ],
                          )),
                    ),
                    flex: 1),
              ],
            ),
          ),
        ),
      );
    }
  }
}
