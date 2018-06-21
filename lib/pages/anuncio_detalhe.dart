import 'package:distrito_app/utils/functions.dart';
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
        return ListTile(
          // leading: Icon(Icons.phone),
          title: Text(item['nome']),
          subtitle: Text(item['predicado']),
        );
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

    _getCron(cron) {
      debugPrint(cron);
      return ListTile(
        title: Text(dataPorExtensoAbreviada(cron['timestamp'])),
        subtitle: Text(
            '${diaSemana(cron['timestamp'])} às ${cron['hora'].toString()}'),
      );
    }

    _getEventInfo() {
      if (cronograma.length > 0) {
        cronograma.forEach((cron) {
          // pessoa(cron['preletores']);
          // pessoa(cron['cantores']);
          // debugPrint(cron['timestamp'].toString());
          // debugPrint('${cron['local']['nome']}, ${cron['local']['endereco']}');
          return ListTile(
              leading: Icon(Icons.pin_drop),
              title: new Text(cron['local']['nome']),
              subtitle: new Text(cron['local']['endereco']));
        });
      }
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
              // new ListView.builder(
              //   itemCount: cronograma.length,
              //   itemBuilder: (context, index) {
              //     final cron = cronograma[index];
              //     return _getCron(cron);
              //   },
              // ),
              new ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(dataPorExtensoAbreviada(cronograma[0]['timestamp'])),
        subtitle: Text(
            '${diaSemana(cronograma[0]['timestamp'])} às ${cronograma[0]['hora'].toString()}'),
              ),
              new ListTile(
                leading: Icon(Icons.pin_drop, color: Colors.black),
                title: new Text(document['cronograma'][0]['local']['nome']),
                subtitle:
                    new Text(document['cronograma'][0]['local']['endereco']),
              ),
              // new Container(

              //                 child: new ListView(children: <Widget>[
              //     // _getEventInfo(),
              //     ListTile(
              //   leading: Icon(Icons.pin_drop),
              //   title: new Text(document['cronograma'][0]['local']['nome']),
              //   subtitle: new Text(document['cronograma'][0]['local']['endereco']))
              //   ]),
              // ),
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
