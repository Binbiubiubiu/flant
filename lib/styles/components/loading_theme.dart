import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanLoadingTheme extends InheritedTheme {
  const FlanLoadingTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanLoadingThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanLoadingTheme(
          key: key,
          data: FlanLoadingTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanLoadingThemeData data;

  static FlanLoadingThemeData of(BuildContext context) {
    final FlanLoadingTheme? loadingTheme =
        context.dependOnInheritedWidgetOfExactType<FlanLoadingTheme>();
    return loadingTheme?.data ?? FlanTheme.of(context).loadingTheme;
  }

  @override
  bool updateShouldNotify(FlanLoadingTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanLoadingTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanLoadingThemeData with Diagnosticable {
  factory FlanLoadingThemeData({
    Color? textColor,
    double? textFontSize,
    Color? spinnerColor,
    double? spinnerSize,
    Duration? spinnerAnimationDuration,
  }) {
    return FlanLoadingThemeData.raw(
      textColor: textColor ?? FlanThemeVars.gray6,
      textFontSize: textFontSize ?? FlanThemeVars.fontSizeMd.rpx,
      spinnerColor: spinnerColor ?? FlanThemeVars.gray5,
      spinnerSize: spinnerSize ?? 30.0.rpx,
      spinnerAnimationDuration:
          spinnerAnimationDuration ?? const Duration(milliseconds: 800),
    );
  }

  const FlanLoadingThemeData.raw({
    required this.textColor,
    required this.textFontSize,
    required this.spinnerColor,
    required this.spinnerSize,
    required this.spinnerAnimationDuration,
  });

  final Color textColor;
  final double textFontSize;
  final Color spinnerColor;
  final double spinnerSize;
  final Duration spinnerAnimationDuration;

  FlanLoadingThemeData copyWith({
    Color? textColor,
    double? textFontSize,
    Color? spinnerColor,
    double? spinnerSize,
    Duration? spinnerAnimationDuration,
  }) {
    return FlanLoadingThemeData(
      textColor: textColor ?? this.textColor,
      textFontSize: textFontSize ?? this.textFontSize,
      spinnerColor: spinnerColor ?? this.spinnerColor,
      spinnerSize: spinnerSize ?? this.spinnerSize,
      spinnerAnimationDuration:
          spinnerAnimationDuration ?? this.spinnerAnimationDuration,
    );
  }

  FlanLoadingThemeData merge(FlanLoadingThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      textColor: other.textColor,
      textFontSize: other.textFontSize,
      spinnerColor: other.spinnerColor,
      spinnerSize: other.spinnerSize,
      spinnerAnimationDuration: other.spinnerAnimationDuration,
    );
  }

  static FlanLoadingThemeData lerp(
      FlanLoadingThemeData? a, FlanLoadingThemeData? b, double t) {
    return FlanLoadingThemeData(
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      textFontSize: lerpDouble(a?.textFontSize, b?.textFontSize, t),
      spinnerColor: Color.lerp(a?.spinnerColor, b?.spinnerColor, t),
      spinnerSize: lerpDouble(a?.spinnerSize, b?.spinnerSize, t),
      // spinnerAnimationDuration: Duration.lerp(
      //     a?.spinnerAnimationDuration, b?.spinnerAnimationDuration, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      textColor,
      textFontSize,
      spinnerColor,
      spinnerSize,
      spinnerAnimationDuration,
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
    return other is FlanLoadingThemeData &&
        other.textColor == textColor &&
        other.textFontSize == textFontSize &&
        other.spinnerColor == spinnerColor &&
        other.spinnerSize == spinnerSize &&
        other.spinnerAnimationDuration == spinnerAnimationDuration;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('textFontSize', textFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('spinnerColor', spinnerColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('spinnerSize', spinnerSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Duration>(
        'spinnerAnimationDuration', spinnerAnimationDuration,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
