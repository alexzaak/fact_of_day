import 'package:auto_size_text/auto_size_text.dart';
import 'package:fact_of_day/data/fact.dart';
import 'package:fact_of_day/generated/i18n.dart';
import 'package:fact_of_day/ui/colors.dart';
import 'package:fact_of_day/ui/viewmodel.dart';
import 'package:flutter/material.dart';

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
        parent: animationController, curve: Curves.fastOutSlowIn);
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
          body: new Padding(
            padding: const EdgeInsets.symmetric(vertical: 75.0),
            child: new AutoSizeText(
              S.of(context).hello,
              style: new TextStyle(color: Colors.white10, fontSize: 45.0),
            ),
          ));
    } else {
      return new Scaffold(
        backgroundColor: dispcolor,
        body: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 75.0),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Align(
                    alignment: Alignment.topLeft,
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: new AutoSizeText(
                        S.of(context).title,
                        style:
                            new TextStyle(color: Colors.white, fontSize: 45.0),
                      ),
                    )),
                new Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
                  child: new Opacity(
                    opacity: animation.value * 1,
                    child: new Transform(
                        transform: new Matrix4.translationValues(
                            0.0, animation.value * -50.0, 0.0),
                        child: new AutoSizeText(
                          fact.text,
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 45.0,
                              fontWeight: FontWeight.w300),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
