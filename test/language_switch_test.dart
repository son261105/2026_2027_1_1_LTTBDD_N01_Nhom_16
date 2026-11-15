import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webnghenhac/main.dart';
import 'package:webnghenhac/models/song.dart';
import 'package:webnghenhac/state/app_language.dart';
import 'package:webnghenhac/state/app_translations.dart';
import 'package:webnghenhac/state/ui_state.dart';

void main() {
  test(
    'counts translate while music titles stay in their original language',
    () {
      expect(translateText('1 bài hát', AppLanguage.english), '1 song');
      expect(translateText('4 bài hát', AppLanguage.english), '4 songs');
      expect(
        translateText('Album  ·  2026  ·  5 Bài hát', AppLanguage.english),
        'Album  ·  2026  ·  5 songs',
      );
      expect(
        translateText('142332 người theo dõi', AppLanguage.english),
        '142332 followers',
      );
      for (final title in [
        'Tìm Em',
        'Sơn Tùng M-TP',
        'Đánh Đổi',
        'Nhạc chill',
      ]) {
        expect(translateText(title, AppLanguage.english), title);
      }
      expect(translateText('4 bài hát', AppLanguage.vietnamese), '4 bài hát');
    },
  );

  testWidgets('language menu updates every page and preserves page state', (
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
      queueOpen.value = false;
    });

    await tester.pumpWidget(const MusicApp());
    await tester.pumpAndSettle();
    expect(find.text('Bảng Xếp Hạng'), findsOneWidget);

    await tester.tap(find.byTooltip('Ngôn ngữ'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CheckedPopupMenuItem<AppLanguage>).last);
    await tester.pumpAndSettle();
    expect(appLanguage.value, AppLanguage.english);
    expect(find.text('Charts'), findsOneWidget);
    expect(find.text('Company'), findsOneWidget);
    expect(find.text('Top Vietnamese Music'), findsOneWidget);

    const pages = {
      AppPage.mine: 'Created Playlists (1)',
      AppPage.following: '142332 followers',
      AppPage.favoriteSongs: 'Remove from Liked Songs',
      AppPage.recent: 'Played Songs (4)',
      AppPage.album: 'Album  ·  2026  ·  5 songs',
      AppPage.artist: 'Popular',
      AppPage.playlistChill: '3 songs',
      AppPage.groupInfo: 'Course Information',
    };
    for (final entry in pages.entries) {
      currentPage.value = entry.key;
      await tester.pumpAndSettle();
      if (entry.key == AppPage.favoriteSongs) {
        expect(find.byTooltip(entry.value), findsNWidgets(4));
        await tester.tap(find.byTooltip(entry.value).first);
        await tester.pumpAndSettle();
        expect(find.byTooltip(entry.value), findsNWidgets(4));
      } else {
        expect(find.text(entry.value, findRichText: true), findsOneWidget);
      }
      expect(tester.takeException(), isNull);
    }

    selectedSong.value = const Song(
      title: 'Tìm Em',
      artists: [Artist(name: 'Bảo Anh', followers: 10, color: Colors.blue)],
      color: Colors.blue,
      image: 'imgs/TimEm.jpg',
    );
    currentPage.value = AppPage.song;
    await tester.pumpAndSettle();
    expect(find.text('Lyrics'), findsOneWidget);
    expect(find.text('10 followers'), findsOneWidget);
    await tester.ensureVisible(find.text('...Show More'));
    await tester.tap(find.text('...Show More'));
    await tester.pumpAndSettle();
    queueOpen.value = true;
    await tester.pumpAndSettle();
    expect(find.text('Now Playing'), findsOneWidget);

    await tester.tap(find.byTooltip('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CheckedPopupMenuItem<AppLanguage>).first);
    await tester.pumpAndSettle();
    expect(appLanguage.value, AppLanguage.vietnamese);
    expect(currentPage.value, AppPage.song);
    expect(queueOpen.value, isTrue);
    expect(find.text('Thu gọn'), findsOneWidget);
    expect(find.text('Lời bài hát'), findsOneWidget);
    expect(find.text('Đang phát'), findsOneWidget);
    expect(find.text('10 người theo dõi'), findsOneWidget);
    expect(find.text('Tìm Em'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
