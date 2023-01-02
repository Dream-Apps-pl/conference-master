import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sponsor.g.dart';

@JsonSerializable(explicitToJson: true)
class Sponsor {
  final String name;
  final String logo;
  final String url;
  final SponsorLevel level;
  Sponsor(this.name, this.logo, this.url, this.level);

  static Sponsor fromJson(Map<String, dynamic> json) => _$SponsorFromJson(json);
  Map<String, dynamic> toJson() => _$SponsorToJson(this);
}

enum SponsorLevel {
  platinium,
  gold,
  silver,
  bronze,
}

@Collection<Sponsor>('sponsor')
final sponsorRef = SponsorCollectionReference();
