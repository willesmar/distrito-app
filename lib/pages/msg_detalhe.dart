import 'package:flutter/material.dart';
import 'package:distrito_app/model/mensagem/autor.dart';
import 'package:html2md/html2md.dart' as html2md;
import '../utils/functions.dart' as fn;
import 'package:distrito_app/model/imagem.dart';

class MensagemDetalhe extends StatelessWidget {
  MensagemDetalhe({this.document});
  final document;
  @override
  Widget build(BuildContext context) {
    String mensagem = document['msg'].toString();
    String markdown = html2md.convert(mensagem);
    Imagem imagem = new Imagem(
        createdAt: '${document['imagem']['createdAt']}',
        nameFile: '${document['imagem']['nameFile']}',
        url: '${document['imagem']['url']}');
    Imagem autorImagem = new Imagem(
        createdAt: '${document['autor']['foto']['createdAt']}',
        nameFile: '${document['autor']['foto']['nameFile']}',
        url: '${document['autor']['foto']['url']}');
    Autor autor = new Autor(
        nome: '${document['autor']['nome']}',
        foto: autorImagem,
        predicado: '${document['autor']['predicado']}');

    return Scaffold(
      appBar: AppBar(
        title: Text(document['titulo']),
      ),
      body: new ListView(
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new ShowImage(imagem: imagem),
              new ShowPassagem(document: document),
              new ShowDate(document: document),
              new ShowMensagem(markdown: markdown),
              new ShowAutor(autor: autor),
            ],
          ),
        ],
      ),
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
  const ShowMensagem({
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
