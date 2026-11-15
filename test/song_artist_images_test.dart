import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webnghenhac/main.dart';
import 'package:webnghenhac/state/app_language.dart';
import 'package:webnghenhac/state/ui_state.dart';
import 'package:webnghenhac/widgets/cover_art.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('artist portraits can be loaded and decoded', () async {
    for (final path in [
      'imgs/AnhHngle.jpg',
      'imgs/BaoAnh.jpg',
      'imgs/ConMuaNgangQua.jpg',
    ]) {
      final data = await rootBundle.load(path);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      expect(frame.image.width, greaterThan(0));
      frame.image.dispose();
      codec.dispose();
    }
  });

  testWidgets('artist photos remain visible after switching VI and EN', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1920, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(() {
      appLanguage.value = AppLanguage.vietnamese;
      currentPage.value = AppPage.home;
      selectedSong.value = null;
    });
    await tester.pumpWidget(const MusicApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tìm Em'));
    await tester.pumpAndSettle();
    expect(selectedSong.value!.artists.map((artist) => artist.image), [
      'imgs/AnhHngle.jpg',
      'imgs/BaoAnh.jpg',
    ]);
    for (final language in [
      AppLanguage.vietnamese,
      AppLanguage.english,
      AppLanguage.vietnamese,
    ]) {
      appLanguage.value = language;
      await tester.pumpAndSettle();
      for (final path in ['imgs/AnhHngle.jpg', 'imgs/BaoAnh.jpg']) {
        final cover = find.byWidgetPredicate(
          (widget) => widget is CoverArt && widget.image == path,
        );
        final provider = tester
            .widget<Image>(
              find.descendant(of: cover, matching: find.byType(Image)),
            )
            .image;
        final configuration = createLocalImageConfiguration(
          tester.element(cover),
        );
        await tester.runAsync(() async {
          final stream = provider.resolve(configuration);
          final loaded = Completer<void>();
          final listener = ImageStreamListener(
            (image, synchronousCall) {
              if (!loaded.isCompleted) loaded.complete();
            },
            onError: (Object error, StackTrace? stack) {
              if (!loaded.isCompleted) loaded.completeError(error, stack);
            },
          );
          stream.addListener(listener);
          try {
            await loaded.future.timeout(const Duration(seconds: 10));
          } finally {
            stream.removeListener(listener);
          }
        });
        await tester.pump();
        final raw = tester.widget<RawImage>(
          find.descendant(of: cover, matching: find.byType(RawImage)),
        );
        expect(raw.image, isNotNull, reason: '$path in $language');
      }
      expect(tester.takeException(), isNull);
    }
  });
}
