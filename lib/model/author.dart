import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable(explicitToJson: true)
class Author {
  Author(
    this.id,
    this.name,
    this.longBio,
    this.occupation,
    this.twitter,
    this.avatar,
  );

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  final String id;
  final String name;
  final String longBio;
  final String occupation;
  final String twitter;
  final String avatar;

  @override
  String toString() {
    return name;
  }
}
