import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanNotifyTheme extends InheritedTheme {
  const FlanNotifyTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanNotifyThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanNotifyTheme(
          key: key,
          data: FlanNotifyTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanNotifyThemeData data;

  static FlanNotifyThemeData of(BuildContext context) {
    final FlanNotifyTheme? notifyTheme =
        context.dependOnInheritedWidgetOfExactType<FlanNotifyTheme>();
    return notifyTheme?.data ?? FlanTheme.of(context).notifyTheme;
  }

  @override
  bool updateShouldNotify(FlanNotifyTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanNotifyTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanNotifyThemeData with Diagnosticable {
  factory FlanNotifyThemeData({
    Color? textColor,
    EdgeInsets? padding,
    double? fontSize,
    double? lineHeight,
    Color? primaryBackgroundColor,
    Color? successBackgroundColor,
    Color? dangerBackgroundColor,
    Color? warningBackgroundColor,
  }) {
    final double _fontSize = fontSize ?? FlanThemeVars.fontSizeMd.rpx;
    return FlanNotifyThemeData.raw(
      textColor: textColor ?? FlanThemeVars.white,
      padding: padding ??
          EdgeInsets.symmetric(
              vertical: FlanThemeVars.paddingXs.rpx,
              horizontal: FlanThemeVars.paddingMd.rpx),
      fontSize: fontSize ?? _fontSize,
      lineHeight: lineHeight ?? (FlanThemeVars.lineHeightMd.rpx / _fontSize),
      primaryBackgroundColor: primaryBackgroundColor ?? FlanThemeVars.blue,
      successBackgroundColor: successBackgroundColor ?? FlanThemeVars.green,
      dangerBackgroundColor: dangerBackgroundColor ?? FlanThemeVars.red,
      warningBackgroundColor: warningBackgroundColor ?? FlanThemeVars.orange,
    );
  }

  const FlanNotifyThemeData.raw({
    required this.textColor,
    required this.padding,
    required this.fontSize,
    required this.lineHeight,
    required this.primaryBackgroundColor,
    required this.successBackgroundColor,
    required this.dangerBackgroundColor,
    required this.warningBackgroundColor,
  });

  final Color textColor;
  final EdgeInsets padding;
  final double fontSize;
  final double lineHeight;
  final Color primaryBackgroundColor;
  final Color successBackgroundColor;
  final Color dangerBackgroundColor;
  final Color warningBackgroundColor;

  FlanNotifyThemeData copyWith({
    Color? textColor,
    EdgeInsets? padding,
    double? fontSize,
    double? lineHeight,
    Color? primaryBackgroundColor,
    Color? successBackgroundColor,
    Color? dangerBackgroundColor,
    Color? warningBackgroundColor,
  }) {
    return FlanNotifyThemeData(
      textColor: textColor ?? this.textColor,
      padding: padding ?? this.padding,
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      primaryBackgroundColor:
          primaryBackgroundColor ?? this.primaryBackgroundColor,
      successBackgroundColor:
          successBackgroundColor ?? this.successBackgroundColor,
      dangerBackgroundColor:
          dangerBackgroundColor ?? this.dangerBackgroundColor,
      warningBackgroundColor:
          warningBackgroundColor ?? this.warningBackgroundColor,
    );
  }

  FlanNotifyThemeData merge(FlanNotifyThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      textColor: other.textColor,
      padding: other.padding,
      fontSize: other.fontSize,
      lineHeight: other.lineHeight,
      primaryBackgroundColor: other.primaryBackgroundColor,
      successBackgroundColor: other.successBackgroundColor,
      dangerBackgroundColor: other.dangerBackgroundColor,
      warningBackgroundColor: other.warningBackgroundColor,
    );
  }

  static FlanNotifyThemeData lerp(
      FlanNotifyThemeData? a, FlanNotifyThemeData? b, double t) {
    return FlanNotifyThemeData(
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t),
      lineHeight: lerpDouble(a?.lineHeight, b?.lineHeight, t),
      primaryBackgroundColor:
          Color.lerp(a?.primaryBackgroundColor, b?.primaryBackgroundColor, t),
      successBackgroundColor:
          Color.lerp(a?.successBackgroundColor, b?.successBackgroundColor, t),
      dangerBackgroundColor:
          Color.lerp(a?.dangerBackgroundColor, b?.dangerBackgroundColor, t),
      warningBackgroundColor:
          Color.lerp(a?.warningBackgroundColor, b?.warningBackgroundColor, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      textColor,
      padding,
      fontSize,
      lineHeight,
      primaryBackgroundColor,
      successBackgroundColor,
      dangerBackgroundColor,
      warningBackgroundColor,
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
    return other is FlanNotifyThemeData &&
        other.textColor == textColor &&
        other.padding == padding &&
        other.fontSize == fontSize &&
        other.lineHeight == lineHeight &&
        other.primaryBackgroundColor == primaryBackgroundColor &&
        other.successBackgroundColor == successBackgroundColor &&
        other.dangerBackgroundColor == dangerBackgroundColor &&
        other.warningBackgroundColor == warningBackgroundColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('lineHeight', lineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'primaryBackgroundColor', primaryBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'successBackgroundColor', successBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'dangerBackgroundColor', dangerBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'warningBackgroundColor', warningBackgroundColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
