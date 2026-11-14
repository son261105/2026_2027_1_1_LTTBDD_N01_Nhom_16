import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webnghenhac/state/app_router.dart';
import 'package:webnghenhac/state/ui_state.dart';

void main() {
  testWidgets('detail pages report URLs and restore browser navigation', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(() => currentPage.value = AppPage.home);

    final navigation = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.navigation,
      (call) async => navigation.add(call),
    );
    addTearDown(() {
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.navigation,
        null,
      );
    });

    final delegate = _TestRouterDelegate();
    addTearDown(delegate.dispose);
    await tester.pumpWidget(
      MaterialApp.router(
        routerDelegate: delegate,
        routeInformationParser: const AppRouteParser(),
      ),
    );
    await tester.pumpAndSettle();

    final provider =
        Router.of(tester.element(find.text('home'))).routeInformationProvider!
            as PlatformRouteInformationProvider;

    for (final page in [AppPage.album, AppPage.artist, AppPage.song]) {
      navigation.clear();
      currentPage.value = page;
      await tester.pumpAndSettle();

      final update = navigation.lastWhere(
        (call) => call.method == 'routeInformationUpdated',
      );
      expect(update.arguments['uri'], '/${page.name}');
      expect(update.arguments['replace'], false);
      expect(find.text('Về trang chủ'), findsNothing);

      // Trình duyệt gửi URL trước đó khi người dùng nhấn Back.
      await provider.didPushRouteInformation(
        RouteInformation(uri: Uri.parse('/')),
      );
      await tester.pumpAndSettle();
      expect(currentPage.value, AppPage.home);

      // Forward khôi phục lại trang chi tiết đã mở.
      await provider.didPushRouteInformation(
        RouteInformation(uri: Uri.parse('/${page.name}')),
      );
      await tester.pumpAndSettle();
      expect(currentPage.value, page);

      await provider.didPushRouteInformation(
        RouteInformation(uri: Uri.parse('/')),
      );
      await tester.pumpAndSettle();
    }
    expect(tester.takeException(), isNull);
  });
}

class _TestRouterDelegate extends AppRouterDelegate {
  @override
  Widget build(BuildContext context) => Text(currentConfiguration.name);
}
