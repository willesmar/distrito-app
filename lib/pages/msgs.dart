import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/functions.dart' as fn;
import './msg_detalhe.dart';

class Mensagens extends StatelessWidget {
  // final List cards = new List.generate(20, (i) => new CustomCard()).toList();

  _buildListItem(BuildContext context, DocumentSnapshot document) {
    final img = document['imagem'];
    final imgUrl = img['url'];
    return new GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MensagemDetalhe(document: document)));
      }, //=> debugPrint(document['titulo']),
      child: new Card(
        key: new ValueKey(document.documentID),
        elevation: 2.0,
        child: new Column(
          children: <Widget>[
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
                    fn.dataPorExtenso(document['timestamp']),
                    style: new TextStyle(fontSize: 16.0),
                  )),
                ],
              ),
            ),
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
                child: new Text(document.data['titulo'],
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.white,
                      decorationColor: Colors.red,
                    )),
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
                          document['passagem'],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Mensagens'),
        backgroundColor: Colors.green[800],
      ),
      body: new StreamBuilder(
        stream: Firestore.instance
            .collection('mensagens')
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

// _buildListItem(BuildContext context, DocumentSnapshot document) {
//   return new ListTile(
//     key: new ValueKey(document.documentID),
//     title: new Container(
//       decoration: new BoxDecoration(
//         border: new Border.all(color: const Color(0x80000000)),
//         borderRadius: new BorderRadius.circular(5.0),
//       ),
//       padding: const EdgeInsets.all(10.0),
//       child: new Row(
//         children: <Widget>[
//           new Expanded(
//             child: new Text(document['igreja']),
//           ),
//           new Text(
//             document['votes'].toString(),
//           )
//         ],
//       ),
//     ),
//   );
// }

class CustomCard extends StatelessWidget {
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
