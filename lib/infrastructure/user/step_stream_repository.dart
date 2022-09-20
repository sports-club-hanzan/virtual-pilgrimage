import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pedometer/pedometer.dart';

final stepStreamProvider = StreamProvider<StepCount>((_) => Pedometer.stepCountStream);
final gettableStepStatusStreamProvider =
    StreamProvider<PedestrianStatus>((_) => Pedometer.pedestrianStatusStream);

class StepStreamRepository {
  StepStreamRepository(this._stepCountStream, this._logger);

  final Stream<StepCount> _stepCountStream;
  final Logger _logger;

  /// 最新の歩数情報を取得
  Future<StepCount> getLatestStep() async {
    final step = await _stepCountStream.last;
    _logger.d(step);
    return step;
  }
}
