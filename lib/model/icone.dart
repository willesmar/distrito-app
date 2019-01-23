class Icone {
  String valor;
  String icon;
  String nome;

  Icone({this.valor, this.icon, this.nome});

  factory Icone.fromJson(Map<dynamic, dynamic> json) {
    return new Icone(
        valor: json['valor'], icon: json['icon'], nome: json['nome']);
  }
}
