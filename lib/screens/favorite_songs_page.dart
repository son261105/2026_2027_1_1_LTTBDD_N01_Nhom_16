import 'package:flutter/material.dart';
import '../state/favorite_songs.dart';
import '../theme/app_colors.dart';
import 'playlist_page.dart';

class FavoriteSongsPage extends StatelessWidget {
  const FavoriteSongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FavoriteTrack>>(
      valueListenable: favoriteSongs,
      builder: (context, songs, _) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1B3A3A), AppColors.sidebar],
            stops: [0, 0.45],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlaylistHeader(
                title: 'Bài hát yêu thích',
                image: 'imgs/AnhNgheSiAmee.jpg',
                description:
                    'Đen Vâu , Sơn Tùng M-TP , Phan Mạnh Quỳnh , Hngle , Bảo Anh',
                songCount: songs.length,
                showPlaylistLabel: false,
                titleFontSize: 32,
                alignContentToCover: true,
              ),
              const SizedBox(height: 32),
              _FavoriteSongTable(songs: songs),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteSongTable extends StatelessWidget {
  final List<FavoriteTrack> songs;

  const _FavoriteSongTable({required this.songs});

  Widget _columns({
    required Widget number,
    required Widget title,
    required Widget artist,
    required Widget duration,
    required Widget action,
  }) {
    return Row(
      children: [
        SizedBox(width: 40, child: number),
        Expanded(flex: 5, child: title),
        const SizedBox(width: 12),
        Expanded(flex: 3, child: artist),
        SizedBox(
          width: 64,
          child: Align(alignment: Alignment.centerRight, child: duration),
        ),
        const SizedBox(width: 12),
        SizedBox(width: 40, child: action),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: _columns(
              number: const Text('#'),
              title: const Text('Tên bài hát'),
              artist: const Text('Nghệ sĩ'),
              duration: const Icon(
                Icons.access_time,
                color: AppColors.textSecondary,
                size: 18,
              ),
              action: const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 8),
          if (songs.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text('Chưa có bài hát yêu thích'),
            ),
          for (var index = 0; index < songs.length; index++)
            Padding(
              key: ValueKey(songs[index].title),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _columns(
                number: Text('${index + 1}'),
                title: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        songs[index].image,
                        width: 38,
                        height: 38,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        songs[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                artist: Text(
                  songs[index].artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                duration: Text(songs[index].duration),
                action: IconButton(
                  tooltip: 'Xóa khỏi yêu thích',
                  icon: const Icon(Icons.delete_outline_rounded, size: 20),
                  color: AppColors.textSecondary,
                  onPressed: () {},
                ),
              ),
            ),
        ],
      ),
    );
  }
}
