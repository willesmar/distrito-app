import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Sobre'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: new Container(
        child: new Center(
          child: new Icon(
            Icons.account_balance,
            size: 150.0,
            color: Theme.of(context).primaryColor,
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
