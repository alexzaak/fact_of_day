import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'data/repository.dart';
import 'data/fact.dart';
import 'colors.dart';

void main() => runApp(new MaterialApp(
      home: new Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  Fact fact;

  _getfact() {
    Repository().getRandom().then((response) {
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
    _getfact();
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
              "Loading",
              style: new TextStyle(color: Colors.white, fontSize: 45.0),
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
                        "Did you Know?",
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
