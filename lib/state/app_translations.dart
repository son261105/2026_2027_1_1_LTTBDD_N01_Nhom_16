import 'package:flutter/widgets.dart';
import 'app_language.dart';

class AppLanguageScope extends InheritedNotifier<ValueNotifier<AppLanguage>> {
  AppLanguageScope({super.key, required super.child})
    : super(notifier: appLanguage);
}

extension AppTranslationContext on BuildContext {
  String tr(String text) {
    final language =
        dependOnInheritedWidgetOfExactType<AppLanguageScope>()
            ?.notifier
            ?.value ??
        appLanguage.value;
    return translateText(text, language);
  }
}

String translateText(String text, AppLanguage language) {
  if (language == AppLanguage.vietnamese) return text;
  final translated = _english[text];
  if (translated != null) return translated;

  final songs = RegExp(r'^(\d+) bài hát$').firstMatch(text);
  if (songs != null) {
    final count = songs.group(1)!;
    return '$count ${count == '1' ? 'song' : 'songs'}';
  }
  final followers = RegExp(r'^(\d+) người theo dõi$').firstMatch(text);
  if (followers != null) return '${followers.group(1)} followers';
  final album = RegExp(
    r'^(Album\s*·\s*\d+\s*·\s*)(\d+) Bài hát$',
  ).firstMatch(text);
  if (album != null) {
    final count = album.group(2)!;
    return '${album.group(1)}$count ${count == '1' ? 'song' : 'songs'}';
  }
  return text;
}

const _english = {
  'Trang chủ': 'Home',
  'Của Tôi': 'My Library',
  'THƯ VIỆN': 'LIBRARY',
  'Bài hát yêu thích': 'Liked Songs',
  'Nghe gần đây': 'Recently Played',
  'Nghệ sĩ yêu thích': 'Favorite Artists',
  'PLAYLIST ĐÃ TẠO': 'CREATED PLAYLISTS',
  'ALBUM YÊU THÍCH': 'FAVORITE ALBUMS',
  'Playlist đã tạo (1)': 'Created Playlists (1)',
  'Album yêu thích (1)': 'Favorite Albums (1)',
  'Bảng Xếp Hạng': 'Charts',
  'Nghệ sĩ thịnh hành': 'Trending Artists',
  'Hiện tất cả': 'Show All',
  'Album Hot': 'Hot Albums',
  'Thêm': 'More',
  'Top Bài Hát Thịnh Hành': 'Top Trending Songs',
  'Top Nhạc Việt': 'Top Vietnamese Music',
  'Phát': 'Play',
  'Phát tất cả': 'Play All',
  'Trộn bài': 'Shuffle',
  'Tắt trộn bài': 'Turn Off Shuffle',
  'Tiêu đề': 'Title',
  'Tên bài hát': 'Song Title',
  'Nghệ sĩ': 'Artist',
  'Bài hát': 'Song',
  'Lời bài hát': 'Lyrics',
  '...Xem thêm': '...Show More',
  'Thu gọn': 'Show Less',
  'Tải về': 'Download',
  'Thêm vào playlist': 'Add to Playlist',
  'Theo dõi': 'Follow',
  'Đang theo dõi': 'Following',
  'Người theo dõi': 'Followers',
  'Đang theo dõi · 1': 'Following · 1',
  'Phổ biến': 'Popular',
  '5,4 Tr người nghe hằng tháng': '5.4M monthly listeners',
  'Xóa khỏi yêu thích': 'Remove from Liked Songs',
  'Chưa có bài hát yêu thích': 'No liked songs yet',
  'Bài hát đã phát ': 'Played Songs ',
  'Danh sách phát': 'Queue',
  'Đang phát': 'Now Playing',
  'Tiếp theo': 'Up Next',
  'Âm lượng': 'Volume',
  'Bỏ yêu thích': 'Unlike',
  'Yêu thích album': 'Like Album',
  'Sao chép thông tin album để chia sẻ': 'Copy Album Info to Share',
  'Chia sẻ': 'Share',
  'Đã sao chép thông tin album': 'Album info copied',
  'Miễn phí': 'Free',
  'Thông tin nhóm': 'Group Info',
  'Thông tin môn học': 'Course Information',
  'Lớp: CNTT6': 'Class: CNTT6',
  'Phát triển toàn bộ dự án': 'Developed the entire project',
  'Môn học: Lập Trình Thiết Bị Di Động': 'Course: Mobile Device Programming',
  'Giảng viên: ThS. Nguyễn Xuân Quế': 'Lecturer: MSc. Nguyễn Xuân Quế',
  'Giới thiệu dự án Music': 'About the Music Project',
  'Music là dự án xây dựng giao diện website nghe nhạc, giúp người dùng khám phá bài hát, album và nghệ sĩ, đồng thời theo dõi thư viện âm nhạc cá nhân.':
      'Music is a music website interface where users can explore songs, albums and artists, and browse their personal music library.',
  'Công ty': 'Company',
  'Giới thiệu': 'About',
  'Việc làm': 'Jobs',
  'Cộng đồng': 'Communities',
  'Dành cho các Nghệ sĩ': 'For Artists',
  'Dành cho Nhà sáng tạo': 'For Creators',
  'Dành cho Tác giả': 'For Songwriters',
  'Nhà phát triển': 'Developers',
  'Quảng cáo': 'Advertising',
  'Nhà đầu tư': 'Investors',
  'Nhà cung cấp': 'Vendors',
  'Đường liên kết hữu ích': 'Useful Links',
  'Hỗ trợ': 'Support',
  'Ứng dụng Di động Miễn phí': 'Free Mobile App',
  'Phổ biến theo quốc gia': 'Popular by Country',
  'Top lời bài hát': 'Top Lyrics',
  'Thêm nhạc': 'Add Music',
  'Các gói của MusicChill': 'MusicChill Plans',
  'Pháp lý': 'Legal',
  'Trung tâm an toàn và quyền riêng tư': 'Safety & Privacy Center',
  'Chính sách quyền riêng tư': 'Privacy Policy',
  'Giới thiệu Quảng cáo': 'About Ads',
  'Hỗ trợ tiếp cận': 'Accessibility',
};
