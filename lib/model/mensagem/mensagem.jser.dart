// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensagem.dart';

// **************************************************************************
// Generator: JaguarSerializerGenerator
// **************************************************************************

abstract class _$MensagemJsonSerializer implements Serializer<Mensagem> {
  Serializer<Autor> __autorJsonSerializer;
  Serializer<Autor> get _autorJsonSerializer =>
      __autorJsonSerializer ?? new AutorJsonSerializer();
  Serializer<Comentario> __comentarioJsonSerializer;
  Serializer<Comentario> get _comentarioJsonSerializer =>
      __comentarioJsonSerializer ?? new ComentarioJsonSerializer();
  Serializer<Like> __likeJsonSerializer;
  Serializer<Like> get _likeJsonSerializer =>
      __likeJsonSerializer ?? new LikeJsonSerializer();
  Serializer<Imagem> __imagemJsonSerializer;
  Serializer<Imagem> get _imagemJsonSerializer =>
      __imagemJsonSerializer ?? new ImagemJsonSerializer();
  @override
  Map<String, dynamic> toMap(Mensagem model) {
    if (model == null) return null;
    Map<dynamic, dynamic> ret = <dynamic, dynamic>{};
    setMapValue(ret, 'autor', _autorJsonSerializer.toMap(model.autor));
    setMapValue(
        ret, 'comentarios', _comentarioJsonSerializer.toMap(model.comentarios));
    setMapValue(ret, 'likes', _likeJsonSerializer.toMap(model.likes));
    setMapValue(ret, 'data', model.data);
    setMapValue(ret, 'imagem', _imagemJsonSerializer.toMap(model.imagem));
    setMapValue(ret, 'msg', model.msg);
    setMapValue(ret, 'passagem', model.passagem);
    setMapValue(ret, 'titulo', model.titulo);
    setMapValue(ret, 'timestamp', model.timestamp);
    return ret;
  }

  @override
  Mensagem fromMap(Map map) {
    if (map == null) return null;
    final obj = new Mensagem();
    obj.autor = _autorJsonSerializer.fromMap(map['autor'] as Map);
    obj.comentarios =
        _comentarioJsonSerializer.fromMap(map['comentarios'] as Map);
    obj.likes = _likeJsonSerializer.fromMap(map['likes'] as Map);
    obj.data = map['data'].toString();
    obj.imagem = _imagemJsonSerializer.fromMap(map['imagem'] as Map);
    obj.msg = map['msg'] as String;
    obj.passagem = map['passagem'] as String;
    obj.titulo = map['titulo'] as String;
    obj.timestamp = map['timestamp'] as String;
    return obj;
  }
}
