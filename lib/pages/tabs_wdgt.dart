import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:distrito_app/utils/custom_icons_icons.dart';
import 'dart:math' as math;
import 'dart:async';

import '../utils/globals.dart' as globals;
import '../utils/bloc.dart';
import './msgs.dart' as mensagens;
import './anuncios.dart' as anuncios;
import './programa.dart' as programa;
import './sobre.dart' as sobre;
// import './crm.dart' as crm;

class MyTabs extends StatefulWidget {
  final String igreja;
  // Bloc bloc;

  MyTabs({this.igreja});
  //  {
  //   this.bloc = Bloc();
  // }

  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  String _homeScreenText = "Waiting for token...";
  bool _topicButtonsDisabled = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  TabController controller;

  @override
  void initState() {
    super.initState();
    debugPrint(widget.igreja);
    controller = new TabController(vsync: this, length: 4);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);
    // bloc.igreja.listen((hasIgreja) async {
    //   print('Igreja => $hasIgreja');
    //   if (hasIgreja.length < 1) {
    //     await selecionarIgrejaModal(context);
    //   }
    // });
    if (widget.igreja.isEmpty) {
      selecionarIgrejaModal(context);
    } else if (widget.igreja.isNotEmpty) {
      globals.igreja = widget.igreja;
    }
    // widget.bloc.igreja.listen((hasIgreja) async {
    //   print('Igreja => $hasIgreja');
    // });

    return Provider(
      child: Scaffold(
        bottomNavigationBar: new Material(
          color: Theme.of(context).primaryColor, //Colors.green[900],
          child: new TabBar(
            controller: controller,
            labelStyle: new TextStyle(fontSize: 9.0),
            indicatorWeight: 0.01,
            indicatorColor: Colors.transparent, //(0xFF36424E),
            tabs: <Tab>[
              new Tab(
                icon: new Icon(CustomIcons.fire_station),
                text: 'Msg',
              ),
              // new Tab( //XXX: CRM qnd tiver implementado na ES
              //   icon: Transform(
              //     transform: new Matrix4.rotationZ(math.pi),
              //     alignment: FractionalOffset.center,
              //     child: Icon(CustomIcons.spread),
              //   ),
              //   text: 'CRM',
              // ),
              new Tab(
                icon: new Icon(Icons.event_note),
                text: 'Com',
              ),
              new Tab(
                icon: new Icon(Icons.local_activity),
                text: 'Prgrm',
              ),
              new Tab(
                icon: new Icon(Icons.location_city),
                text: 'Sobre',
              ),
            ],
          ),
        ),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new mensagens.Mensagens(),
            // new crm.ComunhaoRelacionamentoMissao(),
            new anuncios.Anuncios(),
            new programa.Programa(),
            new sobre.Sobre(),
          ],
        ),
      ),
    );
  }

  Future selecionarIgrejaModal(BuildContext context) async {
    final bloc = Provider.of(context);
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: const Text('Selecione uma igreja!'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  bloc.selecionarIgreja('jacy');
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Container(
                  height: 40.0,
                  child: const ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/simbolo_iasd.png'),
                      width: 28.0,
                      height: 25.0,
                    ),
                    title: Text('IASD Jacy'),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  bloc.selecionarIgreja('oliveira3');
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Container(
                  height: 40.0,
                  child: const ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/simbolo_iasd.png'),
                      width: 28.0,
                      height: 25.0,
                    ),
                    title: Text('IASD Oliveira III'),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  bloc.selecionarIgreja('piratininga');
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Container(
                  height: 40.0,
                  child: const ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/simbolo_iasd.png'),
                      width: 28.0,
                      height: 25.0,
                    ),
                    title: Text('IASD Piratininga'),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  bloc.selecionarIgreja('caicara');
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Container(
                  height: 40.0,
                  child: const ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/simbolo_iasd.png'),
                      width: 28.0,
                      height: 25.0,
                    ),
                    title: Text('IASD Caiçara'),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  bloc.selecionarIgreja('uniao');
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Container(
                  height: 40.0,
                  child: const ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/simbolo_iasd.png'),
                      width: 28.0,
                      height: 25.0,
                    ),
                    title: Text('IASD União'),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
