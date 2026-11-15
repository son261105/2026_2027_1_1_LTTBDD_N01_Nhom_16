import 'package:flutter/material.dart';
import '../state/app_language.dart';
import '../state/ui_state.dart';
import '../theme/app_colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(alignment: Alignment.centerLeft, child: _Brand()),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 760),
              child: Row(
                children: [
                  _PremiumButton(
                    label: 'Thông tin nhóm',
                    onTap: () => currentPage.value = AppPage.groupInfo,
                  ),
                  SizedBox(width: 32),
                  _HomeButton(),
                  SizedBox(width: 8),
                  Expanded(child: _SearchBar()),
                  SizedBox(width: 16),
                  _PremiumButton(),
                ],
              ),
            ),
          ),
          // Phải: avatar người dùng và lựa chọn ngôn ngữ.
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [_Avatar(), SizedBox(width: 8), _LanguageButton()],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  const _HomeButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        hoverColor: AppColors.surfaceHover,
        onTap: () => currentPage.value = AppPage.home,
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(Icons.home_outlined, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        style: const TextStyle(color: Colors.white, fontSize: 14),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: 'Bạn muốn phát nội dung gì?',
          hintStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textSecondary,
            size: 20,
          ),
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(500),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(500),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(500),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.avatar,
      child: Text(
        'S',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: appLanguage,
      builder: (context, language, _) => Material(
        color: Colors.white,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: PopupMenuButton<AppLanguage>(
          tooltip: language == AppLanguage.vietnamese ? 'Ngôn ngữ' : 'Language',
          initialValue: language,
          onSelected: (value) => appLanguage.value = value,
          position: PopupMenuPosition.under,
          color: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          itemBuilder: (context) => [
            CheckedPopupMenuItem(
              value: AppLanguage.vietnamese,
              checked: language == AppLanguage.vietnamese,
              child: const Text('Tiếng Việt'),
            ),
            CheckedPopupMenuItem(
              value: AppLanguage.english,
              checked: language == AppLanguage.english,
              child: const Text('English'),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.language, color: Colors.black, size: 20),
                const SizedBox(width: 6),
                Text(
                  language == AppLanguage.vietnamese ? 'VI' : 'EN',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PremiumButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _PremiumButton({this.label = 'Khám phá Premium', this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const StadiumBorder(),
      child: InkWell(
        customBorder: const StadiumBorder(),
        hoverColor: Colors.black12,
        onTap: onTap ?? () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.graphic_eq, color: Colors.black, size: 20),
        ),
        const SizedBox(width: 8),
        const Text(
          'MusicChill',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
