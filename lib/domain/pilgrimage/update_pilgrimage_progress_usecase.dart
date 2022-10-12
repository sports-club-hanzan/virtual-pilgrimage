import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/update_pilgrimage_progress_interactor.dart';
import 'package:virtualpilgrimage/domain/pilgrimage/update_pilgrimage_progress_result.dart';
import 'package:virtualpilgrimage/domain/temple/temple_repository.dart';
import 'package:virtualpilgrimage/domain/user/health/health_repository.dart';
import 'package:virtualpilgrimage/domain/user/user_repository.dart';
import 'package:virtualpilgrimage/domain/user/virtual_pilgrimage_user.codegen.dart';

final updatePilgrimageProgressUsecaseProvider = Provider<UpdatePilgrimageProgressUsecase>(
  (ref) => UpdatePilgrimageProgressInteractor(
    ref.read(templeRepositoryProvider),
    ref.read(healthRepositoryProvider),
    ref.read(userRepositoryProvider),
  ),
);

// お遍路の進捗を更新するUseCase
abstract class UpdatePilgrimageProgressUsecase {
  /// お遍路の進捗状況を更新
  ///
  /// [user] 更新対象のユーザ情報
  Future<UpdatePilgrimageProgressResult> execute(VirtualPilgrimageUser user);
}
