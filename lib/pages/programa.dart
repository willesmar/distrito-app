import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:screen/screen.dart';

import '../utils/functions.dart' as fn;

// TODO: titulo com nome do programa, data completa abaixo
// TODO: aba/collapse de escala
// TODO: onClick mark as completed
// TODO: criar aba de transição/extras
class Programa extends StatefulWidget {
  @override
  ProgramaState createState() => new ProgramaState();
}

class ProgramaState extends State<Programa> {
  // String _appBarTitle = 'Programa';
  // bool hasData;
  // Widget _appBar;
  // Color _primary;
  // double _size;
  bool _toggle = false;
  Color _corCirculoTimeline = Color(0xFFA7B9D1);

  @override
  void initState() {
    super.initState();
    _toggle = false;
    _corCirculoTimeline = Color(0xFFA7B9D1);
    // _appBarTitle = 'Programa';
    // _primary = Theme.of(context).primaryColor;
    // _size = MediaQuery.of(context).size.width;
    // _appBar = _initAppBar(context);
    // Screen.keepOn(true);
  }

  @override
  void dispose() {
    super.dispose();
    Screen.keepOn(false);
    _toggle = false;
    _corCirculoTimeline = Color(0xFFA7B9D1);
  }

  List<Widget> _makeAtividade(List atividade, {String grupoAtividade: null}) {
    List<Widget> listaAtividade = [];
    List<Widget> listaRetornada = [];

    for (var i = 0; i < atividade.length; i++) {
      listaAtividade.add(_buildCard(context, atividade[i]));
    }

    if (grupoAtividade != null) {
      listaRetornada.add(Container(
          decoration: BoxDecoration(color: Color(0xFFA7B9D1)),
          child: ExpansionTile(
            initiallyExpanded: true,
            backgroundColor: Color(0xFFA7B9D1),
            title: Text(
              grupoAtividade.toString(), //.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white),
            ),
            children: listaAtividade.toList(),
          )));
      // itemZero = Container(
      //   decoration: BoxDecoration(color: Color(0xFFA7B9D1)),
      //   child: ListTile(
      //     dense: true,
      //     // contentPadding: EdgeInsets.only(left: 70.0),
      //     title: Center(
      //       child: Text(
      //         grupoAtividade.toString(), //.toUpperCase(),
      //         style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //             fontSize: 20.0,
      //             color: Colors.white),
      //       ),
      //     ),
      //   ),
      // );
    } else {
      listaRetornada = listaAtividade;
    }

    return listaRetornada;
  }

  Widget makeEscala(String departamento, List<dynamic> integrantes) {
    String ministerio = '';
    List<Widget> listaEscala = [];
    switch (departamento) {
      case 'anciaos':
        ministerio = 'Ancionato';
        break;
      case 'recepcao':
        ministerio = 'Recepção';
        break;
      case 'sonoplastia':
        ministerio = 'Sonoplastia';
        break;
      case 'musica':
        ministerio = 'Música';
        break;
      case 'diaconos':
        ministerio = 'Diaconos';
        break;
      case 'diaconisas':
        ministerio = 'Diaconisas';
        break;
      case 'escolaSabatina':
        ministerio = 'Escola Sabatina';
        break;
      case 'mensagemMusical':
        ministerio = 'Mensagem Musical';
        break;
      default:
        ministerio = 'Ministério';
    }
    integrantes.forEach((integrante) {
      listaEscala.add(Chip(label: Text(integrante)));
    });
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        child: Text(ministerio),
      ),
      subtitle: Wrap(
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines
        children: listaEscala.toList(),
      ),
    );
  }

  Widget _generateListCards(BuildContext context, document) {
    List<Widget> listaPrograma = [];
    Map<dynamic, dynamic> escala = document['equipes'];
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
        decoration: BoxDecoration(color: Color(0xFF90979F)),
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

    listaPrograma.add(Divider(
      height: 1.0,
    ));

    if (escala.isNotEmpty) {
      List<Widget> listaEscala = [];
      escala.keys.forEach((key) {
        List<dynamic> integrantes = escala[key];
        listaEscala.add(makeEscala(key, integrantes));
      });
      listaPrograma.add(Container(
          decoration: BoxDecoration(color: Color(0xFFA7B9D1)),
          child: ExpansionTile(
            backgroundColor: Color(0xFFA7B9D1),
            title: Text(
              'Escalas', //.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white),
            ),
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(0.0),
                decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
                child: Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: listaEscala.toList(),
                ),
              ),
            ],
            // children: listaEscala.toList(),
          )));
    }

    if (louvorSize > 0) {
      listaPrograma.addAll(_makeAtividade(louvor, grupoAtividade: 'Louvor'));
    }

    if (esSize > 0) {
      listaPrograma.addAll(
          _makeAtividade(escolaSabatina, grupoAtividade: 'Escola Sabatina'));
    }

    if (extraSize > 0) {
      listaPrograma.addAll(_makeAtividade(extra, grupoAtividade: 'Transição'));
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
            child: Container(
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
          new Positioned( //TODO: use checkbox?
            top: 15.0,
            left: 10.0,
            child: new Container(
              height: 40.0,
              width: 40.0,
              child: new Icon(_icone, color: Colors.white, size: 30.0),
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD32F2F),//Color(0xFFA7B9D1), //Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget _initAppBar(BuildContext context, {document: null}) {
  //   if (document == null) {
  //     return AppBar(
  //       title: Text(_appBarTitle != null ? _appBarTitle : 'Programa'),
  //       backgroundColor: _primary, //Colors.green[600],
  //     );
  //   }
  //   return PreferredSize(
  //     preferredSize: new Size(_size, 20.0),
  //     child: ListTile(
  //       dense: true,
  //       title: Center(
  //         child: Text(
  //           document['nomePrograma'].toString().toUpperCase(),
  //           style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: 24.0,
  //               color: Colors.white),
  //         ),
  //       ),
  //       subtitle: Center(
  //         child: Text(
  //           fn.dataCompleta(document['timestamp']),
  //           style: new TextStyle(fontSize: 16.0, color: Colors.white),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Screen.keepOn(true);
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Programa'),
        backgroundColor: Theme.of(context).primaryColor, //Colors.green[600],
      ),
      body: new StreamBuilder(
        stream: Firestore.instance
            .collection('programas')
            .where('publicado', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
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
