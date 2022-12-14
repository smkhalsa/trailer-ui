enum Unit {
  F,
  C,
}

abstract class ClimateService {
  Stream<int> get targetTemp;
  Stream<int> get currentTemp;
  Stream<Unit> get unit;

  void setTemp(int temp);
}
