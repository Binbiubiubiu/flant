import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanCircleTheme extends InheritedTheme {
  const FlanCircleTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanCircleThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanCircleTheme(
          key: key,
          data: FlanCircleTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanCircleThemeData data;

  static FlanCircleThemeData of(BuildContext context) {
    final FlanCircleTheme? circleTheme =
        context.dependOnInheritedWidgetOfExactType<FlanCircleTheme>();
    return circleTheme?.data ?? FlanTheme.of(context).circleTheme;
  }

  @override
  bool updateShouldNotify(FlanCircleTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanCircleTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanCircleThemeData with Diagnosticable {
  factory FlanCircleThemeData({
    double? size,
    Color? color,
    Color? layerColor,
    Color? textColor,
    FontWeight? textFontWeight,
    double? textFontSize,
    double? textLineHeight,
  }) {
    final double _textFontSize = textFontSize ?? FlanThemeVars.fontSizeMd.rpx;
    return FlanCircleThemeData.raw(
      size: size ?? 100.0.rpx,
      color: color ?? FlanThemeVars.blue,
      layerColor: layerColor ?? FlanThemeVars.white,
      textColor: textColor ?? FlanThemeVars.textColor,
      textFontWeight: textFontWeight ?? FlanThemeVars.fontWeightBold,
      textFontSize: _textFontSize,
      textLineHeight:
          textLineHeight ?? (FlanThemeVars.lineHeightMd.rpx / _textFontSize),
    );
  }

  const FlanCircleThemeData.raw({
    required this.size,
    required this.color,
    required this.layerColor,
    required this.textColor,
    required this.textFontWeight,
    required this.textFontSize,
    required this.textLineHeight,
  });

  final double size;
  final Color color;
  final Color layerColor;
  final Color textColor;
  final FontWeight textFontWeight;
  final double textFontSize;
  final double textLineHeight;

  FlanCircleThemeData copyWith({
    double? size,
    Color? color,
    Color? layerColor,
    Color? textColor,
    FontWeight? textFontWeight,
    double? textFontSize,
    double? textLineHeight,
  }) {
    return FlanCircleThemeData(
      size: size ?? this.size,
      color: color ?? this.color,
      layerColor: layerColor ?? this.layerColor,
      textColor: textColor ?? this.textColor,
      textFontWeight: textFontWeight ?? this.textFontWeight,
      textFontSize: textFontSize ?? this.textFontSize,
      textLineHeight: textLineHeight ?? this.textLineHeight,
    );
  }

  FlanCircleThemeData merge(FlanCircleThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      size: other.size,
      color: other.color,
      layerColor: other.layerColor,
      textColor: other.textColor,
      textFontWeight: other.textFontWeight,
      textFontSize: other.textFontSize,
      textLineHeight: other.textLineHeight,
    );
  }

  static FlanCircleThemeData lerp(
      FlanCircleThemeData? a, FlanCircleThemeData? b, double t) {
    return FlanCircleThemeData(
      size: lerpDouble(a?.size, b?.size, t),
      color: Color.lerp(a?.color, b?.color, t),
      layerColor: Color.lerp(a?.layerColor, b?.layerColor, t),
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      textFontWeight: FontWeight.lerp(a?.textFontWeight, b?.textFontWeight, t),
      textFontSize: lerpDouble(a?.textFontSize, b?.textFontSize, t),
      textLineHeight: lerpDouble(a?.textLineHeight, b?.textLineHeight, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      size,
      color,
      layerColor,
      textColor,
      textFontWeight,
      textFontSize,
      textLineHeight,
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
    return other is FlanCircleThemeData &&
        other.size == size &&
        other.color == color &&
        other.layerColor == layerColor &&
        other.textColor == textColor &&
        other.textFontWeight == textFontWeight &&
        other.textFontSize == textFontSize &&
        other.textLineHeight == textLineHeight;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('size', size, defaultValue: null));
    properties
        .add(DiagnosticsProperty<Color>('color', color, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('layerColor', layerColor,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<FontWeight>(
        'textFontWeight', textFontWeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('textFontSize', textFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('textLineHeight', textLineHeight,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
