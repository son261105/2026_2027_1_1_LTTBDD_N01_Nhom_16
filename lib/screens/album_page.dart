import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

const _pink = Color(0xFFFF4D8D);
const _cyan = Color(0xFF00D4E8);

const _albumName = 'M-TP';
const _albumYear = 2026;
const _albumImage = 'imgs/AlbumMTP.jpg';
const _artistName = 'Sơn Tùng M-TP';
const _artistImage = 'imgs/NgheSiSonTung.jpg';

class _AlbumSong {
  final String title;
  final String image;
  final String duration;

  const _AlbumSong(this.title, this.image, this.duration);
}

const _originalSongs = [
  _AlbumSong('Nơi Này Có Anh', 'imgs/NoiNayCoAnh.jpg', '04:57'),
  _AlbumSong('Âm Thầm Bên Em', 'imgs/AmThamBenEm.jpg', '04:51'),
  _AlbumSong('Nắng Ấm Xa Dần', 'imgs/NangAmXaDan.jpg', '04:04'),
  _AlbumSong('Em Của Ngày Hôm Qua', 'imgs/EmCuaNgayHomQua.jpg', '04:06'),
  _AlbumSong('Buông Đôi Tay Nhau Ra', 'imgs/BuongDoiTayNhauRa.jpg', '04:32'),
];

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final List<_AlbumSong> _songs = List.of(_originalSongs);
  bool _isLiked = false;
  bool _isShuffle = false;

  void _toggleShuffle() {
    setState(() {
      _isShuffle = !_isShuffle;
      if (_isShuffle) {
        _songs.shuffle();
      } else {
        _songs
          ..clear()
          ..addAll(_originalSongs);
      }
    });
  }

  Future<void> _shareAlbum() async {
    await Clipboard.setData(
      const ClipboardData(text: 'Album $_albumName · $_artistName'),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã sao chép thông tin album')),
    );
  }

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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AlbumHeader(
              songCount: _songs.length,
              isLiked: _isLiked,
              onLike: () => setState(() => _isLiked = !_isLiked),
              onShare: _shareAlbum,
              isShuffle: _isShuffle,
              onShuffle: _toggleShuffle,
            ),
          ],
        ),
      ),
    );
  }
}

class _AlbumHeader extends StatelessWidget {
  final int songCount;
  final bool isLiked;
  final VoidCallback onLike;
  final VoidCallback onShare;
  final bool isShuffle;
  final VoidCallback onShuffle;

  const _AlbumHeader({
    required this.songCount,
    required this.isLiked,
    required this.onLike,
    required this.onShare,
    required this.isShuffle,
    required this.onShuffle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            _albumImage,
            width: 260,
            height: 260,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Album  ·  $_albumYear  ·  $songCount Bài hát',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                _albumName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: Image.asset(
                      _artistImage,
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    _artistName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      IconButton(
                        tooltip: isLiked ? 'Bỏ yêu thích' : 'Yêu thích album',
                        onPressed: onLike,
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? _pink : Colors.white,
                          size: 30,
                        ),
                      ),
                      Text(
                        isLiked ? '1' : '0',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      IconButton(
                        tooltip: 'Sao chép thông tin album để chia sẻ',
                        onPressed: onShare,
                        icon: Transform.flip(
                          flipX: true,
                          child: const Icon(
                            Icons.reply_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const Text(
                        'Chia sẻ',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FilledButton.icon(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: _cyan,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(212, 50),
                      shape: const StadiumBorder(),
                      textStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow_rounded, size: 28),
                    label: const Text('Phát tất cả'),
                  ),
                  IconButton.filled(
                    tooltip: isShuffle ? 'Tắt trộn bài' : 'Trộn bài',
                    onPressed: onShuffle,
                    isSelected: isShuffle,
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFF2F2F2F),
                      foregroundColor: isShuffle ? _cyan : Colors.white,
                      fixedSize: const Size(50, 50),
                      shape: const CircleBorder(),
                    ),
                    icon: const Icon(Icons.shuffle_rounded, size: 25),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
