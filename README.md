# MusicChill — Website nghe nhạc

MusicChill là dự án xây dựng giao diện website nghe nhạc bằng Flutter, thực hiện trong môn **Lập Trình Thiết Bị Di Động**. Dự án mang đến không gian khám phá bài hát, album, nghệ sĩ và thư viện âm nhạc cá nhân với giao diện tối.

## Thông tin thực hiện

| Nội dung     | Thông tin                  |
| ------------ | -------------------------- |
| Sinh viên    | Trương Đình Sơn            |
| Mã sinh viên | 23010527                   |
| Lớp          | CNTT6                      |
| Môn học      | Lập Trình Thiết Bị Di Động |
| Giảng viên   | ThS. Nguyễn Xuân Quế       |
| Vai trò      | Phát triển toàn bộ dự án   |

## Các phần chính

- **Trang chủ:** giới thiệu bài hát, nghệ sĩ và album.
- **Chi tiết âm nhạc:** trang bài hát, lời bài hát Tìm Em, trang nghệ sĩ và album M-TP.
- **Thư viện cá nhân:** bài hát yêu thích, nghe gần đây, playlist Nhạc chill và album yêu thích.
- **Của Tôi:** thông tin tài khoản, playlist đã tạo và danh sách nghệ sĩ đang theo dõi.
- **Giao diện trình phát:** thanh điều khiển nhạc, tiến trình, âm lượng và danh sách chờ.

Phiên bản hiện tại tập trung vào giao diện và điều hướng với dữ liệu mẫu. Một số nút, như phát nhạc và xóa bài hát yêu thích, đang được dùng để minh họa giao diện.

## Công nghệ

- Flutter và Dart, sử dụng giao diện Material.
- Hình ảnh được lưu trong thư mục `imgs/`.

## Chạy dự án

Cài đặt Flutter với Dart đáp ứng yêu cầu `^3.10.4` trong `pubspec.yaml`, sau đó chạy các lệnh tại thư mục gốc dự án:

````bash
flutter pub get
flutter run -d chrome


## Cấu trúc chính

```text
lib/
├── models/      # Mô hình dữ liệu
├── screens/     # Các trang giao diện
├── state/       # Trạng thái và điều hướng
├── theme/       # Màu sắc dùng chung
├── widgets/     # Các thành phần giao diện dùng lại
└── main.dart    # Điểm khởi chạy ứng dụng
imgs/           # Hình ảnh bài hát, album và nghệ sĩ
````
