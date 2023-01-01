import 'package:dbus/dbus.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

import 'package:trailer_ui/service_interfaces/network_service.dart';

class NMNetworkService extends NetworkService {
  final DBusClient _client;
  late String _wifiDevicePath;

  NMNetworkService() : _client = DBusClient.system();

  /// This method must be run before any others
  Future<void> init() async {
    final wifiPath = await _getWifiDevice();
    if (wifiPath == null) throw Exception("No Wifi Device Found");
    _wifiDevicePath = wifiPath;
  }

  Future<void> dispose() async {
    await _client.close();
  }

  /// Helper method to create a DBus Object for Network Manager
  DBusRemoteObject _nmObject(String path) => DBusRemoteObject(
        _client,
        name: 'org.freedesktop.NetworkManager', // don't change this
        path: DBusObjectPath(path),
      );

  /// Returns a List of paths for all devices
  Future<List<String>> _getDevicePaths() async {
    final object = _nmObject('/org/freedesktop/NetworkManager');
    final result = await object
        .callMethod('org.freedesktop.NetworkManager', 'GetDevices', []);
    return result.values.first.asStringArray().toList();
  }

  /// Gets all properties for a given device
  Future<Map<String, DBusValue>> _getDeviceProps(String path) async {
    final object = _nmObject(path);
    return await object
        .getAllProperties('org.freedesktop.NetworkManager.Device');
  }

  /// Returns the path for the first "wifi" device found
  Future<String?> _getWifiDevice() async {
    for (var path in await _getDevicePaths()) {
      final device = await _getDeviceProps(path);

      /// DeviceType of "2" is a wifi device. Read more about device types here
      /// https://developer-old.gnome.org/NetworkManager/stable/nm-dbus-types.html#NMDeviceType
      final deviceType = device['DeviceType']!.asUint32();
      if (deviceType == 2) {
        return path;
      }
    }
    return null;
  }

  Stream<Map<String, DBusValue>> get _wirelessDeviceProps {
    final obj = _nmObject(_wifiDevicePath);
    return obj
        .getAllProperties("org.freedesktop.NetworkManager.Device.Wireless")
        .asStream()
        .concatWith([
      obj.propertiesChanged.map((props) => props.changedProperties)
    ]).scan(
      (accumulated, value, index) => ({...accumulated, ...value}),
      {},
    );
  }

  Future<AccessPoint?> _getAccessPointDetails(String accessPointPath) async {
    var object = _nmObject(accessPointPath);
    Map<String, DBusValue> properties;
    try {
      properties = await object
          .getAllProperties('org.freedesktop.NetworkManager.AccessPoint');
    } catch (e) {
      return null;
    }

    final name = utf8.decode(properties["Ssid"]!.asByteArray().toList());

    /// TODO: this is of type Byte (hexidecimal). It should be converted to a decimal
    final signalStrength = (properties["Strength"]!.asByte() / 100);

    return AccessPoint(
      id: accessPointPath,
      name: name,
      signalStrength: signalStrength,
    );
  }

  @override
  Stream<List<AccessPoint>> get accessPoints {
    return _wirelessDeviceProps.switchMap(
      (props) => Future.wait(
        props["AccessPoints"]!.asStringArray().map(
              (path) => _getAccessPointDetails(path),
            ),
      )
          .then(
            (accessPoints) => accessPoints
                // Filter out nulls
                .whereType<AccessPoint>()
                // Add active flag
                .map(
                  (accessPoint) =>
                      accessPoint.id == props["ActiveAccessPoint"]!.asString()
                          ? AccessPoint(
                              id: accessPoint.id,
                              name: accessPoint.name,
                              signalStrength: accessPoint.signalStrength,
                              isActive: true,
                            )
                          : accessPoint,
                )
                .toList(),
          )
          .asStream(),
    );
  }

  @override
  Future<void> disconnect() async {
    if (_wifiDevicePath == null) return;
    await _nmObject(_wifiDevicePath)
        .callMethod('org.freedesktop.NetworkManager.Device', "Disconnect", []);
  }

  @override
  Future<void> forget(String accessPointId) {
    // TODO: implement forget
    throw UnimplementedError();
  }

  @override
  Future<void> scan() async {
    await _nmObject(_wifiDevicePath).callMethod(
        "org.freedesktop.NetworkManager.Device.Wireless", "RequestScan", []);
  }

  @override
  Future<void> connect(String accessPointId, String? password) {
    // TODO: implement connect
    throw UnimplementedError();
  }
}
