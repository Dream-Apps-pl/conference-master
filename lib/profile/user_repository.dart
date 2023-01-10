import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/model/user.dart';
import 'package:conferenceapp/profile/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository {
  final AuthRepository _authRepository;
  final FirebaseFirestore _firestore;
  late User _cachedUser;

  UserRepository(this._authRepository, this._firestore) {
    this.user.listen((user) {
      print('log id $user');
      _cachedUser = user;
    });
  }

  Stream<DocumentSnapshot> get _usersSnapshotsStream {
    return _authRepository.userId.asyncExpand((id) {
      if (id == null) return null;

      return _firestore.doc('users/$id').snapshots();
    });
  }

  Stream<User> get user => Rx.combineLatest2(
        _authRepository.userId,
        _usersSnapshotsStream,
        _getUserFromSnapshot,
      ).asBroadcastStream();

  Future<void> addTalkToFavorites(String talkId) async {
    logger.setDeviceString('userId', _authRepository.idUser);
    await _firestore.doc('users/${_authRepository.idUser}').update(
      {
        'userId': _authRepository.idUser,
        'favoriteTalksIds': FieldValue.arrayUnion([talkId]),
        'updated': DateTime.now(),
      },
    );
  }

  Future<void> removeTalkFromFavorites(String talkId) async {
    await _firestore.doc('users/${_authRepository.idUser}').update({
      'userId': _authRepository.idUser,
      'favoriteTalksIds': FieldValue.arrayRemove([talkId]),
      'updated': DateTime.now()
    });
  }

  User _getUserFromSnapshot(
    String id,
    DocumentSnapshot userSnapshot,
  ) {
    if (id != userSnapshot.id || id != _cachedUser.userId) {
      logger.warn('Wrong auth id of cached user');
    }
    if (userSnapshot.exists) {
      final user = User.fromJson(userSnapshot.data() as Map<String, dynamic>);
      _cachedUser = user;
      return user;
    } else {
      return User(id, [], '');
    }
  }
}
