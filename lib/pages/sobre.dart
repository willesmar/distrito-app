import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:distrito_app/model/imagem.dart';
import 'package:distrito_app/pages/img_full.dart';
import 'package:distrito_app/pages/pastor_detalhe.dart';
import 'package:distrito_app/pages/restart_wdgt.dart';
import 'package:distrito_app/utils/bloc.dart';
import 'package:distrito_app/utils/bloc_provider.dart';
import 'package:distrito_app/utils/custom_icons_icons.dart';
import 'package:distrito_app/utils/globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/contato.dart';

class Sobre extends StatelessWidget {
  Color _cardHeaderColor = Color(0xFF2F557F);
  Color _cardHeaderColorFont = Colors.white;

  _launchMAPS(String lat, String long, {isIOS: false}) async {
    String appleUrl = 'http://maps.apple.com/?ll=${lat},${long}';
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&destination=${lat},${long}';
    String wazeUrl = 'https://waze.com/ul?ll=${lat},${long}&navigate=yes';
    if (!isIOS && await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else if (isIOS && await canLaunch(appleUrl)) {
      await launch(appleUrl);
    } else if (await canLaunch(wazeUrl)) {
      await launch(wazeUrl);
    } else {
      print('Could not launch url');
    }
  }

  IconData _getIcon(String icone) {
    IconData iconeDinamico;
    switch (icone) {
      case 'phone':
        iconeDinamico = Icons.phone;
        break;
      case 'sitemap':
        iconeDinamico = Icons.error;
        break;
      case 'envelope':
        iconeDinamico = Icons.mail_outline;
        break;
      case 'blog':
        iconeDinamico = Icons.error;
        break;
      case 'whatsapp':
        iconeDinamico = CustomIcons.whatsapp;
        break;
      case 'instagram':
        iconeDinamico = CustomIcons.instagram;
        break;
      case 'twitter':
        iconeDinamico = CustomIcons.twitter_squared;
        break;
      case 'facebook':
        iconeDinamico = CustomIcons.facebook_official;
        break;
      case 'youtube':
        iconeDinamico = CustomIcons.youtube_squared;
        break;
      case 'spotify':
        iconeDinamico = CustomIcons.spotify;
        break;
      case 'pinterest':
        iconeDinamico = Icons.error;
        break;
      default:
        iconeDinamico = Icons.error;
    }
    return iconeDinamico;
  }

  Widget topoSobreCard(BuildContext context, Imagem fachada) {
    return new Container(
      constraints: new BoxConstraints.expand(
        height: 300.0,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return ImageFullScreen(imagemUrl: fachada.url);
            },
            fullscreenDialog: true,
          ));
        },
        child: new Stack(fit: StackFit.expand, children: <Widget>[
          new CachedNetworkImage(
            imageUrl: fachada.url,
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
                          'IASD OLIVEIRA III', // XXX: get dynamic name of church, save on backend too
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
    );
  }

  Widget localizacaoSobreCard(sobreObj, {isIOS: false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 3.0),
      child: Card(
        elevation: isIOS ? 1.0 : 2.0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: _cardHeaderColor),
                child: Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Localização',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: _cardHeaderColorFont),
                    ),
                  )
                ]),
              ),
              GestureDetector(
                onTap: () {
                  if (sobreObj['endereco']['coords']['lat'] != null &&
                      sobreObj['endereco']['coords']['long'] != null) {
                    _launchMAPS(sobreObj['endereco']['coords']['lat'],
                        sobreObj['endereco']['coords']['long'],
                        isIOS: isIOS);
                  }
                },
                child: CachedNetworkImage(
                  imageUrl: sobreObj['endereco']['mapa']['url'],
                  placeholder: Image.asset(
                    'assets/images/placeholder-image.png',
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                  errorWidget: new Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 8.0, 12.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${sobreObj['endereco']['rua']}, ${sobreObj['endereco']['numero']} - ${sobreObj['endereco']['bairro']}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '${sobreObj['endereco']['cidade']} - ${sobreObj['endereco']['estado']}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'CEP: ${sobreObj['endereco']['cep']}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  Widget horariosCultosSobreCard(BuildContext context, sobreObj,
      {isIOS: false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
      child: Card(
        elevation: isIOS ? 1.0 : 2.0,
        child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(color: _cardHeaderColor),
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Cultos',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _cardHeaderColorFont),
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child:
                Column(children: _contentCultos(context, sobreObj['cultos'])),
          ),
        ]),
      ),
    );
  }

  List<Widget> _contentCultos(
      BuildContext ctx, LinkedHashMap<String, dynamic> data) {
    List<Widget> arr = [];
    data.forEach((a, b) {
      b.forEach((k, v) {
        if (k != 'dia') {
          arr.add(ListTile(
            title: Text(
              b['dia'],
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _contentAtividadeCultos(ctx, v)),
            ),
          ));
        }
      });
    });
    return arr;
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

  Widget contatosSobreCard(BuildContext context, sobreObj, {isIOS: false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
      child: Card(
        elevation: isIOS ? 1.0 : 2.0,
        child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(color: _cardHeaderColor),
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Contato',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _cardHeaderColorFont),
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: Column(
              children: [
                _contentContato(context, sobreObj['contato']),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _contentContato(
      BuildContext ctx, LinkedHashMap<String, dynamic> data) {
    List<Widget> arr = [];
    data.forEach((a, b) {
      Contato contato = Contato.fromJson(b);
      arr.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
          child: OutlineButton.icon(
            label: Text(
              contato.nome,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
            ),
            icon: Icon(_getIcon(contato.icone)),
            onPressed: () async {
              // print('${contato.url}');
              if (await canLaunch('${contato.url}')) {
                await launch('${contato.url}');
              }
            },
          ),
        ),
      );
    });
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: arr.toList(),
    );
  }

  Widget pastorSobreCard(BuildContext context, sobreObj, {isIOS: false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 6.0),
      child: Card(
        elevation: isIOS ? 1.0 : 2.0,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PastorDetalhe(document: sobreObj['pastor'])));
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: _cardHeaderColor),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Nosso Pastor',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: _cardHeaderColorFont),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundImage:
                        NetworkImage(sobreObj['pastor']['foto']['url']),
                  ),
                  title: Text(sobreObj['pastor']['nome']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(sobreObj['pastor']['predicado']),
                      Text(sobreObj['pastor']['email'])
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> _sobrePageItens(BlocDados bloc, {isIOS: false}) {
    return StreamBuilder(
        stream: bloc.sobre,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          var sobreObj = {};

          snapshot.data.documents.forEach((DocumentSnapshot doc) async {
            var docId = doc.documentID;
            sobreObj[docId] = doc.data;
          });
          Imagem fachada = Imagem.fromJson(sobreObj['fachada']);

          return ListView(children: <Widget>[
            topoSobreCard(context, fachada),
            localizacaoSobreCard(sobreObj, isIOS: isIOS),
            horariosCultosSobreCard(context, sobreObj, isIOS: isIOS),
            contatosSobreCard(context, sobreObj, isIOS: isIOS),
            pastorSobreCard(context, sobreObj, isIOS: isIOS),
          ]);
        });
  }

  CupertinoPageScaffold _iosSobrePage(BuildContext context, BlocDados bloc) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Sobre'),
        trailing: CupertinoButton(
            color: Colors.transparent,
            minSize: 35.0,
            padding: EdgeInsets.all(0.0),
            child: Icon(
                IconData(0xf459,
                    fontFamily: 'CupertinoIcons',
                    fontPackage: 'cupertino_icons'),
                size: 30.0),
            onPressed: () {
              _deletePrefs(context);
            }),
      ),
      child: _sobrePageItens(bloc, isIOS: true),
    );
  }

  _deletePrefs(BuildContext context) async {
    print('_deletePrefs');
    final SharedPreferences prefs = await globals.sprefs;
    await prefs.remove('igreja');
    return RestartWidget.restartApp(context);
//    runApp(DistritoApp());
//    Navigator.of(context).pushReplacement(MaterialPageRoute(
//        builder: (context) => MyTabs(igreja: value.toString())));
//    return ActionSheetIgreja();
//    return "OK";
  }

  Scaffold _androidSobrePage(BuildContext context, BlocDados bloc) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Sobre'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_balance), //TODO: escolher icon melhor
            onPressed: () {
              _deletePrefs(context);
            },
          ),
        ],
      ),
      body: _sobrePageItens(bloc),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    // final bloc = Provider.of(context);
    final BlocDados bloc = BlocProvider.of<BlocDados>(context);

    if (isIOS) {
      _cardHeaderColor = CupertinoColors.inactiveGray;
      _cardHeaderColorFont = Colors.white;
      return _iosSobrePage(context, bloc);
    } else {
      return _androidSobrePage(context, bloc);
    }
  }
}
