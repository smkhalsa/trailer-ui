import 'package:flutter/material.dart';
import 'package:trailer_ui/scroll_behavior.dart';
import 'package:trailer_ui/setup.dart';
import 'package:trailer_ui/router.dart';
import 'package:trailer_ui/theme.dart';

void main() {
  /// TODO: replace with production services
  setupMockServices();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: theme,
      scrollBehavior: AppScrollBehavior(),
    );
  }
}
