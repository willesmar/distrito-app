import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_text.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:flutter_html_view/flutter_html_video.dart';
// import 'package:flutter_html_view/flutter_html_view.dart';
// import 'package:flutter_html_view/html_parser.dart';
// import 'package:flutter_html_textview/flutter_html_textview.dart';

class MensagemDetalhe extends StatelessWidget {
  MensagemDetalhe({this.document});
  final document;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    debugPrint(document['titulo']);
    const Map<String, String> caracteresEspeciais = {
      'á': '&aacute;',
      'Á': '&Aacute;',
      'ã': '&atilde;',
      'Ã': '&Atilde;',
      'â': '&acirc;',
      'Â': '&Acirc;',
      'à': '&agrave;',
      'À': '&Agrave;',
      'é': '&eacute;',
      'É': '&Eacute;',
      'ê': '&ecirc;',
      'Ê': '&Ecirc;',
      'í': '&iacute;',
      'Í': '&Iacute;',
      'ó': '&oacute;',
      'Ó': '&Oacute;',
      'õ': '&otilde;',
      'Õ': '&Otilde;',
      'ô': '&ocirc;',
      'Ô': '&Ocirc;',
      'ú': '&uacute;',
      'Ú': '&Uacute;',
      'ç': '&ccedil;',
      'Ç': '&Ccedil;',
    };

    String mensagem = document['msg'].toString();
    String markdown = html2md.convert(mensagem);

    // void iterateMapEntry(key, value) {
    //   mensagem = mensagem.replaceAll(new RegExp('$value'), '$key');
    // }

    // caracteresEspeciais.forEach(iterateMapEntry);
    // mensagem = mensagem.replaceAll(new RegExp('&nbsp;'), ' ');
    // mensagem = mensagem.replaceAll(new RegExp('&ldquo;'), '"');
    // mensagem = mensagem.replaceAll(new RegExp('&rdquo;'), '"');
    // mensagem = mensagem.replaceAll(new RegExp('&ndash;'), '--');
    // mensagem = mensagem.replaceAll(new RegExp('<br />'), '\n');
    // descricao = descricao.replaceAll(new RegExp('<.*?>'), '');
    // descricao = descricao.replaceAll(new RegExp('&otilde;'), 'õ');
    // descricao = descricao.replaceAll(new RegExp('&ccedil;'), 'ç');
    debugPrint(markdown);
    return Scaffold(
      appBar: AppBar(
        title: Text(document['titulo']),
      ),
      body: new Markdown(
        data: markdown,
        styleSheet: ,
      ), // HtmlTextView(data: document['msg']), //Text(document['msg']),
    );
  }
}
