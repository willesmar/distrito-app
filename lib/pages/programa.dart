import 'package:flutter/material.dart';

class Programa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Programa'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: new Container(
          child: new Center(
            child: new Icon(
              Icons.adb,
              size: 150.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ));
  }
}
