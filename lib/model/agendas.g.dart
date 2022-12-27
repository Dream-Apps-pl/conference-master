// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'agendas.dart';

// **************************************************************************
// CollectionGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, use_super_parameters

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class AgendasCollectionReference
    implements
        AgendasQuery,
        FirestoreCollectionReference<Agendas, AgendasQuerySnapshot> {
  factory AgendasCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$AgendasCollectionReference;

  static Agendas fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return _$AgendasFromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Agendas value,
    SetOptions? options,
  ) {
    return _$AgendasToJson(value);
  }

  @override
  CollectionReference<Agendas> get reference;

  @override
  AgendasDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<AgendasDocumentReference> add(Agendas value);
}

class _$AgendasCollectionReference extends _$AgendasQuery
    implements AgendasCollectionReference {
  factory _$AgendasCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$AgendasCollectionReference._(
      firestore.collection('agenda').withConverter(
            fromFirestore: AgendasCollectionReference.fromFirestore,
            toFirestore: AgendasCollectionReference.toFirestore,
          ),
    );
  }

  _$AgendasCollectionReference._(
    CollectionReference<Agendas> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  String get path => reference.path;

  @override
  CollectionReference<Agendas> get reference =>
      super.reference as CollectionReference<Agendas>;

  @override
  AgendasDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return AgendasDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<AgendasDocumentReference> add(Agendas value) {
    return reference.add(value).then((ref) => AgendasDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$AgendasCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class AgendasDocumentReference
    extends FirestoreDocumentReference<Agendas, AgendasDocumentSnapshot> {
  factory AgendasDocumentReference(DocumentReference<Agendas> reference) =
      _$AgendasDocumentReference;

  DocumentReference<Agendas> get reference;

  /// A reference to the [AgendasCollectionReference] containing this document.
  AgendasCollectionReference get parent {
    return _$AgendasCollectionReference(reference.firestore);
  }

  @override
  Stream<AgendasDocumentSnapshot> snapshots();

  @override
  Future<AgendasDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();
}

class _$AgendasDocumentReference
    extends FirestoreDocumentReference<Agendas, AgendasDocumentSnapshot>
    implements AgendasDocumentReference {
  _$AgendasDocumentReference(this.reference);

  @override
  final DocumentReference<Agendas> reference;

  /// A reference to the [AgendasCollectionReference] containing this document.
  AgendasCollectionReference get parent {
    return _$AgendasCollectionReference(reference.firestore);
  }

  @override
  Stream<AgendasDocumentSnapshot> snapshots() {
    return reference.snapshots().map(AgendasDocumentSnapshot._);
  }

  @override
  Future<AgendasDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then(AgendasDocumentSnapshot._);
  }

  @override
  Future<AgendasDocumentSnapshot> transactionGet(Transaction transaction) {
    return transaction.get(reference).then(AgendasDocumentSnapshot._);
  }

  @override
  bool operator ==(Object other) {
    return other is AgendasDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

abstract class AgendasQuery
    implements QueryReference<Agendas, AgendasQuerySnapshot> {
  @override
  AgendasQuery limit(int limit);

  @override
  AgendasQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  AgendasQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    AgendasDocumentSnapshot? startAtDocument,
    AgendasDocumentSnapshot? endAtDocument,
    AgendasDocumentSnapshot? endBeforeDocument,
    AgendasDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  AgendasQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  AgendasQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });

  AgendasQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    AgendasDocumentSnapshot? startAtDocument,
    AgendasDocumentSnapshot? endAtDocument,
    AgendasDocumentSnapshot? endBeforeDocument,
    AgendasDocumentSnapshot? startAfterDocument,
  });
}

class _$AgendasQuery extends QueryReference<Agendas, AgendasQuerySnapshot>
    implements AgendasQuery {
  _$AgendasQuery(
    this._collection, {
    required Query<Agendas> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  @override
  Stream<AgendasQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(AgendasQuerySnapshot._fromQuerySnapshot);
  }

  @override
  Future<AgendasQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(AgendasQuerySnapshot._fromQuerySnapshot);
  }

  @override
  AgendasQuery limit(int limit) {
    return _$AgendasQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  AgendasQuery limitToLast(int limit) {
    return _$AgendasQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  AgendasQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    AgendasDocumentSnapshot? startAtDocument,
    AgendasDocumentSnapshot? endAtDocument,
    AgendasDocumentSnapshot? endBeforeDocument,
    AgendasDocumentSnapshot? startAfterDocument,
  }) {
    final query =
        $referenceWithoutCursor.orderBy(fieldPath, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }
    return _$AgendasQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  AgendasQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$AgendasQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      $queryCursor: $queryCursor,
    );
  }

  AgendasQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$AgendasQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  AgendasQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    AgendasDocumentSnapshot? startAtDocument,
    AgendasDocumentSnapshot? endAtDocument,
    AgendasDocumentSnapshot? endBeforeDocument,
    AgendasDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(FieldPath.documentId,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$AgendasQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$AgendasQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class AgendasDocumentSnapshot extends FirestoreDocumentSnapshot<Agendas> {
  AgendasDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final DocumentSnapshot<Agendas> snapshot;

  @override
  AgendasDocumentReference get reference {
    return AgendasDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Agendas? data;
}

class AgendasQuerySnapshot
    extends FirestoreQuerySnapshot<Agendas, AgendasQueryDocumentSnapshot> {
  AgendasQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  factory AgendasQuerySnapshot._fromQuerySnapshot(
    QuerySnapshot<Agendas> snapshot,
  ) {
    final docs = snapshot.docs.map(AgendasQueryDocumentSnapshot._).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return _decodeDocumentChange(
        change,
        AgendasDocumentSnapshot._,
      );
    }).toList();

    return AgendasQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  static FirestoreDocumentChange<AgendasDocumentSnapshot>
      _decodeDocumentChange<T>(
    DocumentChange<T> docChange,
    AgendasDocumentSnapshot Function(DocumentSnapshot<T> doc) decodeDoc,
  ) {
    return FirestoreDocumentChange<AgendasDocumentSnapshot>(
      type: docChange.type,
      oldIndex: docChange.oldIndex,
      newIndex: docChange.newIndex,
      doc: decodeDoc(docChange.doc),
    );
  }

  final QuerySnapshot<Agendas> snapshot;

  @override
  final List<AgendasQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<AgendasDocumentSnapshot>> docChanges;
}

class AgendasQueryDocumentSnapshot
    extends FirestoreQueryDocumentSnapshot<Agendas>
    implements AgendasDocumentSnapshot {
  AgendasQueryDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final QueryDocumentSnapshot<Agendas> snapshot;

  @override
  final Agendas data;

  @override
  AgendasDocumentReference get reference {
    return AgendasDocumentReference(snapshot.reference);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agendas _$AgendasFromJson(Map<String, dynamic> json) => Agendas(
      dayOne: (json['day_one'] as List<dynamic>?)
          ?.map((e) => Talk.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

const _$AgendasFieldMap = <String, String>{
  'dayOne': 'day_one',
};

Map<String, dynamic> _$AgendasToJson(Agendas instance) => <String, dynamic>{
      'day_one': instance.dayOne?.map((e) => e.toJson()).toList(),
    };
