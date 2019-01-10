import 'package:distrito_app/widgets/app_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:html2md/html2md.dart' as html2md;

import 'package:distrito_app/utils/functions.dart';
import './image_wrapper.dart';

class AnuncioDetalhe extends StatelessWidget {
  AnuncioDetalhe({this.document});
  final document;
  final double _iconSize = 34.0;
  final Color _iconColor = Colors.black;
  final double _containerListTileHeight = 55.0;

  Widget _getDataHora(cron) {
    return Container(
      height: _containerListTileHeight,
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        leading: Icon(
          Icons.calendar_today,
          color: _iconColor,
          size: _iconSize,
        ),
        title: Text(dataPorExtensoAbreviada(cron['timestamp'])),
        subtitle: Text(
            '${diaSemana(cron['timestamp'])} às ${cron['hora'].toString()}'),
      ),
    );
  }

  Widget _getLocal(local) {
    return Container(
      height: _containerListTileHeight,
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        leading: Icon(
          Icons.pin_drop,
          color: _iconColor,
          size: _iconSize,
        ),
        title: new Text(local['nome']),
        subtitle: new Text(local['endereco']),
      ),
    );
  }

  Widget _getPessoa(pessoa, tipo) {
    IconData icone = Icons.person;
    if (tipo == 'cantor') {
      icone = Icons.music_note;
    }
    if (tipo == 'preletor') {
      icone = Icons.mic;
    }

    return Container(
      height: _containerListTileHeight,
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        leading: Icon(
          icone,
          color: _iconColor,
          size: _iconSize,
        ),
        title: new Text(pessoa['nome']),
        subtitle: new Text(pessoa['predicado']),
      ),
    );
  }

  List<Widget> _getPessoas(pessoas, tipo) {
    List<Widget> lista = [];
    pessoas.forEach((pessoa) {
      if (pessoa != null) {
        lista.add(_getPessoa(pessoa, tipo));
      }
    });
    return lista;
  }

  List<Widget> _getCronograma() {
    List<Widget> lista = [];
    List<dynamic> arr = document['cronograma'];
    arr.forEach((item) {
      if (item['timestamp'] > 0) {
        lista.add(_getDataHora(item));
      }
      if (item['local'] != null) {
        lista.add(_getLocal(item['local']));
      }
      if (item['cantores'] != null) {
        lista.addAll(_getPessoas(item['cantores'], 'cantor'));
      }
      if (item['preletores'] != null) {
        lista.addAll(_getPessoas(item['preletores'], 'preletor'));
      }
      lista.add(Divider());
    });
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    String descricao = document['descricao'].toString();
    String descricaoMarkdown = html2md.convert(descricao);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppTabBar(title: Text(document['nome']), context: context,),
      body: new ListView(
        children: <Widget>[
          // new Image.network(document['imagem']['url'], fit: BoxFit.cover),
          ImageWrapper(
            imagemUrl: document['imagem']['url'],
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                children: List.of(_getCronograma().toList()),
              ),
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
