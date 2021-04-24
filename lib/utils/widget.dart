// 🐦 Flutter imports:
import 'package:flutter/material.dart';

import '../styles/theme.dart';

void nextTick(void Function(Duration timestamp) callback) {
  WidgetsBinding.instance?.addPostFrameCallback(callback);
}

extension FlanSizeExtension on num {
  double get rpx => FlanTheme.rpx(this);
}

extension FlanListExtension on List<Widget?> {
  List<Widget> get noNull => whereType<Widget>().toList();
}
