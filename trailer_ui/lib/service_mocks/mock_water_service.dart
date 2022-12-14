import 'package:rxdart/rxdart.dart';
import 'package:trailer_ui/service_interfaces/water_service.dart';

class MockWaterService extends WaterService {
  final _freshCapacity = 100;
  final _greyCapacity = 75;
  final _washCapacity = 16;

  @override
  final BehaviorSubject<double> freshLevel = BehaviorSubject.seeded(100);

  @override
  late Stream<double> freshPercentage =
      freshLevel.map((level) => level / _freshCapacity);

  @override
  final BehaviorSubject<double> greyLevel = BehaviorSubject.seeded(25);

  @override
  late Stream<double> greyPercentage =
      greyLevel.map((level) => level / _greyCapacity);

  @override
  final BehaviorSubject<double> washLevel = BehaviorSubject.seeded(8);

  @override
  late Stream<double> washPercentage =
      washLevel.map((level) => level / _washCapacity);
}
