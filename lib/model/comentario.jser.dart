// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comentario.dart';

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$ComentarioJsonSerializer implements Serializer<Comentario> {
  @override
  Map<String, dynamic> toMap(Comentario model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'userIde', model.userIde);
    setMapValue(ret, 'nome', model.nome);
    setMapValue(ret, 'comment', model.comment);
    return ret;
  }

  @override
  Comentario fromMap(Map map) {
    if (map == null) return null;
    final obj = new Comentario();
    obj.userIde = map['userIde'] as String;
    obj.nome = map['nome'] as String;
    obj.comment = map['comment'] as String;
    return obj;
  }
}
