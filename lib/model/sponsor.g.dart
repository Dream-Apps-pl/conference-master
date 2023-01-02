// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'sponsor.dart';

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
abstract class SponsorCollectionReference
    implements
        SponsorQuery,
        FirestoreCollectionReference<Sponsor, SponsorQuerySnapshot> {
  factory SponsorCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$SponsorCollectionReference;

  static Sponsor fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return _$SponsorFromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Sponsor value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  CollectionReference<Sponsor> get reference;

  @override
  SponsorDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<SponsorDocumentReference> add(Sponsor value);
}

class _$SponsorCollectionReference extends _$SponsorQuery
    implements SponsorCollectionReference {
  factory _$SponsorCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$SponsorCollectionReference._(
      firestore.collection('sponsor').withConverter(
            fromFirestore: SponsorCollectionReference.fromFirestore,
            toFirestore: SponsorCollectionReference.toFirestore,
          ),
    );
  }

  _$SponsorCollectionReference._(
    CollectionReference<Sponsor> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  String get path => reference.path;

  @override
  CollectionReference<Sponsor> get reference =>
      super.reference as CollectionReference<Sponsor>;

  @override
  SponsorDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return SponsorDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<SponsorDocumentReference> add(Sponsor value) {
    return reference.add(value).then((ref) => SponsorDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$SponsorCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class SponsorDocumentReference
    extends FirestoreDocumentReference<Sponsor, SponsorDocumentSnapshot> {
  factory SponsorDocumentReference(DocumentReference<Sponsor> reference) =
      _$SponsorDocumentReference;

  DocumentReference<Sponsor> get reference;

  /// A reference to the [SponsorCollectionReference] containing this document.
  SponsorCollectionReference get parent {
    return _$SponsorCollectionReference(reference.firestore);
  }

  @override
  Stream<SponsorDocumentSnapshot> snapshots();

  @override
  Future<SponsorDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  /// Updates data on the document. Data will be merged with any existing
  /// document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update({
    String name,
    FieldValue nameFieldValue,
    String logo,
    FieldValue logoFieldValue,
    String url,
    FieldValue urlFieldValue,
  });

  /// Updates fields in the current document using the transaction API.
  ///
  /// The update will fail if applied to a document that does not exist.
  void transactionUpdate(
    Transaction transaction, {
    String name,
    FieldValue nameFieldValue,
    String logo,
    FieldValue logoFieldValue,
    String url,
    FieldValue urlFieldValue,
  });
}

class _$SponsorDocumentReference
    extends FirestoreDocumentReference<Sponsor, SponsorDocumentSnapshot>
    implements SponsorDocumentReference {
  _$SponsorDocumentReference(this.reference);

  @override
  final DocumentReference<Sponsor> reference;

  /// A reference to the [SponsorCollectionReference] containing this document.
  SponsorCollectionReference get parent {
    return _$SponsorCollectionReference(reference.firestore);
  }

  @override
  Stream<SponsorDocumentSnapshot> snapshots() {
    return reference.snapshots().map(SponsorDocumentSnapshot._);
  }

  @override
  Future<SponsorDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then(SponsorDocumentSnapshot._);
  }

  @override
  Future<SponsorDocumentSnapshot> transactionGet(Transaction transaction) {
    return transaction.get(reference).then(SponsorDocumentSnapshot._);
  }

  Future<void> update({
    Object? name = _sentinel,
    FieldValue? nameFieldValue,
    Object? logo = _sentinel,
    FieldValue? logoFieldValue,
    Object? url = _sentinel,
    FieldValue? urlFieldValue,
  }) async {
    assert(
      name == _sentinel || nameFieldValue == null,
      "Cannot specify both name and nameFieldValue",
    );
    assert(
      logo == _sentinel || logoFieldValue == null,
      "Cannot specify both logo and logoFieldValue",
    );
    assert(
      url == _sentinel || urlFieldValue == null,
      "Cannot specify both url and urlFieldValue",
    );
    final json = {
      if (name != _sentinel) _$SponsorFieldMap['name']!: name as String,
      if (nameFieldValue != null) _$SponsorFieldMap['name']!: nameFieldValue,
      if (logo != _sentinel) _$SponsorFieldMap['logo']!: logo as String,
      if (logoFieldValue != null) _$SponsorFieldMap['logo']!: logoFieldValue,
      if (url != _sentinel) _$SponsorFieldMap['url']!: url as String,
      if (urlFieldValue != null) _$SponsorFieldMap['url']!: urlFieldValue,
    };

    return reference.update(json);
  }

  void transactionUpdate(
    Transaction transaction, {
    Object? name = _sentinel,
    FieldValue? nameFieldValue,
    Object? logo = _sentinel,
    FieldValue? logoFieldValue,
    Object? url = _sentinel,
    FieldValue? urlFieldValue,
  }) {
    assert(
      name == _sentinel || nameFieldValue == null,
      "Cannot specify both name and nameFieldValue",
    );
    assert(
      logo == _sentinel || logoFieldValue == null,
      "Cannot specify both logo and logoFieldValue",
    );
    assert(
      url == _sentinel || urlFieldValue == null,
      "Cannot specify both url and urlFieldValue",
    );
    final json = {
      if (name != _sentinel) _$SponsorFieldMap['name']!: name as String,
      if (nameFieldValue != null) _$SponsorFieldMap['name']!: nameFieldValue,
      if (logo != _sentinel) _$SponsorFieldMap['logo']!: logo as String,
      if (logoFieldValue != null) _$SponsorFieldMap['logo']!: logoFieldValue,
      if (url != _sentinel) _$SponsorFieldMap['url']!: url as String,
      if (urlFieldValue != null) _$SponsorFieldMap['url']!: urlFieldValue,
    };

    transaction.update(reference, json);
  }

  @override
  bool operator ==(Object other) {
    return other is SponsorDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

abstract class SponsorQuery
    implements QueryReference<Sponsor, SponsorQuerySnapshot> {
  @override
  SponsorQuery limit(int limit);

  @override
  SponsorQuery limitToLast(int limit);

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
  SponsorQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    SponsorDocumentSnapshot? startAtDocument,
    SponsorDocumentSnapshot? endAtDocument,
    SponsorDocumentSnapshot? endBeforeDocument,
    SponsorDocumentSnapshot? startAfterDocument,
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
  SponsorQuery whereFieldPath(
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

  SponsorQuery whereDocumentId({
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
  SponsorQuery whereName({
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
  SponsorQuery whereLogo({
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
  SponsorQuery whereUrl({
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

  SponsorQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    SponsorDocumentSnapshot? startAtDocument,
    SponsorDocumentSnapshot? endAtDocument,
    SponsorDocumentSnapshot? endBeforeDocument,
    SponsorDocumentSnapshot? startAfterDocument,
  });

  SponsorQuery orderByName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    SponsorDocumentSnapshot? startAtDocument,
    SponsorDocumentSnapshot? endAtDocument,
    SponsorDocumentSnapshot? endBeforeDocument,
    SponsorDocumentSnapshot? startAfterDocument,
  });

  SponsorQuery orderByLogo({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    SponsorDocumentSnapshot? startAtDocument,
    SponsorDocumentSnapshot? endAtDocument,
    SponsorDocumentSnapshot? endBeforeDocument,
    SponsorDocumentSnapshot? startAfterDocument,
  });

  SponsorQuery orderByUrl({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    SponsorDocumentSnapshot? startAtDocument,
    SponsorDocumentSnapshot? endAtDocument,
    SponsorDocumentSnapshot? endBeforeDocument,
    SponsorDocumentSnapshot? startAfterDocument,
  });
}

class _$SponsorQuery extends QueryReference<Sponsor, SponsorQuerySnapshot>
    implements SponsorQuery {
  _$SponsorQuery(
    this._collection, {
    required Query<Sponsor> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  @override
  Stream<SponsorQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(SponsorQuerySnapshot._fromQuerySnapshot);
  }

  @override
  Future<SponsorQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(SponsorQuerySnapshot._fromQuerySnapshot);
  }

  @override
  SponsorQuery limit(int limit) {
    return _$SponsorQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  SponsorQuery limitToLast(int limit) {
    return _$SponsorQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  SponsorQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SponsorDocumentSnapshot? startAtDocument,
    SponsorDocumentSnapshot? endAtDocument,
    SponsorDocumentSnapshot? endBeforeDocument,
    SponsorDocumentSnapshot? startAfterDocument,
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
    return _$SponsorQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  SponsorQuery whereFieldPath(
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
    return _$SponsorQuery(
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

  SponsorQuery whereDocumentId({
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
    return _$SponsorQuery(
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

  SponsorQuery whereName({
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
    return _$SponsorQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$SponsorFieldMap['name']!,
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

  SponsorQuery whereLogo({
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
    return _$SponsorQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$SponsorFieldMap['logo']!,
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

  SponsorQuery whereUrl({
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
    return _$SponsorQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$SponsorFieldMap['url']!,
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

  SponsorQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SponsorDocumentSnapshot? startAtDocument,
    SponsorDocumentSnapshot? endAtDocument,
    SponsorDocumentSnapshot? endBeforeDocument,
    SponsorDocumentSnapshot? startAfterDocument,
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

    return _$SponsorQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  SponsorQuery orderByName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SponsorDocumentSnapshot? startAtDocument,
    SponsorDocumentSnapshot? endAtDocument,
    SponsorDocumentSnapshot? endBeforeDocument,
    SponsorDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$SponsorFieldMap['name']!,
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

    return _$SponsorQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  SponsorQuery orderByLogo({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SponsorDocumentSnapshot? startAtDocument,
    SponsorDocumentSnapshot? endAtDocument,
    SponsorDocumentSnapshot? endBeforeDocument,
    SponsorDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$SponsorFieldMap['logo']!,
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

    return _$SponsorQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  SponsorQuery orderByUrl({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    SponsorDocumentSnapshot? startAtDocument,
    SponsorDocumentSnapshot? endAtDocument,
    SponsorDocumentSnapshot? endBeforeDocument,
    SponsorDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$SponsorFieldMap['url']!,
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

    return _$SponsorQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$SponsorQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class SponsorDocumentSnapshot extends FirestoreDocumentSnapshot<Sponsor> {
  SponsorDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final DocumentSnapshot<Sponsor> snapshot;

  @override
  SponsorDocumentReference get reference {
    return SponsorDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Sponsor? data;
}

class SponsorQuerySnapshot
    extends FirestoreQuerySnapshot<Sponsor, SponsorQueryDocumentSnapshot> {
  SponsorQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  factory SponsorQuerySnapshot._fromQuerySnapshot(
    QuerySnapshot<Sponsor> snapshot,
  ) {
    final docs = snapshot.docs.map(SponsorQueryDocumentSnapshot._).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return _decodeDocumentChange(
        change,
        SponsorDocumentSnapshot._,
      );
    }).toList();

    return SponsorQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  static FirestoreDocumentChange<SponsorDocumentSnapshot>
      _decodeDocumentChange<T>(
    DocumentChange<T> docChange,
    SponsorDocumentSnapshot Function(DocumentSnapshot<T> doc) decodeDoc,
  ) {
    return FirestoreDocumentChange<SponsorDocumentSnapshot>(
      type: docChange.type,
      oldIndex: docChange.oldIndex,
      newIndex: docChange.newIndex,
      doc: decodeDoc(docChange.doc),
    );
  }

  final QuerySnapshot<Sponsor> snapshot;

  @override
  final List<SponsorQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<SponsorDocumentSnapshot>> docChanges;
}

class SponsorQueryDocumentSnapshot
    extends FirestoreQueryDocumentSnapshot<Sponsor>
    implements SponsorDocumentSnapshot {
  SponsorQueryDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final QueryDocumentSnapshot<Sponsor> snapshot;

  @override
  final Sponsor data;

  @override
  SponsorDocumentReference get reference {
    return SponsorDocumentReference(snapshot.reference);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sponsor _$SponsorFromJson(Map<String, dynamic> json) => Sponsor(
      json['name'] as String,
      json['logo'] as String,
      json['url'] as String,
      $enumDecode(_$SponsorLevelEnumMap, json['level']),
    );

const _$SponsorFieldMap = <String, String>{
  'name': 'name',
  'logo': 'logo',
  'url': 'url',
  'level': 'level',
};

Map<String, dynamic> _$SponsorToJson(Sponsor instance) => <String, dynamic>{
      'name': instance.name,
      'logo': instance.logo,
      'url': instance.url,
      'level': _$SponsorLevelEnumMap[instance.level]!,
    };

const _$SponsorLevelEnumMap = {
  SponsorLevel.platinium: 'platinium',
  SponsorLevel.gold: 'gold',
  SponsorLevel.silver: 'silver',
  SponsorLevel.bronze: 'bronze',
};
