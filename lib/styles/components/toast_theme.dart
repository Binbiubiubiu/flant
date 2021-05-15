import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanToastTheme extends InheritedTheme {
  const FlanToastTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanToastThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanToastTheme(
          key: key,
          data: FlanToastTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanToastThemeData data;

  static FlanToastThemeData of(BuildContext context) {
    final FlanToastTheme? toastTheme =
        context.dependOnInheritedWidgetOfExactType<FlanToastTheme>();
    return toastTheme?.data ?? FlanTheme.of(context).toastTheme;
  }

  @override
  bool updateShouldNotify(FlanToastTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanToastTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanToastThemeData with Diagnosticable {
  factory FlanToastThemeData({
    double? maxWidth,
    double? fontSize,
    Color? textColor,
    Color? loadingIconColor,
    double? lineHeight,
    double? borderRadius,
    Color? backgroundColor,
    double? iconSize,
    double? textMinWidth,
    EdgeInsets? textPadding,
    EdgeInsets? defaultPadding,
    double? defaultWidth,
    double? defaultMinHeight,
    double? positionTopDistance,
    double? positionBottomDistance,
  }) {
    final double _fontSize = fontSize ?? FlanThemeVars.fontSizeMd.rpx;
    return FlanToastThemeData.raw(
      maxWidth: maxWidth ?? .7,
      fontSize: _fontSize,
      textColor: textColor ?? FlanThemeVars.white,
      loadingIconColor: loadingIconColor ?? FlanThemeVars.white,
      lineHeight: lineHeight ?? (FlanThemeVars.lineHeightMd.rpx / _fontSize),
      borderRadius: borderRadius ?? FlanThemeVars.borderRadiusLg.rpx,
      backgroundColor: backgroundColor ?? FlanThemeVars.black.withOpacity(.7),
      iconSize: iconSize ?? 36.0.rpx,
      textMinWidth: textMinWidth ?? 96.0.rpx,
      textPadding: textPadding ??
          EdgeInsets.symmetric(
              vertical: FlanThemeVars.paddingXs.rpx,
              horizontal: FlanThemeVars.paddingSm.rpx),
      defaultPadding:
          defaultPadding ?? EdgeInsets.all(FlanThemeVars.paddingMd.rpx),
      defaultWidth: defaultWidth ?? 88.0.rpx,
      defaultMinHeight: defaultMinHeight ?? 88.0.rpx,
      positionTopDistance: positionTopDistance ?? .2,
      positionBottomDistance: positionBottomDistance ?? .2,
    );
  }

  const FlanToastThemeData.raw({
    required this.maxWidth,
    required this.fontSize,
    required this.textColor,
    required this.loadingIconColor,
    required this.lineHeight,
    required this.borderRadius,
    required this.backgroundColor,
    required this.iconSize,
    required this.textMinWidth,
    required this.textPadding,
    required this.defaultPadding,
    required this.defaultWidth,
    required this.defaultMinHeight,
    required this.positionTopDistance,
    required this.positionBottomDistance,
  });

  final double maxWidth;
  final double fontSize;
  final Color textColor;
  final Color loadingIconColor;
  final double lineHeight;
  final double borderRadius;
  final Color backgroundColor;
  final double iconSize;
  final double textMinWidth;
  final EdgeInsets textPadding;
  final EdgeInsets defaultPadding;
  final double defaultWidth;
  final double defaultMinHeight;
  final double positionTopDistance;
  final double positionBottomDistance;

  FlanToastThemeData copyWith({
    double? maxWidth,
    double? fontSize,
    Color? textColor,
    Color? loadingIconColor,
    double? lineHeight,
    double? borderRadius,
    Color? backgroundColor,
    double? iconSize,
    double? textMinWidth,
    EdgeInsets? textPadding,
    EdgeInsets? defaultPadding,
    double? defaultWidth,
    double? defaultMinHeight,
    double? positionTopDistance,
    double? positionBottomDistance,
  }) {
    return FlanToastThemeData(
      maxWidth: maxWidth ?? this.maxWidth,
      fontSize: fontSize ?? this.fontSize,
      textColor: textColor ?? this.textColor,
      loadingIconColor: loadingIconColor ?? this.loadingIconColor,
      lineHeight: lineHeight ?? this.lineHeight,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconSize: iconSize ?? this.iconSize,
      textMinWidth: textMinWidth ?? this.textMinWidth,
      textPadding: textPadding ?? this.textPadding,
      defaultPadding: defaultPadding ?? this.defaultPadding,
      defaultWidth: defaultWidth ?? this.defaultWidth,
      defaultMinHeight: defaultMinHeight ?? this.defaultMinHeight,
      positionTopDistance: positionTopDistance ?? this.positionTopDistance,
      positionBottomDistance:
          positionBottomDistance ?? this.positionBottomDistance,
    );
  }

  FlanToastThemeData merge(FlanToastThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      maxWidth: other.maxWidth,
      fontSize: other.fontSize,
      textColor: other.textColor,
      loadingIconColor: other.loadingIconColor,
      lineHeight: other.lineHeight,
      borderRadius: other.borderRadius,
      backgroundColor: other.backgroundColor,
      iconSize: other.iconSize,
      textMinWidth: other.textMinWidth,
      textPadding: other.textPadding,
      defaultPadding: other.defaultPadding,
      defaultWidth: other.defaultWidth,
      defaultMinHeight: other.defaultMinHeight,
      positionTopDistance: other.positionTopDistance,
      positionBottomDistance: other.positionBottomDistance,
    );
  }

  static FlanToastThemeData lerp(
      FlanToastThemeData? a, FlanToastThemeData? b, double t) {
    return FlanToastThemeData(
      maxWidth: lerpDouble(a?.maxWidth, b?.maxWidth, t),
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t),
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      loadingIconColor: Color.lerp(a?.loadingIconColor, b?.loadingIconColor, t),
      lineHeight: lerpDouble(a?.lineHeight, b?.lineHeight, t),
      borderRadius: lerpDouble(a?.borderRadius, b?.borderRadius, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      iconSize: lerpDouble(a?.iconSize, b?.iconSize, t),
      textMinWidth: lerpDouble(a?.textMinWidth, b?.textMinWidth, t),
      textPadding: EdgeInsets.lerp(a?.textPadding, b?.textPadding, t),
      defaultPadding: EdgeInsets.lerp(a?.defaultPadding, b?.defaultPadding, t),
      defaultWidth: lerpDouble(a?.defaultWidth, b?.defaultWidth, t),
      defaultMinHeight: lerpDouble(a?.defaultMinHeight, b?.defaultMinHeight, t),
      positionTopDistance:
          lerpDouble(a?.positionTopDistance, b?.positionTopDistance, t),
      positionBottomDistance:
          lerpDouble(a?.positionBottomDistance, b?.positionBottomDistance, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      maxWidth,
      fontSize,
      textColor,
      loadingIconColor,
      lineHeight,
      borderRadius,
      backgroundColor,
      iconSize,
      textMinWidth,
      textPadding,
      defaultPadding,
      defaultWidth,
      defaultMinHeight,
      positionTopDistance,
      positionBottomDistance,
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
    return other is FlanToastThemeData &&
        other.maxWidth == maxWidth &&
        other.fontSize == fontSize &&
        other.textColor == textColor &&
        other.loadingIconColor == loadingIconColor &&
        other.lineHeight == lineHeight &&
        other.borderRadius == borderRadius &&
        other.backgroundColor == backgroundColor &&
        other.iconSize == iconSize &&
        other.textMinWidth == textMinWidth &&
        other.textPadding == textPadding &&
        other.defaultPadding == defaultPadding &&
        other.defaultWidth == defaultWidth &&
        other.defaultMinHeight == defaultMinHeight &&
        other.positionTopDistance == positionTopDistance &&
        other.positionBottomDistance == positionBottomDistance;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<double>('maxWidth', maxWidth, defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'loadingIconColor', loadingIconColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('lineHeight', lineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('borderRadius', borderRadius,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('iconSize', iconSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('textMinWidth', textMinWidth,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('textPadding', textPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'defaultPadding', defaultPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('defaultWidth', defaultWidth,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'defaultMinHeight', defaultMinHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'positionTopDistance', positionTopDistance,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'positionBottomDistance', positionBottomDistance,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
