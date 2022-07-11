import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanProgressTheme extends InheritedTheme {
  const FlanProgressTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanProgressThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanProgressTheme(
          key: key,
          data: FlanProgressTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanProgressThemeData data;

  static FlanProgressThemeData of(BuildContext context) {
    final FlanProgressTheme? progressTheme =
        context.dependOnInheritedWidgetOfExactType<FlanProgressTheme>();
    return progressTheme?.data ?? FlanTheme.of(context).progressTheme;
  }

  @override
  bool updateShouldNotify(FlanProgressTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanProgressTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanProgressThemeData with Diagnosticable {
  factory FlanProgressThemeData({
    double? height,
    Color? color,
    Color? backgroundColor,
    EdgeInsets? pivotPadding,
    Color? pivotTextColor,
    double? pivotFontSize,
    double? pivotLineHeight,
    Color? pivotBackgroundColor,
  }) {
    return FlanProgressThemeData.raw(
      height: height ?? 4.0.rpx,
      color: color ?? FlanThemeVars.blue,
      backgroundColor: backgroundColor ?? FlanThemeVars.gray3,
      pivotPadding: pivotPadding ??
          EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0.rpx),
      pivotTextColor: pivotTextColor ?? FlanThemeVars.white,
      pivotFontSize: pivotFontSize ?? FlanThemeVars.fontSizeXs.rpx,
      pivotLineHeight: pivotLineHeight ?? 1.6,
      pivotBackgroundColor: pivotBackgroundColor ?? FlanThemeVars.blue,
    );
  }

  const FlanProgressThemeData.raw({
    required this.height,
    required this.color,
    required this.backgroundColor,
    required this.pivotPadding,
    required this.pivotTextColor,
    required this.pivotFontSize,
    required this.pivotLineHeight,
    required this.pivotBackgroundColor,
  });

  final double height;
  final Color color;
  final Color backgroundColor;
  final EdgeInsets pivotPadding;
  final Color pivotTextColor;
  final double pivotFontSize;
  final double pivotLineHeight;
  final Color pivotBackgroundColor;

  FlanProgressThemeData copyWith({
    double? height,
    Color? color,
    Color? backgroundColor,
    EdgeInsets? pivotPadding,
    Color? pivotTextColor,
    double? pivotFontSize,
    double? pivotLineHeight,
    Color? pivotBackgroundColor,
  }) {
    return FlanProgressThemeData(
      height: height ?? this.height,
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      pivotPadding: pivotPadding ?? this.pivotPadding,
      pivotTextColor: pivotTextColor ?? this.pivotTextColor,
      pivotFontSize: pivotFontSize ?? this.pivotFontSize,
      pivotLineHeight: pivotLineHeight ?? this.pivotLineHeight,
      pivotBackgroundColor: pivotBackgroundColor ?? this.pivotBackgroundColor,
    );
  }

  FlanProgressThemeData merge(FlanProgressThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      height: other.height,
      color: other.color,
      backgroundColor: other.backgroundColor,
      pivotPadding: other.pivotPadding,
      pivotTextColor: other.pivotTextColor,
      pivotFontSize: other.pivotFontSize,
      pivotLineHeight: other.pivotLineHeight,
      pivotBackgroundColor: other.pivotBackgroundColor,
    );
  }

  static FlanProgressThemeData lerp(
      FlanProgressThemeData? a, FlanProgressThemeData? b, double t) {
    return FlanProgressThemeData(
      height: lerpDouble(a?.height, b?.height, t),
      color: Color.lerp(a?.color, b?.color, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      pivotPadding: EdgeInsets.lerp(a?.pivotPadding, b?.pivotPadding, t),
      pivotTextColor: Color.lerp(a?.pivotTextColor, b?.pivotTextColor, t),
      pivotFontSize: lerpDouble(a?.pivotFontSize, b?.pivotFontSize, t),
      pivotLineHeight: lerpDouble(a?.pivotLineHeight, b?.pivotLineHeight, t),
      pivotBackgroundColor:
          Color.lerp(a?.pivotBackgroundColor, b?.pivotBackgroundColor, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      height,
      color,
      backgroundColor,
      pivotPadding,
      pivotTextColor,
      pivotFontSize,
      pivotLineHeight,
      pivotBackgroundColor,
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
    return other is FlanProgressThemeData &&
        other.height == height &&
        other.color == color &&
        other.backgroundColor == backgroundColor &&
        other.pivotPadding == pivotPadding &&
        other.pivotTextColor == pivotTextColor &&
        other.pivotFontSize == pivotFontSize &&
        other.pivotLineHeight == pivotLineHeight &&
        other.pivotBackgroundColor == pivotBackgroundColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('height', height, defaultValue: null));
    properties
        .add(DiagnosticsProperty<Color>('color', color, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('pivotPadding', pivotPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('pivotTextColor', pivotTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('pivotFontSize', pivotFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'pivotLineHeight', pivotLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'pivotBackgroundColor', pivotBackgroundColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
