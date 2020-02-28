import 'package:auto_size_text/auto_size_text.dart';
import 'package:fact_of_day/data/local/tables.dart';
import 'package:fact_of_day/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

typedef void CustomCallback(String value);

class FavoriteTab extends StatelessWidget {
  FavoriteTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dbProvider = Provider.of<FavoriteDao>(context);

    return Scaffold(
        body: StreamBuilder<List<FavoriteData>>(
            stream: _dbProvider.favoriteList,
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
                return MainWidget(_data);
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

class MainWidget extends StatelessWidget {
  var _dbProvider;

  onRemoveFavorite(String content) {
    _dbProvider.deleteFavorite(content: content);
  }

  final List<FavoriteData> favorites;

  MainWidget(this.favorites);

  @override
  Widget build(BuildContext context) {
    _dbProvider = Provider.of<FavoriteDao>(context);

    return Center(
      child: favorites.isEmpty
          ? Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(S.of(context).favorite_list_empty,
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w300))))
          : new ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (BuildContext ctx, int index) {
                return new CustomWidget(
                    content: favorites[index].content,
                    trailingIconOne: new Icon(Icons.share),
                    trailingIconTwo: new Icon(Icons.favorite),
                    onRemoveFavorite: this.onRemoveFavorite);
              }),
    );
  }
}

class CustomWidget extends StatelessWidget {
  final String content;

  final Icon trailingIconOne;

  final Icon trailingIconTwo;

  final CustomCallback onRemoveFavorite;

  CustomWidget(
      {@required this.content,
      @required this.trailingIconOne,
      @required this.trailingIconTwo,
      @required this.onRemoveFavorite});

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  child: new Text(
                    content,
                    style: new TextStyle(
                        color: Theme.of(context).textTheme.caption.color,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300),
                  )),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new IconButton(
                      icon: trailingIconOne,
                      onPressed: () {
                        Share.share(content);
                      }),
                  new IconButton(
                      icon: trailingIconTwo,
                      onPressed: () {
                        onRemoveFavorite(content);
                      }),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
