import 'package:mockito/mockito.dart';

import 'mock.mocks.dart';

void defaultMockFirebaseCrashlytics(MockFirebaseCrashlytics mockFirebaseCrashlytics) {
  when(mockFirebaseCrashlytics.log(any)).thenAnswer((_) => Future.value());
  when(mockFirebaseCrashlytics.recordError(any, any, reason: anyNamed('reason')))
      .thenAnswer((_) => Future.value());
  when(mockFirebaseCrashlytics.setUserIdentifier(any)).thenAnswer((_) => Future.value());
  when(mockFirebaseCrashlytics.recordError(any, null)).thenAnswer((_) => Future.value());
}
