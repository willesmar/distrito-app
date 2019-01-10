import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// import './utils/bloc.dart';
import 'package:distrito_app/pages/splashscreen.dart';
// import 'dart:async';
// import 'dart:math' as math;
// import 'package:distrito_app/utils/custom_icons_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './utils/globals.dart' as globals;
// import './pages/msgs.dart' as mensagens;
// import './pages/anuncios.dart' as anuncios;
// import './pages/programa.dart' as programa;
// import './pages/sobre.dart' as sobre;
// import './pages/crm.dart' as crm;
// import './pages/tabs_wdgt.dart';

void main() {
  // final bloc = Bloc();
  // debugPaintSizeEnabled = true;
  // debugPaintPointersEnabled = true;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<String> listaIgrejas = [
    'jacy',
    'oliveira3',
    'piratininga',
    'caicara',
    'uniao',
    'aquarios',
    'nacoes',
  ];
  listaIgrejas.forEach((i) {
    _firebaseMessaging.unsubscribeFromTopic(i);
  });
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(DistritoApp());
  });
}

class DistritoApp extends StatelessWidget {
  // final Bloc bloc;

  DistritoApp() {
    checkIgreja();
  }

  checkIgreja() async {
    final SharedPreferences prefs = await globals.sprefs;
    prefs.setString('igreja', 'oliveira3');
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    // if (isIOS) {
    //   return CupertinoApp(
    //     debugShowCheckedModeBanner: false,
    //     home: SplashScreen(),
    //   );
    // }
    final ThemeData kIOSTheme = new ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.grey[200],
      primaryColorBrightness: Brightness.light,
    );

    final ThemeData kDefaultTheme = new ThemeData(
      primaryColor: Color(0xFF003366), //Colors.lightBlueAccent[700],
      backgroundColor: Color(0xFFF3FDFE),
      bottomAppBarColor: Color(0xFF003366),
    );
    // var qqcoisa = checkIgreja();

    // this.bloc.igreja.isEmpty.then((hasIgreja) {
    //   print('Igreja => $hasIgreja');
    //   // return hasIgreja;
    // });
    if (isIOS) {
      return CupertinoApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        home: SplashScreen(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        // debugShowMaterialGrid: true,
        theme: isIOS ? kIOSTheme : kDefaultTheme,
        home: SplashScreen(),
        // child: MyTabs(),
      );
    }
  }
}

// class MyTabs extends StatefulWidget {
//   final Bloc bloc;

//   MyTabs(this.bloc);

//   @override
//   MyTabsState createState() => new MyTabsState();
// }

// class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
//   TabController controller;
//   String _igreja;
//   SharedPreferences _prefs;

//   Future getSharedPrefs() async {
//     _prefs = await SharedPreferences.getInstance();
//     _prefs.setString("igreja", "oliveira3");
//     // _igreja = prefs.getString("igreja") ?? null;
//     setState(() {
//       _igreja = _prefs.getString("igreja") ?? null;
//     });
//   }

//   _askedToLead(BuildContext context) async {
//     return await showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return new AlertDialog(
//             title: new Text('Are you Sure ?'),
//             actions: <Widget>[
//               new FlatButton(
//                 child: new Text('Yes'),
//                 onPressed: () {
//                   Navigator.of(context).pop(true);
//                 },
//               ),
//               new FlatButton(
//                 child: new Text('No'),
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 },
//               )
//             ],
//           );
//         });
//   }

