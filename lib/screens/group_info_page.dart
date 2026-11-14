import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GroupInfoPage extends StatelessWidget {
  const GroupInfoPage({super.key});

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
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thông tin nhóm',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                const CircleAvatar(
                  radius: 52,
                  backgroundColor: AppColors.avatar,
                  child: Text(
                    'Sơn',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Trương Đình Sơn - 23010527',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Lớp: CNTT6',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Phát triển toàn bộ dự án',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36),
            const Text(
              'Thông tin môn học',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Môn học: Lập Trình Thiết Bị Di Động',
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.6),
            ),
            const SizedBox(height: 8),
            const Text(
              'Giảng viên: ThS. Nguyễn Xuân Quế',
              style: TextStyle(color: Colors.white, fontSize: 15, height: 1.6),
            ),
            const Divider(height: 56, thickness: 1, color: Colors.white24),
            const _ProjectOverview(),
          ],
        ),
      ),
    );
  }
}

class _ProjectOverview extends StatelessWidget {
  const _ProjectOverview();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 960),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Giới thiệu dự án Music',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Music là dự án xây dựng giao diện website nghe nhạc, '
            'giúp người dùng khám phá bài hát, album và nghệ sĩ, '
            'đồng thời theo dõi thư viện âm nhạc cá nhân.',
            style: TextStyle(color: Colors.white, fontSize: 15, height: 1.7),
          ),
        ],
      ),
    );
  }
}
