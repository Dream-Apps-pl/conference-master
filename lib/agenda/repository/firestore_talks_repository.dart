import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/model/talk.dart';
import 'package:conferenceapp/model/talk_list.dart';

import 'talks_repository.dart';

class FirestoreTalkRepository implements TalkRepository {
  final talksCollection = FirebaseFirestore.instance.collection('talks');
  // .where("public", isEqualTo: true);

  @override
  Stream<List<Talk>> talks() {
    var data = talksCollection.snapshots().map((snapshot) {
      final list = snapshot.docs.map(getTalks).toList();
      return list.expand((l) => l.talks).toList();
    });
    return data;
  }

  @override
  Stream<Talk> talk(String id) {
    StreamTransformer<List<Talk>, Talk> transform =
        StreamTransformer.fromHandlers(
      handleData: (List<Talk> data, EventSink<Talk> sink) {
        sink.add(data.firstWhere((t) => t.id == id));
      },
      handleError: (Object error, StackTrace stacktrace, EventSink sink) {
        sink.addError('Something went wrong: $error');
      },
      handleDone: (EventSink<Talk> sink) => sink.close(),
    );

    return talks().transform(transform);
  }

  TalkList getTalks(DocumentSnapshot docs) {
    try {
      return TalkList.fromJson(docs.data() as Map<String, dynamic>);
    } catch (e, s) {
      logger.errorException(e, s);
      return TalkList(DateTime(2023, 1, 1), <Talk>[]);
    }
  }

  @override
  void refresh() {
    // TODO: implement refresh
  }
}
