import 'package:virtualpilgrimage/application/pilgrimage/temple_repository.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/temple_info.codegen.dart';

class FakeTempleRepository extends TempleRepository {
  FakeTempleRepository(this.temples);

  final Map<int, TempleInfo> temples;

  @override
  Future<TempleInfo> getTempleInfo(int templeId) {
    final temple = temples[templeId];
    return Future.value(temple ?? temples.values.first);
  }

  @override
  Future<List<TempleInfo>> getTempleInfoWithPaging({required int limit}) {
    return Future.value(temples.values.toList());
  }
}
