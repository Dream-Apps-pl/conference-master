// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talk_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalkList _$TalkListFromJson(Map json) => TalkList(
      dateTimeFromTimeStamp(json['day']),
      (json['talks'] as List<dynamic>)
          .map((e) => Talk.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$TalkListToJson(TalkList instance) => <String, dynamic>{
      'day': dateTimeToTimeStamp(instance.day),
      'talks': instance.talks.map((e) => e.toJson()).toList(),
    };
