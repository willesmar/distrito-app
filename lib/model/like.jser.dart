// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$LikeJsonSerializer implements Serializer<Like> {
  @override
  Map<String, dynamic> toMap(Like model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValue(ret, 'qtd', model.qtd);
    setMapValue(
        ret, 'users', codeIterable(model.users, (val) => val as String));
    return ret;
  }

  @override
  Like fromMap(Map map) {
    if (map == null) return null;
    final obj = new Like();
    obj.qtd = map['qtd'] as num;
    obj.users =
        codeIterable<String>(map['users'] as Iterable, (val) => val as String);
    return obj;
  }
}
