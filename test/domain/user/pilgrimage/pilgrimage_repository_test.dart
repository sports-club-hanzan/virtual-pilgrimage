import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:virtualpilgrimage/domain/user/pilgrimage/pilgrimage_repository.dart';

import '../../../helper/mock.mocks.dart';
import '../../../helper/provider_container.dart';

void main() {
  final logger = Logger(level: Level.error);
  late MockFirebaseStorage mockFirebaseStorage;
  late MockReference mockReference;
  late PilgrimageRepository target;

  setUp(() {
    mockFirebaseStorage = MockFirebaseStorage();
    mockReference = MockReference();
    target = PilgrimageRepository(
      mockFirebaseStorage,
      logger,
    );
  });

  group('PilgrimageRepository', () {
    test('DI', () {
      final container = mockedProviderContainer();
      final repository = container.read(pilgrimageRepositoryProvider);
      expect(repository, isNotNull);
    });

    const String pilgrimageId = '1';
    const String filename = '1.png';
    group('getTempleImageUrl', () {
      setUp(() {
        when(mockFirebaseStorage.ref()).thenReturn(mockReference);
        when(mockReference.child(any)).thenReturn(mockReference);
        when(mockReference.getDownloadURL()).thenAnswer((_) => Future.value('http://exmaple.com/temples/$pilgrimageId/$filename'));
      });
      group('正常系', () {
        test('画像URLが出力する', () async {
          // when
          final actual = await target.getTempleImageUrl(pilgrimageId, filename);

          // then
          expect(actual, 'http://exmaple.com/temples/$pilgrimageId/$filename');
        });
      });
    });
  });
}
