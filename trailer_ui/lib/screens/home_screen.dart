import 'package:flutter/material.dart';
import 'package:trailer_ui/widgets/awning.dart';
import 'package:trailer_ui/widgets/deck.dart';
import 'package:trailer_ui/widgets/leveling.dart';
import 'package:trailer_ui/widgets/temperature.dart';
import 'package:trailer_ui/widgets/energy.dart';
import 'package:trailer_ui/widgets/bed.dart';
import 'package:trailer_ui/widgets/water.dart';
import 'package:trailer_ui/widgets/settings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Vela"),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid.extent(
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              maxCrossAxisExtent: 250,
              children: [
                Temperature(),
                Energy(),
                Water(),
                Bed(),
                Awning(),
                Deck(),
                Leveling(),
                Settings(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
