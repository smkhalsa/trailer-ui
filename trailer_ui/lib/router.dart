import 'package:go_router/go_router.dart';

import 'package:trailer_ui/screens/home_screen.dart';
import 'package:trailer_ui/screens/climate_screen.dart';
import 'package:trailer_ui/screens/energy_screen.dart';
import 'package:trailer_ui/screens/water_screen.dart';
import 'package:trailer_ui/screens/settings_screen.dart';

final router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomeScreen(), routes: [
    GoRoute(
      path: "climate",
      builder: (context, state) => const ClimateScreen(),
    ),
    GoRoute(
      path: "energy",
      builder: (context, state) => const EnergyScreen(),
    ),
    GoRoute(
      path: "water",
      builder: (context, state) => const WaterScreen(),
    ),
    GoRoute(
      path: "settings",
      builder: (context, state) => SettingsScreen(),
    ),
  ]),
]);
