import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './../utils/globals.dart' as globals;
import 'package:distrito_app/model/pastor/pastor.dart';
import 'package:distrito_app/pages/pastor_wdgt.dart';

class Sobre extends StatefulWidget {
  @override
  SobreState createState() => new SobreState();
}
// var pastor = Firestore.instance.document('sobre/pastor').snapshots();
// var obs = new Observable(pastor).map((DocumentSnapshot doc) {doc['nome']});
// debugPrint(pastor.data.documents.length);
// AsyncSnapshot<QuerySnapshot> snapshot;
// Stream<DocumentSnapshot> _pastorSnp;
// var _pastor;

// Future<void> getPastor() async {
//   Stream<DocumentSnapshot> pastorSnp =
//       await Firestore.instance.document('sobre/pastor').snapshots();
//   _pastor = await pastorSnp.listen((data) {
//     // debugPrint(data.data['nome']);
//     return data.data;
//   });

// if (pastor.first != null) {
//   var first = pastor.take(1);
//   var lista = first.toList();
//   var nome = first.asBroadcastStream().map((doc) {
//     debugPrint(doc.data['nome']);
//     return doc.data;
//   });
// }
// }

class SobreState extends State<Sobre> {
  String _igrejaPref;

  // Future<String> _getSharedPrefs() async {
  //   var pref = await SharedPreferences.getInstance();
  //   var igreja = await pref.getString("igreja") ?? "nadaaaaaa";
  //   debugPrint(igreja);
  //   return igreja;
  //   // return await _getIgreja(pref).then((val) => val);
  //   // debugPrint(_prefs.getString("igreja") ?? null);
  // }

  @override
  void initState() {
    super.initState();
    _igrejaPref = globals.igreja;
    // _igrejaPref = await _getSharedPrefs();
    // if (_igrejaPref == null) {
    // _getSharedPrefs().then((pref) {
    //   debugPrint(pref);
    //   _igrejaPref = pref;
    // });
    // }
  }

  @override
  void dispose() {
    super.dispose();
    // _igrejaPref = null;
  }

  List<Widget> _contentAtividadeCultos(BuildContext ctx, List data) {
    List<Widget> arr = [];
    data.forEach((atividade) {
      arr.add(
        Text(
          '${atividade['nome']} - ${atividade['inicio']}',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
        ),
      );
    });
    return arr;
  }

  List<Widget> _contentCultos(BuildContext ctx, List data) {
    List<Widget> arr = [];
    data.forEach((conteudo) {
      arr.add(ListTile(
        title: Text(
          conteudo['dia'],
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _contentAtividadeCultos(ctx, conteudo['atividades'])),
        ),
      ));
    });
    return arr;
  }

  List<Widget> _contentContato(BuildContext ctx, List data) {
    List<Widget> arr = [];
    data.forEach((contato) {
      arr.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
          child: OutlineButton.icon(
            label: Text(
              contato['nome'],
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
            ),
            icon: Icon(Icons.face),
            onPressed: () {},
          ),
        ),
        // Text(
        //   contato['nome'],
        //   style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
        // ),
      );
    });
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Sobre'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder(
          stream:
              Firestore.instance.document('sobre/${_igrejaPref}').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LinearProgressIndicator();
            }
            return ListView(children: <Widget>[
              new Container(
                constraints: new BoxConstraints.expand(
                  height: 300.0,
                ),
                child: new Stack(fit: StackFit.expand, children: <Widget>[
                  new Image.asset(
                    'assets/images/iasd_ol3.jpg', // TODO: get dynamic imgs
                    fit: BoxFit.cover,
                  ),
                  new Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: new Container(
                      decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ]),
                      ),
                      padding: const EdgeInsets.all(18.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Expanded(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
                                  'IASD OLIVEIRA III',
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 3.0),
                child: Card(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(color: Color(0xFF90979F)),
                          child: Row(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Localização',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )
                          ]),
                        ),
                        Image.asset(
                          'assets/images/map.png', // TODO: get dynamic imgs
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(18.0, 8.0, 12.0, 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${snapshot.data['endereco']['rua']}, ${snapshot.data['endereco']['numero']} - ${snapshot.data['endereco']['bairro']}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                '${snapshot.data['endereco']['cidade']} - ${snapshot.data['endereco']['estado']}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                'CEP: ${snapshot.data['endereco']['cep']}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
                child: Card(
                  child: Column(children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: Color(0xFF90979F)),
                      child: Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Cultos',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                          children:
                              _contentCultos(context, snapshot.data['cultos'])),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
                child: Card(
                  child: Column(children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: Color(0xFF90979F)),
                      child: Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Contato',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                      child: Column(
                          children: _contentContato(
                              context, snapshot.data['contato'])), //TODO:
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 6.0),
                child: PastorCard(),
              ),
            ]);
          }),
    );
  }
}
