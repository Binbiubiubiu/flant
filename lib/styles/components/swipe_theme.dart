// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanSwipeTheme extends InheritedTheme {
  const FlanSwipeTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanSwipeThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanSwipeTheme(
          key: key,
          data: FlanSwipeTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanSwipeThemeData data;

  static FlanSwipeThemeData of(BuildContext context) {
    final FlanSwipeTheme? swipeTheme =
        context.dependOnInheritedWidgetOfExactType<FlanSwipeTheme>();
    return swipeTheme?.data ?? FlanTheme.of(context).swipeTheme;
  }

  @override
  bool updateShouldNotify(FlanSwipeTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanSwipeTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanSwipeThemeData with Diagnosticable {
  factory FlanSwipeThemeData({
    double? indicatorSize,
    double? indicatorMargin,
    double? indicatorActiveOpacity,
    double? indicatorInactiveOpacity,
    Color? indicatorActiveBackgroundColor,
    Color? indicatorInactiveBackgroundColor,
  }) {
    return FlanSwipeThemeData.raw(
      indicatorSize: indicatorSize ?? 6.0.rpx,
      indicatorMargin: indicatorMargin ?? FlanThemeVars.paddingSm.rpx,
      indicatorActiveOpacity: indicatorActiveOpacity ?? 1.0,
      indicatorInactiveOpacity: indicatorInactiveOpacity ?? 0.3,
      indicatorActiveBackgroundColor:
          indicatorActiveBackgroundColor ?? FlanThemeVars.blue,
      indicatorInactiveBackgroundColor:
          indicatorInactiveBackgroundColor ?? FlanThemeVars.borderColor,
    );
  }

  const FlanSwipeThemeData.raw({
    required this.indicatorSize,
    required this.indicatorMargin,
    required this.indicatorActiveOpacity,
    required this.indicatorInactiveOpacity,
    required this.indicatorActiveBackgroundColor,
    required this.indicatorInactiveBackgroundColor,
  });

  final double indicatorSize;
  final double indicatorMargin;
  final double indicatorActiveOpacity;
  final double indicatorInactiveOpacity;
  final Color indicatorActiveBackgroundColor;
  final Color indicatorInactiveBackgroundColor;

  FlanSwipeThemeData copyWith({
    double? indicatorSize,
    double? indicatorMargin,
    double? indicatorActiveOpacity,
    double? indicatorInactiveOpacity,
    Color? indicatorActiveBackgroundColor,
    Color? indicatorInactiveBackgroundColor,
  }) {
    return FlanSwipeThemeData(
      indicatorSize: indicatorSize ?? this.indicatorSize,
      indicatorMargin: indicatorMargin ?? this.indicatorMargin,
      indicatorActiveOpacity:
          indicatorActiveOpacity ?? this.indicatorActiveOpacity,
      indicatorInactiveOpacity:
          indicatorInactiveOpacity ?? this.indicatorInactiveOpacity,
      indicatorActiveBackgroundColor:
          indicatorActiveBackgroundColor ?? this.indicatorActiveBackgroundColor,
      indicatorInactiveBackgroundColor: indicatorInactiveBackgroundColor ??
          this.indicatorInactiveBackgroundColor,
    );
  }

  FlanSwipeThemeData merge(FlanSwipeThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      indicatorSize: other.indicatorSize,
      indicatorMargin: other.indicatorMargin,
      indicatorActiveOpacity: other.indicatorActiveOpacity,
      indicatorInactiveOpacity: other.indicatorInactiveOpacity,
      indicatorActiveBackgroundColor: other.indicatorActiveBackgroundColor,
      indicatorInactiveBackgroundColor: other.indicatorInactiveBackgroundColor,
    );
  }

  static FlanSwipeThemeData lerp(
      FlanSwipeThemeData? a, FlanSwipeThemeData? b, double t) {
    return FlanSwipeThemeData(
      indicatorSize: lerpDouble(a?.indicatorSize, b?.indicatorSize, t),
      indicatorMargin: lerpDouble(a?.indicatorMargin, b?.indicatorMargin, t),
      indicatorActiveOpacity:
          lerpDouble(a?.indicatorActiveOpacity, b?.indicatorActiveOpacity, t),
      indicatorInactiveOpacity: lerpDouble(
          a?.indicatorInactiveOpacity, b?.indicatorInactiveOpacity, t),
      indicatorActiveBackgroundColor: Color.lerp(
          a?.indicatorActiveBackgroundColor,
          b?.indicatorActiveBackgroundColor,
          t),
      indicatorInactiveBackgroundColor: Color.lerp(
          a?.indicatorInactiveBackgroundColor,
          b?.indicatorInactiveBackgroundColor,
          t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      indicatorSize,
      indicatorMargin,
      indicatorActiveOpacity,
      indicatorInactiveOpacity,
      indicatorActiveBackgroundColor,
      indicatorInactiveBackgroundColor,
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
    return other is FlanSwipeThemeData &&
        other.indicatorSize == indicatorSize &&
        other.indicatorMargin == indicatorMargin &&
        other.indicatorActiveOpacity == indicatorActiveOpacity &&
        other.indicatorInactiveOpacity == indicatorInactiveOpacity &&
        other.indicatorActiveBackgroundColor ==
            indicatorActiveBackgroundColor &&
        other.indicatorInactiveBackgroundColor ==
            indicatorInactiveBackgroundColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<double>('indicatorSize', indicatorSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'indicatorMargin', indicatorMargin,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'indicatorActiveOpacity', indicatorActiveOpacity,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'indicatorInactiveOpacity', indicatorInactiveOpacity,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'indicatorActiveBackgroundColor', indicatorActiveBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'indicatorInactiveBackgroundColor', indicatorInactiveBackgroundColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
