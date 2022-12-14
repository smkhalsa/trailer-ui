import 'package:rxdart/rxdart.dart';

import 'package:trailer_ui/service_interfaces/linear_mechanism_service.dart';

class MockLinearMechanismService extends LinearMechanismService {
  MockLinearMechanismService() {
    state.switchMap<MechanismState>((s) {
      if (s == MechanismState.stopped) {
        return NeverStream();
      } else {
        return Stream.periodic(const Duration(milliseconds: 20), (_) => s);
      }
    }).listen((s) {
      switch (s) {
        case MechanismState.extending:
          return position.add(position.value + .005);
        case MechanismState.retracting:
          return position.add(position.value - .005);
        default:
          return;
      }
    });
    position.skip(1).listen((p) {
      if (p <= 0 || p >= 1) toggle();
    });
  }

  MechanismState _previousState = MechanismState.stopped;

  @override
  final BehaviorSubject<double> position = BehaviorSubject.seeded(0);

  @override
  final BehaviorSubject<MechanismState> state =
      BehaviorSubject.seeded(MechanismState.stopped);

  @override
  void toggle() {
    final current = state.value;
    if (current == MechanismState.stopped) {
      if (_previousState == MechanismState.extending) {
        state.add(MechanismState.retracting);
      } else {
        state.add(MechanismState.extending);
      }
    } else {
      state.add(MechanismState.stopped);
    }
    _previousState = current;
  }
}
