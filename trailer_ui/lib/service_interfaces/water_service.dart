abstract class WaterService {
  /// Fresh water level in gallons
  Stream<double> get freshLevel;

  /// Fresh water percent full
  Stream<double> get freshPercentage;

  /// Grey water level in gallons
  Stream<double> get greyLevel;

  /// Grey water percent full
  Stream<double> get greyPercentage;

  /// Wash (filtered) water level in gallons
  Stream<double> get washLevel;

  /// Wash (filtered) water percent full
  Stream<double> get washPercentage;
}
