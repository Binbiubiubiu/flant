import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanActionBarTheme extends InheritedTheme {
  const FlanActionBarTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanActionBarThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanActionBarTheme(
          key: key,
          data: FlanActionBarTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanActionBarThemeData data;

  static FlanActionBarThemeData of(BuildContext context) {
    final FlanActionBarTheme? actionBarTheme =
        context.dependOnInheritedWidgetOfExactType<FlanActionBarTheme>();
    return actionBarTheme?.data ?? FlanTheme.of(context).actionBarTheme;
  }

  @override
  bool updateShouldNotify(FlanActionBarTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanActionBarTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanActionBarThemeData with Diagnosticable {
  factory FlanActionBarThemeData({
    Color? backgroundColor,
    double? height,
    double? iconWidth,
    double? iconHeightFactor,
    Color? iconColor,
    double? iconSize,
    double? iconFontSize,
    Color? iconActiveColor,
    Color? iconTextColor,
    double? buttonHeight,
    LinearGradient? buttonWarningColor,
    LinearGradient? buttonDangerColor,
  }) {
    return FlanActionBarThemeData.raw(
      backgroundColor: backgroundColor ?? FlanThemeVars.white,
      height: height ?? 50.0.rpx,
      iconWidth: iconWidth ?? 48.0.rpx,
      iconHeightFactor: iconHeightFactor ?? 1.0,
      iconColor: iconColor ?? FlanThemeVars.textColor,
      iconSize: iconSize ?? 18.0.rpx,
      iconFontSize: iconFontSize ?? FlanThemeVars.fontSizeXs.rpx,
      iconActiveColor: iconActiveColor ?? FlanThemeVars.activeColor,
      iconTextColor: iconTextColor ?? FlanThemeVars.gray7,
      buttonHeight: buttonHeight ?? 40.0.rpx,
      buttonWarningColor: buttonWarningColor ?? FlanThemeVars.gradientOrange,
      buttonDangerColor: buttonDangerColor ?? FlanThemeVars.gradientRed,
    );
  }

  const FlanActionBarThemeData.raw({
    required this.backgroundColor,
    required this.height,
    required this.iconWidth,
    required this.iconHeightFactor,
    required this.iconColor,
    required this.iconSize,
    required this.iconFontSize,
    required this.iconActiveColor,
    required this.iconTextColor,
    required this.buttonHeight,
    required this.buttonWarningColor,
    required this.buttonDangerColor,
  });

  final Color backgroundColor;
  final double height;
  final double iconWidth;
  final double iconHeightFactor;
  final Color iconColor;
  final double iconSize;
  final double iconFontSize;
  final Color iconActiveColor;
  final Color iconTextColor;
  final double buttonHeight;
  final LinearGradient buttonWarningColor;
  final LinearGradient buttonDangerColor;

  FlanActionBarThemeData copyWith({
    Color? backgroundColor,
    double? height,
    double? iconWidth,
    double? iconHeightFactor,
    Color? iconColor,
    double? iconSize,
    double? iconFontSize,
    Color? iconActiveColor,
    Color? iconTextColor,
    double? buttonHeight,
    LinearGradient? buttonWarningColor,
    LinearGradient? buttonDangerColor,
  }) {
    return FlanActionBarThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      height: height ?? this.height,
      iconWidth: iconWidth ?? this.iconWidth,
      iconHeightFactor: iconHeightFactor ?? this.iconHeightFactor,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      iconFontSize: iconFontSize ?? this.iconFontSize,
      iconActiveColor: iconActiveColor ?? this.iconActiveColor,
      iconTextColor: iconTextColor ?? this.iconTextColor,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      buttonWarningColor: buttonWarningColor ?? this.buttonWarningColor,
      buttonDangerColor: buttonDangerColor ?? this.buttonDangerColor,
    );
  }

  FlanActionBarThemeData merge(FlanActionBarThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      backgroundColor: other.backgroundColor,
      height: other.height,
      iconWidth: other.iconWidth,
      iconHeightFactor: other.iconHeightFactor,
      iconColor: other.iconColor,
      iconSize: other.iconSize,
      iconFontSize: other.iconFontSize,
      iconActiveColor: other.iconActiveColor,
      iconTextColor: other.iconTextColor,
      buttonHeight: other.buttonHeight,
      buttonWarningColor: other.buttonWarningColor,
      buttonDangerColor: other.buttonDangerColor,
    );
  }

  static FlanActionBarThemeData lerp(
      FlanActionBarThemeData? a, FlanActionBarThemeData? b, double t) {
    return FlanActionBarThemeData(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      height: lerpDouble(a?.height, b?.height, t),
      iconWidth: lerpDouble(a?.iconWidth, b?.iconWidth, t),
      iconHeightFactor: lerpDouble(a?.iconHeightFactor, b?.iconHeightFactor, t),
      iconColor: Color.lerp(a?.iconColor, b?.iconColor, t),
      iconSize: lerpDouble(a?.iconSize, b?.iconSize, t),
      iconFontSize: lerpDouble(a?.iconFontSize, b?.iconFontSize, t),
      iconActiveColor: Color.lerp(a?.iconActiveColor, b?.iconActiveColor, t),
      iconTextColor: Color.lerp(a?.iconTextColor, b?.iconTextColor, t),
      buttonHeight: lerpDouble(a?.buttonHeight, b?.buttonHeight, t),
      buttonWarningColor:
          LinearGradient.lerp(a?.buttonWarningColor, b?.buttonWarningColor, t),
      buttonDangerColor:
          LinearGradient.lerp(a?.buttonDangerColor, b?.buttonDangerColor, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      backgroundColor,
      height,
      iconWidth,
      iconHeightFactor,
      iconColor,
      iconSize,
      iconFontSize,
      iconActiveColor,
      iconTextColor,
      buttonHeight,
      buttonWarningColor,
      buttonDangerColor,
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
    return other is FlanActionBarThemeData &&
        other.backgroundColor == backgroundColor &&
        other.height == height &&
        other.iconWidth == iconWidth &&
        other.iconHeightFactor == iconHeightFactor &&
        other.iconColor == iconColor &&
        other.iconSize == iconSize &&
        other.iconFontSize == iconFontSize &&
        other.iconActiveColor == iconActiveColor &&
        other.iconTextColor == iconTextColor &&
        other.buttonHeight == buttonHeight &&
        other.buttonWarningColor == buttonWarningColor &&
        other.buttonDangerColor == buttonDangerColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties
        .add(DiagnosticsProperty<double>('height', height, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('iconWidth', iconWidth,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'iconHeightFactor', iconHeightFactor,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('iconColor', iconColor, defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('iconSize', iconSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('iconFontSize', iconFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'iconActiveColor', iconActiveColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('iconTextColor', iconTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('buttonHeight', buttonHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<LinearGradient>(
        'buttonWarningColor', buttonWarningColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<LinearGradient>(
        'buttonDangerColor', buttonDangerColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
