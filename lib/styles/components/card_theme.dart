// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanCardTheme extends InheritedTheme {
  const FlanCardTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanCardThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanCardTheme(
          key: key,
          data: FlanCardTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanCardThemeData data;

  static FlanCardThemeData of(BuildContext context) {
    final FlanCardTheme? cardTheme =
        context.dependOnInheritedWidgetOfExactType<FlanCardTheme>();
    return cardTheme?.data ?? FlanTheme.of(context).cardTheme;
  }

  @override
  bool updateShouldNotify(FlanCardTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanCardTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanCardThemeData with Diagnosticable {
  factory FlanCardThemeData({
    EdgeInsets? padding,
    double? fontSize,
    Color? textColor,
    Color? backgroundColor,
    double? thumbSize,
    double? thumbBorderRadius,
    double? titleLineHeight,
    Color? descColor,
    double? descLineHeight,
    Color? priceColor,
    Color? originPriceColor,
    Color? numColor,
    double? originPriceFontSize,
    double? priceFontSize,
    double? priceIntegerFontSize,
    String? priceFontFamily,
  }) {
    final double _fontSize = fontSize ?? FlanThemeVars.fontSizeSm.rpx;
    return FlanCardThemeData.raw(
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: FlanThemeVars.paddingXs.rpx,
            horizontal: FlanThemeVars.paddingMd.rpx,
          ),
      fontSize: fontSize ?? FlanThemeVars.fontSizeSm.rpx,
      textColor: textColor ?? FlanThemeVars.textColor,
      backgroundColor: backgroundColor ?? FlanThemeVars.backgroundColorLight,
      thumbSize: thumbSize ?? 88.0.rpx,
      thumbBorderRadius: thumbBorderRadius ?? FlanThemeVars.borderRadiusLg.rpx,
      titleLineHeight: titleLineHeight ?? (16.0.rpx / _fontSize),
      descColor: descColor ?? FlanThemeVars.gray7,
      descLineHeight:
          descLineHeight ?? (FlanThemeVars.lineHeightMd.rpx / _fontSize),
      priceColor: priceColor ?? FlanThemeVars.gray8,
      originPriceColor: originPriceColor ?? FlanThemeVars.gray6,
      numColor: numColor ?? FlanThemeVars.gray6,
      originPriceFontSize: originPriceFontSize ?? FlanThemeVars.fontSizeXs.rpx,
      priceFontSize: priceFontSize ?? FlanThemeVars.fontSizeSm.rpx,
      priceIntegerFontSize:
          priceIntegerFontSize ?? FlanThemeVars.fontSizeLg.rpx,
      priceFontFamily: priceFontFamily ?? FlanThemeVars.priceIntegerFontFamily,
    );
  }

  const FlanCardThemeData.raw({
    required this.padding,
    required this.fontSize,
    required this.textColor,
    required this.backgroundColor,
    required this.thumbSize,
    required this.thumbBorderRadius,
    required this.titleLineHeight,
    required this.descColor,
    required this.descLineHeight,
    required this.priceColor,
    required this.originPriceColor,
    required this.numColor,
    required this.originPriceFontSize,
    required this.priceFontSize,
    required this.priceIntegerFontSize,
    required this.priceFontFamily,
  });

  final EdgeInsets padding;
  final double fontSize;
  final Color textColor;
  final Color backgroundColor;
  final double thumbSize;
  final double thumbBorderRadius;
  final double titleLineHeight;
  final Color descColor;
  final double descLineHeight;
  final Color priceColor;
  final Color originPriceColor;
  final Color numColor;
  final double originPriceFontSize;
  final double priceFontSize;
  final double priceIntegerFontSize;
  final String priceFontFamily;

  FlanCardThemeData copyWith({
    EdgeInsets? padding,
    double? fontSize,
    Color? textColor,
    Color? backgroundColor,
    double? thumbSize,
    double? thumbBorderRadius,
    double? titleLineHeight,
    Color? descColor,
    double? descLineHeight,
    Color? priceColor,
    Color? originPriceColor,
    Color? numColor,
    double? originPriceFontSize,
    double? priceFontSize,
    double? priceIntegerFontSize,
    String? priceFontFamily,
  }) {
    return FlanCardThemeData(
      padding: padding ?? this.padding,
      fontSize: fontSize ?? this.fontSize,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      thumbSize: thumbSize ?? this.thumbSize,
      thumbBorderRadius: thumbBorderRadius ?? this.thumbBorderRadius,
      titleLineHeight: titleLineHeight ?? this.titleLineHeight,
      descColor: descColor ?? this.descColor,
      descLineHeight: descLineHeight ?? this.descLineHeight,
      priceColor: priceColor ?? this.priceColor,
      originPriceColor: originPriceColor ?? this.originPriceColor,
      numColor: numColor ?? this.numColor,
      originPriceFontSize: originPriceFontSize ?? this.originPriceFontSize,
      priceFontSize: priceFontSize ?? this.priceFontSize,
      priceIntegerFontSize: priceIntegerFontSize ?? this.priceIntegerFontSize,
      priceFontFamily: priceFontFamily ?? this.priceFontFamily,
    );
  }

  FlanCardThemeData merge(FlanCardThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      padding: other.padding,
      fontSize: other.fontSize,
      textColor: other.textColor,
      backgroundColor: other.backgroundColor,
      thumbSize: other.thumbSize,
      thumbBorderRadius: other.thumbBorderRadius,
      titleLineHeight: other.titleLineHeight,
      descColor: other.descColor,
      descLineHeight: other.descLineHeight,
      priceColor: other.priceColor,
      originPriceColor: other.originPriceColor,
      numColor: other.numColor,
      originPriceFontSize: other.originPriceFontSize,
      priceFontSize: other.priceFontSize,
      priceIntegerFontSize: other.priceIntegerFontSize,
      priceFontFamily: other.priceFontFamily,
    );
  }

  static FlanCardThemeData lerp(
      FlanCardThemeData? a, FlanCardThemeData? b, double t) {
    return FlanCardThemeData(
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t),
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      thumbSize: lerpDouble(a?.thumbSize, b?.thumbSize, t),
      thumbBorderRadius:
          lerpDouble(a?.thumbBorderRadius, b?.thumbBorderRadius, t),
      titleLineHeight: lerpDouble(a?.titleLineHeight, b?.titleLineHeight, t),
      descColor: Color.lerp(a?.descColor, b?.descColor, t),
      descLineHeight: lerpDouble(a?.descLineHeight, b?.descLineHeight, t),
      priceColor: Color.lerp(a?.priceColor, b?.priceColor, t),
      originPriceColor: Color.lerp(a?.originPriceColor, b?.originPriceColor, t),
      numColor: Color.lerp(a?.numColor, b?.numColor, t),
      originPriceFontSize:
          lerpDouble(a?.originPriceFontSize, b?.originPriceFontSize, t),
      priceFontSize: lerpDouble(a?.priceFontSize, b?.priceFontSize, t),
      priceIntegerFontSize:
          lerpDouble(a?.priceIntegerFontSize, b?.priceIntegerFontSize, t),
      priceFontFamily: b?.priceFontFamily,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      padding,
      fontSize,
      textColor,
      backgroundColor,
      thumbSize,
      thumbBorderRadius,
      titleLineHeight,
      descColor,
      descLineHeight,
      priceColor,
      originPriceColor,
      numColor,
      originPriceFontSize,
      priceFontSize,
      priceIntegerFontSize,
      priceFontFamily,
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
    return other is FlanCardThemeData &&
        other.padding == padding &&
        other.fontSize == fontSize &&
        other.textColor == textColor &&
        other.backgroundColor == backgroundColor &&
        other.thumbSize == thumbSize &&
        other.thumbBorderRadius == thumbBorderRadius &&
        other.titleLineHeight == titleLineHeight &&
        other.descColor == descColor &&
        other.descLineHeight == descLineHeight &&
        other.priceColor == priceColor &&
        other.originPriceColor == originPriceColor &&
        other.numColor == numColor &&
        other.originPriceFontSize == originPriceFontSize &&
        other.priceFontSize == priceFontSize &&
        other.priceIntegerFontSize == priceIntegerFontSize &&
        other.priceFontFamily == priceFontFamily;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('thumbSize', thumbSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'thumbBorderRadius', thumbBorderRadius,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'titleLineHeight', titleLineHeight,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('descColor', descColor, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('descLineHeight', descLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('priceColor', priceColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'originPriceColor', originPriceColor,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('numColor', numColor, defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'originPriceFontSize', originPriceFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('priceFontSize', priceFontSize,
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
