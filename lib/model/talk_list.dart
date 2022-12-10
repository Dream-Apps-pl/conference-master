import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferenceapp/model/talk.dart';
import 'package:conferenceapp/utils/firestore_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talk_list.g.dart';

@JsonSerializable(
  explicitToJson: true,
  anyMap: true,
)
class TalkList {
  @JsonKey(
    fromJson: dateTimeFromTimeStamp,
    toJson: dateTimeToTimeStamp,
  )
  final DateTime? day;
  final List<Talk> talks;

  TalkList(this.day, this.talks);
  factory TalkList.fromJson(Map<String, dynamic> json) =>
      _$TalkListFromJson(json);
  Map<String, dynamic> toJson() => _$TalkListToJson(this);
}

DateTime? dateTimeFromTimeStamp(dynamic data) {
  Timestamp? timestamp;

  if (data is Timestamp) {
    timestamp = data;
  } else if (data is Map) {
    timestamp = Timestamp(data['_seconds'], data['_nanoseconds']);
  }
  return timestamp?.toDate();
}

Map<String, dynamic>? dateTimeToTimeStamp(DateTime? dateTime) {
  final timestamp = Timestamp.fromDate(dateTime ?? DateTime.now());
  return {
    '_seconds': timestamp.seconds,
    '_nanoseconds': timestamp.nanoseconds,
  };
}
