import 'package:distrito_app/model/imagem.dart';
import 'package:distrito_app/model/mensagem/autor.dart';
import 'package:distrito_app/model/mensagem/mensagem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html2md/html2md.dart' as html2md;

import './image_wrapper.dart';
import '../utils/functions.dart' as fn;

class MensagemDetalhe extends StatelessWidget {
  MensagemDetalhe({this.msg});
  final Mensagem msg;
  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    String mensagem = msg.msg.toString();
    String markdown = html2md.convert(mensagem);

    if (isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(msg.titulo),
        ),
        child: new _pageItens(msg: msg, markdown: markdown),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(msg.titulo),
        ),
        body: new _pageItens(msg: msg, markdown: markdown),
      );
    }
  }
}

class _pageItens extends StatelessWidget {
  const _pageItens({
    Key key,
    @required this.msg,
    @required this.markdown,
  }) : super(key: key);

  final Mensagem msg;
  final String markdown;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new ShowImage(imagem: msg.imagem),
            new ShowPassagem(passagem: msg.passagem),
            new ShowDate(timestamp: msg.timestamp),
            new ShowMensagem(markdown: markdown),
            new ShowAutor(autor: msg.autor),
          ],
        ),
      ],
    );
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

class ShowMensagem extends StatelessWidget {
  final String markdown;
  const ShowMensagem({
    Key key,
    @required this.markdown,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: new Text(
        this.markdown,
        textAlign: TextAlign.justify,
        style: new TextStyle(fontSize: 16.0),
      ),
    );
  }
}

class ShowDate extends StatelessWidget {
  const ShowDate({
    Key key,
    @required this.timestamp,
  }) : super(key: key);

  final int timestamp;

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
            fn.dataPorExtenso(timestamp),
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
    @required this.passagem,
  }) : super(key: key);

  final String passagem;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(12.0),
      child: new Text(
        passagem,
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
    return ImageWrapper(
      imagemUrl: imagem.url,
    );
  }
}
