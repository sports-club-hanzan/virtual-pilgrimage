import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((_) => FirebaseAuth.instance);

final firebaseAuthUserStateProvider = StateProvider.autoDispose<User?>(
  (_) => FirebaseAuth.instance.currentUser,
);
