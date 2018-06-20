import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:html2md/html2md.dart' as html2md;
import '../utils/functions.dart' as fn;
import './anuncio_detalhe.dart';

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
    String descricaoMarkdown = html2md.convert(descricao);

    return new GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnuncioDetalhe(document: document)));
      },
      child: new Card(
        key: new ValueKey(document.documentID),
        elevation: 2.0,
        child: new Column(
          children: <Widget>[
            new Container(
              constraints: new BoxConstraints.expand(
                height: 200.0,
              ),
              child: new Stack(fit: StackFit.expand, children: <Widget>[
                new Image.network(imgUrl, fit: BoxFit.cover),
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
                                document.data['nome'],
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
            new Row(
              children: <Widget>[
                new Flexible(
                  child: new Padding(
                    padding: new EdgeInsets.all(12.0),
                    child: new Text(
                      descricaoMarkdown,
                      textAlign: TextAlign.justify,
                      style: new TextStyle(fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
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
