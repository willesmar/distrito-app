import 'dart:async';

import 'package:distrito_app/model/push_notification.dart';
import 'package:distrito_app/utils/bloc_provider.dart';
import 'package:distrito_app/utils/custom_icons_icons.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './anuncios.dart';
import './msgs.dart';
import './programa.dart';
import './sobre.dart';
import '../utils/bloc.dart';
// import './crm.dart';

class MyTabs extends StatefulWidget {
  final String igreja;

  MyTabs({this.igreja});

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
//    debugPrint(widget.igreja);
    controller = new TabController(vsync: this, length: 4);
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {});
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
      // unsubscribeAllTopics();
    });
    _firebaseMessaging.subscribeToTopic(widget.igreja);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  BlocProvider _iosTabs(BuildContext context) {
    return BlocProvider<BlocDados>(
      bloc: BlocDados(),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          iconSize: 24.0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(IconData(0xf42e,
                  fontFamily: 'CupertinoIcons',
                  fontPackage: 'cupertino_icons')),
              title: Text('Mensagem'),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconData(0xf2d1,
                  fontFamily: 'CupertinoIcons',
                  fontPackage: 'cupertino_icons')),
              title: Text('Comunicação'),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconData(0xf453,
                  fontFamily: 'CupertinoIcons',
                  fontPackage: 'cupertino_icons')),
              title: Text('Programa'),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconData(0xf44c,
                  fontFamily: 'CupertinoIcons',
                  fontPackage: 'cupertino_icons')),
              title: Text('Sobre'),
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          assert(index >= 0 && index <= 3);
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return new Mensagens();
                },
              );
              break;
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return new Anuncios();
                },
              );
              break;
            case 2:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return new Programa();
                },
              );
              break;
            case 3:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return new Sobre();
                },
              );
              break;
          }
        },
      ),
    );
  }

  BlocProvider _androidTabs(BuildContext context) {
    return BlocProvider<BlocDados>(
      bloc: BlocDados(),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: new Material(
          elevation: 0.5,
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
            new Mensagens(),
            // new ComunhaoRelacionamentoMissao(),
            new Anuncios(),
            new Programa(),
            new Sobre(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        PushNotification pushMessage = PushNotification.fromJson(message);
        showPushNotification(context, pushMessage);
      },
      onLaunch: (Map<String, dynamic> message) async {
        PushNotification pushMessage = PushNotification.fromJson(message);
        showPushNotification(context, pushMessage);
      },
      onResume: (Map<String, dynamic> message) async {
        PushNotification pushMessage = PushNotification.fromJson(message);
        showPushNotification(context, pushMessage);
      },
    );

    // if (widget.igreja.isEmpty) {
    //   selecionarIgrejaModal(context);
    // } else if (widget.igreja.isNotEmpty) {
    //   globals.igreja = widget.igreja;
    // }

    if (isIOS) {
      return _iosTabs(context);
    } else {
      return _androidTabs(context);
    }
  }

  void showPushNotification(
      BuildContext context, PushNotification pushMessage) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(pushMessage.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(pushMessage.body),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future selecionarIgrejaModal(BuildContext context) async {
    // final bloc = Provider.of(context);
    final BlocDados bloc = BlocProvider.of<BlocDados>(context);
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
