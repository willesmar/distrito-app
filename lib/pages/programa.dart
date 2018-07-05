import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/functions.dart' as fn;

// TODO: titulo com nome do programa, data completa abaixo
// TODO: aba/collapse de escala
// TODO: onClick mark as completed
// TODO: manter tela ligada nesta aba
class Programa extends StatefulWidget {
  @override
  ProgramaState createState() => new ProgramaState();
}

class ProgramaState extends State<Programa> {
  String _appBarTitle = 'Programa';
  bool hasData;
  Widget _appBar;
  Color _primary;
  double _size;

  @override
  void initState() {
    super.initState();
    _appBarTitle = 'Programa';
    _primary = Theme.of(context).primaryColor;
    _size = MediaQuery.of(context).size.width;
    _appBar = _initAppBar(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _makeAtividade(List atividade, {String grupoAtividade: null}) {
    List<Widget> listaAtividade = [];
    for (var i = 0; i < atividade.length; i++) {
      if (i == 0 && grupoAtividade != null) {
        listaAtividade.add(Container(
          decoration: BoxDecoration(color: Color(0xFFA7B9D1)),
          child: ListTile(
            dense: true,
            // contentPadding: EdgeInsets.only(left: 70.0),
            title: Center(
              child: Text(
                grupoAtividade.toString(), //.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
            ),
          ),
        ));
      }
      listaAtividade.add(_buildCard(context, atividade[i]));
    }
    return listaAtividade;
  }

  Widget _generateListCards(BuildContext context, document) {
    List<Widget> listaPrograma = [];
    List louvor = document['louvor'];
    num louvorSize = louvor.length;
    List escolaSabatina = document['escolaSabatina'];
    num esSize = escolaSabatina.length;
    List extra = document['extra'];
    num extraSize = extra.length;
    List culto = document['culto'];
    num cultoSize = culto.length;

    listaPrograma.add(
      Container(
        decoration: BoxDecoration(color: Color(0xFFA7B9D1)),
        padding: EdgeInsets.only(top: 8.0),
        child: ListTile(
          dense: true,
          title: Center(
            child: Text(
              document['nomePrograma'].toString().toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white),
            ),
          ),
          subtitle: Center(
            child: Text(
              fn.dataCompleta(document['timestamp']),
              style: new TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );

    if (louvorSize > 0) {
      listaPrograma.addAll(_makeAtividade(louvor, grupoAtividade: 'Louvor'));
    }

    if (esSize > 0) {
      listaPrograma.addAll(
          _makeAtividade(escolaSabatina, grupoAtividade: 'Escola Sabatina'));
    }

    if (extraSize > 0) {
      listaPrograma.addAll(_makeAtividade(extra));
    }

    if (cultoSize > 0) {
      listaPrograma.addAll(_makeAtividade(culto, grupoAtividade: 'Culto'));
    }
    return Column(
      children: listaPrograma,
    );
  }

  IconData _getIcon(String icone) {
    switch (icone) {
      case 'musical-notes':
        return Icons.music_note;
        break;
      case 'musical-note':
        return Icons.music_note;
        break;
      case 'microphone':
        return Icons.mic;
        break;
      case 'film':
        return Icons.ondemand_video;
        break;
      case 'people':
        return Icons.person;
        break;
      case 'person':
        return Icons.person;
        break;
      default:
        return Icons.announcement;
    }
  }

  Widget _buildCard(BuildContext context, document) {
    IconData _icone = _getIcon(document['icone']);

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: new Stack(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: FlatButton(
              onPressed: () {
                debugPrint(document['nomeAtividade']);
              },
              padding: EdgeInsets.all(0.0),
              child: new Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 8.0, 12.0, 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 3.0),
                        child: Text(
                          document['nomeAtividade'],
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 3.0),
                            child: Icon(
                              Icons.schedule,
                              size: 14.0,
                            ),
                          ),
                          Text(
                            '${document['hInicio']} - ${document['duracao']} min',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 3.0),
                            child: Icon(
                              Icons.person,
                              size: 14.0,
                            ),
                          ),
                          Text(
                            document['responsavel'],
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          new Positioned(
            top: 0.0,
            bottom: 0.0,
            left: 30.0,
            child: new Container(
              height: double.infinity,
              width: 1.0,
              color: Color(0xFFBACEE6),
            ),
          ),
          new Positioned(
            top: 15.0,
            left: 10.0,
            child: new Container(
              height: 40.0,
              width: 40.0,
              // child: new Icon(_icone, color: Colors.white, size: 30.0),
              child: new Icon(_icone, color: Colors.white, size: 30.0),
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFA7B9D1), //Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _initAppBar(BuildContext context, {document: null}) {
    if (document == null) {
      return AppBar(
        title: Text(_appBarTitle != null ? _appBarTitle : 'Programa'),
        backgroundColor: _primary, //Colors.green[600],
      );
    }
    return PreferredSize(
      preferredSize: new Size(_size, 20.0),
      child: ListTile(
        dense: true,
        title: Center(
          child: Text(
            document['nomePrograma'].toString().toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.white),
          ),
        ),
        subtitle: Center(
          child: Text(
            fn.dataCompleta(document['timestamp']),
            style: new TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBar,
      // new AppBar(
      //   title: new Text(_appBarTitle != null ? _appBarTitle : 'Programa'),
      //   backgroundColor: Theme.of(context).primaryColor, //Colors.green[600],
      // ),
      body: new StreamBuilder(
        stream: Firestore.instance
            .collection('programas')
            .where('publicado', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          _appBarTitle = snapshot.data.documents.first['nomePrograma']
              .toString()
              .toUpperCase();

          _appBar =
              _initAppBar(context, document: snapshot.data.documents.first);
          return new ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return _generateListCards(
                    context, snapshot.data.documents.first);
              });
        },
      ),
    );
  }
}
