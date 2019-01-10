class Atividade {
  bool completada;
  String duracao;
  String hFim;
  String hInicio;
  String icone;
  String nomeAtividade;
  String responsavel;

  Atividade(
      {this.completada,
      this.duracao,
      this.hFim,
      this.hInicio,
      this.icone,
      this.nomeAtividade,
      this.responsavel});

  factory Atividade.fromJson(Map<dynamic, dynamic> json) {
    final _icone = json['icone'];
    return new Atividade(
      completada: json['completada'],
      duracao: json['duracao'],
      hFim: json['hFim'],
      hInicio: json['hInicio'],
      icone: _icone['valor'],
      nomeAtividade: json['nomeAtividade'],
      responsavel: json['responsavel'],
    );
  }
}
