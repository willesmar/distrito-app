import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:distrito_app/pages/pastor_detalhe.dart';
import 'package:flutter/material.dart';

class PastorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return StreamBuilder(
      stream: Firestore.instance.document('sobre/pastor').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }
        return Card(
          elevation: isIOS ? 1.0 : 2.0,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PastorDetalhe(document: snapshot.data)));
            },
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: Color(0xFF90979F)),
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
                      backgroundImage: new NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/iasd-oliveira3-fb.appspot.com/o/mensagens%2F3DThzBmtj5CWcU724n4K%2Fitaniel.jpg?alt=media&token=c814bcec-bd4d-4b55-b160-ac091fdfb5c8'),
                    ),
                    title: Text(snapshot.data['nome']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(snapshot.data['predicado']),
                        Text(snapshot.data['email'])
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
  }
}
