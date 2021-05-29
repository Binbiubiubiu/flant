// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanTreeSelectTheme extends InheritedTheme {
  const FlanTreeSelectTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanTreeSelectThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanTreeSelectTheme(
          key: key,
          data: FlanTreeSelectTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanTreeSelectThemeData data;

  static FlanTreeSelectThemeData of(BuildContext context) {
    final FlanTreeSelectTheme? treeSelectTheme =
        context.dependOnInheritedWidgetOfExactType<FlanTreeSelectTheme>();
    return treeSelectTheme?.data ?? FlanTheme.of(context).treeSelectTheme;
  }

  @override
  bool updateShouldNotify(FlanTreeSelectTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanTreeSelectTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanTreeSelectThemeData with Diagnosticable {
  factory FlanTreeSelectThemeData({
    double? fontSize,
    Color? navBackgroundColor,
    Color? contentBackgroundColor,
    EdgeInsets? navItemPadding,
    double? itemHeight,
    Color? itemActiveColor,
    Color? itemDisabledColor,
    double? itemSelectedSize,
  }) {
    return FlanTreeSelectThemeData.raw(
      fontSize: fontSize ?? FlanThemeVars.fontSizeMd.rpx,
      navBackgroundColor: navBackgroundColor ?? FlanThemeVars.backgroundColor,
      contentBackgroundColor: contentBackgroundColor ?? FlanThemeVars.white,
      navItemPadding: navItemPadding ??
          EdgeInsets.symmetric(
              vertical: 14.0.rpx, horizontal: FlanThemeVars.paddingSm.rpx),
      itemHeight: itemHeight ?? 48.0.rpx,
      itemActiveColor: itemActiveColor ?? FlanThemeVars.red,
      itemDisabledColor: itemDisabledColor ?? FlanThemeVars.gray5,
      itemSelectedSize: itemSelectedSize ?? 16.0.rpx,
    );
  }

  const FlanTreeSelectThemeData.raw({
    required this.fontSize,
    required this.navBackgroundColor,
    required this.contentBackgroundColor,
    required this.navItemPadding,
    required this.itemHeight,
    required this.itemActiveColor,
    required this.itemDisabledColor,
    required this.itemSelectedSize,
  });

  final double fontSize;
  final Color navBackgroundColor;
  final Color contentBackgroundColor;
  final EdgeInsets navItemPadding;
  final double itemHeight;
  final Color itemActiveColor;
  final Color itemDisabledColor;
  final double itemSelectedSize;

  FlanTreeSelectThemeData copyWith({
    double? fontSize,
    Color? navBackgroundColor,
    Color? contentBackgroundColor,
    EdgeInsets? navItemPadding,
    double? itemHeight,
    Color? itemActiveColor,
    Color? itemDisabledColor,
    double? itemSelectedSize,
  }) {
    return FlanTreeSelectThemeData(
      fontSize: fontSize ?? this.fontSize,
      navBackgroundColor: navBackgroundColor ?? this.navBackgroundColor,
      contentBackgroundColor:
          contentBackgroundColor ?? this.contentBackgroundColor,
      navItemPadding: navItemPadding ?? this.navItemPadding,
      itemHeight: itemHeight ?? this.itemHeight,
      itemActiveColor: itemActiveColor ?? this.itemActiveColor,
      itemDisabledColor: itemDisabledColor ?? this.itemDisabledColor,
      itemSelectedSize: itemSelectedSize ?? this.itemSelectedSize,
    );
  }

  FlanTreeSelectThemeData merge(FlanTreeSelectThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      fontSize: other.fontSize,
      navBackgroundColor: other.navBackgroundColor,
      contentBackgroundColor: other.contentBackgroundColor,
      navItemPadding: other.navItemPadding,
      itemHeight: other.itemHeight,
      itemActiveColor: other.itemActiveColor,
      itemDisabledColor: other.itemDisabledColor,
      itemSelectedSize: other.itemSelectedSize,
    );
  }

  static FlanTreeSelectThemeData lerp(
      FlanTreeSelectThemeData? a, FlanTreeSelectThemeData? b, double t) {
    return FlanTreeSelectThemeData(
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t),
      navBackgroundColor:
          Color.lerp(a?.navBackgroundColor, b?.navBackgroundColor, t),
      contentBackgroundColor:
          Color.lerp(a?.contentBackgroundColor, b?.contentBackgroundColor, t),
      navItemPadding: EdgeInsets.lerp(a?.navItemPadding, b?.navItemPadding, t),
      itemHeight: lerpDouble(a?.itemHeight, b?.itemHeight, t),
      itemActiveColor: Color.lerp(a?.itemActiveColor, b?.itemActiveColor, t),
      itemDisabledColor:
          Color.lerp(a?.itemDisabledColor, b?.itemDisabledColor, t),
      itemSelectedSize: lerpDouble(a?.itemSelectedSize, b?.itemSelectedSize, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      fontSize,
      navBackgroundColor,
      contentBackgroundColor,
      navItemPadding,
      itemHeight,
      itemActiveColor,
      itemDisabledColor,
      itemSelectedSize,
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
    return other is FlanTreeSelectThemeData &&
        other.fontSize == fontSize &&
        other.navBackgroundColor == navBackgroundColor &&
        other.contentBackgroundColor == contentBackgroundColor &&
        other.navItemPadding == navItemPadding &&
        other.itemHeight == itemHeight &&
        other.itemActiveColor == itemActiveColor &&
        other.itemDisabledColor == itemDisabledColor &&
        other.itemSelectedSize == itemSelectedSize;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'navBackgroundColor', navBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'contentBackgroundColor', contentBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'navItemPadding', navItemPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('itemHeight', itemHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'itemActiveColor', itemActiveColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'itemDisabledColor', itemDisabledColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'itemSelectedSize', itemSelectedSize,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
