import 'package:distrito_app/model/atividade.dart';
import 'package:distrito_app/model/programa.dart';
import 'package:distrito_app/pages/notify_button_wdg.dart';
import 'package:distrito_app/utils/bloc_provider.dart';
import 'package:distrito_app/utils/programa_notification_bloc.dart';
import 'package:distrito_app/widgets/app_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

import '../utils/functions.dart' as fn;
import '../utils/bloc.dart';

// TODO: titulo com nome do programa, data completa abaixo OK
// TODO: aba/collapse de escala OK
// TODO: onClick mark as completed TRY
// TODO: criar aba de transição/extras OK
class Programa extends StatefulWidget {
  @override
  ProgramaState createState() => new ProgramaState();
}

class ProgramaState extends State<Programa> {
  ScrollController _scrollViewController;
  bool _toggle = false;
  Color _corCirculoTimeline = Color(0xFFA7B9D1);
  Color topColor = Color(0xFF2F557F);

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _toggle = false;
    _corCirculoTimeline = Color(0xFFA7B9D1);
    // Screen.keepOn(true);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    Screen.keepOn(false);
    _toggle = false;
    _corCirculoTimeline = Color(0xFFA7B9D1);
    super.dispose();
  }

  List<Widget> _makeAtividade(List<Atividade> atividade,
      {String grupoAtividade: null}) {
    List<Widget> listaAtividade = [];
    List<Widget> listaRetornada = [];
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    for (var i = 0; i < atividade.length; i++) {
      listaAtividade.add(_buildCard(context, atividade[i]));
    }

    if (grupoAtividade != null) {
      listaRetornada.add(Container(
          decoration: BoxDecoration(color: isIOS ? Colors.grey[200] : topColor),
          child: ExpansionTile(
            initiallyExpanded: true,
            backgroundColor: isIOS ? Colors.grey[200] : topColor,
            title: Text(
              grupoAtividade.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: isIOS ? Colors.grey[900] : Colors.white),
            ),
            children: listaAtividade.toList(),
          )));
    } else {
      listaRetornada = listaAtividade;
    }

    return listaRetornada;
  }

  Widget makeEscala(String departamento, List<String> integrantes) {
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
      listaEscala.add(Chip(
        label: Text(
          integrante,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFF3E8391).withOpacity(0.3),
      ));
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

  Widget _generateListCards(BuildContext context, ProgramaModel prgrm) {
    List<Widget> listaPrograma = [];
    Map<dynamic, dynamic> escala = prgrm.equipes;
    num louvorSize = prgrm.louvor.length;
    num esSize = prgrm.escolaSabatina.length;
    num extraSize = prgrm.extra.length;
    num cultoSize = prgrm.culto.length;
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    listaPrograma.add(
      Container(
        decoration: BoxDecoration(color: isIOS ? Colors.grey[200] : topColor),
        padding: EdgeInsets.only(top: 8.0),
        child: ListTile(
          dense: true,
          title: Center(
            child: Text(
              prgrm.nomePrograma.toString().toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: isIOS ? Colors.grey[900] : Colors.white),
            ),
          ),
          subtitle: Center(
            child: Text(
              fn.dataCompleta(prgrm.timestamp),
              style: new TextStyle(
                  fontSize: 16.0,
                  color: isIOS ? Colors.grey[900] : Colors.white),
            ),
          ),
        ),
      ),
    );

    if (escala != null) {
      List<Widget> listaEscala = [];
      escala.keys.forEach((key) {
        List<String> integrantes = escala[key].cast<String>();
        listaEscala.add(makeEscala(key, integrantes));
      });
      listaPrograma.add(Container(
          decoration: BoxDecoration(color: isIOS ? Colors.grey[200] : topColor),
          child: ExpansionTile(
            initiallyExpanded: false,
            backgroundColor: isIOS ? Colors.grey[100] : topColor,
            title: Text(
              'Escalas',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: isIOS ? Colors.grey[900] : Colors.white),
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
          )));
    }

    if (louvorSize > 0) {
      listaPrograma
          .addAll(_makeAtividade(prgrm.louvor, grupoAtividade: 'Louvor'));
    }

    if (esSize > 0) {
      listaPrograma.addAll(_makeAtividade(prgrm.escolaSabatina,
          grupoAtividade: 'Escola Sabatina'));
    }

    if (extraSize > 0) {
      listaPrograma
          .addAll(_makeAtividade(prgrm.extra, grupoAtividade: 'Transição'));
    }

    if (cultoSize > 0) {
      listaPrograma
          .addAll(_makeAtividade(prgrm.culto, grupoAtividade: 'Culto'));
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

  TextStyle _formatResponsavelDuracaoTituloText() {
    return TextStyle(fontSize: 10.0, color: Colors.grey[600]);
  }

  TextStyle _formatResponsavelDuracaoText() {
    return TextStyle(fontSize: 14.0, color: Colors.grey[800]);
  }

  Widget _buildCard(BuildContext context, document) {
    IconData _icone = _getIcon(document.icone);
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Card(
          color: Colors.grey[100],
          clipBehavior: Clip.antiAlias,
          elevation: isIOS ? 0.3 : 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 2,
                // fit: FlexFit.tight,
                child: Container(
                  color: isIOS
                      ? Colors.grey[400]
                      : Color(0xFF3E8391).withOpacity(0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child:
                                  Icon(_icone, color: Colors.white, size: 26.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              // color: Colors.yellowAccent,
                              child: Center(
                                child: Text(
                                  '${document.hInicio}',
                                  style: TextStyle(
                                    fontFamily: 'Digital-7',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 8,
                fit: FlexFit.tight,
                child: Container(
                  // color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                child: Text(
                                  document.nomeAtividade,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'DURAÇÃO',
                                      style:
                                          _formatResponsavelDuracaoTituloText(),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '${document.duracao} min',
                                      style: _formatResponsavelDuracaoText(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            _getFimAtividade(document.hFim),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'RESPONSÁVEL',
                                      style:
                                          _formatResponsavelDuracaoTituloText(),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      document.responsavel,
                                      style: _formatResponsavelDuracaoText(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // return Container(
    //   decoration: BoxDecoration(color: Colors.white),
    //   child: new Stack(
    //     children: <Widget>[
    //       new Padding(
    //         padding: const EdgeInsets.only(left: 45.0),
    //         child: Container(
    //           width: double.infinity,
    //           child: Padding(
    //             padding: const EdgeInsets.fromLTRB(4.0, 8.0, 12.0, 8.0),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               mainAxisSize: MainAxisSize.max,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Padding(
    //                   padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 3.0),
    //                   child: Text(
    //                     document.nomeAtividade,
    //                     style: TextStyle(
    //                         fontSize: 16.0, fontWeight: FontWeight.w500),
    //                   ),
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   mainAxisSize: MainAxisSize.max,
    //                   children: <Widget>[
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 8.0, right: 3.0),
    //                       child: Icon(
    //                         Icons.schedule,
    //                         size: 14.0,
    //                       ),
    //                     ),
    //                     Text(
    //                       '${document.hInicio} - ${document.duracao} min',
    //                       style: TextStyle(fontSize: 14.0),
    //                     ),
    //                     Padding(
    //                       padding:
    //                           const EdgeInsets.only(left: 10.0, right: 3.0),
    //                       child: Icon(
    //                         Icons.person,
    //                         size: 14.0,
    //                       ),
    //                     ),
    //                     Text(
    //                       document.responsavel,
    //                       style: TextStyle(fontSize: 14.0),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       new Positioned(
    //         top: 0.0,
    //         bottom: 0.0,
    //         left: 30.0,
    //         child: new Container(
    //           height: double.infinity,
    //           width: 1.0,
    //           color: Color(0xFFBACEE6),
    //         ),
    //       ),
    //       new Positioned(
    //         //TODO: use checkbox?
    //         top: 15.0,
    //         left: 10.0,
    //         child: new Container(
    //           height: 40.0,
    //           width: 40.0,
    //           child: new Icon(_icone, color: Colors.white, size: 30.0),
    //           decoration: new BoxDecoration(
    //             shape: BoxShape.circle,
    //             color: Color(0xFFA7B9D1),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget _getFimAtividade(String hFim) {
    Size screen = MediaQuery.of(context).size;
    // print(screen.width);
    if (screen.width >= 360.0) {
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'FINAL',
                style: _formatResponsavelDuracaoTituloText(),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                '${hFim}',
                style: _formatResponsavelDuracaoText(),
              )
            ],
          ),
        ],
      );
    }
    return Container();
  }

  // @override
  // Widget build(BuildContext context) {
  //   final bloc = Provider.of(context);
  //   Screen.keepOn(true);
  //   return new Scaffold(
  //     resizeToAvoidBottomPadding: true,
  //     // appBar: AppBar(
  //     //   title: new Text('Programa'),
  //     // ),
  //     body: NestedScrollView(
  //       controller: _scrollViewController,
  //       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
  //         return <Widget>[
  //           SliverAppBar(
  //             title: Text('Programa'),
  //             pinned: false,
  //             floating: true,
  //             forceElevated: true,
  //           ),
  //         ];
  //       },
  //       body: StreamBuilder(
  //         stream: bloc.programas,
  //         builder: (context, snapshot) {
  //           if (!snapshot.hasData) {
  //             return LinearProgressIndicator();
  //           }
  //           return new ListView.builder(
  //             padding: EdgeInsets.only(top: 0.0),
  //               itemCount: 1,
  //               itemBuilder: (context, index) {
  //                 return _generateListCards(
  //                     context,
  //                     new ProgramaModel.fromJson(
  //                         snapshot.data.documents.first.data));
  //               });
  //         },
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    // bool _notify = false;
    final bloc = Provider.of(context);
    Screen.keepOn(true);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppTabBar(
          title: Text('Programação'),
          context: context,
          actions: <Widget>[
            BlocProvider<ProgramaNotificationBloc>(
              bloc: ProgramaNotificationBloc(),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: NotificarButtonWidget(),
              ),
            ),
          ]),
      body: new StreamBuilder(
        stream: bloc.programas,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          return new ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return _generateListCards(
                    context,
                    new ProgramaModel.fromJson(
                        snapshot.data.documents.first.data));
              });
        },
      ),
    );
  }
}
