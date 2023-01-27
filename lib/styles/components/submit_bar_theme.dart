import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanSubmitBarTheme extends InheritedTheme {
  const FlanSubmitBarTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanSubmitBarThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanSubmitBarTheme(
          key: key,
          data: FlanSubmitBarTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanSubmitBarThemeData data;

  static FlanSubmitBarThemeData of(BuildContext context) {
    final FlanSubmitBarTheme? submitBarTheme =
        context.dependOnInheritedWidgetOfExactType<FlanSubmitBarTheme>();
    return submitBarTheme?.data ?? FlanTheme.of(context).submitBarTheme;
  }

  @override
  bool updateShouldNotify(FlanSubmitBarTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanSubmitBarTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanSubmitBarThemeData with Diagnosticable {
  factory FlanSubmitBarThemeData({
    double? height,
    Color? backgroundColor,
    double? buttonWidth,
    Color? priceColor,
    double? priceFontSize,
    double? currencyFontSize,
    Color? textColor,
    double? textFontSize,
    EdgeInsets? tipPadding,
    double? tipFontSize,
    double? tipLineHeight,
    Color? tipColor,
    Color? tipBackgroundColor,
    double? tipIconSize,
    double? buttonHeight,
    EdgeInsets? padding,
    double? priceIntegerFontSize,
    String? priceFontFamily,
  }) {
    return FlanSubmitBarThemeData.raw(
      height: height ?? 50.0.rpx,
      backgroundColor: backgroundColor ?? FlanThemeVars.white,
      buttonWidth: buttonWidth ?? 110.0.rpx,
      priceColor: priceColor ?? FlanThemeVars.red,
      priceFontSize: priceFontSize ?? FlanThemeVars.fontSizeMd.rpx,
      currencyFontSize: currencyFontSize ?? FlanThemeVars.fontSizeMd.rpx,
      textColor: textColor ?? FlanThemeVars.textColor,
      textFontSize: textFontSize ?? FlanThemeVars.fontSizeMd.rpx,
      tipPadding: tipPadding ??
          EdgeInsets.symmetric(
            vertical: FlanThemeVars.paddingXs.rpx,
            horizontal: FlanThemeVars.paddingSm.rpx,
          ),
      tipFontSize: tipFontSize ?? FlanThemeVars.fontSizeSm.rpx,
      tipLineHeight: tipLineHeight ?? 1.5,
      tipColor: tipColor ?? const Color(0xfff56723),
      tipBackgroundColor: tipBackgroundColor ?? const Color(0xfffff7cc),
      tipIconSize: tipIconSize ?? 12.0.rpx,
      buttonHeight: buttonHeight ?? 40.0.rpx,
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: FlanThemeVars.paddingMd.rpx,
          ),
      priceIntegerFontSize: priceIntegerFontSize ?? 20.0.rpx,
      priceFontFamily: priceFontFamily ?? FlanThemeVars.priceIntegerFontFamily,
    );
  }

  const FlanSubmitBarThemeData.raw({
    required this.height,
    required this.backgroundColor,
    required this.buttonWidth,
    required this.priceColor,
    required this.priceFontSize,
    required this.currencyFontSize,
    required this.textColor,
    required this.textFontSize,
    required this.tipPadding,
    required this.tipFontSize,
    required this.tipLineHeight,
    required this.tipColor,
    required this.tipBackgroundColor,
    required this.tipIconSize,
    required this.buttonHeight,
    required this.padding,
    required this.priceIntegerFontSize,
    required this.priceFontFamily,
  });

  final double height;
  final Color backgroundColor;
  final double buttonWidth;
  final Color priceColor;
  final double priceFontSize;
  final double currencyFontSize;
  final Color textColor;
  final double textFontSize;
  final EdgeInsets tipPadding;
  final double tipFontSize;
  final double tipLineHeight;
  final Color tipColor;
  final Color tipBackgroundColor;
  final double tipIconSize;
  final double buttonHeight;
  final EdgeInsets padding;
  final double priceIntegerFontSize;
  final String priceFontFamily;

  FlanSubmitBarThemeData copyWith({
    double? height,
    Color? backgroundColor,
    double? buttonWidth,
    Color? priceColor,
    double? priceFontSize,
    double? currencyFontSize,
    Color? textColor,
    double? textFontSize,
    EdgeInsets? tipPadding,
    double? tipFontSize,
    double? tipLineHeight,
    Color? tipColor,
    Color? tipBackgroundColor,
    double? tipIconSize,
    double? buttonHeight,
    EdgeInsets? padding,
    double? priceIntegerFontSize,
    String? priceFontFamily,
  }) {
    return FlanSubmitBarThemeData(
      height: height ?? this.height,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      buttonWidth: buttonWidth ?? this.buttonWidth,
      priceColor: priceColor ?? this.priceColor,
      priceFontSize: priceFontSize ?? this.priceFontSize,
      currencyFontSize: currencyFontSize ?? this.currencyFontSize,
      textColor: textColor ?? this.textColor,
      textFontSize: textFontSize ?? this.textFontSize,
      tipPadding: tipPadding ?? this.tipPadding,
      tipFontSize: tipFontSize ?? this.tipFontSize,
      tipLineHeight: tipLineHeight ?? this.tipLineHeight,
      tipColor: tipColor ?? this.tipColor,
      tipBackgroundColor: tipBackgroundColor ?? this.tipBackgroundColor,
      tipIconSize: tipIconSize ?? this.tipIconSize,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      padding: padding ?? this.padding,
      priceIntegerFontSize: priceIntegerFontSize ?? this.priceIntegerFontSize,
      priceFontFamily: priceFontFamily ?? this.priceFontFamily,
    );
  }

  FlanSubmitBarThemeData merge(FlanSubmitBarThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      height: other.height,
      backgroundColor: other.backgroundColor,
      buttonWidth: other.buttonWidth,
      priceColor: other.priceColor,
      priceFontSize: other.priceFontSize,
      currencyFontSize: other.currencyFontSize,
      textColor: other.textColor,
      textFontSize: other.textFontSize,
      tipPadding: other.tipPadding,
      tipFontSize: other.tipFontSize,
      tipLineHeight: other.tipLineHeight,
      tipColor: other.tipColor,
      tipBackgroundColor: other.tipBackgroundColor,
      tipIconSize: other.tipIconSize,
      buttonHeight: other.buttonHeight,
      padding: other.padding,
      priceIntegerFontSize: other.priceIntegerFontSize,
      priceFontFamily: other.priceFontFamily,
    );
  }

  static FlanSubmitBarThemeData lerp(
      FlanSubmitBarThemeData? a, FlanSubmitBarThemeData? b, double t) {
    return FlanSubmitBarThemeData(
      height: lerpDouble(a?.height, b?.height, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      buttonWidth: lerpDouble(a?.buttonWidth, b?.buttonWidth, t),
      priceColor: Color.lerp(a?.priceColor, b?.priceColor, t),
      priceFontSize: lerpDouble(a?.priceFontSize, b?.priceFontSize, t),
      currencyFontSize: lerpDouble(a?.currencyFontSize, b?.currencyFontSize, t),
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      textFontSize: lerpDouble(a?.textFontSize, b?.textFontSize, t),
      tipPadding: EdgeInsets.lerp(a?.tipPadding, b?.tipPadding, t),
      tipFontSize: lerpDouble(a?.tipFontSize, b?.tipFontSize, t),
      tipLineHeight: lerpDouble(a?.tipLineHeight, b?.tipLineHeight, t),
      tipColor: Color.lerp(a?.tipColor, b?.tipColor, t),
      tipBackgroundColor:
          Color.lerp(a?.tipBackgroundColor, b?.tipBackgroundColor, t),
      tipIconSize: lerpDouble(a?.tipIconSize, b?.tipIconSize, t),
      buttonHeight: lerpDouble(a?.buttonHeight, b?.buttonHeight, t),
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      priceIntegerFontSize:
          lerpDouble(a?.priceIntegerFontSize, b?.priceIntegerFontSize, t),
      priceFontFamily: b?.priceFontFamily,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      height,
      backgroundColor,
      buttonWidth,
      priceColor,
      priceFontSize,
      currencyFontSize,
      textColor,
      textFontSize,
      tipPadding,
      tipFontSize,
      tipLineHeight,
      tipColor,
      tipBackgroundColor,
      tipIconSize,
      buttonHeight,
      padding,
      priceIntegerFontSize,
      priceFontFamily,
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
    return other is FlanSubmitBarThemeData &&
        other.height == height &&
        other.backgroundColor == backgroundColor &&
        other.buttonWidth == buttonWidth &&
        other.priceColor == priceColor &&
        other.priceFontSize == priceFontSize &&
        other.currencyFontSize == currencyFontSize &&
        other.textColor == textColor &&
        other.textFontSize == textFontSize &&
        other.tipPadding == tipPadding &&
        other.tipFontSize == tipFontSize &&
        other.tipLineHeight == tipLineHeight &&
        other.tipColor == tipColor &&
        other.tipBackgroundColor == tipBackgroundColor &&
        other.tipIconSize == tipIconSize &&
        other.buttonHeight == buttonHeight &&
        other.padding == padding &&
        other.priceIntegerFontSize == priceIntegerFontSize &&
        other.priceFontFamily == priceFontFamily;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('height', height, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('buttonWidth', buttonWidth,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('priceColor', priceColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('priceFontSize', priceFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'currencyFontSize', currencyFontSize,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('textFontSize', textFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('tipPadding', tipPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('tipFontSize', tipFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('tipLineHeight', tipLineHeight,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('tipColor', tipColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'tipBackgroundColor', tipBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('tipIconSize', tipIconSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('buttonHeight', buttonHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'priceIntegerFontSize', priceIntegerFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<String>(
        'priceFontFamily', priceFontFamily,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
