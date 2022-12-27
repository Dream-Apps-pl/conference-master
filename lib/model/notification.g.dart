// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppNotification _$AppNotificationFromJson(Map json) => AppNotification(
      json['title'] as String,
      DateTime.parse(json['dateTime'] as String),
      json['content'] as String,
      json['important'] as bool,
      json['url'] as String,
    );

const _$AppNotificationFieldMap = <String, String>{
  'title': 'title',
  'dateTime': 'dateTime',
  'content': 'content',
  'important': 'important',
  'url': 'url',
};

Map<String, dynamic> _$AppNotificationToJson(AppNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'dateTime': instance.dateTime.toIso8601String(),
      'content': instance.content,
      'important': instance.important,
      'url': instance.url,
    };
