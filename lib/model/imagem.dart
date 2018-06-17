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
