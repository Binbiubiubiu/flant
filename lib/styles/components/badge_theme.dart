// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanBadgeTheme extends InheritedTheme {
  const FlanBadgeTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanBadgeThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanBadgeTheme(
          key: key,
          data: FlanBadgeTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanBadgeThemeData data;

  static FlanBadgeThemeData of(BuildContext context) {
    final FlanBadgeTheme? badgeTheme =
        context.dependOnInheritedWidgetOfExactType<FlanBadgeTheme>();
    return badgeTheme?.data ?? FlanTheme.of(context).badgeTheme;
  }

  @override
  bool updateShouldNotify(FlanBadgeTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanBadgeTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanBadgeThemeData with Diagnosticable {
  factory FlanBadgeThemeData({
    double? size,
    Color? color,
    EdgeInsets? padding,
    double? fontSize,
    FontWeight? fontWeight,
    double? borderWidth,
    Color? backgroundColor,
    Color? dotColor,
    double? dotSize,
    String? fontFamily,
  }) {
    return FlanBadgeThemeData.raw(
      size: size ?? 16.0.rpx,
      color: color ?? FlanThemeVars.white,
      padding:
          padding ?? EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0.rpx),
      fontSize: fontSize ?? FlanThemeVars.fontSizeSm.rpx,
      fontWeight: fontWeight ?? FlanThemeVars.fontWeightBold,
      borderWidth: borderWidth ?? FlanThemeVars.borderWidthBase.rpx,
      backgroundColor: backgroundColor ?? FlanThemeVars.red,
      dotColor: dotColor ?? FlanThemeVars.red,
      dotSize: dotSize ?? 8.0.rpx,
      fontFamily: fontFamily ?? '',
    );
  }

  const FlanBadgeThemeData.raw({
    required this.size,
    required this.color,
    required this.padding,
    required this.fontSize,
    required this.fontWeight,
    required this.borderWidth,
    required this.backgroundColor,
    required this.dotColor,
    required this.dotSize,
    required this.fontFamily,
  });

  final double size;
  final Color color;
  final EdgeInsets padding;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderWidth;
  final Color backgroundColor;
  final Color dotColor;
  final double dotSize;
  final String fontFamily;

  FlanBadgeThemeData copyWith({
    double? size,
    Color? color,
    EdgeInsets? padding,
    double? fontSize,
    FontWeight? fontWeight,
    double? borderWidth,
    Color? backgroundColor,
    Color? dotColor,
    double? dotSize,
    String? fontFamily,
  }) {
    return FlanBadgeThemeData(
      size: size ?? this.size,
      color: color ?? this.color,
      padding: padding ?? this.padding,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      borderWidth: borderWidth ?? this.borderWidth,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      dotColor: dotColor ?? this.dotColor,
      dotSize: dotSize ?? this.dotSize,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }

  FlanBadgeThemeData merge(FlanBadgeThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      size: other.size,
      color: other.color,
      padding: other.padding,
      fontSize: other.fontSize,
      fontWeight: other.fontWeight,
      borderWidth: other.borderWidth,
      backgroundColor: other.backgroundColor,
      dotColor: other.dotColor,
      dotSize: other.dotSize,
      fontFamily: other.fontFamily,
    );
  }

  static FlanBadgeThemeData lerp(
      FlanBadgeThemeData? a, FlanBadgeThemeData? b, double t) {
    return FlanBadgeThemeData(
      size: lerpDouble(a?.size, b?.size, t),
      color: Color.lerp(a?.color, b?.color, t),
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t),
      fontWeight: FontWeight.lerp(a?.fontWeight, b?.fontWeight, t),
      borderWidth: lerpDouble(a?.borderWidth, b?.borderWidth, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      dotColor: Color.lerp(a?.dotColor, b?.dotColor, t),
      dotSize: lerpDouble(a?.dotSize, b?.dotSize, t),
      fontFamily: b?.fontFamily,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      size,
      color,
      padding,
      fontSize,
      fontWeight,
      borderWidth,
      backgroundColor,
      dotColor,
      dotSize,
      fontFamily,
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
    return other is FlanBadgeThemeData &&
        other.size == size &&
        other.color == color &&
        other.padding == padding &&
        other.fontSize == fontSize &&
        other.fontWeight == fontWeight &&
        other.borderWidth == borderWidth &&
        other.backgroundColor == backgroundColor &&
        other.dotColor == dotColor &&
        other.dotSize == dotSize &&
        other.fontFamily == fontFamily;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('size', size, defaultValue: null));
    properties
        .add(DiagnosticsProperty<Color>('color', color, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<FontWeight>('fontWeight', fontWeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('borderWidth', borderWidth,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('dotColor', dotColor, defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('dotSize', dotSize, defaultValue: null));
    properties.add(DiagnosticsProperty<String>('fontFamily', fontFamily,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
