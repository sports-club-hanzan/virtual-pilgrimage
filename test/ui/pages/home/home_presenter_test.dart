import 'package:flutter_test/flutter_test.dart';
import 'package:virtualpilgrimage/ui/pages/home/home_presenter.dart';

import '../../../helper/provider_container.dart';

void main() {
  late HomePresenter target;

  setUp(() {
    final container = mockedProviderContainer();
    target = container.read(homeProvider.notifier);
  });

  group('HomePresenter', () {
    test('DI', () {
      expect(target, isNotNull);
    });

    // TODO(s14t284): UIやPresenterのテストを必要に応じて書く
  });
}
