import 'package:distrito_app/model/imagem.dart';

class Pastor {
  String biografia;
  String email;
  String nome;
  String predicado;
  // Imagem foto;

  Pastor({this.biografia, this.email, this.nome, this.predicado});//, this.foto});

  Pastor.fromJson(Map<String, dynamic> json) {
    new Pastor(
      biografia: json['biografia'],
      email: json['email'],
      nome: json['nome'],
      predicado: json['predicado'],
      // foto: new Imagem(
      //   createdAt: json['foto']['created_at'],
      //   nameFile: json['foto']['nome'],
      //   url: json['foto']['url'],
      // ),
    );
  }
}
