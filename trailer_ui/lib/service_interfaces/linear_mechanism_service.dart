import 'package:rxdart/rxdart.dart';

enum MechanismState {
  stopped,
  retracting,
  extending,
}

abstract class LinearMechanismService {
  /// Percentage with 0 fully retracted and 1 fully extended
  Stream<double> get position;

  Stream<MechanismState> get state;

  void toggle();

  late Stream<String> stateText =
      CombineLatestStream([position, state], (values) {
    final p = values[0] as double;
    final s = values[1] as MechanismState;
    switch (s) {
      case MechanismState.stopped:
        {
          if (p <= 0.0) {
            return "Retracted";
          } else if (p >= 1.0) {
            return "Extended";
          } else {
            return "Paused";
          }
        }
      case MechanismState.extending:
        return "Extending";
      case MechanismState.retracting:
        return "Retracting";
    }
  }).distinct();
}
