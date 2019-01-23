import 'package:cached_network_image/cached_network_image.dart';
import 'package:distrito_app/model/imagem.dart';
import 'package:distrito_app/model/mensagem/autor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html2md/html2md.dart' as html2md;

import './img_full.dart';
import '../utils/functions.dart' as fn;

class PastorDetalhe extends StatelessWidget {
  final document;

  PastorDetalhe({this.document});

  ListView _pastorDetalheItens(BuildContext context, String markdown) {
    return new ListView(
      children: <Widget>[
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              constraints: new BoxConstraints.expand(
                height: 350.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return ImageFullScreen(
                          imagemUrl: document['foto']['url']);
                    },
                    fullscreenDialog: true,
                  ));
                },
                child: new Stack(fit: StackFit.expand, children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: document['foto']['url'],
                    placeholder:
                        Image.asset('assets/images/placeholder-image.png'),
                    fit: BoxFit.cover,
                    errorWidget: new Icon(Icons.error),
                  ),
                  Positioned(
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
                                  '${document['nome']}',
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
            ),
            new ShowBiografia(markdown: markdown),
          ],
        ),
      ],
    );
  }

  _iosPastorDetalhe(BuildContext context, String markdown) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Programação'),
      ),
      child: _pastorDetalheItens(context, markdown),
    );
  }

  Scaffold _androidPastorDetalhe(BuildContext context, String markdown) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Nosso Pastor'),
      ),
      body: _pastorDetalheItens(context, markdown),
    );
  }

  @override
  Widget build(BuildContext context) {
    String biografia = document['biografia'].toString();
    String markdown = html2md.convert(biografia);
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      return _iosPastorDetalhe(context, markdown);
    } else {
      return _androidPastorDetalhe(context, markdown);
    }
  }
}

class ShowAutor extends StatelessWidget {
  const ShowAutor({
    Key key,
    @required this.autor,
  }) : super(key: key);

  final Autor autor;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new CircleAvatar(
          backgroundImage: new NetworkImage(autor.foto.url),
        ),
        new Padding(
          padding: const EdgeInsets.all(12.0),
          child: new Column(
            children: <Widget>[
              new Text(
                autor.nome,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              new Text(
                autor.predicado,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ShowBiografia extends StatelessWidget {
  const ShowBiografia({
    Key key,
    @required this.markdown,
  }) : super(key: key);

  final String markdown;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(12.0),
      child: new Text(
        markdown,
        textAlign: TextAlign.justify,
        style: new TextStyle(fontSize: 16.0),
      ),
    );
  }
}

class ShowDate extends StatelessWidget {
  const ShowDate({
    Key key,
    @required this.document,
  }) : super(key: key);

  final document;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: new Icon(
              Icons.calendar_today,
              size: 16.0,
            ),
          ),
          new Text(
            fn.dataPorExtenso(document['timestamp']),
            style: new TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class ShowPassagem extends StatelessWidget {
  const ShowPassagem({
    Key key,
    @required this.document,
  }) : super(key: key);

  final document;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(12.0),
      child: new Text(
        document['passagem'],
        textAlign: TextAlign.justify,
        style: new TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
      ),
    );
  }
}

class ShowImage extends StatelessWidget {
  const ShowImage({
    Key key,
    @required this.imagem,
  }) : super(key: key);

  final Imagem imagem;

  @override
  Widget build(BuildContext context) {
    return new Image.network(imagem.url, fit: BoxFit.cover);
  }
}
