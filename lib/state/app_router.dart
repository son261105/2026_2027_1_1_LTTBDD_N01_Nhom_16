import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import 'ui_state.dart';

class AppRouteParser extends RouteInformationParser<AppPage> {
  const AppRouteParser();

  @override
  Future<AppPage> parseRouteInformation(RouteInformation routeInformation) {
    final path = routeInformation.uri.path;
    final page = AppPage.values.firstWhere(
      (page) => path == '/${page.name}',
      orElse: () => AppPage.home,
    );
    return SynchronousFuture(page);
  }

  @override
  RouteInformation restoreRouteInformation(AppPage configuration) {
    return RouteInformation(
      uri: Uri(
        path: configuration == AppPage.home ? '/' : '/${configuration.name}',
      ),
    );
  }
}

/// Đồng bộ trang đang mở với lịch sử Back/Forward của trình duyệt.
class AppRouterDelegate extends RouterDelegate<AppPage> with ChangeNotifier {
  AppRouterDelegate() {
    currentPage.addListener(notifyListeners);
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  AppPage get currentConfiguration => currentPage.value;

  @override
  Future<void> setNewRoutePath(AppPage configuration) {
    currentPage.value = configuration;
    return SynchronousFuture<void>(null);
  }

  @override
  Future<bool> popRoute() {
    if (currentPage.value == AppPage.home) return SynchronousFuture(false);
    currentPage.value = AppPage.home;
    return SynchronousFuture(true);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: const [MaterialPage<void>(child: HomeScreen())],
      onDidRemovePage: (_) {},
    );
  }

  @override
  void dispose() {
    currentPage.removeListener(notifyListeners);
    super.dispose();
  }
}
