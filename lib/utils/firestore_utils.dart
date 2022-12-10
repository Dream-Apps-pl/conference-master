import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUtils {
  static DateTime fromJson(Timestamp val) {
    return DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);
  }

  static Timestamp toJson(DateTime time) =>
      Timestamp.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
}
