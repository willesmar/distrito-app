import 'package:jaguar_serializer/jaguar_serializer.dart';
import './autor.dart';
import '../comentario.dart';
import '../like.dart';
import '../imagem.dart';
part 'mensagem.jser.dart';

class Mensagem {
  Autor autor;
  Comentario comentarios;
  Like likes;
  String data;
  Imagem imagem;
  String msg;
  String passagem;
  String titulo;
  String timestamp;

  // Mensagem(
  //     Map<dynamic, dynamic> autor,
  //     Like likes,
  //     String data,
  //     Imagem imagem,
  //     String msg,
  //     String passagem,
  //     String titulo,
  //     String timestamp,
  //     Comentario comentarios) {
  //   this.autor = autor.isNotEmpty ? new Autor.fromHashMap(autor) : null;
  //   this.likes = likes.toString().isNotEmpty ? likes : null;
  //   this.data = data;
  //   this.imagem = imagem.toString().isNotEmpty ? imagem : null;
  //   this.msg = msg;
  //   this.passagem = passagem;
  //   this.titulo = titulo;
  //   this.timestamp = timestamp;
  // }

  // factory Mensagem.fromJson(Map<dynamic, dynamic> json) {
  //   // print(json['autor'].keys);
  //   var autor = json['autor']; //new Autor.fromJson(json['autor']);
  //   var likes = null; //new Like.fromJson(json['likes']);
  //   var imagem = null; //new Imagem.fromJson(json['imagem']);
  //   return new Mensagem(
  //       autor,
  //       likes,
  //       json['data'].toString(),
  //       imagem,
  //       json['msg'],
  //       json['passagem'],
  //       json['titulo'],
  //       json['timestamp'], //DateTime.fromMicrosecondsSinceEpoch(json['timestamp']),
  //       json['comentarios']);
  // }
}

@GenSerializer()
class MensagemJsonSerializer extends Serializer<Mensagem>
    with _$MensagemJsonSerializer {}
