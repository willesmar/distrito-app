import 'dart:collection';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:distrito_app/utils/custom_icons_icons.dart';
import './img_full.dart';
import '../utils/bloc.dart';
import '../model/imagem.dart';
import './pastor_detalhe.dart';

class Contato {
  String icone;
  String nome;
  String url;

  Contato({this.icone, this.nome, this.url});

  factory Contato.fromJson(Map<dynamic, dynamic> json) {
    return new Contato(
      icone: json['icone'],
      nome: json['nome'],
      url: json['url'],
    );
  }
}

class Sobre extends StatelessWidget {

  final Color _cardHeaderColor = Color(0xFF2F557F);

  _launchMAPS(String lat, String long) async {
    String appleUrl = 'http://maps.apple.com/?ll=${lat},${long}';
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&destination=${lat},${long}';
    String wazeUrl = 'https://waze.com/ul?ll=${lat},${long}&navigate=yes';
    if (Platform.isAndroid && await canLaunch(googleUrl)) {
      print('launching com googleUrl'); // XXX:
      await launch(googleUrl);
    } else if (Platform.isIOS && await canLaunch(appleUrl)) {
      print('launching apple url'); // XXX:
      await launch(appleUrl);
    } else if (await canLaunch(wazeUrl)) {
      print('launching waze url'); // XXX:
      await launch(wazeUrl);
    } else {
      print(lat); // XXX:
      print(long); // XXX:
      print('Could not launch url');
    }
  }

  IconData _getIcon(String icone) {
    IconData iconeDinamico;
    switch (icone) {
      case 'phone':
        iconeDinamico = Icons.phone;
        break;
      case 'mail':
        iconeDinamico = Icons.mail_outline;
        break;
      case 'facebook':
        iconeDinamico = CustomIcons.facebook_official;
        break;
      case 'instagram':
        iconeDinamico = CustomIcons.instagram;
        break;
      case 'youtube':
        iconeDinamico = CustomIcons.youtube_squared;
        break;
      case 'whatsapp':
        iconeDinamico = CustomIcons.whatsapp;
        break;
      case 'twitter':
        iconeDinamico = CustomIcons.twitter_squared;
        break;
      case 'spotify':
        iconeDinamico = CustomIcons.spotify;
        break;
      default:
        iconeDinamico = Icons.face;
    }
    return iconeDinamico;
  }

  // var arr = [];
  // data.forEach((a, b) {
  //   debugPrint('a $a');
  //   debugPrint('b $b');
  //   arr.add(b);
  // });
  // debugPrint(imagemFachada.url);
  // data.values.map((i) => debugPrint(i));

  Widget topoSobreCard(BuildContext context, Imagem fachada) {
    return new Container(
      constraints: new BoxConstraints.expand(
        height: 300.0,
      ),
      child: GestureDetector(
        onTap: () {
          // debugPrint('tap imagem sobre');
          Navigator.of(context).push(MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return ImageFullScreen(imagemUrl: fachada.url);
            },
            fullscreenDialog: true,
          ));
        },
        child: new Stack(fit: StackFit.expand, children: <Widget>[
          // new Image.network(fachada.url, fit: BoxFit.cover),
          new CachedNetworkImage(
            imageUrl: fachada.url,
            placeholder: Image.asset('assets/images/placeholder-image.png', fit: BoxFit.cover,),
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

  // Widget getFachadaImg(BuildContext ctx, LinkedHashMap<String, dynamic> data) {
  //   Imagem imagemFachada = Imagem.fromJson(data);
  //   return Image.network(imagemFachada.url, fit: BoxFit.cover);
  // }

  Widget localizacaoSobreCard(sobreObj) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 3.0),
      child: Card(
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
                          color: Colors.white),
                    ),
                  )
                ]),
              ),
              GestureDetector(
                onTap: () {
                  if (sobreObj['endereco']['coords']['lat'] != null &&
                      sobreObj['endereco']['coords']['long'] != null) {
                    _launchMAPS(sobreObj['endereco']['coords']['lat'],
                        sobreObj['endereco']['coords']['long']);
                  }
                },
                child:
                    // Image.network(
                    //   sobreObj['endereco']['mapa']['url'],
                    //   fit: BoxFit.cover,
                    // ),
                    CachedNetworkImage(
                  imageUrl: sobreObj['endereco']['mapa']['url'],
                  placeholder:
                      Image.asset('assets/images/placeholder-image.png', fit: BoxFit.cover,),
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

  Widget horariosCultosSobreCard(BuildContext context, sobreObj) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
      child: Card(
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
                      color: Colors.white),
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

  Widget contatosSobreCard(BuildContext context, sobreObj) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
      child: Card(
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
                      color: Colors.white),
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
            ), // TODO:
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

  Widget pastorSobreCard(BuildContext context, sobreObj) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 6.0),
      child: Card(
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
                            color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text('Sobre'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder(
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
              localizacaoSobreCard(sobreObj),
              horariosCultosSobreCard(context, sobreObj),
              contatosSobreCard(context, sobreObj),
              pastorSobreCard(context, sobreObj),
            ]);
          }),
    );
  }
}
