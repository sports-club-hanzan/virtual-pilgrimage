import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/auth/auth_repository.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_auth_provider.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_provider.dart';

import 'mock.mocks.dart';

final defaultOverrides = <Override>[
  // firebase
  firebaseAuthProvider.overrideWithValue(MockFirebaseAuth()),
  firebaseCrashlyticsProvider.overrideWithValue(MockFirebaseCrashlytics()),
  firestoreProvider.overrideWithValue(MockFirebaseFirestore()),
  firebaseAuthUserStateProvider.overrideWithValue(StateController(MockUser())),
  // google signIn
  googleSignInProvider.overrideWithValue(MockGoogleSignIn()),
];

ProviderContainer mockedProviderContainer({List<Override>? overrides}) => ProviderContainer(
      overrides: [
        ...defaultOverrides,
        ...?overrides,
      ],
    );
