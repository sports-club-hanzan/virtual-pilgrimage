import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: subtype_of_sealed_class
/// Firestore の QueryDocumentSnapshot はmock化できなかったので自前で用意したmock用のクラス
class MockQueryDocumentSnapshot<T extends Object?> implements QueryDocumentSnapshot<T> {
  MockQueryDocumentSnapshot(this._t);

  late DocumentSnapshot<T> snapshot;
  final T _t;

  @override
  // ignore: type_annotate_public_apis, always_declare_return_types
  operator [](Object field) {
    throw UnimplementedError();
  }

  @override
  T data() {
    return _t;
  }

  @override
  bool get exists => throw UnimplementedError();

  @override
  // ignore: type_annotate_public_apis, always_declare_return_types
  get(Object field) {
    throw UnimplementedError();
  }

  @override
  String get id => throw UnimplementedError();

  @override
  SnapshotMetadata get metadata => throw UnimplementedError();

  @override
  DocumentReference<T> get reference => throw UnimplementedError();
}
