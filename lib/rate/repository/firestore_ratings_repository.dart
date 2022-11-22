// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/model/user.dart';
import 'package:conferenceapp/profile/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ratings_repository.dart';

class FirestoreRatingsRepository implements RatingsRepository {
  final SharedPreferences _sharedPreferences;
  final CollectionReference _ratingsCollection;
  final UserRepository _userRepository;

  String _talkRatingKey(String talkId) => talkId + "_rating";
  String _talkReviewKey(String talkId) => talkId + "_review";

  FirestoreRatingsRepository(
      this._sharedPreferences, this._ratingsCollection, this._userRepository);

  @override
  String myReviewOfTalk(String talkId) {
    try {
      final key = _talkReviewKey(talkId);
      return _sharedPreferences.getString(key) ?? '0';
    } catch (e, s) {
      logger.errorException(e, s);
      return '0';
    }
  }

  @override
  int myRatingOfTalk(String talkId) {
    try {
      final key = _talkRatingKey(talkId);
      return _sharedPreferences.getInt(key) ?? 0;
    } catch (e, s) {
      logger.errorException(e, s);
      return 0;
    }
  }

  @override
  void rateTalk(String talkId, int rating) async {
    try {
      final key = _talkRatingKey(talkId);
      _sharedPreferences.setInt(key, rating);
    } catch (e, s) {
      logger.errorException(e, s);
    }

    final me = await _getCurrentUser();
    if (me == null) {
      logger.warn("Cannot rate talk $talkId because user is null.");
      return;
    }

    final myTalkRatingDoc = await _getMyTalkRatingDocument(me.userId, talkId);

    if (myTalkRatingDoc != null && myTalkRatingDoc.exists) {
      myTalkRatingDoc.reference
          .update({"rating": rating, "update_date": Timestamp.now()});
    } else {
      _ratingsCollection.add({
        "user_id": me.userId,
        "talk_id": talkId,
        "rating": rating,
        "update_date": Timestamp.now()
      });
    }
  }

  @override
  void reviewTalk(String talkId, String review) async {
    try {
      final key = _talkReviewKey(talkId);
      _sharedPreferences.setString(key, review);
    } catch (e, s) {
      logger.errorException(e, s);
    }

    final me = await _getCurrentUser();
    if (me == null) {
      logger.warn("Cannot review talk $talkId because user is null.");
      return;
    }

    final myTalkRatingDoc = await _getMyTalkRatingDocument(me.userId, talkId);

    if (myTalkRatingDoc != null && myTalkRatingDoc.exists) {
      myTalkRatingDoc.reference
          .update({"review": review, "update_date": Timestamp.now()});
    } else {
      _ratingsCollection.add({
        "user_id": me.userId,
        "talk_id": talkId,
        "review": review,
        "update_date": Timestamp.now()
      });
    }
  }

  Future<DocumentSnapshot?> _getMyTalkRatingDocument(
      String userId, String talkId) async {
    try {
      return (await _ratingsCollection
              .where("user_id", isEqualTo: userId)
              .where("talk_id", isEqualTo: talkId)
              .get())
          .docs
          .firstOrDefault();
    } catch (e, s) {
      logger.errorException(e, s);
      return null;
    }
  }

  Future<User>? _getCurrentUser() {
    try {
      return _userRepository.user.first;
    } catch (e, s) {
      logger.errorException(e, s);
      return null;
    }
  }
}

extension ListOperations on List<DocumentSnapshot> {
  DocumentSnapshot<Object?>? firstOrDefault() {
    return this.length > 0 ? this.first : null;
  }
}
