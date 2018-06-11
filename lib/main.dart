import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Firebase',
      home: const MyHomePage(title: 'Test Firebase teste'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  _buildListItem(BuildContext context, DocumentSnapshot document) {
    // return new ListTile(
    //   key: new ValueKey(document.documentID),
    //   title: new Container(
    //     decoration: new BoxDecoration(
    //       border: new Border.all(color: const Color(0x80000000)),
    //       borderRadius: new BorderRadius.circular(5.0),
    //     ),
    //     padding: const EdgeInsets.all(10.0),
    //     child: new Row(
    //       children: <Widget>[
    //         new Expanded(
    //           child: new Text(document['igreja']),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    final img = document['imagem'];
    final imgUrl = img['url'];
    return new Card(
      key: new ValueKey(document.documentID),
      elevation: 2.0,
      child: new Column(
        children: <Widget>[
          new Image.network(
              '$imgUrl'),
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
              )),
          new Padding(
            padding: new EdgeInsets.all(7.0),
            child: new Row(children: <Widget>[
              new Padding(
                padding: new EdgeInsets.all(7.0),
                child:
                    new Text(document['titulo'], style: new TextStyle(fontSize: 18.0)),
              )
            ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(title)),
      body: new StreamBuilder(
        stream: Firestore.instance.collection('mensagens').where('publicado', isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Carregando...');
          // print(snapshot.data.documents[0]['igreja']);
          // return new Text('data');
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              //padding: const EdgeInsets.only(top: 10.0),
              //itemExtent: 55.0,
              itemBuilder: (context, index) {
                // print(index);
                return _buildListItem(context, snapshot.data.documents[index]);
              });
        },
      ),
    );
  }
}

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
