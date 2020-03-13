import 'package:auto_size_text/auto_size_text.dart';
import 'package:fact_of_day/domain/model/credit.dart';
import 'package:fact_of_day/generated/i18n.dart';
import 'package:fact_of_day/ui/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class CreditsTab extends StatelessWidget {
  CreditsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ViewModel>(context);

    return Scaffold(
        body: StreamBuilder<List<Credit>>(
            stream: viewModel.getCredits().asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final _data = snapshot.data;
                if (_data.length == 0) {
                  return Center(
                      child: AutoSizeText(
                    S.of(context).favorite_list_empty,
                    textAlign: TextAlign.center,
                    minFontSize: 15,
                    maxFontSize: 45,
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
                  ));
                }
                return CreditWidget(_data);
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

class CreditWidget extends StatelessWidget {
  final List<Credit> _credit;

  CreditWidget(this._credit);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: Center(
          child: ListView.builder(
              itemCount: _credit.length,
              itemBuilder: (BuildContext ctx, int index) {
                return CustomWidget(
                    name: _credit[index].name,
                    link: _credit[index].link,
                    trailingIconOne: new Icon(Icons.share));
              })),
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
                        color: Colors.white,
                        fontSize: 20.0,
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
