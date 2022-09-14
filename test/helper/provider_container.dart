import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/auth/auth_repository.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_analytics_provider.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_auth_provider.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firebase_crashlytics_provider.dart';
import 'package:virtualpilgrimage/infrastructure/firebase/firestore_provider.dart';

import 'mock.mocks.dart';

final defaultOverrides = <Override>[
  // firebase
  firebaseAuthProvider.overrideWithValue(MockFirebaseAuth()),
  firestoreProvider.overrideWithValue(MockFirebaseFirestore()),
  firebaseAuthUserStateProvider.overrideWithValue(StateController(MockUser())),
  firebaseCrashlyticsProvider.overrideWithValue(MockFirebaseCrashlytics()),
  firebaseAnalyticsProvider.overrideWithValue(MockFirebaseAnalytics()),
  // google signIn
  googleSignInProvider.overrideWithValue(MockGoogleSignIn()),
];

ProviderContainer mockedProviderContainer({List<Override>? overrides}) => ProviderContainer(
      overrides: [
        ...defaultOverrides,
        ...?overrides,
      ],
    );
