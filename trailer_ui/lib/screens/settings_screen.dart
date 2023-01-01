import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../service_interfaces/network_service.dart';

class SettingsScreen extends StatelessWidget {
  final networkService = GetIt.I<NetworkService>();

  SettingsScreen({super.key});

  Widget iconForSignalStrength(double strength) {
    if (strength < .25) {
      return const Icon(
        Icons.network_wifi_1_bar,
      );
    } else if (strength < .50) {
      return const Icon(
        Icons.network_wifi_2_bar,
      );
    } else if (strength < .75) {
      return const Icon(
        Icons.network_wifi_3_bar,
      );
    } else {
      return const Icon(
        Icons.network_wifi,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          IconButton(
            onPressed: () => networkService.scan(),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: StreamBuilder(
          initialData: const <AccessPoint>[],
          stream: networkService.accessPoints,
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final accessPoint = snapshot.data!.elementAt(index);

                return ListTile(
                  title: Text(accessPoint.name),
                  trailing: iconForSignalStrength(accessPoint.signalStrength),
                  subtitle:
                      accessPoint.isActive ? const Text("Connected") : null,
                  onTap: () {},
                );
              },
              itemCount: snapshot.data!.length,
            );
          }),
    );
  }
}
