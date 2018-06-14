import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'autor.jser.dart';

class Autor {
  String nome;
  String predicado;
  String foto;

  Autor({this.nome, this.predicado, this.foto});

  factory Autor.fromJson(Map<dynamic, dynamic> json) {
    print(json['nome']);
    return new Autor(
        nome: json['nome'], predicado: json['predicado'], foto: json['foto']);
  }

  factory Autor.fromHashMap(Map<String, String> json) {
    return new Autor(
        nome: json['nome'].toString(), predicado: json['predicado'].toString(), foto: json['foto'].toString());
  }
}

@GenSerializer()
class AutorJsonSerializer extends Serializer<Autor> with _$AutorJsonSerializer {
}
