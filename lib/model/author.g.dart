// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      json['id'] as String,
      json['name'] as String,
      json['longBio'] as String,
      json['occupation'] as String,
      json['twitter'] as String,
      json['avatar'] as String,
    );

const _$AuthorFieldMap = <String, String>{
  'id': 'id',
  'name': 'name',
  'longBio': 'longBio',
  'occupation': 'occupation',
  'twitter': 'twitter',
  'avatar': 'avatar',
};

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'longBio': instance.longBio,
      'occupation': instance.occupation,
      'twitter': instance.twitter,
      'avatar': instance.avatar,
    };
