import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'playlist_page.dart';

class FavoriteSongsPage extends StatelessWidget {
  const FavoriteSongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1B3A3A), AppColors.sidebar],
          stops: [0, 0.45],
        ),
      ),
      child: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlaylistHeader(
              title: 'Bài hát yêu thích',
              image: 'imgs/AnhNgheSiAmee.jpg',
              description: 'Đình Sơn',
              songCount: 4,
              showPlaylistLabel: false,
              titleFontSize: 32,
              alignContentToCover: true,
            ),
          ],
        ),
      ),
    );
  }
}
