import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organizer.g.dart';

@JsonSerializable(explicitToJson: true)
class Organizer {
  final String name;
  final String picture;
  final String longBio;

  Organizer(
    this.name,
    this.picture,
    this.longBio,
  );

  static Organizer fromJson(Map<String, dynamic> json) =>
      _$OrganizerFromJson(json);
  Map<String, dynamic> toJson() => _$OrganizerToJson(this);
}

@Collection<Organizer>('organizer')
final organizerRef = OrganizerCollectionReference();
