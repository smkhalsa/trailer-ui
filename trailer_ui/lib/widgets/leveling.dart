import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:trailer_ui/service_interfaces/linear_mechanism_service.dart';

class Leveling extends StatelessWidget {
  Leveling({super.key});

  final mechanismsService =
      GetIt.I<LinearMechanismService>(instanceName: "leveling");

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () => mechanismsService.toggle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.expand,
                    size: 48,
                  ),
                ),
                Text(
                  "Jacks",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                StreamBuilder(
                  stream: mechanismsService.position,
                  builder: (context, snapshot) => Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    width: 100,
                    child: LinearProgressIndicator(
                      value: snapshot.data,
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: mechanismsService.stateText,
                  builder: (context, snapshot) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${snapshot.data}"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
