import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Programa extends StatefulWidget {
  @override
  ProgramaState createState() => new ProgramaState();
}

class ProgramaState extends State<Programa> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildListCards(BuildContext context, DocumentSnapshot document) {
    return new Stack(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: new Card(
            margin: new EdgeInsets.all(20.0),
            child: new Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.green,
            ),
          ),
        ),
        new Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 35.0,
          child: new Container(
            height: double.infinity,
            width: 1.0,
            color: Colors.blue,
          ),
        ),
        new Positioned(
          top: 100.0,
          left: 15.0,
          child: new Container(
            height: 40.0,
            width: 40.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: new Container(
              margin: new EdgeInsets.all(5.0),
              height: 30.0,
              width: 30.0,
              decoration:
                  new BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Programa'),
        backgroundColor: Theme.of(context).primaryColor, //Colors.green[600],
      ),
      body: new StreamBuilder(
        stream: Firestore.instance
            .collection('programas')
            .where('publicado', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return _buildListCards(context, snapshot.data.documents[index]);
                // debugPrint(snapshot.data.documents.length.toString());
              });
        },
      ),
    );
  }
}
