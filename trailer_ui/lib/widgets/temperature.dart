import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:trailer_ui/service_interfaces/climate_service.dart';

class Temperature extends StatelessWidget {
  Temperature({super.key});

  final climateService = GetIt.I<ClimateService>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () => context.go("/climate"),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Icon(
                    Icons.thermostat,
                    size: 48,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: climateService.currentTemp,
                      builder: (context, snapshot) => Text(
                        "${snapshot.data}°",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    StreamBuilder(
                      stream: climateService.targetTemp,
                      builder: (context, snapshot) => Text.rich(
                        TextSpan(text: "Set to ", children: [
                          TextSpan(
                            text: "${snapshot.data}°",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: StreamBuilder(
                initialData: Unit.F,
                stream: climateService.unit,
                builder: (context, snapshot) => Text(
                  snapshot.data!.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.outline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
