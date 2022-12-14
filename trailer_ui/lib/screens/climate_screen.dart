import 'package:flutter/material.dart';

class ClimateScreen extends StatelessWidget {
  const ClimateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Climate"),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid.extent(
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              maxCrossAxisExtent: 250,
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
