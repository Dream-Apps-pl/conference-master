import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:conferenceapp/model/agenda.dart';
import 'package:conferenceapp/model/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'author.dart';
import 'room.dart';

part 'talk.g.dart';

enum DayType { one, two, three }

@JsonSerializable(explicitToJson: true)
class Talk implements Comparable<Talk> {
  final String id;
  final String title;
  final List<Author> authors;
  final String description;
  final TalkType type;
  @TimestampConverter()
  final DateTime startTime;
  @TimestampConverter()
  final DateTime endTime;
  final Room room;
  final DayType? day;

  Talk(
    this.id,
    this.title,
    this.authors,
    this.description,
    this.startTime,
    this.endTime,
    this.room,
    this.type,
    this.day,
  );

  factory Talk.fromJson(Map<String, dynamic> json) => _$TalkFromJson(json);

  factory Talk.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Talk.fromJson(data);
  }

  Map<String, dynamic> toJson() => _$TalkToJson(this);

  @override
  int compareTo(Talk other) {
    return startTime.compareTo(other.startTime);
  }

  @override
  String toString() {
    return "Talk: $title";
  }
}

@Collection<Talk>('talks')
final talksRef = TalkCollectionReference();
