import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:virtualpilgrimage/domain/user/user_icon_repository.dart';
import '../../helper/provider_container.dart';

@GenerateMocks([http.Client])
void main() {
  late UserIconRepository target;

  setUp(() {
    target = UserIconRepository();
  });

  group('UserIconRepository', () {
    test('DI', () {
      final container = mockedProviderContainer();
      final repository = container.read(userIconRepositoryProvider);
      expect(repository, isNotNull);
    });

    group('get', () {
      const userIconUrl = 'https://example.com/example.png';

      group('正常系', () {
        setUp(() {
          MockClient((_) async =>
            http.Response('assets', 200),
          );
        });
        test('画像が取得できる', () async {
          //then
          final actual = await target.loadIconImage(userIconUrl);
          expect(actual, isA<BitmapDescriptor>());
        });
      });
    });
  });
}
