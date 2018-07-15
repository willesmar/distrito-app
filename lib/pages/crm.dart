import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComunhaoRelacionamentoMissao extends StatelessWidget {
  Future _getSharedPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // _prefs.setString("igreja", "oliveira3");
    // _igreja = prefs.getString("igreja") ?? null;
    // setState(() {
    //   _igreja = _prefs.getString("igreja") ?? null;
    // });
    debugPrint(_prefs.getString("igreja") ?? null);
  }

  @override
  Widget build(BuildContext context) {
    _getSharedPrefs();
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
