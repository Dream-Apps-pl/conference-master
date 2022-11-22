// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sponsors _$SponsorsFromJson(Map<String, dynamic> json) => Sponsors(
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => SponsorFields.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SponsorsToJson(Sponsors instance) => <String, dynamic>{
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
      'items': instance.items,
    };

SponsorFields _$SponsorFieldsFromJson(Map json) => SponsorFields(
      SystemFields.fromJson(Map<String, dynamic>.from(json['sys'] as Map)),
      Sponsor.fromJson(json['fields'] as Map),
    );

Map<String, dynamic> _$SponsorFieldsToJson(SponsorFields instance) =>
    <String, dynamic>{
      'sys': instance.sys?.toJson(),
      'fields': instance.fields?.toJson(),
    };

Sponsor _$SponsorFromJson(Map json) => Sponsor(
      json['nazwaFirmy'] as String,
      Asset.fromJson(Map<String, dynamic>.from(json['logo'] as Map)),
      json['linkDoStronySponsora'] as String,
      $enumDecode(_$SponsorLevelEnumMap, json['poziomSponsoringu']),
    );

Map<String, dynamic> _$SponsorToJson(Sponsor instance) => <String, dynamic>{
      'nazwaFirmy': instance.name,
      'logo': instance.logo.toJson(),
      'linkDoStronySponsora': instance.url,
      'poziomSponsoringu': _$SponsorLevelEnumMap[instance.level]!,
    };

const _$SponsorLevelEnumMap = {
  SponsorLevel.platinium: 'platinium',
  SponsorLevel.gold: 'gold',
  SponsorLevel.silver: 'silver',
  SponsorLevel.bronze: 'bronze',
};
