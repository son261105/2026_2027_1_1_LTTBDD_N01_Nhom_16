import 'package:flutter/material.dart';
import '../state/app_translations.dart';
import '../state/ui_state.dart';
import '../theme/app_colors.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppPage>(
      valueListenable: currentPage,
      builder: (context, page, _) {
        return Container(
          width: 280,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.sidebar,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _NavItem(
                  icon: Icons.home_filled,
                  label: context.tr('Trang chủ'),
                  selected: page == AppPage.home,
                  onTap: () => currentPage.value = AppPage.home,
                ),
                const SizedBox(height: 4),
                _NavItem(
                  icon: Icons.person_outline,
                  label: context.tr('Của Tôi'),
                  selected: page == AppPage.mine,
                  onTap: () => currentPage.value = AppPage.mine,
                ),
                const SizedBox(height: 28),
                _SectionTitle(context.tr('THƯ VIỆN')),
                const SizedBox(height: 8),
                _LibraryItem(
                  icon: Icons.favorite,
                  color: const Color(0xFFFF4D8D),
                  label: context.tr('Bài hát yêu thích'),
                  selected: page == AppPage.favoriteSongs,
                  onTap: () => currentPage.value = AppPage.favoriteSongs,
                ),
                _LibraryItem(
                  icon: Icons.history,
                  color: const Color(0xFF3B82F6),
                  label: context.tr('Nghe gần đây'),
                  selected: page == AppPage.recent,
                  onTap: () => currentPage.value = AppPage.recent,
                ),
                const SizedBox(height: 28),
                _SectionTitle(context.tr('PLAYLIST ĐÃ TẠO'), showAdd: true),
                const SizedBox(height: 8),
                _LibraryItem(
                  color: const Color(0xFF0EA5A4),
                  label: 'Nhạc chill',
                  imagePath: 'imgs/NgheSiDenVau.jpg',
                  selected: page == AppPage.playlistChill,
                  onTap: () => currentPage.value = AppPage.playlistChill,
                ),
                const SizedBox(height: 28),
                _SectionTitle(context.tr('ALBUM YÊU THÍCH')),
                const SizedBox(height: 8),
                _LibraryItem(
                  color: const Color(0xFF334155),
                  label: 'M-TP',
                  imagePath: 'imgs/AlbumMTP.jpg',
                  selected: page == AppPage.album,
                  onTap: () => currentPage.value = AppPage.album,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.surfaceHover : Colors.transparent,
      borderRadius: BorderRadius.circular(500),
      child: InkWell(
        borderRadius: BorderRadius.circular(500),
        hoverColor: AppColors.surface,
        onTap: onTap,
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(width: 14),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  final bool showAdd;

  const _SectionTitle(this.text, {this.showAdd = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ),
          if (showAdd)
            InkWell(
              borderRadius: BorderRadius.circular(500),
              onTap: () {},
              child: const Icon(
                Icons.add_circle_outline,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}

class _LibraryItem extends StatelessWidget {
  final IconData? icon;
  final Color color;
  final String label;
  final String? imagePath;
  final bool selected;
  final VoidCallback? onTap;

  const _LibraryItem({
    this.icon,
    required this.color,
    required this.label,
    this.imagePath,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.surfaceHover : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        hoverColor: AppColors.surface,
        onTap: onTap,
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: imagePath != null
                    ? Image.asset(imagePath!, fit: BoxFit.cover)
                    : Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
