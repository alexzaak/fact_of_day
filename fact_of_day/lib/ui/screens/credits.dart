import 'package:auto_size_text/auto_size_text.dart';
import 'package:fact_of_day/data/credit.dart';
import 'package:fact_of_day/generated/i18n.dart';
import 'package:fact_of_day/ui/colors.dart';
import 'package:fact_of_day/ui/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsScreen extends StatefulWidget {
  @override
  _CreditsScreen createState() => _CreditsScreen();
}

class _CreditsScreen extends State<CreditsScreen> {
  List<Credit> _credits = new List();

  Future<void> _getCredits() async {
    setState(() {
      _credits = ViewModel().getCredits();
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

  initState() {
    super.initState();
    _getCredits();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dispcolor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: dispcolor.withOpacity(0.5),
      ),
      body: Center(
          child: new Column(children: <Widget>[
        new Expanded(
            child: new Align(
                alignment: Alignment.topLeft,
                child: new Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new AutoSizeText(
                    S.of(context).credits_text,
                    style: new TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                )),
            flex: 1),
        new Expanded(
            child: new ListView.builder(
                itemCount: _credits.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return new GestureDetector(
                    onTap: () => _launchURL(_credits[index].link),
                    child: new CustomWidget(
                        name: _credits[index].name,
                        link: _credits[index].link,
                        trailingIconOne: new Icon(Icons.share)),
                  );
                }),
            flex: 9),
      ])),
    );
  }
}

class CustomWidget extends StatelessWidget {
  String name;
  String link;

  Icon trailingIconOne;

  CustomWidget(
      {@required this.name,
      @required this.link,
      @required this.trailingIconOne});

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  child: new Text(
                    name,
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300),
                  )),
              new IconButton(
                  icon: trailingIconOne,
                  onPressed: () {
                    Share.share("$name -- $link");
                  }),
            ],
          ),
          new Divider(
            height: 15.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
