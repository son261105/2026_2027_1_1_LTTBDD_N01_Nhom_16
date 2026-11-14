import 'package:flutter/foundation.dart';
import '../models/song.dart';

final ValueNotifier<bool> queueOpen = ValueNotifier<bool>(false);

enum AppPage {
  home,
  mine,
  groupInfo,
  following,
  favoriteSongs,
  recent,
  favoriteArtists,
  playlistChill,
  song,
  artist,
  album,
}

/// Trang đang được chọn
final ValueNotifier<AppPage> currentPage = ValueNotifier<AppPage>(AppPage.home);

/// Bài hát đang được mở ở trang chi tiết
final ValueNotifier<Song?> selectedSong = ValueNotifier<Song?>(null);
