import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:distrito_app/utils/custom_icons_icons.dart';
import './../utils/globals.dart' as globals;
import './dialog_igreja.dart';
import '../utils/bloc.dart';

class ComunhaoRelacionamentoMissao extends StatelessWidget {
  // final msgBloc = Bloc();
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
    final bloc = Provider.of(context);
    bloc.igreja.listen((data) => debugPrint('Igreja selecionada: $data'));
    // final msgs = this.msgBloc.mensagens;
    // msgs.listen((data) {
    //   for (var i = 0; i < data.documentChanges.length; i++) {
    //     print(data.documentChanges[i].document['titulo']);
    //   }
    // });
    // data.documentChanges.forEach((msg) =>
    //   msg.document.data.values.forEach((doc) => print(doc))
    // ));
    var _resp;
    // _getSharedPrefs();
    debugPrint(globals.igreja);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('CRM'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: new Container(
          child: new Column(
              // child: new Icon(
              //   Icons.work,
              //   size: 150.0,
              //   color: Theme.of(context).primaryColor,
              // ),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    CustomIcons.religious_christian,
                    size: 150.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(
                    onPressed: _launchURL,
                    child: new Text('Show Flutter homepage'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(
                    onPressed: _launchMAP,
                    child: new Text('Show AMAP'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(
                    onPressed: _launchGMAP,
                    child: new Text('Show GMAP'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(
                    onPressed: _launchMAPS,
                    child: new Text('Show a MAP'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(
                    onPressed: () {
                      _resp = _askedToLead(context);
                    },
                    child: new Text('Show Modal'),
                  ),
                ),
              ]),
        ));
  }

  // _openModal(BuildContext context) {
  //   showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       new DialogIgreja();
  //     });
  // }

  _askedToLead(BuildContext context) async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: const Text('Select assignment'),
            children: <Widget>[
              new SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 'Dep1');
                },
                child: const Text('Treasury department'),
              ),
              new SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 'Dep2');
                },
                child: const Text('State department'),
              ),
            ],
          );
        })) {
      case 'Dep1':
        print('Dep1');
        break;
      case 'Dep2':
        print('Dep2');
        break;
    }
  }

  _launchURL() async {
    const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchMAP() async {
    const url = 'http://maps.apple.com/?ll=-20.5368731,-54.6456721';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchMAPS() async {
    const appleUrl = 'http://maps.apple.com/?sll=-20.489762, -54.666715';
    const googleUrl = 'google.navigation:q=-20.489762, -54.666715';
    if (await canLaunch("comgooglemaps://")) {
      print('launching com googleUrl');
      await launch(googleUrl);
    } else if (await canLaunch(appleUrl)) {
      print('launching apple url');
      await launch(appleUrl);
    } else {
      throw 'Could not launch url';
    }
  }

  _launchGMAP() async {
    // const url = 'comgooglemaps://?center=-20.5368731,-54.6456721,15';
    const url = 'google.navigation:q=-20.5368731, -54.6456721';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
