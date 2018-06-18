import 'package:flutter/material.dart';

class Programa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Programa'),
          backgroundColor: Colors.teal[900],
        ),
        body: new Container(
          child: new Center(
            child: new Icon(
              Icons.adb,
              size: 150.0,
              color: Colors.teal[900],
            ),
          ),
        ));
  }
}
