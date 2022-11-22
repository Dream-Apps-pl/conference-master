import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable(
  ignoreUnannotated: false,
  anyMap: true,
)
class AppNotification extends Comparable<AppNotification> {
  final String title;
  final DateTime dateTime;
  final String content;
  final bool important;
  final String url;

  AppNotification(
      this.title, this.dateTime, this.content, this.important, this.url);

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$AppNotificationToJson(this);

  @override
  int compareTo(other) {
    return -dateTime.compareTo(other.dateTime);
  }
}
