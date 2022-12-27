// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

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

const _$SponsorsFieldMap = <String, String>{
  'total': 'total',
  'skip': 'skip',
  'limit': 'limit',
  'items': 'items',
};

Map<String, dynamic> _$SponsorsToJson(Sponsors instance) => <String, dynamic>{
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
      'items': instance.items,
    };

SponsorFields _$SponsorFieldsFromJson(Map<String, dynamic> json) =>
    SponsorFields(
      SystemFields.fromJson(json['sys'] as Map<String, dynamic>),
      Sponsor.fromJson(json['fields'] as Map<String, dynamic>),
    );

const _$SponsorFieldsFieldMap = <String, String>{
  'sys': 'sys',
  'fields': 'fields',
};

Map<String, dynamic> _$SponsorFieldsToJson(SponsorFields instance) =>
    <String, dynamic>{
      'sys': instance.sys?.toJson(),
      'fields': instance.fields?.toJson(),
    };

Sponsor _$SponsorFromJson(Map<String, dynamic> json) => Sponsor(
      json['nazwaFirmy'] as String,
      Asset.fromJson(json['logo'] as Map<String, dynamic>),
      json['linkDoStronySponsora'] as String,
      $enumDecode(_$SponsorLevelEnumMap, json['poziomSponsoringu']),
    );

const _$SponsorFieldMap = <String, String>{
  'name': 'nazwaFirmy',
  'logo': 'logo',
  'url': 'linkDoStronySponsora',
  'level': 'poziomSponsoringu',
};

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
