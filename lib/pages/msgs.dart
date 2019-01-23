import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:distrito_app/model/mensagem/mensagem.dart';
import 'package:distrito_app/pages/msg_detalhe.dart';
import 'package:distrito_app/utils/bloc.dart';
import 'package:distrito_app/utils/bloc_provider.dart';
import 'package:distrito_app/utils/globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO: tipos de mídia: imagem, video
class Mensagens extends StatelessWidget {
  Future selecionarIgrejaModal(BuildContext context) async {
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

  Widget _buildListItem(BuildContext context, Mensagem msg, {isIOS: false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MensagemDetalhe(msg: msg)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
        child: new Card(
          // key: new ValueKey(msg.documentID),
          elevation: isIOS ? 1.0 : 2.0,
          child: new Column(
            children: <Widget>[
              new Container(
                constraints: new BoxConstraints.expand(
                  height: 200.0,
                ),
                child: new Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    new CachedNetworkImage(
                      imageUrl: msg.imagem.url,
                      placeholder: Image.asset(
                        'assets/images/placeholder-image.png',
                        fit: BoxFit.cover,
                      ),
                      fit: BoxFit.cover,
                      errorWidget: new Icon(Icons.error),
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
                                    msg.titulo,
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  new Text(
                                    'por ${msg.autor.nome}',
                                    style: new TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0,
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
                  ],
                ),
              ),
              new Padding(
                  padding: new EdgeInsets.all(7.0),
                  child: new Row(
                    children: <Widget>[
                      new Flexible(
                        child: new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Text(
                            msg.passagem,
                            textAlign: TextAlign.justify,
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iosMsgPg(BuildContext context, BlocDados bloc) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.grey[50],
      navigationBar: CupertinoNavigationBar(
        middle: Text('Mensagens'),
      ),
      child: StreamBuilder(
        stream: bloc.mensagens,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return _buildListItem(context,
                    new Mensagem.fromJson(snapshot.data.documents[index].data),
                    isIOS: true);
              });
        },
      ),
    );
  }

  Scaffold _androidMsgPg(BuildContext context, BlocDados bloc) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Mensagens'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
        child: new StreamBuilder(
          stream: bloc.mensagens,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LinearProgressIndicator();
            }
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return _buildListItem(
                      context,
                      new Mensagem.fromJson(
                          snapshot.data.documents[index].data));
                });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final BlocDados bloc = BlocProvider.of<BlocDados>(context);

    if (globals.igreja.isEmpty) {
      selecionarIgrejaModal(context);
    } else if (globals.igreja.isNotEmpty) {
      bloc.selecionarIgreja(globals.igreja);
    }

    // bloc.igreja.listen((hasIgreja) async {
    //   print('Igreja => $hasIgreja');
    // });

    if (isIOS) {
      return _iosMsgPg(context, bloc);
    } else {
      return _androidMsgPg(context, bloc);
    }
  }
}

class CustomCard extends StatelessWidget {
  Future selecionarIgrejaModal(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 2.0,
      child: new Column(
        children: <Widget>[
          new Image.network(
              'https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
          new Padding(
              padding: new EdgeInsets.all(7.0),
              child: new Row(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.all(7.0),
                    child: new Icon(Icons.thumb_up),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(7.0),
                    child: new Text(
                      'Like',
                      style: new TextStyle(fontSize: 18.0),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(7.0),
                    child: new Icon(Icons.comment),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(7.0),
                    child: new Text('Comments',
                        style: new TextStyle(fontSize: 18.0)),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
