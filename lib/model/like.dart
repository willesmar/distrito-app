import 'package:jaguar_serializer/jaguar_serializer.dart';
part 'like.jser.dart';

class Like {
  num qtd;
  List<String> users;

  // Like({this.qtd, this.users});

  // factory fromJson(Map<dynamic, dynamic> json) {
  //   return new Like(
  //     qtd: json['qtd'],
  //     users: json['users']
  //   );
  // }
}

@GenSerializer()
class LikeJsonSerializer extends Serializer<Like> with _$LikeJsonSerializer {}
