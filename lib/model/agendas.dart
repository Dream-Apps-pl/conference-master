import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:conferenceapp/model/talk.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agendas.g.dart';

@JsonSerializable(explicitToJson: true)
class Agendas {
  Agendas({
    required this.dayOne,
  });
  @JsonKey(name: 'day_one')
  final List<Talk>? dayOne;
}

@Collection<Agendas>('agenda')
final agendasRef = AgendasCollectionReference();
