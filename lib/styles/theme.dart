import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'badge_theme.dart';
import 'button_theme.dart';
import 'cell_group_theme.dart';
import 'cell_theme.dart';
import 'count_down_theme.dart';
import 'divider_theme.dart';
import 'empty_theme.dart';
import 'image_theme.dart';
import 'tag_theme.dart';

class FlanTheme extends StatelessWidget {
  const FlanTheme({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  final FlanThemeData data;

  final Widget child;

  static double Function(num n) rpx = (num n) => n.toDouble();

  static final FlanThemeData _kFallbackTheme = FlanThemeData.fallback();

  static FlanThemeData of(BuildContext context) {
    final _InheritedFlanTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedFlanTheme>();

    return inheritedTheme?.theme.data ?? _kFallbackTheme;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedFlanTheme(
      theme: this,
      child: child,
    );
  }
}

class _InheritedFlanTheme extends InheritedTheme {
  const _InheritedFlanTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  final FlanTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedFlanTheme old) =>
      theme.data != old.theme.data;
}

@immutable
class FlanThemeData with Diagnosticable {
  factory FlanThemeData({
    FlanBadgeThemeData? badgeTheme,
    FlanButtonThemeData? buttonTheme,
    FlanCellThemeData? cellTheme,
    FlanCellGroupThemeData? cellGroupTheme,
    FlanCountDownThemeData? countDownTheme,
    FlanDividerThemeData? dividerTheme,
    FlanEmptyThemeData? emptyTheme,
    FlanImageThemeData? imageTheme,
    FlanTagThemeData? tagTheme,
  }) {
    return FlanThemeData.raw(
      badgeTheme: badgeTheme ?? FlanBadgeThemeData(),
      buttonTheme: buttonTheme ?? FlanButtonThemeData(),
      cellTheme: cellTheme ?? FlanCellThemeData(),
      cellGroupTheme: cellGroupTheme ?? FlanCellGroupThemeData(),
      countDownTheme: countDownTheme ?? FlanCountDownThemeData(),
      dividerTheme: dividerTheme ?? FlanDividerThemeData(),
      emptyTheme: emptyTheme ?? FlanEmptyThemeData(),
      imageTheme: imageTheme ?? FlanImageThemeData(),
      tagTheme: tagTheme ?? FlanTagThemeData(),
    );
  }

  const FlanThemeData.raw({
    required this.badgeTheme,
    required this.buttonTheme,
    required this.cellTheme,
    required this.cellGroupTheme,
    required this.countDownTheme,
    required this.dividerTheme,
    required this.emptyTheme,
    required this.imageTheme,
    required this.tagTheme,
  });

  factory FlanThemeData.fallback() => FlanThemeData();

  /// 徽标样式
  final FlanBadgeThemeData badgeTheme;

  /// 按钮样式
  final FlanButtonThemeData buttonTheme;

  /// 单元格样式
  final FlanCellThemeData cellTheme;

  /// 单元格组样式
  final FlanCellGroupThemeData cellGroupTheme;

  /// 倒计时样式
  final FlanCountDownThemeData countDownTheme;

  /// 空状态样式
  final FlanEmptyThemeData emptyTheme;

  /// 分割线样式
  final FlanDividerThemeData dividerTheme;

  /// 图片样式
  final FlanImageThemeData imageTheme;

  // 标签样式
  final FlanTagThemeData tagTheme;

  static FlanThemeData lerp(FlanThemeData a, FlanThemeData b, double t) {
    return FlanThemeData.raw(
      badgeTheme: FlanBadgeThemeData.lerp(a.badgeTheme, b.badgeTheme, t),
      buttonTheme: FlanButtonThemeData.lerp(a.buttonTheme, b.buttonTheme, t),
      cellTheme: FlanCellThemeData.lerp(a.cellTheme, b.cellTheme, t),
      cellGroupTheme:
          FlanCellGroupThemeData.lerp(a.cellGroupTheme, b.cellGroupTheme, t),
      countDownTheme:
          FlanCountDownThemeData.lerp(a.countDownTheme, b.countDownTheme, t),
      dividerTheme:
          FlanDividerThemeData.lerp(a.dividerTheme, b.dividerTheme, t),
      emptyTheme: FlanEmptyThemeData.lerp(a.emptyTheme, b.emptyTheme, t),
      imageTheme: FlanImageThemeData.lerp(a.imageTheme, b.imageTheme, t),
      tagTheme: FlanTagThemeData.lerp(a.tagTheme, b.tagTheme, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[];
    return hashList(values);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is FlanThemeData && other.buttonTheme == buttonTheme;
  }
}
