import 'package:flutter/material.dart';

class ComunhaoRelacionamentoMissao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('CRM'),
          backgroundColor: Colors.teal[900],
        ),
        body: new Container(
          child: new Center(
            child: new Icon(
              Icons.work,
              size: 150.0,
              color: Colors.teal[900],
            ),
          ),
        ));
  }
}
