import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'state/app_language.dart';
import 'state/app_router.dart';
import 'state/app_translations.dart';

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
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: appLanguage,
      builder: (context, language, _) => MaterialApp.router(
        title: 'Music Web',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        locale: Locale(language == AppLanguage.vietnamese ? 'vi' : 'en'),
        supportedLocales: const [Locale('vi'), Locale('en')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        builder: (context, child) => AppLanguageScope(child: child!),
        routerDelegate: _routerDelegate,
        routeInformationParser: const AppRouteParser(),
      ),
    );
  }
}
