import 'package:flutter/foundation.dart';

enum AppLanguage { vietnamese, english }

final appLanguage = ValueNotifier<AppLanguage>(AppLanguage.vietnamese);
