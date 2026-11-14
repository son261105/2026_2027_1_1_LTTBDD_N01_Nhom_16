import 'package:flutter/material.dart';
import 'state/app_router.dart';

void main() => runApp(const MusicApp());

class MusicApp extends StatefulWidget {
  const MusicApp({super.key});

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  final _routerDelegate = AppRouterDelegate();

  @override
  void dispose() {
    _routerDelegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Music Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      routerDelegate: _routerDelegate,
      routeInformationParser: const AppRouteParser(),
    );
  }
}
