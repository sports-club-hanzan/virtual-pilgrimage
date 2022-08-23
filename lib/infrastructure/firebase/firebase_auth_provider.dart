import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider =
    Provider.autoDispose<FirebaseAuth>((_) => FirebaseAuth.instance);

final firebaseAuthUserStateProvider = StateProvider.autoDispose<User?>(
  (_) => FirebaseAuth.instance.currentUser,
);

// ref. https://torikatsu923.hatenablog.com/entry/2022/04/17/131146
final _prevUser = StateProvider<User?>((ref) => null);

extension StreamExtention<T> on Stream<T> {
  Future<T> next() {
    final completer = Completer<T>();
    final sub = listen(null);
    sub.onData((e) {
      sub.cancel();
      completer.complete(e);
    });
    return completer.future;
  }
}

final firebaseAuthUserStateChangeProvider = StreamProvider.autoDispose<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges().transform(
    StreamTransformer.fromHandlers(
      handleData: ((data, sink) {
        if (data != ref.read(_prevUser)) {
          sink.add(data);
          ref.read(_prevUser.notifier).update((_) => data);
        }
      }),
    ),
  ),
);
