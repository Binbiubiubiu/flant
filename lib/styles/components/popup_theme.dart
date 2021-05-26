import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanPopupTheme extends InheritedTheme {
  const FlanPopupTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanPopupThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanPopupTheme(
          key: key,
          data: FlanPopupTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanPopupThemeData data;

  static FlanPopupThemeData of(BuildContext context) {
    final FlanPopupTheme? popupTheme =
        context.dependOnInheritedWidgetOfExactType<FlanPopupTheme>();
    return popupTheme?.data ?? FlanTheme.of(context).popupTheme;
  }

  @override
  bool updateShouldNotify(FlanPopupTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanPopupTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanPopupThemeData with Diagnosticable {
  factory FlanPopupThemeData({
    Color? backgroundColor,
    Duration? transitionDuration,
    double? roundBorderRadius,
    double? closeIconSize,
    Color? closeIconColor,
    Color? closeIconActiveColor,
    double? closeIconMargin,
  }) {
    return FlanPopupThemeData.raw(
      backgroundColor: backgroundColor ?? FlanThemeVars.white,
      transitionDuration:
          transitionDuration ?? FlanThemeVars.animationDurationBase,
      roundBorderRadius: roundBorderRadius ?? 16.0.rpx,
      closeIconSize: closeIconSize ?? 22.0.rpx,
      closeIconColor: closeIconColor ?? FlanThemeVars.gray5,
      closeIconActiveColor: closeIconActiveColor ?? FlanThemeVars.gray6,
      closeIconMargin: closeIconMargin ?? 16.0.rpx,
    );
  }

  const FlanPopupThemeData.raw({
    required this.backgroundColor,
    required this.transitionDuration,
    required this.roundBorderRadius,
    required this.closeIconSize,
    required this.closeIconColor,
    required this.closeIconActiveColor,
    required this.closeIconMargin,
  });

  final Color backgroundColor;
  final Duration transitionDuration;
  final double roundBorderRadius;
  final double closeIconSize;
  final Color closeIconColor;
  final Color closeIconActiveColor;
  final double closeIconMargin;

  FlanPopupThemeData copyWith({
    Color? backgroundColor,
    Duration? transitionDuration,
    double? roundBorderRadius,
    double? closeIconSize,
    Color? closeIconColor,
    Color? closeIconActiveColor,
    double? closeIconMargin,
  }) {
    return FlanPopupThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      roundBorderRadius: roundBorderRadius ?? this.roundBorderRadius,
      closeIconSize: closeIconSize ?? this.closeIconSize,
      closeIconColor: closeIconColor ?? this.closeIconColor,
      closeIconActiveColor: closeIconActiveColor ?? this.closeIconActiveColor,
      closeIconMargin: closeIconMargin ?? this.closeIconMargin,
    );
  }

  FlanPopupThemeData merge(FlanPopupThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      backgroundColor: other.backgroundColor,
      transitionDuration: other.transitionDuration,
      roundBorderRadius: other.roundBorderRadius,
      closeIconSize: other.closeIconSize,
      closeIconColor: other.closeIconColor,
      closeIconActiveColor: other.closeIconActiveColor,
      closeIconMargin: other.closeIconMargin,
    );
  }

  static FlanPopupThemeData lerp(
      FlanPopupThemeData? a, FlanPopupThemeData? b, double t) {
    return FlanPopupThemeData(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      transitionDuration: b
          ?.transitionDuration, // lerpDuration(a?.transitionDuration, b?.transitionDuration, t),
      roundBorderRadius:
          lerpDouble(a?.roundBorderRadius, b?.roundBorderRadius, t),
      closeIconSize: lerpDouble(a?.closeIconSize, b?.closeIconSize, t),
      closeIconColor: Color.lerp(a?.closeIconColor, b?.closeIconColor, t),
      closeIconActiveColor:
          Color.lerp(a?.closeIconActiveColor, b?.closeIconActiveColor, t),
      closeIconMargin: lerpDouble(a?.closeIconMargin, b?.closeIconMargin, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      backgroundColor,
      transitionDuration,
      roundBorderRadius,
      closeIconSize,
      closeIconColor,
      closeIconActiveColor,
      closeIconMargin,
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
    return other is FlanPopupThemeData &&
        other.backgroundColor == backgroundColor &&
        other.transitionDuration == transitionDuration &&
        other.roundBorderRadius == roundBorderRadius &&
        other.closeIconSize == closeIconSize &&
        other.closeIconColor == closeIconColor &&
        other.closeIconActiveColor == closeIconActiveColor &&
        other.closeIconMargin == closeIconMargin;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Duration>(
        'transitionDuration', transitionDuration,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'roundBorderRadius', roundBorderRadius,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('closeIconSize', closeIconSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('closeIconColor', closeIconColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'closeIconActiveColor', closeIconActiveColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'closeIconMargin', closeIconMargin,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
