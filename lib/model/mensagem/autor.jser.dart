// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autor.dart';

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$AutorJsonSerializer implements Serializer<Autor> {
  @override
  Map<String, dynamic> toMap(Autor model) {
    if (model == null) return null;
    Map<dynamic, dynamic> ret = <dynamic, dynamic>{};
    setMapValue(ret, 'nome', model.nome);
    setMapValue(ret, 'predicado', model.predicado);
    setMapValue(ret, 'foto', model.foto);
    return ret;
  }

  @override
  Autor fromMap(Map map) {
    if (map == null) return null;
    final obj = new Autor();
    obj.nome = map['nome'] as String;
    obj.predicado = map['predicado'] as String;
    obj.foto = map['foto'].toString();
    return obj;
  }
}
