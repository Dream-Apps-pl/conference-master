// GENERATED CODE - DO NOT MODIFY BY HAND

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

Map<String, dynamic> _$AgendaToJson(Agenda instance) => <String, dynamic>{
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
      'items': instance.items,
    };

AgendaFields _$AgendaFieldsFromJson(Map json) => AgendaFields(
      SystemFields.fromJson(Map<String, dynamic>.from(json['sys'] as Map)),
      Fields.fromJson(json['fields'] as Map),
    );

Map<String, dynamic> _$AgendaFieldsToJson(AgendaFields instance) =>
    <String, dynamic>{
      'sys': instance.sys?.toJson(),
      'fields': instance.fields?.toJson(),
    };

Fields _$FieldsFromJson(Map json) => Fields(
      Fields._dayFromJson(json['day'] as String),
      json['time'] as String,
      json['title'] as String,
      $enumDecode(_$TalkTypeEnumMap, json['type']),
      ContentfulSpeaker.fromJson(json['speaker'] as Map),
      ContentfulSpeaker.fromJson(json['secondSpeaked'] as Map),
      _storeDocumentAsString(json['description'] as Map),
    );

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'day': Fields._dayToJson(instance.day),
      'time': instance.time,
      'title': instance.title,
      'type': _$TalkTypeEnumMap[instance.type]!,
      'speaker': instance.speaker.toJson(),
      'secondSpeaked': instance.secondSpeaker.toJson(),
      'description': instance.description,
    };

const _$TalkTypeEnumMap = {
  TalkType.beginner: 'beginner',
  TalkType.advanced: 'advanced',
  TalkType.other: 'other',
};

ContentfulSpeaker _$ContentfulSpeakerFromJson(Map json) => ContentfulSpeaker(
      SystemFields.fromJson(Map<String, dynamic>.from(json['sys'] as Map)),
      ContentfulSpeakerFields.fromJson(json['fields'] as Map),
    );

Map<String, dynamic> _$ContentfulSpeakerToJson(ContentfulSpeaker instance) =>
    <String, dynamic>{
      'sys': instance.sys?.toJson(),
      'fields': instance.fields?.toJson(),
    };

ContentfulSpeakerFields _$ContentfulSpeakerFieldsFromJson(Map json) =>
    ContentfulSpeakerFields(
      json['name'] as String,
      json['twitter'] as String,
      Asset.fromJson(Map<String, dynamic>.from(json['picture'] as Map)),
      json['topic'] as String,
      _documentFromJson(json['bio'] as Map),
      _documentFromJson(json['longBio'] as Map),
    );

Map<String, dynamic> _$ContentfulSpeakerFieldsToJson(
        ContentfulSpeakerFields instance) =>
    <String, dynamic>{
      'name': instance.name,
      'twitter': instance.twitter,
      'picture': instance.picture.toJson(),
      'topic': instance.topic,
      'bio': _documentToJson(instance.bio),
      'longBio': _documentToJson(instance.longBio),
    };
