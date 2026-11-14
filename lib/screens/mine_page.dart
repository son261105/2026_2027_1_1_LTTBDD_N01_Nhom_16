import 'package:flutter/material.dart';
import '../state/ui_state.dart';
import '../theme/app_colors.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

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
      child: const SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_ProfileHeader(), SizedBox(height: 20), _LibrarySummary()],
        ),
      ),
    );
  }
}

class _LibrarySummary extends StatelessWidget {
  const _LibrarySummary();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth >= 600
            ? ((constraints.maxWidth - 20) / 2).clamp(0.0, 340.0).toDouble()
            : constraints.maxWidth.clamp(0.0, 340.0).toDouble();
        return SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 20,
            runSpacing: 16,
            children: [
              SizedBox(
                width: width,
                child: _SummaryCard(
                  title: 'Bài hát yêu thích',
                  subtitle: '3 bài hát',
                  icon: Icons.favorite,
                  colors: const [Color(0xFF465151), Color(0xFF172323)],
                  image: 'imgs/AlbumMTP.jpg',
                  onTap: () => currentPage.value = AppPage.favoriteSongs,
                ),
              ),
              SizedBox(
                width: width,
                child: _SummaryCard(
                  title: 'Nghe gần đây',
                  subtitle: '4 bài hát',
                  icon: Icons.history_rounded,
                  colors: const [
                    Color(0xFF59B1BC),
                    Color(0xFF155896),
                    Color(0xFF092431),
                  ],
                  iconColor: const Color(0xFF38BDF8),
                  onTap: () => currentPage.value = AppPage.recent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;
  final Color iconColor;
  final String? image;
  final VoidCallback? onTap;

  const _SummaryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
    this.iconColor = Colors.white,
    this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF303733),
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: colors,
                  ),
                  image: image == null
                      ? null
                      : DecorationImage(
                          image: AssetImage(image!),
                          fit: BoxFit.cover,
                        ),
                ),
                child: Icon(icon, color: iconColor, size: 36),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.avatar,
          ),
          child: const Center(
            child: Text(
              'S',
              style: TextStyle(
                color: Colors.black,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    'Đình Sơn',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '|  ID: 71468042',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF596560),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Free',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Wrap(
                spacing: 24,
                runSpacing: 8,
                children: [
                  _FollowCount(label: 'Đang theo dõi', count: 2),
                  _FollowCount(label: 'Người theo dõi', count: 0),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FollowCount extends StatelessWidget {
  final String label;
  final int count;

  const _FollowCount({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '$label · '),
          TextSpan(
            text: '$count',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
