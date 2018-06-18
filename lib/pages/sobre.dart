import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Sobre'),
        backgroundColor: Colors.teal[900],
      ),
      body: new Container(
        child: new Center(
          child: new Icon(
            Icons.account_balance,
            size: 150.0,
            color: Colors.teal[900],
          ),
        ),
      ),
    );
    // return new Container(
    //   child: new Center(
    //     child: new Icon(
    //       Icons.account_balance,
    //       size: 150.0,
    //       color: Colors.red,
    //     ),
    //   ),
    // );
  }
}
