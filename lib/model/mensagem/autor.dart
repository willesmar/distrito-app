
import 'package:distrito_app/model/imagem.dart';

class Autor {
  String nome;
  String predicado;
  Imagem foto;

  Autor({this.nome, this.predicado, this.foto});

  // factory Autor.fromJson(Map<dynamic, dynamic> json) {
  //   print(json['nome']);
  //   return new Autor(
  //       nome: json['nome'], predicado: json['predicado'], foto: json['foto']);
  // }

  // factory Autor.fromHashMap(Map<String, String> json) {
  //   return new Autor(
  //       nome: json['nome'].toString(), predicado: json['predicado'].toString(), foto: json['foto']);
  // }
}