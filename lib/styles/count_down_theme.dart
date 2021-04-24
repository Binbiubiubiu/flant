import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/widget.dart';
import 'theme.dart';
import 'var.dart';

class FlanCountDownTheme extends InheritedTheme {
  const FlanCountDownTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanCountDownThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanCountDownTheme(
          key: key,
          data: FlanCountDownTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanCountDownThemeData data;

  static FlanCountDownThemeData of(BuildContext context) {
    final FlanCountDownTheme? countDownTheme =
        context.dependOnInheritedWidgetOfExactType<FlanCountDownTheme>();
    return countDownTheme?.data ?? FlanTheme.of(context).countDownTheme;
  }

  @override
  bool updateShouldNotify(FlanCountDownTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanCountDownTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanCountDownThemeData with Diagnosticable {
  factory FlanCountDownThemeData({
    Color? textColor,
    double? fontSize,
    double? lineHeight,
  }) {
    return FlanCountDownThemeData.raw(
      textColor: textColor ?? FlanThemeVars.textColor,
      fontSize: fontSize ?? FlanThemeVars.fontSizeMd.rpx,
      lineHeight: lineHeight ?? FlanThemeVars.lineHeightMd.rpx,
    );
  }

  const FlanCountDownThemeData.raw({
    required this.textColor,
    required this.fontSize,
    required this.lineHeight,
  });

  final Color textColor;
  final double fontSize;
  final double lineHeight;

  FlanCountDownThemeData copyWith({
    Color? textColor,
    double? fontSize,
    double? lineHeight,
  }) {
    return FlanCountDownThemeData(
      textColor: textColor ?? this.textColor,
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
    );
  }

  FlanCountDownThemeData merge(FlanCountDownThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      textColor: other.textColor,
      fontSize: other.fontSize,
      lineHeight: other.lineHeight,
    );
  }

  static FlanCountDownThemeData lerp(
      FlanCountDownThemeData? a, FlanCountDownThemeData? b, double t) {
    return FlanCountDownThemeData(
      textColor: Color.lerp(a?.textColor, b?.textColor, t)!,
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t)!,
      lineHeight: lerpDouble(a?.lineHeight, b?.lineHeight, t)!,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      textColor,
      fontSize,
      lineHeight,
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
    return other is FlanCountDownThemeData &&
        other.textColor == textColor &&
        other.fontSize == fontSize &&
        other.lineHeight == lineHeight;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('lineHeight', lineHeight,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
