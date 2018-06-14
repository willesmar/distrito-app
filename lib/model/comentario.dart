import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'comentario.jser.dart';

class Comentario {
  String userIde;
  String nome;
  String comment;
}

@GenSerializer()
  class ComentarioJsonSerializer extends Serializer<Comentario> with _$ComentarioJsonSerializer {
}