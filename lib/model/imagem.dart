import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'imagem.jser.dart';

class Imagem {
  String createdAt;
  String nameFile;
  String url;

  Imagem({this.createdAt, this.nameFile, this.url});

  factory Imagem.fromJson(Map<dynamic, dynamic> json) {
    return new Imagem(
      createdAt: json['createdAt'],
      nameFile: json['nameFile'],
      url: json['url'],
    );
  }
}

@GenSerializer()
  class ImagemJsonSerializer extends Serializer<Imagem> with _$ImagemJsonSerializer {
}
