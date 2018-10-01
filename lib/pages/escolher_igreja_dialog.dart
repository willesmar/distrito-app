import 'dart:async';

import 'package:flutter/material.dart';

import 'package:distrito_app/utils/globals.dart' as globals;

var IgrejaDialog = new EscolherIgrejaDialog();

class EscolherIgrejaDialog {
  double _containerHeight = 40.0;
  double _iasdImgWidth = 28.0;
  double _iasdImgHeight = 25.0;

  Future<Null> selecioneIgreja(BuildContext context) async {
    switch (await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: const Text('Selecione uma igreja!'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  debugPrint(globals.igreja);
                  Navigator.pop(context, 'jacy');
                },
                child: Container(
                  height: _containerHeight,
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/simbolo_iasd.png'),
                      width: _iasdImgWidth,
                      height: _iasdImgHeight,
                    ),
                    title: Text('Vila Jacy'),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  debugPrint(globals.igreja);
                  Navigator.pop(context, 'oliveira3');
                },
                child: Container(
                  height: _containerHeight,
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/simbolo_iasd.png'),
                      width: _iasdImgWidth,
                      height: _iasdImgHeight,
                    ),
                    title: Text('Oliveira III'),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  debugPrint(globals.igreja);
                  Navigator.pop(context, 'piratininga');
                },
                child: Container(
                  height: _containerHeight,
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/simbolo_iasd.png'),
                      width: _iasdImgWidth,
                      height: _iasdImgHeight,
                    ),
                    title: Text('Piratininga'),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  debugPrint(globals.igreja);
                  Navigator.pop(context, 'caicara');
                },
                child: Container(
                  height: _containerHeight,
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/simbolo_iasd.png'),
                      width: _iasdImgWidth,
                      height: _iasdImgHeight,
                    ),
                    title: Text('Caiçara'),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  debugPrint(globals.igreja);
                  Navigator.pop(context, 'uniao');
                },
                child: Container(
                  height: _containerHeight,
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/simbolo_iasd.png'),
                      width: _iasdImgWidth,
                      height: _iasdImgHeight,
                    ),
                    title: Text('União'),
                  ),
                ),
              ),
            ],
          );
        })) {
      case 'jacy':
        debugPrint('jacy');
        // _prefs.setString("igreja", "jacy");
        globals.igreja = 'jacy';
        break;
      case 'oliveira3':
        debugPrint('ol3');
        // _prefs.setString("igreja", "oliveira3");
        globals.igreja = 'oliveira3';
        debugPrint(globals.igreja);
        break;
      case 'piratininga':
        debugPrint('piratininga');
        // _prefs.setString("igreja", "piratininga");
        globals.igreja = 'piratininga';
        break;
      case 'caicara':
        debugPrint('caicara');
        // _prefs.setString("igreja", "caicara");
        globals.igreja = 'caicara';
        break;
      case 'uniao':
        debugPrint('uniao');
        // _prefs.setString("igreja", "uniao");
        globals.igreja = 'uniao';
        break;
      // default:
      //   globals.igreja = 'jacy';
      //   break;
    }
  }
}
