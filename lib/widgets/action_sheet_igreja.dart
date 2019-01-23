import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/igreja.dart';

class ActionSheetIgreja extends StatelessWidget {
  final List<Igreja> _igrejas = [
    new Igreja(igreja: 'IASD Vila Jacy', valor: 'jacy'),
    new Igreja(igreja: 'IASD Oliveira 3', valor: 'oliveira3'),
    new Igreja(igreja: 'IASD Piratininga', valor: 'piratininga'),
    new Igreja(igreja: 'IASD Caiçara', valor: 'caicara'),
  ];
// new Igreja(igreja: 'Grupo União', valor: 'uniao'),
// new Igreja(igreja: 'Grupo Aquários', valor: 'aquarios'),
// new Igreja(igreja: 'Grupo Nações', valor: 'nacoes'),

//  void _goToTabs(value) {
//    globals.igreja = value.toString();
//    Navigator.of(context).pushReplacement(MaterialPageRoute(
//        builder: (context) => MyTabs(igreja: value.toString())));
//  }

  var completer = new Completer<String>();

  List<Widget> _actionOptions(BuildContext context) {
    List<Widget> opt = [];
    _igrejas.forEach((f) {
      opt.add(
        CupertinoActionSheetAction(
          child: Text(f.igreja),
          onPressed: () {
            Navigator.pop(context, f.valor);
          },
        ),
      );
    });
    return opt.toList();
  }

  Future<String> containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // Scaffold.of(context).showSnackBar(new SnackBar(
      //   content: new Text('You clicked $value'),
      //   duration: Duration(milliseconds: 800),
      // ));
      // setState(() {
      //   _currentIgreja = value.toString();
      // });
      print('action sheet' + value.toString());
      completer.complete(value.toString());
//      _goToTabs(value);
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              containerForSheet<String>(
                context: context,
                child: CupertinoActionSheet(
                    title: const Text(
                      'Escolha sua igreja',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    // message: const Text(
                    //     'Your options are '),
                    actions: _actionOptions(context),
                    cancelButton: CupertinoActionSheetAction(
                      child: const Text('Cancelar'),
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                    )),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                // color: CupertinoColors.tr,
                border: Border(
                  top: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
                  bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
                ),
              ),
              height: 54.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // const Text('Escolha uma igreja', style: TextStyle(fontSize: 18.0, color: CupertinoColors.inactiveGray),),
                      Text(
                        _igrejas[1].igreja,
                        style: TextStyle(
                            fontSize: 22.0, color: CupertinoColors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
