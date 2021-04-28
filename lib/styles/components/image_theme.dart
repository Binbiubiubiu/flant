// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanImageTheme extends InheritedTheme {
  const FlanImageTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanImageThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanImageTheme(
          key: key,
          data: FlanImageTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanImageThemeData data;

  static FlanImageThemeData of(BuildContext context) {
    final FlanImageTheme? imageTheme =
        context.dependOnInheritedWidgetOfExactType<FlanImageTheme>();
    return imageTheme?.data ?? FlanTheme.of(context).imageTheme;
  }

  @override
  bool updateShouldNotify(FlanImageTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanImageTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanImageThemeData with Diagnosticable {
  factory FlanImageThemeData({
    Color? placeholderTextColor,
    double? placeholderFontSize,
    Color? placeholderBackgroundColor,
    double? loadingIconSize,
    Color? loadingIconColor,
    double? errorIconSize,
    Color? errorIconColor,
  }) {
    return FlanImageThemeData.raw(
      placeholderTextColor: placeholderTextColor ?? FlanThemeVars.gray6,
      placeholderFontSize: placeholderFontSize ?? FlanThemeVars.fontSizeMd.rpx,
      placeholderBackgroundColor:
          placeholderBackgroundColor ?? FlanThemeVars.backgroundColor,
      loadingIconSize: loadingIconSize ?? 32.0.rpx,
      loadingIconColor: loadingIconColor ?? FlanThemeVars.gray4,
      errorIconSize: errorIconSize ?? 32.0.rpx,
      errorIconColor: errorIconColor ?? FlanThemeVars.gray4,
    );
  }

  const FlanImageThemeData.raw({
    required this.placeholderTextColor,
    required this.placeholderFontSize,
    required this.placeholderBackgroundColor,
    required this.loadingIconSize,
    required this.loadingIconColor,
    required this.errorIconSize,
    required this.errorIconColor,
  });

  final Color placeholderTextColor;
  final double placeholderFontSize;
  final Color placeholderBackgroundColor;
  final double loadingIconSize;
  final Color loadingIconColor;
  final double errorIconSize;
  final Color errorIconColor;

  FlanImageThemeData copyWith({
    Color? placeholderTextColor,
    double? placeholderFontSize,
    Color? placeholderBackgroundColor,
    double? loadingIconSize,
    Color? loadingIconColor,
    double? errorIconSize,
    Color? errorIconColor,
  }) {
    return FlanImageThemeData(
      placeholderTextColor: placeholderTextColor ?? this.placeholderTextColor,
      placeholderFontSize: placeholderFontSize ?? this.placeholderFontSize,
      placeholderBackgroundColor:
          placeholderBackgroundColor ?? this.placeholderBackgroundColor,
      loadingIconSize: loadingIconSize ?? this.loadingIconSize,
      loadingIconColor: loadingIconColor ?? this.loadingIconColor,
      errorIconSize: errorIconSize ?? this.errorIconSize,
      errorIconColor: errorIconColor ?? this.errorIconColor,
    );
  }

  FlanImageThemeData merge(FlanImageThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      placeholderTextColor: other.placeholderTextColor,
      placeholderFontSize: other.placeholderFontSize,
      placeholderBackgroundColor: other.placeholderBackgroundColor,
      loadingIconSize: other.loadingIconSize,
      loadingIconColor: other.loadingIconColor,
      errorIconSize: other.errorIconSize,
      errorIconColor: other.errorIconColor,
    );
  }

  static FlanImageThemeData lerp(
      FlanImageThemeData? a, FlanImageThemeData? b, double t) {
    return FlanImageThemeData(
      placeholderTextColor:
          Color.lerp(a?.placeholderTextColor, b?.placeholderTextColor, t)!,
      placeholderFontSize:
          lerpDouble(a?.placeholderFontSize, b?.placeholderFontSize, t)!,
      placeholderBackgroundColor: Color.lerp(
          a?.placeholderBackgroundColor, b?.placeholderBackgroundColor, t)!,
      loadingIconSize: lerpDouble(a?.loadingIconSize, b?.loadingIconSize, t)!,
      loadingIconColor:
          Color.lerp(a?.loadingIconColor, b?.loadingIconColor, t)!,
      errorIconSize: lerpDouble(a?.errorIconSize, b?.errorIconSize, t)!,
      errorIconColor: Color.lerp(a?.errorIconColor, b?.errorIconColor, t)!,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      placeholderTextColor,
      placeholderFontSize,
      placeholderBackgroundColor,
      loadingIconSize,
      loadingIconColor,
      errorIconSize,
      errorIconColor,
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
    return other is FlanImageThemeData &&
        other.placeholderTextColor == placeholderTextColor &&
        other.placeholderFontSize == placeholderFontSize &&
        other.placeholderBackgroundColor == placeholderBackgroundColor &&
        other.loadingIconSize == loadingIconSize &&
        other.loadingIconColor == loadingIconColor &&
        other.errorIconSize == errorIconSize &&
        other.errorIconColor == errorIconColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Color>(
        'placeholderTextColor', placeholderTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'placeholderFontSize', placeholderFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'placeholderBackgroundColor', placeholderBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'loadingIconSize', loadingIconSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'loadingIconColor', loadingIconColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('errorIconSize', errorIconSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('errorIconColor', errorIconColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
