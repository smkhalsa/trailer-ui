import 'dart:math';
import 'package:rxdart/rxdart.dart';

import 'package:trailer_ui/service_interfaces/energy_service.dart';

class MockEnergyService extends EnergyService {
  MockEnergyService() {
    Stream.periodic(const Duration(seconds: 5)).listen((_) {
      charge.add(charge.value + generation.value / 720 - load.value / 720);
      load.add(load.value + Random().nextInt(1000) - 500);
      generation.add(generation.value + Random().nextInt(1000) - 500);
    });
  }

  static const double _capacity = 50000;

  @override
  final BehaviorSubject<double> charge = BehaviorSubject<double>.seeded(25000);

  @override
  late Stream<double> chargePercentage = charge.map((c) => c / _capacity);

  @override
  final BehaviorSubject<double> load = BehaviorSubject<double>.seeded(2000);

  @override
  final BehaviorSubject<double> generation =
      BehaviorSubject<double>.seeded(2000);
}
