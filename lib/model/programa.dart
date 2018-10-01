import 'package:distrito_app/model/atividade.dart';
import 'package:distrito_app/model/equipes.dart';

class ProgramaModel {
  String nomePrograma;
  bool publicado;
  int timestamp;
  String diaSemana;
  List<Atividade> culto;
  List<Atividade> escolaSabatina;
  List<Atividade> extra;
  List<Atividade> louvor;
  Map<dynamic, dynamic> equipes;

  ProgramaModel(
      {this.nomePrograma,
      this.publicado,
      this.timestamp,
      this.diaSemana,
      this.culto,
      this.escolaSabatina,
      this.extra,
      this.louvor,
      this.equipes});

  factory ProgramaModel.fromJson(Map<dynamic, dynamic> json) {
    var cultoFromJson = json['culto'] as List;
    List<Atividade> cultoList =
        cultoFromJson.map((item) => Atividade.fromJson(item)).toList();
    var esFromjson = json['escolaSabatina'] as List;
    List<Atividade> esList = esFromjson
        .map((item) => Atividade.fromJson(item))
        .toList();
    var extraFromjson = json['extra'] as List;
    List<Atividade> extraList = extraFromjson
        .map((item) => Atividade.fromJson(item))
        .toList();
    var louvorFromjson = json['louvor'] as List;
    List<Atividade> louvorList = louvorFromjson
        .map((item) => Atividade.fromJson(item))
        .toList();
    return new ProgramaModel(
        nomePrograma: json['nomePrograma'],
        publicado: json['publicado'],
        timestamp: json['timestamp'],
        diaSemana: json['diaSemana'],
        culto: cultoList,
        escolaSabatina: esList,
        extra: extraList,
        louvor: louvorList,
        equipes: json['equipes']
      );
  }
}
