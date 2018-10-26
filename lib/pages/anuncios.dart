import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/functions.dart' as fn;
import './anuncio_detalhe.dart';
import '../utils/bloc.dart';

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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
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
                  // new Image.network(imgUrl, fit: BoxFit.cover),
                  // FadeInImage.assetNetwork(
                  //     placeholder: 'assets/images/placeholder-image.png',
                  //     image: imgUrl,
                  //     fit: BoxFit.cover,
                  //   ),
                  new CachedNetworkImage(
                      imageUrl: imgUrl,
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
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      '${fn.dataPorExtensoAbreviada(document.data['cronograma'][0]['timestamp'])} ${document.data['cronograma'].length > 1 ? 'à': ''} ${document.data['cronograma'].length > 1 ? fn.dataPorExtensoAbreviada(document.data['cronograma'][document.data['cronograma'].length - 1]['timestamp']) : '' }',
                      style: new TextStyle(fontSize: 16.0),
                    )),
                  ],
                ),
              ),
              new Row(
                children: <Widget>[
                  new Flexible(
                    child: new Padding(
                      padding: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text('Comunicação'),
        backgroundColor: Theme.of(context).primaryColor, //Colors.green[600],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
        child: new StreamBuilder(
          // stream: Firestore.instance
          //     .collection('anuncios')
          //     .where('publicado', isEqualTo: true)
          //     .snapshots(),
          stream: bloc.anuncios,
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
      ),
    );
  }
}
