// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/theme.dart';

void nextTick(VoidCallback callback) {
  WidgetsBinding.instance?.addPostFrameCallback((Duration timestamp) {
    callback();
  });
}

extension FlanSizeExtension on num {
  double get rpx => FlanTheme.rpx(this);
}

extension FlanListExtension on List<Widget?> {
  List<Widget> get noNull => whereType<Widget>().toList();
}
