import 'package:flutter/material.dart';

class ComunhaoRelacionamentoMissao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('CRM'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: new Container(
          child: new Center(
            child: new Icon(
              Icons.work,
              size: 150.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ));
  }
}
