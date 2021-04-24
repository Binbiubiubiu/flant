import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/widget.dart';
import 'theme.dart';
import 'var.dart';

class FlanTagTheme extends InheritedTheme {
  const FlanTagTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanTagThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanTagTheme(
          key: key,
          data: FlanTagTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanTagThemeData data;

  static FlanTagThemeData of(BuildContext context) {
    final FlanTagTheme? tagTheme =
        context.dependOnInheritedWidgetOfExactType<FlanTagTheme>();
    return tagTheme?.data ?? FlanTheme.of(context).tagTheme;
  }

  @override
  bool updateShouldNotify(FlanTagTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanTagTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanTagThemeData with Diagnosticable {
  factory FlanTagThemeData({
    EdgeInsets? padding,
    Color? textColor,
    double? fontSize,
    double? borderRadius,
    double? lineHeight,
    EdgeInsets? mediumPadding,
    EdgeInsets? largePadding,
    double? largeBorderRadius,
    double? largeFontSize,
    double? roundBorderRadius,
    Color? dangerColor,
    Color? primaryColor,
    Color? successColor,
    Color? warningColor,
    Color? defaultColor,
    Color? plainBackgroundColor,
  }) {
    return FlanTagThemeData.raw(
      padding: padding ??
          EdgeInsets.symmetric(
              vertical: 0, horizontal: FlanThemeVars.paddingBase.rpx),
      textColor: textColor ?? FlanThemeVars.white,
      fontSize: fontSize ?? FlanThemeVars.fontSizeSm.rpx,
      borderRadius: borderRadius ?? 2.0.rpx,
      lineHeight: lineHeight ?? 16.0.rpx,
      mediumPadding: mediumPadding ??
          EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0.rpx),
      largePadding: largePadding ??
          EdgeInsets.symmetric(
              vertical: FlanThemeVars.paddingBase.rpx,
              horizontal: FlanThemeVars.paddingXs.rpx),
      largeBorderRadius: largeBorderRadius ?? FlanThemeVars.borderRadiusMd.rpx,
      largeFontSize: largeFontSize ?? FlanThemeVars.fontSizeMd.rpx,
      roundBorderRadius: roundBorderRadius ?? FlanThemeVars.borderRadiusMax.rpx,
      dangerColor: dangerColor ?? FlanThemeVars.red,
      primaryColor: primaryColor ?? FlanThemeVars.blue,
      successColor: successColor ?? FlanThemeVars.green,
      warningColor: warningColor ?? FlanThemeVars.orange,
      defaultColor: defaultColor ?? FlanThemeVars.gray6,
      plainBackgroundColor: plainBackgroundColor ?? FlanThemeVars.white,
    );
  }

  const FlanTagThemeData.raw({
    required this.padding,
    required this.textColor,
    required this.fontSize,
    required this.borderRadius,
    required this.lineHeight,
    required this.mediumPadding,
    required this.largePadding,
    required this.largeBorderRadius,
    required this.largeFontSize,
    required this.roundBorderRadius,
    required this.dangerColor,
    required this.primaryColor,
    required this.successColor,
    required this.warningColor,
    required this.defaultColor,
    required this.plainBackgroundColor,
  });

  final EdgeInsets padding;
  final Color textColor;
  final double fontSize;
  final double borderRadius;
  final double lineHeight;
  final EdgeInsets mediumPadding;
  final EdgeInsets largePadding;
  final double largeBorderRadius;
  final double largeFontSize;
  final double roundBorderRadius;
  final Color dangerColor;
  final Color primaryColor;
  final Color successColor;
  final Color warningColor;
  final Color defaultColor;
  final Color plainBackgroundColor;

  FlanTagThemeData copyWith({
    EdgeInsets? padding,
    Color? textColor,
    double? fontSize,
    double? borderRadius,
    double? lineHeight,
    EdgeInsets? mediumPadding,
    EdgeInsets? largePadding,
    double? largeBorderRadius,
    double? largeFontSize,
    double? roundBorderRadius,
    Color? dangerColor,
    Color? primaryColor,
    Color? successColor,
    Color? warningColor,
    Color? defaultColor,
    Color? plainBackgroundColor,
  }) {
    return FlanTagThemeData(
      padding: padding ?? this.padding,
      textColor: textColor ?? this.textColor,
      fontSize: fontSize ?? this.fontSize,
      borderRadius: borderRadius ?? this.borderRadius,
      lineHeight: lineHeight ?? this.lineHeight,
      mediumPadding: mediumPadding ?? this.mediumPadding,
      largePadding: largePadding ?? this.largePadding,
      largeBorderRadius: largeBorderRadius ?? this.largeBorderRadius,
      largeFontSize: largeFontSize ?? this.largeFontSize,
      roundBorderRadius: roundBorderRadius ?? this.roundBorderRadius,
      dangerColor: dangerColor ?? this.dangerColor,
      primaryColor: primaryColor ?? this.primaryColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      defaultColor: defaultColor ?? this.defaultColor,
      plainBackgroundColor: plainBackgroundColor ?? this.plainBackgroundColor,
    );
  }

  FlanTagThemeData merge(FlanTagThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      padding: other.padding,
      textColor: other.textColor,
      fontSize: other.fontSize,
      borderRadius: other.borderRadius,
      lineHeight: other.lineHeight,
      mediumPadding: other.mediumPadding,
      largePadding: other.largePadding,
      largeBorderRadius: other.largeBorderRadius,
      largeFontSize: other.largeFontSize,
      roundBorderRadius: other.roundBorderRadius,
      dangerColor: other.dangerColor,
      primaryColor: other.primaryColor,
      successColor: other.successColor,
      warningColor: other.warningColor,
      defaultColor: other.defaultColor,
      plainBackgroundColor: other.plainBackgroundColor,
    );
  }

  static FlanTagThemeData lerp(
      FlanTagThemeData? a, FlanTagThemeData? b, double t) {
    return FlanTagThemeData(
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t)!,
      textColor: Color.lerp(a?.textColor, b?.textColor, t)!,
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t)!,
      borderRadius: lerpDouble(a?.borderRadius, b?.borderRadius, t)!,
      lineHeight: lerpDouble(a?.lineHeight, b?.lineHeight, t)!,
      mediumPadding: EdgeInsets.lerp(a?.mediumPadding, b?.mediumPadding, t)!,
      largePadding: EdgeInsets.lerp(a?.largePadding, b?.largePadding, t)!,
      largeBorderRadius:
          lerpDouble(a?.largeBorderRadius, b?.largeBorderRadius, t)!,
      largeFontSize: lerpDouble(a?.largeFontSize, b?.largeFontSize, t)!,
      roundBorderRadius:
          lerpDouble(a?.roundBorderRadius, b?.roundBorderRadius, t)!,
      dangerColor: Color.lerp(a?.dangerColor, b?.dangerColor, t)!,
      primaryColor: Color.lerp(a?.primaryColor, b?.primaryColor, t)!,
      successColor: Color.lerp(a?.successColor, b?.successColor, t)!,
      warningColor: Color.lerp(a?.warningColor, b?.warningColor, t)!,
      defaultColor: Color.lerp(a?.defaultColor, b?.defaultColor, t)!,
      plainBackgroundColor:
          Color.lerp(a?.plainBackgroundColor, b?.plainBackgroundColor, t)!,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      padding,
      textColor,
      fontSize,
      borderRadius,
      lineHeight,
      mediumPadding,
      largePadding,
      largeBorderRadius,
      largeFontSize,
      roundBorderRadius,
      dangerColor,
      primaryColor,
      successColor,
      warningColor,
      defaultColor,
      plainBackgroundColor,
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
    return other is FlanTagThemeData &&
        other.padding == padding &&
        other.textColor == textColor &&
        other.fontSize == fontSize &&
        other.borderRadius == borderRadius &&
        other.lineHeight == lineHeight &&
        other.mediumPadding == mediumPadding &&
        other.largePadding == largePadding &&
        other.largeBorderRadius == largeBorderRadius &&
        other.largeFontSize == largeFontSize &&
        other.roundBorderRadius == roundBorderRadius &&
        other.dangerColor == dangerColor &&
        other.primaryColor == primaryColor &&
        other.successColor == successColor &&
        other.warningColor == warningColor &&
        other.defaultColor == defaultColor &&
        other.plainBackgroundColor == plainBackgroundColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('borderRadius', borderRadius,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('lineHeight', lineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'mediumPadding', mediumPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('largePadding', largePadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'largeBorderRadius', largeBorderRadius,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('largeFontSize', largeFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'roundBorderRadius', roundBorderRadius,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('dangerColor', dangerColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('primaryColor', primaryColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('successColor', successColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('warningColor', warningColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('defaultColor', defaultColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'plainBackgroundColor', plainBackgroundColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
