import 'package:flutter/material.dart';
import '../state/ui_state.dart';
import '../theme/app_colors.dart';
import '../widgets/cover_art.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1C302C), AppColors.sidebar],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Đình Sơn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFF333B38))),
              ),
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(bottom: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF00D4E8), width: 3),
                  ),
                ),
                child: const Text(
                  'Đang theo dõi · 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF00D4E8),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                'Nghệ sĩ',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            const SizedBox(height: 24),
            const _FollowedArtistCard(),
          ],
        ),
      ),
    );
  }
}

class _FollowedArtistCard extends StatelessWidget {
  const _FollowedArtistCard();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => currentPage.value = AppPage.artist,
          hoverColor: AppColors.surface,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AspectRatio(
                  aspectRatio: 1,
                  child: CoverArt(
                    color: Color(0xFFE11D48),
                    image: 'imgs/NgheSiSonTung.jpg',
                    icon: Icons.person,
                    circle: true,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Sơn Tùng M-TP',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '142332 người theo dõi',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white38),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Đang theo dõi',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
