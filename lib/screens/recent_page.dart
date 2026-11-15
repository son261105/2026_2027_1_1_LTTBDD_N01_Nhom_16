import 'package:flutter/material.dart';
import '../state/app_translations.dart';
import '../theme/app_colors.dart';
import 'playlist_page.dart' show PlaylistSong, PlaylistSongRow;

const _recentSongs = [
  (
    title: 'Tìm Em',
    artist: 'Hngle, Bảo Anh',
    image: 'imgs/TimEm.jpg',
    duration: '04:12',
  ),
  (
    title: 'Nơi Này Có Anh',
    artist: 'Sơn Tùng M-TP',
    image: 'imgs/NoiNayCoAnh.jpg',
    duration: '04:57',
  ),
  (
    title: 'Đi Về Nhà',
    artist: 'Đen Vâu',
    image: 'imgs/DiVeNha.jpg',
    duration: '04:23',
  ),
  (
    title: 'Vợ Người Ta',
    artist: 'Phan Mạnh Quỳnh',
    image: 'imgs/VoNguoiTa.jpg',
    duration: '05:45',
  ),
];

class RecentPage extends StatelessWidget {
  const RecentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1E2B25), AppColors.sidebar],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton.filled(
                  tooltip: context.tr('Phát tất cả'),
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFF00D4E8),
                    foregroundColor: const Color(0xFF003C42),
                    fixedSize: const Size(50, 50),
                    shape: const CircleBorder(),
                  ),
                  icon: const Icon(Icons.play_arrow_rounded, size: 34),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: context.tr('Bài hát đã phát ')),
                        TextSpan(
                          text: '(4)',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 28,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const _RecentSongsTable(),
          ],
        ),
      ),
    );
  }
}

class _RecentSongsTable extends StatelessWidget {
  const _RecentSongsTable();

  Widget _columns({
    required Widget number,
    required Widget title,
    required Widget artist,
    required Widget duration,
  }) {
    return Row(
      children: [
        SizedBox(width: 40, child: number),
        Expanded(flex: 5, child: title),
        Expanded(flex: 3, child: artist),
        SizedBox(
          width: 80,
          child: Align(alignment: Alignment.centerRight, child: duration),
        ),
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
              title: Text(
                context.tr('Tiêu đề'),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              artist: Text(
                context.tr('Nghệ sĩ'),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              duration: const Icon(
                Icons.access_time,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (var index = 0; index < _recentSongs.length; index++)
            PlaylistSongRow(
              index + 1,
              PlaylistSong(
                _recentSongs[index].title,
                _recentSongs[index].artist,
                _recentSongs[index].image,
                _recentSongs[index].duration,
              ),
            ),
        ],
      ),
    );
  }
}
