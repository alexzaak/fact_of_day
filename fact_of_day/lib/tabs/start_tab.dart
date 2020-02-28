import 'package:admob_flutter/admob_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fact_of_day/data/local/tables.dart';
import 'package:fact_of_day/domain/model/fact.dart';
import 'package:fact_of_day/generated/i18n.dart';
import 'package:fact_of_day/ui/viewmodel.dart';
import 'package:fact_of_day/utils/banner_id.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class StartTab extends StatefulWidget {
  StartTab({Key key}) : super(key: key);

  @override
  _StartTab createState() => _StartTab();
}

class _StartTab extends State<StartTab> {
  ViewModel _viewModelProvider;

  initState() {
    super.initState();
  }

  dispose() {
    _viewModelProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _viewModelProvider = Provider.of<ViewModel>(context);

    return Scaffold(
        body: StreamBuilder<Fact>(
            stream: _viewModelProvider.getRandomFact().asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final _data = snapshot.data;
                return MainWidget(_data);
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

class MainWidget extends StatelessWidget {
  final Fact fact;

  MainWidget(this.fact);

  @override
  Widget build(BuildContext context) {
    final _dbProvider = Provider.of<FavoriteDao>(context);
    final _viewModelProvider = Provider.of<ViewModel>(context);

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: AutoSizeText(
                S.of(context).title,
                textAlign: TextAlign.center,
                minFontSize: 20,
                maxFontSize: 45,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: 45),
              )),
          Spacer(
            flex: 1,
          ),
          Expanded(
              flex: 6,
              child: Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: InkWell(
                          onTap: () => _viewModelProvider.getRandomFact,
                          child: Card(
                              child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.05),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    flex: 7,
                                    child: Center(
                                        child: AutoSizeText(
                                      fact.text,
                                      textAlign: TextAlign.center,
                                      minFontSize: 10,
                                      maxFontSize: 45,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 35),
                                    ))),
                                Spacer(flex: 1),
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        new IconButton(
                                            icon: Icon(Icons.share),
                                            onPressed: () {
                                              Share.share(fact.text);
                                            }),
                                        StreamBuilder<FavoriteData>(
                                            stream: _dbProvider
                                                .isFavorite(fact.text),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return new IconButton(
                                                    icon: Icon(Icons.favorite),
                                                    onPressed: () {
                                                      _dbProvider
                                                          .deleteFavorite(
                                                              content:
                                                                  fact.text);
                                                    });
                                              }
                                              return new IconButton(
                                                  icon: Icon(
                                                      Icons.favorite_border),
                                                  onPressed: () {
                                                    _dbProvider.addFavorite(
                                                        content: fact.text,
                                                        permalink:
                                                            fact.permalink,
                                                        sourceUrl:
                                                            fact.sourceUrl);
                                                  });
                                            }),
                                      ],
                                    ))
                              ],
                            ),
                          )))))),
          Spacer(
            flex: 1,
          ),
          Expanded(
              flex: 1,
              child: AdmobBanner(
                adUnitId: BANNER_ANDROID_AD_UNIT_ID,
                adSize: AdmobBannerSize.SMART_BANNER,
              ))
        ],
      ),
    );
  }
}
