import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/functions.dart' as fn;

class Anuncios extends StatefulWidget {
  @override
  AnunciosState createState() => new AnunciosState();
}

class AnunciosState extends State<Anuncios> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildListItem(BuildContext context, DocumentSnapshot document) {
    final img = document['imagem'];
    final imgUrl = img['url'];
    String descricao = document['descricao'].toString();
    descricao = descricao.replaceAll(new RegExp('<.*?>'), '');
    descricao = descricao.replaceAll(new RegExp('&nbsp;'), ' ');
    descricao = descricao.replaceAll(new RegExp('&otilde;'), 'õ');
    descricao = descricao.replaceAll(new RegExp('&ccedil;'), 'ç');
    descricao = descricao.replaceAll(new RegExp('&atilde;'), 'ã');
    debugPrint(descricao);
    return new Card(
      key: new ValueKey(document.documentID),
      elevation: 2.0,
      child: new Column(
        children: <Widget>[
          new Container(
            constraints: new BoxConstraints.expand(
              height: 200.0,
            ),
            alignment: Alignment.bottomLeft,
            padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(imgUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: new Container(
              child: new Text(document.data['nome'],
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.white,
                    decorationColor: Colors.red,
                  )),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Row(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: new Icon(
                    Icons.calendar_today,
                    size: 16.0,
                  ),
                ),
                new Expanded(
                    child: new Text(
                  'data', //fn.dataPorExtenso(document['timestamp']),
                  style: new TextStyle(fontSize: 16.0),
                )),
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new RichText(
              text: new TextSpan(
                text: 'Hello ',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  new TextSpan(
                      text: 'bold',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new TextSpan(text: ' world!'),
                ],
              ),
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
                        descricao,
                        textAlign: TextAlign.justify,
                        style: new TextStyle(fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Comunicação'),
        backgroundColor: Colors.green[600],
      ),
      body: new StreamBuilder(
        stream: Firestore.instance
            .collection('anuncios')
            .where('publicado', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Carregando...');
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return _buildListItem(context, snapshot.data.documents[index]);
              });
        },
      ),
    );
  }
}