//   _selecioneIgreja() async {
//     switch (await showDialog<String>(
//         context: context,
//         builder: (BuildContext context) {
//           return new SimpleDialog(
//             title: const Text('Selecione uma igreja!'),
//             children: <Widget>[
//               SimpleDialogOption(
//                 onPressed: () {
//                   debugPrint(_igreja);
//                   // Navigator.pop(context, 'jacy');
//                   Navigator.of(context, rootNavigator: true).pop('jacy');
//                 },
//                 child: Container(
//                   height: 40.0,
//                   child: const ListTile(
//                     leading: Image(
//                       image: AssetImage('assets/images/simbolo_iasd.png'),
//                       width: 28.0,
//                       height: 25.0,
//                     ),
//                     // CircleAvatar(
//                     //   backgroundColor: Colors.transparent,
//                     //   backgroundImage:
//                     //       AssetImage('assets/images/simbolo_iasd.png'),
//                     // ),
//                     title: Text('IASD Jacy'),
//                   ),
//                 ),
//               ),
//               SimpleDialogOption(
//                 onPressed: () {
//                   debugPrint(_igreja);
//                   // Navigator.pop(context, 'oliveira3');
//                   Navigator.of(context, rootNavigator: true).pop('oliveira3');
//                 },
//                 child: Container(
//                   height: 40.0,
//                   child: const ListTile(
//                     leading: Image(
//                       image: AssetImage('assets/images/simbolo_iasd.png'),
//                       width: 28.0,
//                       height: 25.0,
//                     ),
//                     title: Text('IASD Oliveira III'),
//                   ),
//                 ),
//               ),
//               SimpleDialogOption(
//                 onPressed: () {
//                   debugPrint(_igreja);
//                   // Navigator.pop(context, 'piratininga');
//                   Navigator.of(context, rootNavigator: true).pop('piratininga');
//                 },
//                 child: Container(
//                   height: 40.0,
//                   child: const ListTile(
//                     leading: Image(
//                       image: AssetImage('assets/images/simbolo_iasd.png'),
//                       width: 28.0,
//                       height: 25.0,
//                     ),
//                     title: Text('IASD Piratininga'),
//                   ),
//                 ),
//               ),
//               SimpleDialogOption(
//                 onPressed: () {
//                   debugPrint(_igreja);
//                   // Navigator.pop(context, 'caicara');
//                   Navigator.of(context, rootNavigator: true).pop('caicara');
//                 },
//                 child: Container(
//                   height: 40.0,
//                   child: const ListTile(
//                     leading: Image(
//                       image: AssetImage('assets/images/simbolo_iasd.png'),
//                       width: 28.0,
//                       height: 25.0,
//                     ),
//                     title: Text('IASD Caiçara'),
//                   ),
//                 ),
//               ),
//               SimpleDialogOption(
//                 onPressed: () {
//                   debugPrint(_igreja);
//                   // Navigator.pop(context, 'uniao');
//                   Navigator.of(context, rootNavigator: true).pop('uniao');
//                 },
//                 child: Container(
//                   height: 40.0,
//                   child: const ListTile(
//                     leading: Image(
//                       image: AssetImage('assets/images/simbolo_iasd.png'),
//                       width: 28.0,
//                       height: 25.0,
//                     ),
//                     title: Text('IASD União'),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         })) {
//       case 'jacy':
//         debugPrint('jacy');
//         // _prefs.setString("igreja", "jacy");
//         globals.igreja = 'jacy';
//         break;
//       case 'oliveira3':
//         debugPrint('ol3');
//         // _prefs.setString("igreja", "oliveira3");
//         globals.igreja = 'oliveira3';
//         break;
//       case 'piratininga':
//         debugPrint('piratininga');
//         // _prefs.setString("igreja", "piratininga");
//         globals.igreja = 'piratininga';
//         break;
//       case 'caicara':
//         debugPrint('caicara');
//         // _prefs.setString("igreja", "caicara");
//         globals.igreja = 'caicara';
//         break;
//       case 'uniao':
//         debugPrint('uniao');
//         // _prefs.setString("igreja", "uniao");
//         globals.igreja = 'uniao';
//         break;
//     }
//     // return 'oliveira3';
//   }

