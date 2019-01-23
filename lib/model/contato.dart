import 'icone.dart';

class Contato {
  String icone;
  String nome;
  String url;

  Contato({this.icone, this.nome, this.url});

  factory Contato.fromJson(Map<dynamic, dynamic> json) {
    Icone icone = Icone.fromJson(json['icone']);
    return new Contato(
      icone: icone.valor,
      nome: json['nome'],
      url: json['url'],
    );
  }
}
