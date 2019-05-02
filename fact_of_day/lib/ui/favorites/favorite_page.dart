import 'package:fact_of_day/ui/colors.dart';
import 'package:fact_of_day/ui/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

typedef void CustomCallback(String value);

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreen createState() => _FavoriteScreen();
}

class _FavoriteScreen extends State<FavoriteScreen> {
  List<String> favorites = new List();

  onRemoveFavorite(String content) async {
    await ViewModel().removeFavorite(content);
    await _getFavorites();
  }

  Future<void> _getFavorites() async {
    ViewModel().getFavorites().then((response) {
      setState(() {
        favorites = response;
      });
    });
  }

  initState() {
    super.initState();
    _getFavorites();
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
        child: new ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return new CustomWidget(
                  content: favorites[index],
                  trailingIconOne: new Icon(Icons.share),
                  trailingIconTwo: new Icon(Icons.favorite),
                  onRemoveFavorite: this.onRemoveFavorite);
            }),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  String content;

  Icon trailingIconOne;

  Icon trailingIconTwo;

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
                        color: Colors.black,
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
              ),
              new Divider(
                height: 15.0,
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