//   @override
//   void initState() {
//     super.initState();
//     controller = new TabController(vsync: this, length: 5);
//     _igreja = null;
//     // if (_igreja == null)
//     //   _askedToLead(context).then((val) {
//     //     print(val);
//     //   });
//     getSharedPrefs();
//     // _askedToLead(context);
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   // @override
//   // void didChangeDependencies() {
//   //   if (_igreja == null)
//   //     _askedToLead(context).then((val) {
//   //       print(val);
//   //     });
//   //     // _igreja == 'oliveira3';
//   //     // globals.igreja = 'oliveira3';

//   //   super.didChangeDependencies();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // if (_igreja == null) {
//     //   // _askedToLead(context).then((val) {
//     //   //   print(val);
//     //   // });
//     //   // _igreja == 'oliveira3';
//     globals.igreja = 'oliveira3';
//     // }

//     return Provider(
//       child: Scaffold(
//         bottomNavigationBar: new Material(
//           color: Theme.of(context).primaryColor, //Colors.green[900],
//           child: new TabBar(
//             controller: controller,
//             labelStyle: new TextStyle(fontSize: 9.0),
//             indicatorWeight: 1.0,
//             indicatorColor: Color(0xFF36424E),
//             tabs: <Tab>[
//               new Tab(
//                 icon: new Icon(CustomIcons.fire_station),
//                 text: 'Mensagem',
//               ),
//               new Tab(
//                 icon: Transform(
//                   transform: new Matrix4.rotationZ(math.pi),
//                   alignment: FractionalOffset.center,
//                   child: Icon(CustomIcons.spread),
//                 ),
//                 text: 'CRM',
//               ),
//               new Tab(
//                 icon: new Icon(Icons.event_note),
//                 text: 'Anúncios',
//               ),
//               new Tab(
//                 icon: new Icon(Icons.local_activity),
//                 text: 'Programa',
//               ),
//               new Tab(
//                 icon: new Icon(Icons.location_city),
//                 text: 'Sobre',
//               ),
//             ],
//           ),
//         ),
//         body: new TabBarView(
//           controller: controller,
//           children: <Widget>[
//             new mensagens.Mensagens(),
//             new crm.ComunhaoRelacionamentoMissao(),
//             new anuncios.Anuncios(),
//             new programa.Programa(),
//             new sobre.Sobre(),
//           ],
//         ),
//       ),
//     );

//     // return new Scaffold(
//     //   bottomNavigationBar: new Material(
//     //     color: Theme.of(context).primaryColor, //Colors.green[900],
//     //     child: new TabBar(
//     //       controller: controller,
//     //       labelStyle: new TextStyle(fontSize: 9.0),
//     //       indicatorWeight: 1.0,
//     //       indicatorColor: Color(0xFF36424E),
//     //       tabs: <Tab>[
//     //         new Tab(
//     //           icon: new Icon(CustomIcons.fire_station),
//     //           text: 'Mensagem',
//     //         ),
//     //         new Tab(
//     //           icon: Transform(
//     //             transform: new Matrix4.rotationZ(math.pi),
//     //             alignment: FractionalOffset.center,
//     //             child: Icon(CustomIcons.spread),
//     //           ),
//     //           text: 'CRM',
//     //         ),
//     //         new Tab(
//     //           icon: new Icon(Icons.event_note),
//     //           text: 'Anúncios',
//     //         ),
//     //         new Tab(
//     //           icon: new Icon(Icons.local_activity),
//     //           text: 'Programa',
//     //         ),
//     //         new Tab(
//     //           icon: new Icon(Icons.location_city),
//     //           text: 'Sobre',
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     //   body: new TabBarView(
//     //     controller: controller,
//     //     children: <Widget>[
//     //       new mensagens.Mensagens(),
//     //       new crm.ComunhaoRelacionamentoMissao(),
//     //       new anuncios.Anuncios(),
//     //       new programa.Programa(),
//     //       new sobre.Sobre(),
//     //     ],
//     //   ),
//     // );
//   }
// }
