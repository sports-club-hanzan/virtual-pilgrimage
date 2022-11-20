import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';
import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';

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
