import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanTabbarTheme extends InheritedTheme {
  const FlanTabbarTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanTabbarThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanTabbarTheme(
          key: key,
          data: FlanTabbarTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanTabbarThemeData data;

  static FlanTabbarThemeData of(BuildContext context) {
    final FlanTabbarTheme? tabbarTheme =
        context.dependOnInheritedWidgetOfExactType<FlanTabbarTheme>();
    return tabbarTheme?.data ?? FlanTheme.of(context).tabbarTheme;
  }

  @override
  bool updateShouldNotify(FlanTabbarTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanTabbarTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanTabbarThemeData with Diagnosticable {
  factory FlanTabbarThemeData({
    double? height,
    Color? backgroundColor,
    double? itemFontSize,
    Color? itemTextColor,
    Color? itemActiveColor,
    Color? itemActiveBackgroundColor,
    double? itemLineHeight,
    double? itemIconSize,
    double? itemMarginBottom,
  }) {
    final Color bgColor = backgroundColor ?? FlanThemeVars.white;
    return FlanTabbarThemeData.raw(
      height: height ?? 50.0.rpx,
      backgroundColor: bgColor,
      itemFontSize: itemFontSize ?? FlanThemeVars.fontSizeSm.rpx,
      itemTextColor: itemTextColor ?? FlanThemeVars.gray7,
      itemActiveColor: itemActiveColor ?? FlanThemeVars.blue,
      itemActiveBackgroundColor: itemActiveBackgroundColor ?? bgColor,
      itemLineHeight: itemLineHeight ?? 1.0,
      itemIconSize: itemIconSize ?? 22.0.rpx,
      itemMarginBottom: itemMarginBottom ?? 4.0.rpx,
    );
  }

  const FlanTabbarThemeData.raw({
    required this.height,
    required this.backgroundColor,
    required this.itemFontSize,
    required this.itemTextColor,
    required this.itemActiveColor,
    required this.itemActiveBackgroundColor,
    required this.itemLineHeight,
    required this.itemIconSize,
    required this.itemMarginBottom,
  });

  final double height;
  final Color backgroundColor;
  final double itemFontSize;
  final Color itemTextColor;
  final Color itemActiveColor;
  final Color itemActiveBackgroundColor;
  final double itemLineHeight;
  final double itemIconSize;
  final double itemMarginBottom;

  FlanTabbarThemeData copyWith({
    double? height,
    Color? backgroundColor,
    double? itemFontSize,
    Color? itemTextColor,
    Color? itemActiveColor,
    Color? itemActiveBackgroundColor,
    double? itemLineHeight,
    double? itemIconSize,
    double? itemMarginBottom,
  }) {
    return FlanTabbarThemeData(
      height: height ?? this.height,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      itemFontSize: itemFontSize ?? this.itemFontSize,
      itemTextColor: itemTextColor ?? this.itemTextColor,
      itemActiveColor: itemActiveColor ?? this.itemActiveColor,
      itemActiveBackgroundColor:
          itemActiveBackgroundColor ?? this.itemActiveBackgroundColor,
      itemLineHeight: itemLineHeight ?? this.itemLineHeight,
      itemIconSize: itemIconSize ?? this.itemIconSize,
      itemMarginBottom: itemMarginBottom ?? this.itemMarginBottom,
    );
  }

  FlanTabbarThemeData merge(FlanTabbarThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      height: other.height,
      backgroundColor: other.backgroundColor,
      itemFontSize: other.itemFontSize,
      itemTextColor: other.itemTextColor,
      itemActiveColor: other.itemActiveColor,
      itemActiveBackgroundColor: other.itemActiveBackgroundColor,
      itemLineHeight: other.itemLineHeight,
      itemIconSize: other.itemIconSize,
      itemMarginBottom: other.itemMarginBottom,
    );
  }

  static FlanTabbarThemeData lerp(
      FlanTabbarThemeData? a, FlanTabbarThemeData? b, double t) {
    return FlanTabbarThemeData(
      height: lerpDouble(a?.height, b?.height, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      itemFontSize: lerpDouble(a?.itemFontSize, b?.itemFontSize, t),
      itemTextColor: Color.lerp(a?.itemTextColor, b?.itemTextColor, t),
      itemActiveColor: Color.lerp(a?.itemActiveColor, b?.itemActiveColor, t),
      itemActiveBackgroundColor: Color.lerp(
          a?.itemActiveBackgroundColor, b?.itemActiveBackgroundColor, t),
      itemLineHeight: lerpDouble(a?.itemLineHeight, b?.itemLineHeight, t),
      itemIconSize: lerpDouble(a?.itemIconSize, b?.itemIconSize, t),
      itemMarginBottom: lerpDouble(a?.itemMarginBottom, b?.itemMarginBottom, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      height,
      backgroundColor,
      itemFontSize,
      itemTextColor,
      itemActiveColor,
      itemActiveBackgroundColor,
      itemLineHeight,
      itemIconSize,
      itemMarginBottom,
    ];

    return Object.hashAll(values);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is FlanTabbarThemeData &&
        other.height == height &&
        other.backgroundColor == backgroundColor &&
        other.itemFontSize == itemFontSize &&
        other.itemTextColor == itemTextColor &&
        other.itemActiveColor == itemActiveColor &&
        other.itemActiveBackgroundColor == itemActiveBackgroundColor &&
        other.itemLineHeight == itemLineHeight &&
        other.itemIconSize == itemIconSize &&
        other.itemMarginBottom == itemMarginBottom;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('height', height, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('itemFontSize', itemFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('itemTextColor', itemTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'itemActiveColor', itemActiveColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'itemActiveBackgroundColor', itemActiveBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('itemLineHeight', itemLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('itemIconSize', itemIconSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'itemMarginBottom', itemMarginBottom,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
