import 'package:rxdart/rxdart.dart';

import 'package:trailer_ui/service_interfaces/climate_service.dart';

class MockClimateService extends ClimateService {
  @override
  final BehaviorSubject<int> currentTemp = BehaviorSubject<int>.seeded(68);

  @override
  final BehaviorSubject<int> targetTemp = BehaviorSubject<int>.seeded(72);

  @override
  final BehaviorSubject<Unit> unit = BehaviorSubject<Unit>.seeded(Unit.F);

  @override
  void setTemp(int temp) {
    targetTemp.add(temp);
  }
}
