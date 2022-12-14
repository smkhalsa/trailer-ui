import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:trailer_ui/service_interfaces/energy_service.dart';

class Energy extends StatelessWidget {
  Energy({super.key});

  final energyService = GetIt.I<EnergyService>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () => context.go("/energy"),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.bolt,
                        size: 48,
                      ),
                    ),
                    StreamBuilder(
                      initialData: 0,
                      stream: energyService.charge,
                      builder: (context, snapshot) => RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: (snapshot.data! / 1000).toStringAsFixed(0),
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          TextSpan(
                            text: " kWh",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                  initialData: 0,
                  stream: energyService.netEnergy,
                  builder: (context, snapshot) {
                    final isNegative = snapshot.data!.isNegative;
                    return Text(
                      "${isNegative ? "-" : "+"} ${(snapshot.data!.abs() / 1000).toStringAsFixed(2)} kw",
                      style: TextStyle(
                        color: isNegative ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: StreamBuilder(
                stream: energyService.chargePercentage,
                builder: (context, snapshot) => ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: LinearProgressIndicator(
                    minHeight: 10,
                    value: snapshot.data,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
