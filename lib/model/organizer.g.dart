// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'organizer.dart';

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
abstract class OrganizerCollectionReference
    implements
        OrganizerQuery,
        FirestoreCollectionReference<Organizer, OrganizerQuerySnapshot> {
  factory OrganizerCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$OrganizerCollectionReference;

  static Organizer fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return _$OrganizerFromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Organizer value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  CollectionReference<Organizer> get reference;

  @override
  OrganizerDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<OrganizerDocumentReference> add(Organizer value);
}

class _$OrganizerCollectionReference extends _$OrganizerQuery
    implements OrganizerCollectionReference {
  factory _$OrganizerCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$OrganizerCollectionReference._(
      firestore.collection('organizer').withConverter(
            fromFirestore: OrganizerCollectionReference.fromFirestore,
            toFirestore: OrganizerCollectionReference.toFirestore,
          ),
    );
  }

  _$OrganizerCollectionReference._(
    CollectionReference<Organizer> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  String get path => reference.path;

  @override
  CollectionReference<Organizer> get reference =>
      super.reference as CollectionReference<Organizer>;

  @override
  OrganizerDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return OrganizerDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<OrganizerDocumentReference> add(Organizer value) {
    return reference.add(value).then((ref) => OrganizerDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$OrganizerCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class OrganizerDocumentReference
    extends FirestoreDocumentReference<Organizer, OrganizerDocumentSnapshot> {
  factory OrganizerDocumentReference(DocumentReference<Organizer> reference) =
      _$OrganizerDocumentReference;

  DocumentReference<Organizer> get reference;

  /// A reference to the [OrganizerCollectionReference] containing this document.
  OrganizerCollectionReference get parent {
    return _$OrganizerCollectionReference(reference.firestore);
  }

  @override
  Stream<OrganizerDocumentSnapshot> snapshots();

  @override
  Future<OrganizerDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  /// Updates data on the document. Data will be merged with any existing
  /// document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update({
    String name,
    FieldValue nameFieldValue,
    String picture,
    FieldValue pictureFieldValue,
    String longBio,
    FieldValue longBioFieldValue,
  });

  /// Updates fields in the current document using the transaction API.
  ///
  /// The update will fail if applied to a document that does not exist.
  void transactionUpdate(
    Transaction transaction, {
    String name,
    FieldValue nameFieldValue,
    String picture,
    FieldValue pictureFieldValue,
    String longBio,
    FieldValue longBioFieldValue,
  });
}

class _$OrganizerDocumentReference
    extends FirestoreDocumentReference<Organizer, OrganizerDocumentSnapshot>
    implements OrganizerDocumentReference {
  _$OrganizerDocumentReference(this.reference);

  @override
  final DocumentReference<Organizer> reference;

  /// A reference to the [OrganizerCollectionReference] containing this document.
  OrganizerCollectionReference get parent {
    return _$OrganizerCollectionReference(reference.firestore);
  }

  @override
  Stream<OrganizerDocumentSnapshot> snapshots() {
    return reference.snapshots().map(OrganizerDocumentSnapshot._);
  }

  @override
  Future<OrganizerDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then(OrganizerDocumentSnapshot._);
  }

  @override
  Future<OrganizerDocumentSnapshot> transactionGet(Transaction transaction) {
    return transaction.get(reference).then(OrganizerDocumentSnapshot._);
  }

  Future<void> update({
    Object? name = _sentinel,
    FieldValue? nameFieldValue,
    Object? picture = _sentinel,
    FieldValue? pictureFieldValue,
    Object? longBio = _sentinel,
    FieldValue? longBioFieldValue,
  }) async {
    assert(
      name == _sentinel || nameFieldValue == null,
      "Cannot specify both name and nameFieldValue",
    );
    assert(
      picture == _sentinel || pictureFieldValue == null,
      "Cannot specify both picture and pictureFieldValue",
    );
    assert(
      longBio == _sentinel || longBioFieldValue == null,
      "Cannot specify both longBio and longBioFieldValue",
    );
    final json = {
      if (name != _sentinel) _$OrganizerFieldMap['name']!: name as String,
      if (nameFieldValue != null) _$OrganizerFieldMap['name']!: nameFieldValue,
      if (picture != _sentinel)
        _$OrganizerFieldMap['picture']!: picture as String,
      if (pictureFieldValue != null)
        _$OrganizerFieldMap['picture']!: pictureFieldValue,
      if (longBio != _sentinel)
        _$OrganizerFieldMap['longBio']!: longBio as String,
      if (longBioFieldValue != null)
        _$OrganizerFieldMap['longBio']!: longBioFieldValue,
    };

    return reference.update(json);
  }

  void transactionUpdate(
    Transaction transaction, {
    Object? name = _sentinel,
    FieldValue? nameFieldValue,
    Object? picture = _sentinel,
    FieldValue? pictureFieldValue,
    Object? longBio = _sentinel,
    FieldValue? longBioFieldValue,
  }) {
    assert(
      name == _sentinel || nameFieldValue == null,
      "Cannot specify both name and nameFieldValue",
    );
    assert(
      picture == _sentinel || pictureFieldValue == null,
      "Cannot specify both picture and pictureFieldValue",
    );
    assert(
      longBio == _sentinel || longBioFieldValue == null,
      "Cannot specify both longBio and longBioFieldValue",
    );
    final json = {
      if (name != _sentinel) _$OrganizerFieldMap['name']!: name as String,
      if (nameFieldValue != null) _$OrganizerFieldMap['name']!: nameFieldValue,
      if (picture != _sentinel)
        _$OrganizerFieldMap['picture']!: picture as String,
      if (pictureFieldValue != null)
        _$OrganizerFieldMap['picture']!: pictureFieldValue,
      if (longBio != _sentinel)
        _$OrganizerFieldMap['longBio']!: longBio as String,
      if (longBioFieldValue != null)
        _$OrganizerFieldMap['longBio']!: longBioFieldValue,
    };

    transaction.update(reference, json);
  }

  @override
  bool operator ==(Object other) {
    return other is OrganizerDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

abstract class OrganizerQuery
    implements QueryReference<Organizer, OrganizerQuerySnapshot> {
  @override
  OrganizerQuery limit(int limit);

  @override
  OrganizerQuery limitToLast(int limit);

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
  OrganizerQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    OrganizerDocumentSnapshot? startAtDocument,
    OrganizerDocumentSnapshot? endAtDocument,
    OrganizerDocumentSnapshot? endBeforeDocument,
    OrganizerDocumentSnapshot? startAfterDocument,
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
  OrganizerQuery whereFieldPath(
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

  OrganizerQuery whereDocumentId({
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
  OrganizerQuery whereName({
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
  OrganizerQuery wherePicture({
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
  OrganizerQuery whereLongBio({
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

  OrganizerQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    OrganizerDocumentSnapshot? startAtDocument,
    OrganizerDocumentSnapshot? endAtDocument,
    OrganizerDocumentSnapshot? endBeforeDocument,
    OrganizerDocumentSnapshot? startAfterDocument,
  });

  OrganizerQuery orderByName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    OrganizerDocumentSnapshot? startAtDocument,
    OrganizerDocumentSnapshot? endAtDocument,
    OrganizerDocumentSnapshot? endBeforeDocument,
    OrganizerDocumentSnapshot? startAfterDocument,
  });

  OrganizerQuery orderByPicture({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    OrganizerDocumentSnapshot? startAtDocument,
    OrganizerDocumentSnapshot? endAtDocument,
    OrganizerDocumentSnapshot? endBeforeDocument,
    OrganizerDocumentSnapshot? startAfterDocument,
  });

  OrganizerQuery orderByLongBio({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    OrganizerDocumentSnapshot? startAtDocument,
    OrganizerDocumentSnapshot? endAtDocument,
    OrganizerDocumentSnapshot? endBeforeDocument,
    OrganizerDocumentSnapshot? startAfterDocument,
  });
}

class _$OrganizerQuery extends QueryReference<Organizer, OrganizerQuerySnapshot>
    implements OrganizerQuery {
  _$OrganizerQuery(
    this._collection, {
    required Query<Organizer> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  @override
  Stream<OrganizerQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(OrganizerQuerySnapshot._fromQuerySnapshot);
  }

  @override
  Future<OrganizerQuerySnapshot> get([GetOptions? options]) {
    return reference
        .get(options)
        .then(OrganizerQuerySnapshot._fromQuerySnapshot);
  }

  @override
  OrganizerQuery limit(int limit) {
    return _$OrganizerQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  OrganizerQuery limitToLast(int limit) {
    return _$OrganizerQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  OrganizerQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    OrganizerDocumentSnapshot? startAtDocument,
    OrganizerDocumentSnapshot? endAtDocument,
    OrganizerDocumentSnapshot? endBeforeDocument,
    OrganizerDocumentSnapshot? startAfterDocument,
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
    return _$OrganizerQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  OrganizerQuery whereFieldPath(
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
    return _$OrganizerQuery(
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

  OrganizerQuery whereDocumentId({
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
    return _$OrganizerQuery(
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

  OrganizerQuery whereName({
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
    return _$OrganizerQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$OrganizerFieldMap['name']!,
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

  OrganizerQuery wherePicture({
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
    return _$OrganizerQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$OrganizerFieldMap['picture']!,
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

  OrganizerQuery whereLongBio({
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
    return _$OrganizerQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$OrganizerFieldMap['longBio']!,
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

  OrganizerQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    OrganizerDocumentSnapshot? startAtDocument,
    OrganizerDocumentSnapshot? endAtDocument,
    OrganizerDocumentSnapshot? endBeforeDocument,
    OrganizerDocumentSnapshot? startAfterDocument,
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

    return _$OrganizerQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  OrganizerQuery orderByName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    OrganizerDocumentSnapshot? startAtDocument,
    OrganizerDocumentSnapshot? endAtDocument,
    OrganizerDocumentSnapshot? endBeforeDocument,
    OrganizerDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$OrganizerFieldMap['name']!,
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

    return _$OrganizerQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  OrganizerQuery orderByPicture({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    OrganizerDocumentSnapshot? startAtDocument,
    OrganizerDocumentSnapshot? endAtDocument,
    OrganizerDocumentSnapshot? endBeforeDocument,
    OrganizerDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor
        .orderBy(_$OrganizerFieldMap['picture']!, descending: descending);
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

    return _$OrganizerQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  OrganizerQuery orderByLongBio({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    OrganizerDocumentSnapshot? startAtDocument,
    OrganizerDocumentSnapshot? endAtDocument,
    OrganizerDocumentSnapshot? endBeforeDocument,
    OrganizerDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor
        .orderBy(_$OrganizerFieldMap['longBio']!, descending: descending);
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

    return _$OrganizerQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$OrganizerQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class OrganizerDocumentSnapshot extends FirestoreDocumentSnapshot<Organizer> {
  OrganizerDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final DocumentSnapshot<Organizer> snapshot;

  @override
  OrganizerDocumentReference get reference {
    return OrganizerDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Organizer? data;
}

class OrganizerQuerySnapshot
    extends FirestoreQuerySnapshot<Organizer, OrganizerQueryDocumentSnapshot> {
  OrganizerQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  factory OrganizerQuerySnapshot._fromQuerySnapshot(
    QuerySnapshot<Organizer> snapshot,
  ) {
    final docs = snapshot.docs.map(OrganizerQueryDocumentSnapshot._).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return _decodeDocumentChange(
        change,
        OrganizerDocumentSnapshot._,
      );
    }).toList();

    return OrganizerQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  static FirestoreDocumentChange<OrganizerDocumentSnapshot>
      _decodeDocumentChange<T>(
    DocumentChange<T> docChange,
    OrganizerDocumentSnapshot Function(DocumentSnapshot<T> doc) decodeDoc,
  ) {
    return FirestoreDocumentChange<OrganizerDocumentSnapshot>(
      type: docChange.type,
      oldIndex: docChange.oldIndex,
      newIndex: docChange.newIndex,
      doc: decodeDoc(docChange.doc),
    );
  }

  final QuerySnapshot<Organizer> snapshot;

  @override
  final List<OrganizerQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<OrganizerDocumentSnapshot>> docChanges;
}

class OrganizerQueryDocumentSnapshot
    extends FirestoreQueryDocumentSnapshot<Organizer>
    implements OrganizerDocumentSnapshot {
  OrganizerQueryDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final QueryDocumentSnapshot<Organizer> snapshot;

  @override
  final Organizer data;

  @override
  OrganizerDocumentReference get reference {
    return OrganizerDocumentReference(snapshot.reference);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organizer _$OrganizerFromJson(Map<String, dynamic> json) => Organizer(
      json['name'] as String,
      json['picture'] as String,
      json['longBio'] as String,
    );

const _$OrganizerFieldMap = <String, String>{
  'name': 'name',
  'picture': 'picture',
  'longBio': 'longBio',
};

Map<String, dynamic> _$OrganizerToJson(Organizer instance) => <String, dynamic>{
      'name': instance.name,
      'picture': instance.picture,
      'longBio': instance.longBio,
    };
