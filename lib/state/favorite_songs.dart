import 'package:flutter/foundation.dart';

typedef FavoriteTrack = ({
  String title,
  String artist,
  String image,
  String duration,
});

final favoriteSongs = ValueNotifier<List<FavoriteTrack>>(const [
  (
    title: 'Đi Về Nhà',
    artist: 'Đen Vâu',
    image: 'imgs/DiVeNha.jpg',
    duration: '04:23',
  ),
  (
    title: 'Nơi Này Có Anh',
    artist: 'Sơn Tùng M-TP',
    image: 'imgs/NoiNayCoAnh.jpg',
    duration: '04:57',
  ),
  (
    title: 'Vợ Người Ta',
    artist: 'Phan Mạnh Quỳnh',
    image: 'imgs/VoNguoiTa.jpg',
    duration: '05:45',
  ),
  (
    title: 'Tìm Em',
    artist: 'Hngle, Bảo Anh',
    image: 'imgs/TimEm.jpg',
    duration: '04:12',
  ),
]);
