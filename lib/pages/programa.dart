import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:distrito_app/model/atividade.dart';
import 'package:distrito_app/model/programa.dart';
import 'package:distrito_app/pages/notify_button_wdg.dart';
import 'package:distrito_app/utils/bloc_provider.dart';
import 'package:distrito_app/utils/programa_notification_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

import '../utils/bloc.dart';
import '../utils/functions.dart' as fn;

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
  Color _topColor = Colors.blueGrey[200]; //Color(0xFF2F557F);
  Color _fontTopColor = Colors.black87;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _toggle = false;
    _corCirculoTimeline = Color(0xFFA7B9D1);
    Screen.keepOn(true);
  }

  @override
  void dispose() {
    Screen.keepOn(false);
    _scrollViewController.dispose();
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
          decoration: BoxDecoration(color: _topColor),
          child: ExpansionTile(
            initiallyExpanded: true,
            backgroundColor: _topColor,
            title: Text(
              grupoAtividade.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: _fontTopColor),
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
      listaEscala.add(Material(
        child: Chip(
          label: Text(
            integrante,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: _topColor.withOpacity(0.3),
        ),
      ));
    });
    return Material(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
          child: Text(ministerio),
        ),
        subtitle: Wrap(
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 4.0, // gap between lines
          children: listaEscala.toList(),
        ),
      ),
    );
  }

  Widget _generateListCards(BuildContext context, ProgramaModel prgrm,
      {isIOS: false}) {
    List<Widget> listaPrograma = [];
    Map<dynamic, dynamic> escala = prgrm.equipes;
    num louvorSize = prgrm.louvor.length;
    num esSize = prgrm.escolaSabatina.length;
    num extraSize = prgrm.extra.length;
    num cultoSize = prgrm.culto.length;
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    listaPrograma.add(
      Material(
        child: Container(
          decoration: BoxDecoration(color: _topColor),
          padding: EdgeInsets.only(top: 8.0),
          child: ListTile(
            dense: true,
            title: Center(
              child: Text(
                prgrm.nomePrograma.toString().toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: _fontTopColor),
              ),
            ),
            subtitle: Center(
              child: Text(
                fn.dataCompleta(prgrm.timestamp),
                style: new TextStyle(
                    fontSize: 16.0,
                    color: _fontTopColor),
              ),
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
      listaPrograma.add(Material(
        child: Container(
            decoration:
                BoxDecoration(color: _topColor),
            child: ExpansionTile(
              initiallyExpanded: false,
              backgroundColor: _topColor,
              title: Text(
                'Escalas',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: _fontTopColor),
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
            )),
      ));
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
    return Material(
      child: Column(
        children: listaPrograma,
      ),
    );
  }

  // IconData _getIcon(String icone) {
  //   switch (icone) {
  //     case 'musical-notes':
  //       return Icons.music_note;
  //       break;
  //     case 'musical-note':
  //       return Icons.music_note;
  //       break;
  //     case 'microphone':
  //       return Icons.mic;
  //       break;
  //     case 'film':
  //       return Icons.ondemand_video;
  //       break;
  //     case 'people':
  //       return Icons.person;
  //       break;
  //     case 'person':
  //       return Icons.person;
  //       break;
  //     default:
  //       return Icons.announcement;
  //   }
  // }
  IconData _getIcon(String icone) {
    switch (icone) {
      case 'musical-notes':
        return IconData(0xe900, fontFamily: 'icomoon');
        break;
      case 'musical-note':
        return IconData(0xe911, fontFamily: 'icomoon'); // e900
        break;
      case 'microphone':
        return Icons.mic;
        break;
      case 'film':
        return Icons.ondemand_video;
        break;
      case 'people':
        return IconData(0xe90a, fontFamily: 'icomoon');
        break;
      case 'person':
        return Icons.person;
        break;
      case 'praying-hands':
        return IconData(0xe904, fontFamily: 'icomoon');
        break;
      case 'bullhorn':
        return IconData(0xe901, fontFamily: 'icomoon');
        break;
      case 'bible':
        return IconData(0xe905, fontFamily: 'icomoon');
        break;
      case 'cross':
        return IconData(0xe908, fontFamily: 'icomoon');
        break;
      case 'church':
        return IconData(0xe906, fontFamily: 'icomoon');
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
          color: Colors.grey[50],
          clipBehavior: Clip.antiAlias,
          elevation: isIOS ? 0.3 : 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    color: _topColor.withOpacity(0.3),//Color(0xFF3E8391).withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child:
                                  Icon(_icone, color: Colors.black, size: 20.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  '${document.hInicio}',
                                  style: TextStyle(
                                    fontFamily: 'Digital-7',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
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
                Flexible(
                  flex: 8,
                  fit: FlexFit.tight,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Column(
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
                          // Divider(),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
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

  StreamBuilder<QuerySnapshot> _programaPageListItens(BlocDados bloc,
      {isIOS: false}) {
    return StreamBuilder(
      stream: bloc.programas,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }
        return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return _generateListCards(context,
                  ProgramaModel.fromJson(snapshot.data.documents.first.data),
                  isIOS: isIOS);
            });
      },
    );
  }

  BlocProvider<ProgramaNotificationBloc> _makeProgramaNotificationSubs() {
    return BlocProvider<ProgramaNotificationBloc>(
      bloc: ProgramaNotificationBloc(),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: NotificarButtonWidget(),
      ),
    );
  }

  BlocProvider<ProgramaNotificationBloc>
      _makeAndroidProgramaNotificationSubs() {
    return BlocProvider<ProgramaNotificationBloc>(
        bloc: ProgramaNotificationBloc(),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: NotificarButtonWidget(),
        ));
  }

  CupertinoPageScaffold _iosProgramaPage(BuildContext context, BlocDados bloc) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Programação'),
        trailing: _makeProgramaNotificationSubs(),
      ),
      child: _programaPageListItens(bloc, isIOS: true), // isIOS: true),
    );
  }

  Scaffold _androidProgramaPage(BuildContext context, BlocDados bloc) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('Programação'), actions: <Widget>[
        _makeAndroidProgramaNotificationSubs(),
      ]),
      body: _programaPageListItens(bloc),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final BlocDados bloc = BlocProvider.of<BlocDados>(context);
    Screen.keepOn(true);
    if (isIOS) {
      return _iosProgramaPage(context, bloc);
    } else {
      return _androidProgramaPage(context, bloc);
    }
  }
}
