import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanDividerTheme extends InheritedTheme {
  const FlanDividerTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanDividerThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanDividerTheme(
          key: key,
          data: FlanDividerTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanDividerThemeData data;

  static FlanDividerThemeData of(BuildContext context) {
    final FlanDividerTheme? dividerTheme =
        context.dependOnInheritedWidgetOfExactType<FlanDividerTheme>();
    return dividerTheme?.data ?? FlanTheme.of(context).dividerTheme;
  }

  @override
  bool updateShouldNotify(FlanDividerTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanDividerTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanDividerThemeData with Diagnosticable {
  factory FlanDividerThemeData({
    EdgeInsets? margin,
    Color? textColor,
    double? fontSize,
    double? lineHeight,
    Color? borderColor,
    double? contentPadding,
    double? contentLeftWidthPercent,
    double? contentRightWidthPercent,
  }) {
    final double _fontSize = fontSize ?? FlanThemeVars.fontSizeMd.rpx;
    return FlanDividerThemeData.raw(
      margin: margin ??
          EdgeInsets.symmetric(
              vertical: FlanThemeVars.paddingMd.rpx, horizontal: 0),
      textColor: textColor ?? FlanThemeVars.gray6,
      fontSize: _fontSize,
      lineHeight: (lineHeight ?? 24.0.rpx) / _fontSize,
      borderColor: borderColor ?? FlanThemeVars.borderColor,
      contentPadding: contentPadding ?? FlanThemeVars.paddingMd.rpx,
      contentLeftWidthPercent: contentLeftWidthPercent ?? 0.1,
      contentRightWidthPercent: contentRightWidthPercent ?? 0.1,
    );
  }

  const FlanDividerThemeData.raw({
    required this.margin,
    required this.textColor,
    required this.fontSize,
    required this.lineHeight,
    required this.borderColor,
    required this.contentPadding,
    required this.contentLeftWidthPercent,
    required this.contentRightWidthPercent,
  });

  final EdgeInsets margin;
  final Color textColor;
  final double fontSize;
  final double lineHeight;
  final Color borderColor;
  final double contentPadding;
  final double contentLeftWidthPercent;
  final double contentRightWidthPercent;

  FlanDividerThemeData copyWith({
    EdgeInsets? margin,
    Color? textColor,
    double? fontSize,
    double? lineHeight,
    Color? borderColor,
    double? contentPadding,
    double? contentLeftWidthPercent,
    double? contentRightWidthPercent,
  }) {
    return FlanDividerThemeData(
      margin: margin ?? this.margin,
      textColor: textColor ?? this.textColor,
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      borderColor: borderColor ?? this.borderColor,
      contentPadding: contentPadding ?? this.contentPadding,
      contentLeftWidthPercent:
          contentLeftWidthPercent ?? this.contentLeftWidthPercent,
      contentRightWidthPercent:
          contentRightWidthPercent ?? this.contentRightWidthPercent,
    );
  }

  FlanDividerThemeData merge(FlanDividerThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      margin: other.margin,
      textColor: other.textColor,
      fontSize: other.fontSize,
      lineHeight: other.lineHeight,
      borderColor: other.borderColor,
      contentPadding: other.contentPadding,
      contentLeftWidthPercent: other.contentLeftWidthPercent,
      contentRightWidthPercent: other.contentRightWidthPercent,
    );
  }

  static FlanDividerThemeData lerp(
      FlanDividerThemeData? a, FlanDividerThemeData? b, double t) {
    return FlanDividerThemeData(
      margin: EdgeInsets.lerp(a?.margin, b?.margin, t)!,
      textColor: Color.lerp(a?.textColor, b?.textColor, t)!,
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t)!,
      lineHeight: lerpDouble(a?.lineHeight, b?.lineHeight, t)!,
      borderColor: Color.lerp(a?.borderColor, b?.borderColor, t)!,
      contentPadding: lerpDouble(a?.contentPadding, b?.contentPadding, t)!,
      contentLeftWidthPercent: lerpDouble(
          a?.contentLeftWidthPercent, b?.contentLeftWidthPercent, t)!,
      contentRightWidthPercent: lerpDouble(
          a?.contentRightWidthPercent, b?.contentRightWidthPercent, t)!,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      margin,
      textColor,
      fontSize,
      lineHeight,
      borderColor,
      contentPadding,
      contentLeftWidthPercent,
      contentRightWidthPercent,
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
    return other is FlanDividerThemeData &&
        other.margin == margin &&
        other.textColor == textColor &&
        other.fontSize == fontSize &&
        other.lineHeight == lineHeight &&
        other.borderColor == borderColor &&
        other.contentPadding == contentPadding &&
        other.contentLeftWidthPercent == contentLeftWidthPercent &&
        other.contentRightWidthPercent == contentRightWidthPercent;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<EdgeInsets>('margin', margin, defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('lineHeight', lineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('borderColor', borderColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('contentPadding', contentPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'contentLeftWidthPercent', contentLeftWidthPercent,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'contentRightWidthPercent', contentRightWidthPercent,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
