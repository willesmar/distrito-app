import './autor.dart';
// import '../comentario.dart';
// import '../like.dart';
import '../imagem.dart';

class Mensagem {
  Autor autor;
  // Comentario comentarios;
  // Like likes;
  String data;
  Imagem imagem;
  String msg;
  String passagem;
  String titulo;
  int timestamp;

  Mensagem({this.autor, this.data, this.imagem, this.msg, this.passagem, this.titulo, this.timestamp});

  factory Mensagem.fromJson(Map<dynamic, dynamic> json) {
    // // print(json['autor'].keys);
    // var autor = json['autor']; //new Autor.fromJson(json['autor']);
    // var likes = null; //new Like.fromJson(json['likes']);
    // var imagem = null; //new Imagem.fromJson(json['imagem']);
    return new Mensagem(
      autor: Autor.fromJson(json['autor']),
      data: json['data'].toString(),
      imagem: Imagem.fromJson(json['imagem']),
      msg: json['msg'],
      passagem: json['passagem'],
      titulo: json['titulo'],
      timestamp: json['timestamp'], //DateTime.fromMicrosecondsSinceEpoch(json['timestamp']),
    );
  }
}
