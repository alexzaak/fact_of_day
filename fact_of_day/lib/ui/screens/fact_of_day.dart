import 'package:auto_size_text/auto_size_text.dart';
import 'package:fact_of_day/data/fact.dart';
import 'package:fact_of_day/generated/i18n.dart';
import 'package:fact_of_day/ui/colors.dart';
import 'package:fact_of_day/ui/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

typedef void CustomCallback(String value);

class FactOfDayScreen extends StatefulWidget {
  @override
  _FactOfDayScreen createState() => _FactOfDayScreen();
}

class _FactOfDayScreen extends State<FactOfDayScreen>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  Fact fact;
  Icon favoriteIcon = Icon(Icons.favorite_border);

  Future<void> _getFact() async {
    ViewModel().getFactOfDay().then((response) {
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

  @override
  Widget build(BuildContext context) {
    if (fact == null) {
      return new Scaffold(backgroundColor: dispcolor);
    } else {
      return new Scaffold(
        backgroundColor: dispcolor,
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: dispcolor.withOpacity(0.5),
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
                                new InkWell(
                                    onTap: () => _launchURL(fact.sourceUrl),
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
                                          onPressed: () =>
                                              Share.share(fact.text)),
                                      new IconButton(
                                          icon: favoriteIcon,
                                          tooltip:
                                              S.of(context).add_to_favorite,
                                          onPressed: () => {
                                                ViewModel()
                                                    .toggleFavorite(fact.text),
                                                _setFavoriteIcon(fact.text)
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
