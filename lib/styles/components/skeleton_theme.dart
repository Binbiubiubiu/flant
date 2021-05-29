// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanSkeletonTheme extends InheritedTheme {
  const FlanSkeletonTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanSkeletonThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanSkeletonTheme(
          key: key,
          data: FlanSkeletonTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanSkeletonThemeData data;

  static FlanSkeletonThemeData of(BuildContext context) {
    final FlanSkeletonTheme? skeletonTheme =
        context.dependOnInheritedWidgetOfExactType<FlanSkeletonTheme>();
    return skeletonTheme?.data ?? FlanTheme.of(context).skeletonTheme;
  }

  @override
  bool updateShouldNotify(FlanSkeletonTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanSkeletonTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanSkeletonThemeData with Diagnosticable {
  factory FlanSkeletonThemeData({
    double? rowHeight,
    Color? rowBackgroundColor,
    double? rowMarginTop,
    double? titleWidth,
    double? avatarSize,
    Color? avatarBackgroundColor,
    Duration? animationDuration,
  }) {
    return FlanSkeletonThemeData.raw(
      rowHeight: rowHeight ?? 16.0.rpx,
      rowBackgroundColor: rowBackgroundColor ?? FlanThemeVars.activeColor,
      rowMarginTop: rowMarginTop ?? FlanThemeVars.paddingSm.rpx,
      titleWidth: titleWidth ?? .4.rpx,
      avatarSize: avatarSize ?? 32.0.rpx,
      avatarBackgroundColor: avatarBackgroundColor ?? FlanThemeVars.activeColor,
      animationDuration:
          animationDuration ?? const Duration(milliseconds: 1200),
    );
  }

  const FlanSkeletonThemeData.raw({
    required this.rowHeight,
    required this.rowBackgroundColor,
    required this.rowMarginTop,
    required this.titleWidth,
    required this.avatarSize,
    required this.avatarBackgroundColor,
    required this.animationDuration,
  });

  final double rowHeight;
  final Color rowBackgroundColor;
  final double rowMarginTop;
  final double titleWidth;
  final double avatarSize;
  final Color avatarBackgroundColor;
  final Duration animationDuration;

  FlanSkeletonThemeData copyWith({
    double? rowHeight,
    Color? rowBackgroundColor,
    double? rowMarginTop,
    double? titleWidth,
    double? avatarSize,
    Color? avatarBackgroundColor,
    Duration? animationDuration,
  }) {
    return FlanSkeletonThemeData(
      rowHeight: rowHeight ?? this.rowHeight,
      rowBackgroundColor: rowBackgroundColor ?? this.rowBackgroundColor,
      rowMarginTop: rowMarginTop ?? this.rowMarginTop,
      titleWidth: titleWidth ?? this.titleWidth,
      avatarSize: avatarSize ?? this.avatarSize,
      avatarBackgroundColor:
          avatarBackgroundColor ?? this.avatarBackgroundColor,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  FlanSkeletonThemeData merge(FlanSkeletonThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      rowHeight: other.rowHeight,
      rowBackgroundColor: other.rowBackgroundColor,
      rowMarginTop: other.rowMarginTop,
      titleWidth: other.titleWidth,
      avatarSize: other.avatarSize,
      avatarBackgroundColor: other.avatarBackgroundColor,
      animationDuration: other.animationDuration,
    );
  }

  static FlanSkeletonThemeData lerp(
      FlanSkeletonThemeData? a, FlanSkeletonThemeData? b, double t) {
    return FlanSkeletonThemeData(
      rowHeight: lerpDouble(a?.rowHeight, b?.rowHeight, t),
      rowBackgroundColor:
          Color.lerp(a?.rowBackgroundColor, b?.rowBackgroundColor, t),
      rowMarginTop: lerpDouble(a?.rowMarginTop, b?.rowMarginTop, t),
      titleWidth: lerpDouble(a?.titleWidth, b?.titleWidth, t),
      avatarSize: lerpDouble(a?.avatarSize, b?.avatarSize, t),
      avatarBackgroundColor:
          Color.lerp(a?.avatarBackgroundColor, b?.avatarBackgroundColor, t),
      animationDuration: lerpDuration(a?.animationDuration ?? Duration.zero,
          b?.animationDuration ?? Duration.zero, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      rowHeight,
      rowBackgroundColor,
      rowMarginTop,
      titleWidth,
      avatarSize,
      avatarBackgroundColor,
      animationDuration,
    ];

    return hashList(values);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is FlanSkeletonThemeData &&
        other.rowHeight == rowHeight &&
        other.rowBackgroundColor == rowBackgroundColor &&
        other.rowMarginTop == rowMarginTop &&
        other.titleWidth == titleWidth &&
        other.avatarSize == avatarSize &&
        other.avatarBackgroundColor == avatarBackgroundColor &&
        other.animationDuration == animationDuration;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<double>('rowHeight', rowHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'rowBackgroundColor', rowBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('rowMarginTop', rowMarginTop,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('titleWidth', titleWidth,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('avatarSize', avatarSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'avatarBackgroundColor', avatarBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Duration>(
        'animationDuration', animationDuration,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
