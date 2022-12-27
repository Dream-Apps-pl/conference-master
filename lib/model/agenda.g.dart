// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'agenda.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agenda _$AgendaFromJson(Map<String, dynamic> json) => Agenda(
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => AgendaFields.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

const _$AgendaFieldMap = <String, String>{
  'total': 'total',
  'skip': 'skip',
  'limit': 'limit',
  'items': 'items',
};

Map<String, dynamic> _$AgendaToJson(Agenda instance) => <String, dynamic>{
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

AgendaFields _$AgendaFieldsFromJson(Map<String, dynamic> json) => AgendaFields(
      SystemFields.fromJson(json['sys'] as Map<String, dynamic>),
      Fields.fromJson(json['fields'] as Map<String, dynamic>),
    );

const _$AgendaFieldsFieldMap = <String, String>{
  'sys': 'sys',
  'fields': 'fields',
};

Map<String, dynamic> _$AgendaFieldsToJson(AgendaFields instance) =>
    <String, dynamic>{
      'sys': instance.sys?.toJson(),
      'fields': instance.fields?.toJson(),
    };

Fields _$FieldsFromJson(Map<String, dynamic> json) => Fields(
      Fields._dayFromJson(json['day'] as String),
      json['time'] as String,
      json['title'] as String,
      $enumDecode(_$TalkTypeEnumMap, json['type']),
      json['speaker'] == null
          ? null
          : ContentfulSpeaker.fromJson(json['speaker'] as Map<String, dynamic>),
      json['secondSpeaked'] == null
          ? null
          : ContentfulSpeaker.fromJson(
              json['secondSpeaked'] as Map<String, dynamic>),
      _storeDocumentAsString(json['description'] as Map),
    );

const _$FieldsFieldMap = <String, String>{
  'day': 'day',
  'time': 'time',
  'title': 'title',
  'type': 'type',
  'speaker': 'speaker',
  'secondSpeaker': 'secondSpeaked',
  'description': 'description',
};

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'day': Fields._dayToJson(instance.day),
      'time': instance.time,
      'title': instance.title,
      'type': _$TalkTypeEnumMap[instance.type]!,
      'speaker': instance.speaker?.toJson(),
      'secondSpeaked': instance.secondSpeaker?.toJson(),
      'description': instance.description,
    };

const _$TalkTypeEnumMap = {
  TalkType.beginner: 'beginner',
  TalkType.advanced: 'advanced',
  TalkType.other: 'other',
};

ContentfulSpeaker _$ContentfulSpeakerFromJson(Map<String, dynamic> json) =>
    ContentfulSpeaker(
      SystemFields.fromJson(json['sys'] as Map<String, dynamic>),
      ContentfulSpeakerFields.fromJson(json['fields'] as Map<String, dynamic>),
    );

const _$ContentfulSpeakerFieldMap = <String, String>{
  'sys': 'sys',
  'fields': 'fields',
};

Map<String, dynamic> _$ContentfulSpeakerToJson(ContentfulSpeaker instance) =>
    <String, dynamic>{
      'sys': instance.sys?.toJson(),
      'fields': instance.fields?.toJson(),
    };

ContentfulSpeakerFields _$ContentfulSpeakerFieldsFromJson(
        Map<String, dynamic> json) =>
    ContentfulSpeakerFields(
      json['name'] as String,
      json['twitter'] as String?,
      json['picture'] == null
          ? null
          : Asset.fromJson(json['picture'] as Map<String, dynamic>),
      json['topic'] as String?,
      _documentFromJson(json['bio'] as Map),
      _documentFromJson(json['longBio'] as Map),
    );

const _$ContentfulSpeakerFieldsFieldMap = <String, String>{
  'name': 'name',
  'twitter': 'twitter',
  'picture': 'picture',
  'topic': 'topic',
  'bio': 'bio',
  'longBio': 'longBio',
};

Map<String, dynamic> _$ContentfulSpeakerFieldsToJson(
        ContentfulSpeakerFields instance) =>
    <String, dynamic>{
      'name': instance.name,
      'twitter': instance.twitter,
      'picture': instance.picture?.toJson(),
      'topic': instance.topic,
      'bio': _documentToJson(instance.bio),
      'longBio': _documentToJson(instance.longBio),
    };
