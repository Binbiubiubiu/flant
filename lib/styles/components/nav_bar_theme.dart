import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanNavBarTheme extends InheritedTheme {
  const FlanNavBarTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanNavBarThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanNavBarTheme(
          key: key,
          data: FlanNavBarTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanNavBarThemeData data;

  static FlanNavBarThemeData of(BuildContext context) {
    final FlanNavBarTheme? navBarTheme =
        context.dependOnInheritedWidgetOfExactType<FlanNavBarTheme>();
    return navBarTheme?.data ?? FlanTheme.of(context).navBarTheme;
  }

  @override
  bool updateShouldNotify(FlanNavBarTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanNavBarTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanNavBarThemeData with Diagnosticable {
  factory FlanNavBarThemeData({
    double? height,
    Color? backgroundColor,
    double? arrowSize,
    Color? iconColor,
    Color? textColor,
    double? titleFontSize,
    Color? titleTextColor,
  }) {
    return FlanNavBarThemeData.raw(
      height: height ?? 46.0.rpx,
      backgroundColor: backgroundColor ?? FlanThemeVars.white,
      arrowSize: arrowSize ?? 16.0.rpx,
      iconColor: iconColor ?? FlanThemeVars.blue,
      textColor: textColor ?? FlanThemeVars.blue,
      titleFontSize: titleFontSize ?? FlanThemeVars.fontSizeLg.rpx,
      titleTextColor: titleTextColor ?? FlanThemeVars.textColor,
    );
  }

  const FlanNavBarThemeData.raw({
    required this.height,
    required this.backgroundColor,
    required this.arrowSize,
    required this.iconColor,
    required this.textColor,
    required this.titleFontSize,
    required this.titleTextColor,
  });

  final double height;
  final Color backgroundColor;
  final double arrowSize;
  final Color iconColor;
  final Color textColor;
  final double titleFontSize;
  final Color titleTextColor;

  FlanNavBarThemeData copyWith({
    double? height,
    Color? backgroundColor,
    double? arrowSize,
    Color? iconColor,
    Color? textColor,
    double? titleFontSize,
    Color? titleTextColor,
  }) {
    return FlanNavBarThemeData(
      height: height ?? this.height,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      arrowSize: arrowSize ?? this.arrowSize,
      iconColor: iconColor ?? this.iconColor,
      textColor: textColor ?? this.textColor,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      titleTextColor: titleTextColor ?? this.titleTextColor,
    );
  }

  FlanNavBarThemeData merge(FlanNavBarThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      height: other.height,
      backgroundColor: other.backgroundColor,
      arrowSize: other.arrowSize,
      iconColor: other.iconColor,
      textColor: other.textColor,
      titleFontSize: other.titleFontSize,
      titleTextColor: other.titleTextColor,
    );
  }

  static FlanNavBarThemeData lerp(
      FlanNavBarThemeData? a, FlanNavBarThemeData? b, double t) {
    return FlanNavBarThemeData(
      height: lerpDouble(a?.height, b?.height, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      arrowSize: lerpDouble(a?.arrowSize, b?.arrowSize, t),
      iconColor: Color.lerp(a?.iconColor, b?.iconColor, t),
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      titleFontSize: lerpDouble(a?.titleFontSize, b?.titleFontSize, t),
      titleTextColor: Color.lerp(a?.titleTextColor, b?.titleTextColor, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      height,
      backgroundColor,
      arrowSize,
      iconColor,
      textColor,
      titleFontSize,
      titleTextColor,
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
    return other is FlanNavBarThemeData &&
        other.height == height &&
        other.backgroundColor == backgroundColor &&
        other.arrowSize == arrowSize &&
        other.iconColor == iconColor &&
        other.textColor == textColor &&
        other.titleFontSize == titleFontSize &&
        other.titleTextColor == titleTextColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('height', height, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('arrowSize', arrowSize,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('iconColor', iconColor, defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('titleFontSize', titleFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('titleTextColor', titleTextColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
