import 'package:virtualpilgrimage/domain/temple/temple_info.codegen.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';

class FakeTempleRepository extends TempleRepository {
  FakeTempleRepository(this.templeInfo);

  final TempleInfo templeInfo;

  @override
  Future<TempleInfo> getTempleInfo(int templeId) {
    return Future.value(templeInfo);
  }

  @override
  Future<void> getTempleInfoAll() {
    return Future.value();
  }
}
