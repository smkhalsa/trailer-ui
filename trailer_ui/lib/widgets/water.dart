import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:trailer_ui/service_interfaces/water_service.dart';

class Water extends StatelessWidget {
  Water({super.key});

  final waterService = GetIt.I<WaterService>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () => context.go("/water"),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.opacity,
                size: 48,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                  stream: waterService.freshLevel,
                  builder: (context, snapshot) => Text(
                    "Fresh: ${snapshot.data?.toStringAsFixed(0)} gal",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                StreamBuilder(
                  stream: waterService.freshPercentage,
                  builder: (context, snapshot) => Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    width: 100,
                    child: LinearProgressIndicator(
                      value: snapshot.data,
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: waterService.greyLevel,
                  builder: (context, snapshot) => Text(
                    "Grey: ${snapshot.data?.toStringAsFixed(0)} gal",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                StreamBuilder(
                  stream: waterService.greyPercentage,
                  builder: (context, snapshot) => Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    width: 100,
                    child: LinearProgressIndicator(
                      value: snapshot.data,
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: waterService.washLevel,
                  builder: (context, snapshot) => Text(
                    "Wash: ${snapshot.data?.toStringAsFixed(0)} gal",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                StreamBuilder(
                  stream: waterService.washLevel,
                  builder: (context, snapshot) => Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    width: 100,
                    child: LinearProgressIndicator(
                      value: snapshot.data,
                    ),
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
