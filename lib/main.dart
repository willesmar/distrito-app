import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/mensagem/mensagem.dart';
import 'model/imagem.dart';
import 'utils/functions.dart' as fn;
import './pages/msgs.dart' as mensagens;
import './pages/anuncios.dart' as anuncios;
import './pages/programa.dart' as programa;
import './pages/sobre.dart' as sobre;
import './pages/crm.dart' as crm;

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[600],
      ),
      home: new MyTabs()));
}

class MyTabs extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
          color: Colors.green[600],
          child: new TabBar(
            controller: controller,
            labelStyle: new TextStyle(fontSize: 9.0),
            indicatorColor: new Color(0xFF00796B),
            tabs: <Tab>[
              new Tab(
                icon: new Icon(Icons.speaker_notes),
                text: 'Mensagem',
              ),
              new Tab(
                icon: new Icon(Icons.work),
                text: 'CRM',
              ),
              new Tab(
                icon: new Icon(Icons.event_note),
                text: 'Anúncios',
              ),
              new Tab(
                icon: new Icon(Icons.local_activity),
                text: 'Programa',
              ),
              new Tab(
                icon: new Icon(Icons.location_city),
                text: 'Sobre',
              ),
            ],
          )),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new mensagens.Mensagens(),
          new anuncios.Anuncios(),
          new programa.Programa(),
          new sobre.Sobre(),
          new crm.ComunhaoRelacionamentoMissao()
        ],
      ),
    );
  }
}

// void main() => runApp(new DistritoApp());

// class DistritoApp extends StatefulWidget {
//   const DistritoApp();

//   @override
//   DistritoAppState createState() {
//     return new DistritoAppState();
//   }
// }

// class DistritoAppState extends State<DistritoApp> {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Distrito App',
//       theme: ThemeData(
//         primaryColor: Colors.green[600],
//       ),
//       home: const Tabs(title: 'Distrito App'),
//     );
//   }
// }

// class Tabs extends StatelessWidget {
//   const Tabs({Key key, this.title}) : super(key: key);
//   final String title;

//   _buildListItem(BuildContext context, DocumentSnapshot document) {
//     // return new ListTile(
//     //   key: new ValueKey(document.documentID),
//     //   title: new Container(
//     //     decoration: new BoxDecoration(
//     //       border: new Border.all(color: const Color(0x80000000)),
//     //       borderRadius: new BorderRadius.circular(5.0),
//     //     ),
//     //     padding: const EdgeInsets.all(10.0),
//     //     child: new Row(
//     //       children: <Widget>[
//     //         new Expanded(
//     //           child: new Text(document['igreja']),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );
//     final img = document['imagem'];
//     final imgUrl = img['url'];
//     return new Card(
//       key: new ValueKey(document.documentID),
//       elevation: 2.0,
//       child: new Column(
//         children: <Widget>[
//           // new Image.network('$imgUrl'),
//           new Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: new Row(
//               children: <Widget>[
//                 new Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: new Icon(
//                     Icons.calendar_today,
//                     size: 16.0,
//                   ),
//                 ),
//                 new Expanded(
//                   child: new Text(
//                     fn.dataPorExtenso(document['timestamp']),
//                     style: new TextStyle(fontSize: 16.0),
//                 )),
//               ],
//             ),
//           ),
//           new Container(
//             constraints: new BoxConstraints.expand(
//               height: 200.0,
//             ),
//             alignment: Alignment.bottomLeft,
//             padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
//             decoration: new BoxDecoration(
//               image: new DecorationImage(
//                 image: new NetworkImage(imgUrl),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: new Container(
//               child: new Text(document.data['titulo'],
//                   style: new TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25.0,
//                     color: Colors.white,
//                     decorationColor: Colors.red,
//                   )),
//             ),
//           ),
//           new Padding(
//               padding: new EdgeInsets.all(7.0),
//               child: new Row(
//                 children: <Widget>[
//                   // new Padding(
//                   //   padding: new EdgeInsets.all(7.0),
//                   //   child: new Icon(Icons.thumb_up),
//                   // ),
//                   new Flexible(
//                     child: new Padding(
//                       padding: new EdgeInsets.all(7.0),
//                       child: new Text(
//                         document['passagem'],
//                         textAlign: TextAlign.justify,
//                         style: new TextStyle(fontSize: 16.0),
//                       ),
//                     ),
//                   ),
//                   // new Padding(
//                   //   padding: new EdgeInsets.all(7.0),
//                   //   child: new Icon(Icons.comment),
//                   // ),
//                   // new Padding(
//                   //   padding: new EdgeInsets.all(7.0),
//                   //   child: new Text('Comments',
//                   //       style: new TextStyle(fontSize: 18.0)),
//                   // )
//                 ],
//               )),
//           // new Padding(
//           //   padding: new EdgeInsets.all(7.0),
//           //   child: new Row(children: <Widget>[
//           //     new Padding(
//           //       padding: new EdgeInsets.all(7.0),
//           //       child: new Text(document['titulo'],
//           //           style: new TextStyle(fontSize: 18.0)),
//           //     )
//           //   ]),
//           // ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(title: new Text(title)),
//       body: new StreamBuilder(
//         stream: Firestore.instance
//             .collection('mensagens')
//             .where('publicado', isEqualTo: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return const Text('Carregando...');
//           // print(snapshot.data.documents[0]['igreja']);
//           // return new Text('data');
//           // print(msgs.length);
//           // print();
//           // final size = snapshot.data.documents.length;
//           // final msgs = snapshot.data.documents;
//           // for (var i = 0; i < size; i++) {
//           //   var msg = msgs[i].data;
//           //   // print(msg['titulo']);
//           //   // print(msg['data']);
//           //   // print(msg['timestamp']);
//           //   // var img = msg['imagem'];
//           //   // print(img['nameFile']);
//           //   // var doc = new Mensagem.fromJson(docs[i].data);
//           //   // print(docs[i].data['imagem']);
//           //   // print(doc.timestamp);
//           //   // print('Título => ');
//           //   // new Mensagem.fromJson(jsonEncode(jsonDecode(msg)))
//           //   // print('Título => ${msg['titulo']}');
//           // }
//           return new ListView.builder(
//               itemCount: snapshot.data.documents.length,
//               //padding: const EdgeInsets.only(top: 10.0),
//               //itemExtent: 55.0,
//               itemBuilder: (context, index) {
//                 // print(index);
//                 return _buildListItem(context, snapshot.data.documents[index]);
//               });
//         },
//       ),
//     );
//   }
// }

// class CustomCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Card(
//       elevation: 2.0,
//       child: new Column(
//         children: <Widget>[
//           new Image.network(
//               'https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
//           new Padding(
//               padding: new EdgeInsets.all(7.0),
//               child: new Row(
//                 children: <Widget>[
//                   new Padding(
//                     padding: new EdgeInsets.all(7.0),
//                     child: new Icon(Icons.thumb_up),
//                   ),
//                   new Padding(
//                     padding: new EdgeInsets.all(7.0),
//                     child: new Text(
//                       'Like',
//                       style: new TextStyle(fontSize: 18.0),
//                     ),
//                   ),
//                   new Padding(
//                     padding: new EdgeInsets.all(7.0),
//                     child: new Icon(Icons.comment),
//                   ),
//                   new Padding(
//                     padding: new EdgeInsets.all(7.0),
//                     child: new Text('Comments',
//                         style: new TextStyle(fontSize: 18.0)),
//                   )
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }
