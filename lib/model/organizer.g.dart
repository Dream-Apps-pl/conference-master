// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'organizer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organizers _$OrganizersFromJson(Map<String, dynamic> json) => Organizers(
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrganizerFields.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

const _$OrganizersFieldMap = <String, String>{
  'total': 'total',
  'skip': 'skip',
  'limit': 'limit',
  'items': 'items',
};

Map<String, dynamic> _$OrganizersToJson(Organizers instance) =>
    <String, dynamic>{
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
      'items': instance.items,
    };

OrganizerFields _$OrganizerFieldsFromJson(Map<String, dynamic> json) =>
    OrganizerFields(
      SystemFields.fromJson(json['sys'] as Map<String, dynamic>),
      Organizer.fromJson(json['fields'] as Map<String, dynamic>),
    );

const _$OrganizerFieldsFieldMap = <String, String>{
  'sys': 'sys',
  'fields': 'fields',
};

Map<String, dynamic> _$OrganizerFieldsToJson(OrganizerFields instance) =>
    <String, dynamic>{
      'sys': instance.sys?.toJson(),
      'fields': instance.fields?.toJson(),
    };

Organizer _$OrganizerFromJson(Map json) => Organizer(
      json['name'] as String,
      Asset.fromJson(Map<String, dynamic>.from(json['picture'] as Map)),
      _storeDocumentAsString(json['bio'] as Map),
      _storeDocumentAsString(json['longBio'] as Map),
      json['order'] as int,
    );

const _$OrganizerFieldMap = <String, String>{
  'name': 'name',
  'picture': 'picture',
  'bio': 'bio',
  'longBio': 'longBio',
  'order': 'order',
};

Map<String, dynamic> _$OrganizerToJson(Organizer instance) => <String, dynamic>{
      'name': instance.name,
      'picture': instance.picture.toJson(),
      'bio': instance.bio,
      'longBio': instance.longBio,
      'order': instance.order,
    };
