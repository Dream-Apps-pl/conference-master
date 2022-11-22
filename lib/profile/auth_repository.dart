import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final CollectionReference _adminsCollection;
  final CollectionReference _ticketersCollection;

  AuthRepository(this._firebaseAuth, this._firestore)
      : _adminsCollection = _firestore.collection('admins'),
        _ticketersCollection = _firestore.collection('ticketers') {
    _init();
  }

  void _init() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      final result = await _firebaseAuth.signInAnonymously();
      if (result.user != null) {
        await _firestore.doc('users/${result.user!.uid}').set({
          'userId': result.user!.uid,
          'favoriteTalksIds': [],
        });
      }
    }
  }

  Future signout() async {
    await _firebaseAuth.signOut();
    _init();
  }

  Stream<String> get userId => _firebaseAuth.authStateChanges().map((user) {
        if (user != null) {
          return user.uid;
        } else
          return '';
      });

  Stream<User> get user => _firebaseAuth.authStateChanges().map((user) {
        if (user != null)
          return user;
        else
          return user!;
      });

  Stream<bool> get isAdmin => Rx.combineLatest2(
        userId,
        _adminsSnapshotsStream,
        _isUserAdmin,
      ).asBroadcastStream();

  Stream<bool> get isTicketer => Rx.combineLatest2(
        user,
        _ticketersSnapshotsStream,
        _isUserTicketer,
      ).asBroadcastStream();

  Stream<List<DocumentSnapshot>> get _adminsSnapshotsStream =>
      _adminsCollection.snapshots().map((docs) => docs.docs.toList());

  Stream<List<DocumentSnapshot>> get _ticketersSnapshotsStream =>
      _ticketersCollection.snapshots().map((docs) => docs.docs.toList());

  bool _isUserAdmin(
    String id,
    List<DocumentSnapshot> adminsSnapshot,
  ) {
    try {
      if (adminsSnapshot.length > 0) {
        final isAdmin = adminsSnapshot.firstWhere((f) {
          return f.data["id"] == id;
        }, orElse: () => null);
        return isAdmin != null;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  bool _isUserTicketer(
    User user,
    List<DocumentSnapshot> ticketersSnapshot,
  ) {
    try {
      if (ticketersSnapshot.length > 0) {
        final isTicketer = ticketersSnapshot.firstWhere((f) {
          return f.data()["email"] == user.email;
        }, orElse: () => null);
        return isTicketer != null;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
