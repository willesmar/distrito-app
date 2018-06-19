import 'package:flutter/material.dart';
import 'package:html2md/html2md.dart' as html2md;

class AnuncioDetalhe extends StatelessWidget {
  AnuncioDetalhe({this.document});
  final document;

  @override
  Widget build(BuildContext context) {
    String descricao = document['descricao'].toString();
    String descricaoMarkdown = html2md.convert(descricao);
    var cronograma = document['cronograma'];
    var cronogramaSize = cronograma.length;

    pessoa(itens) {
      itens.forEach((item) {
        debugPrint('${item['nome']}, ${item['predicado']}');
      });
    }

    if (cronograma.length > 0) {
      cronograma.forEach((cron) {
        debugPrint(cron['timestamp'].toString());
        debugPrint('${cron['local']['nome']}, ${cron['local']['endereco']}');
        pessoa(cron['preletores']);
        pessoa(cron['cantores']);
      });
      debugPrint(
          'De ${cronograma[0]['timestamp']} à ${cronograma[cronogramaSize - 1]['timestamp']}');
      debugPrint('${cronograma[0]['preletores'][0]['nome']} e outros');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(document['nome']),
      ),
      body: new ListView(
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Image.network(document['imagem']['url'], fit: BoxFit.cover),
              new Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Text(
                  descricaoMarkdown,
                  textAlign: TextAlign.justify,
                  style: new TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
