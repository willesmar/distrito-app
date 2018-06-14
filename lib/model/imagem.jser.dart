// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imagem.dart';

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$ImagemJsonSerializer implements Serializer<Imagem> {
  @override
  Map<String, dynamic> toMap(Imagem model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'createdAt', model.createdAt);
    setMapValue(ret, 'nameFile', model.nameFile);
    setMapValue(ret, 'url', model.url);
    return ret;
  }

  @override
  Imagem fromMap(Map map) {
    if (map == null) return null;
    final obj = new Imagem();
    obj.createdAt = map['createdAt'] as String;
    obj.nameFile = map['nameFile'] as String;
    obj.url = map['url'] as String;
    return obj;
  }
}
