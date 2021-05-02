import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanNoticeBarTheme extends InheritedTheme {
  const FlanNoticeBarTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanNoticeBarThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanNoticeBarTheme(
          key: key,
          data: FlanNoticeBarTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanNoticeBarThemeData data;

  static FlanNoticeBarThemeData of(BuildContext context) {
    final FlanNoticeBarTheme? noticeBarTheme =
        context.dependOnInheritedWidgetOfExactType<FlanNoticeBarTheme>();
    return noticeBarTheme?.data ?? FlanTheme.of(context).noticeBarTheme;
  }

  @override
  bool updateShouldNotify(FlanNoticeBarTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanNoticeBarTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanNoticeBarThemeData with Diagnosticable {
  factory FlanNoticeBarThemeData({
    double? height,
    EdgeInsets? padding,
    EdgeInsets? wrapablePadding,
    Color? textColor,
    double? fontSize,
    double? lineHeight,
    Color? backgroundColor,
    double? iconSize,
    double? iconMinWidth,
  }) {
    final double _fontSize = fontSize ?? FlanThemeVars.fontSizeMd.rpx;
    return FlanNoticeBarThemeData.raw(
      height: height ?? 40.0.rpx,
      padding: padding ??
          EdgeInsets.symmetric(
              vertical: 0, horizontal: FlanThemeVars.paddingMd.rpx),
      wrapablePadding: wrapablePadding ??
          EdgeInsets.symmetric(
              vertical: FlanThemeVars.paddingXs.rpx,
              horizontal: FlanThemeVars.paddingMd.rpx),
      textColor: textColor ?? FlanThemeVars.orangeDark,
      fontSize: _fontSize,
      lineHeight: lineHeight ?? (24.0.rpx / _fontSize),
      backgroundColor: backgroundColor ?? FlanThemeVars.orangeLight,
      iconSize: iconSize ?? 16.0.rpx,
      iconMinWidth: iconMinWidth ?? 24.0.rpx,
    );
  }

  const FlanNoticeBarThemeData.raw({
    required this.height,
    required this.padding,
    required this.wrapablePadding,
    required this.textColor,
    required this.fontSize,
    required this.lineHeight,
    required this.backgroundColor,
    required this.iconSize,
    required this.iconMinWidth,
  });

  final double height;
  final EdgeInsets padding;
  final EdgeInsets wrapablePadding;
  final Color textColor;
  final double fontSize;
  final double lineHeight;
  final Color backgroundColor;
  final double iconSize;
  final double iconMinWidth;

  FlanNoticeBarThemeData copyWith({
    double? height,
    EdgeInsets? padding,
    EdgeInsets? wrapablePadding,
    Color? textColor,
    double? fontSize,
    double? lineHeight,
    Color? backgroundColor,
    double? iconSize,
    double? iconMinWidth,
  }) {
    return FlanNoticeBarThemeData(
      height: height ?? this.height,
      padding: padding ?? this.padding,
      wrapablePadding: wrapablePadding ?? this.wrapablePadding,
      textColor: textColor ?? this.textColor,
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconSize: iconSize ?? this.iconSize,
      iconMinWidth: iconMinWidth ?? this.iconMinWidth,
    );
  }

  FlanNoticeBarThemeData merge(FlanNoticeBarThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      height: other.height,
      padding: other.padding,
      wrapablePadding: other.wrapablePadding,
      textColor: other.textColor,
      fontSize: other.fontSize,
      lineHeight: other.lineHeight,
      backgroundColor: other.backgroundColor,
      iconSize: other.iconSize,
      iconMinWidth: other.iconMinWidth,
    );
  }

  static FlanNoticeBarThemeData lerp(
      FlanNoticeBarThemeData? a, FlanNoticeBarThemeData? b, double t) {
    return FlanNoticeBarThemeData(
      height: lerpDouble(a?.height, b?.height, t),
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      wrapablePadding:
          EdgeInsets.lerp(a?.wrapablePadding, b?.wrapablePadding, t),
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t),
      lineHeight: lerpDouble(a?.lineHeight, b?.lineHeight, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      iconSize: lerpDouble(a?.iconSize, b?.iconSize, t),
      iconMinWidth: lerpDouble(a?.iconMinWidth, b?.iconMinWidth, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      height,
      padding,
      wrapablePadding,
      textColor,
      fontSize,
      lineHeight,
      backgroundColor,
      iconSize,
      iconMinWidth,
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
    return other is FlanNoticeBarThemeData &&
        other.height == height &&
        other.padding == padding &&
        other.wrapablePadding == wrapablePadding &&
        other.textColor == textColor &&
        other.fontSize == fontSize &&
        other.lineHeight == lineHeight &&
        other.backgroundColor == backgroundColor &&
        other.iconSize == iconSize &&
        other.iconMinWidth == iconMinWidth;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('height', height, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'wrapablePadding', wrapablePadding,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('lineHeight', lineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('iconSize', iconSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('iconMinWidth', iconMinWidth,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
