import 'package:flutter_test/flutter_test.dart';
import 'package:virtualpilgrimage/ui/pages/registration/registration_presenter.dart';

import '../../../helper/provider_container.dart';

void main() {
  late RegistrationPresenter target;

  setUp(() {
    final container = mockedProviderContainer();
    target = container.read(registrationPresenterProvider.notifier);
  });

  group('RegistrationPresenter', () {
    test('DI', () {
      expect(target, isNotNull);
    });

    // TODO(s14t284): UIやPresenterのテストを必要に応じて書く
  });
}
