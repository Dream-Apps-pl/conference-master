import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(
  ignoreUnannotated: false,
  anyMap: true,
)
class User {
  final List<String> favoriteTalksIds;
  final String userId;
  final String? ticketId;

  User(this.userId, this.favoriteTalksIds, this.ticketId);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
