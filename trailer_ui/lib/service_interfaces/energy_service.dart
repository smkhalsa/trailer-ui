import 'package:rxdart/rxdart.dart';

abstract class EnergyService {
  /// Remaining charge in Watt Hours
  Stream<double> get charge;

  /// Remaining charge %
  Stream<double> get chargePercentage;

  /// Load in Watts
  Stream<double> get load;

  /// Generation in Watts
  Stream<double> get generation;

  /// Generation - load in watts
  late Stream<double> netEnergy = CombineLatestStream(
      [generation, load], (values) => values[0] - values[1]);
}
