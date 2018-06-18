import 'package:flutter/material.dart';

class MensagemDetalhe extends StatelessWidget {
  MensagemDetalhe({this.document});
  final document;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    debugPrint(document['titulo']);
    return Scaffold(
      appBar: AppBar(
        title: Text(document['titulo']),
      ),
      body: Text(document['msg']),
    );
  }
}
