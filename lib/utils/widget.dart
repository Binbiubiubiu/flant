import 'package:flutter/material.dart';

import '../styles/theme.dart';

void nextTick(VoidCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback((Duration timestamp) {
    callback();
  });
}

extension FlanSizeExtension on num {
  double get rpx => FlanTheme.rpx(this);
}

// extension FlanListExtension<T> on List<T?> {
//   List<T> get noNull => whereType<T>().toList();
// }
