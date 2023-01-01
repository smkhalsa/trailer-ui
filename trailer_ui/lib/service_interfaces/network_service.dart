class AccessPoint {
  String id;
  String name;
  double signalStrength;
  bool isActive;

  AccessPoint({
    required this.id,
    required this.name,
    required this.signalStrength,
    this.isActive = false,
  });
}

abstract class NetworkService {
  Stream<List<AccessPoint>> get accessPoints;

  Future<void> connect(String accessPointId, String? password);
  Future<void> disconnect();
  Future<void> forget(String accessPointId);
  Future<void> scan();
}
