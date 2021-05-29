// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanPaginationTheme extends InheritedTheme {
  const FlanPaginationTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanPaginationThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanPaginationTheme(
          key: key,
          data: FlanPaginationTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanPaginationThemeData data;

  static FlanPaginationThemeData of(BuildContext context) {
    final FlanPaginationTheme? paginationTheme =
        context.dependOnInheritedWidgetOfExactType<FlanPaginationTheme>();
    return paginationTheme?.data ?? FlanTheme.of(context).paginationTheme;
  }

  @override
  bool updateShouldNotify(FlanPaginationTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanPaginationTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanPaginationThemeData with Diagnosticable {
  factory FlanPaginationThemeData({
    double? height,
    double? fontSize,
    double? itemWidth,
    Color? itemDefaultColor,
    Color? itemDisabledColor,
    Color? itemDisabledBackgroundColor,
    Color? backgroundColor,
    Color? descColor,
    double? disabledOpacity,
  }) {
    return FlanPaginationThemeData.raw(
      height: height ?? 40.0.rpx,
      fontSize: fontSize ?? FlanThemeVars.fontSizeMd.rpx,
      itemWidth: itemWidth ?? 36.0.rpx,
      itemDefaultColor: itemDefaultColor ?? FlanThemeVars.blue,
      itemDisabledColor: itemDisabledColor ?? FlanThemeVars.gray7,
      itemDisabledBackgroundColor:
          itemDisabledBackgroundColor ?? FlanThemeVars.backgroundColor,
      backgroundColor: backgroundColor ?? FlanThemeVars.white,
      descColor: descColor ?? FlanThemeVars.gray7,
      disabledOpacity: disabledOpacity ?? FlanThemeVars.disabledOpacity,
    );
  }

  const FlanPaginationThemeData.raw({
    required this.height,
    required this.fontSize,
    required this.itemWidth,
    required this.itemDefaultColor,
    required this.itemDisabledColor,
    required this.itemDisabledBackgroundColor,
    required this.backgroundColor,
    required this.descColor,
    required this.disabledOpacity,
  });

  final double height;
  final double fontSize;
  final double itemWidth;
  final Color itemDefaultColor;
  final Color itemDisabledColor;
  final Color itemDisabledBackgroundColor;
  final Color backgroundColor;
  final Color descColor;
  final double disabledOpacity;

  FlanPaginationThemeData copyWith({
    double? height,
    double? fontSize,
    double? itemWidth,
    Color? itemDefaultColor,
    Color? itemDisabledColor,
    Color? itemDisabledBackgroundColor,
    Color? backgroundColor,
    Color? descColor,
    double? disabledOpacity,
  }) {
    return FlanPaginationThemeData(
      height: height ?? this.height,
      fontSize: fontSize ?? this.fontSize,
      itemWidth: itemWidth ?? this.itemWidth,
      itemDefaultColor: itemDefaultColor ?? this.itemDefaultColor,
      itemDisabledColor: itemDisabledColor ?? this.itemDisabledColor,
      itemDisabledBackgroundColor:
          itemDisabledBackgroundColor ?? this.itemDisabledBackgroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      descColor: descColor ?? this.descColor,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
    );
  }

  FlanPaginationThemeData merge(FlanPaginationThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      height: other.height,
      fontSize: other.fontSize,
      itemWidth: other.itemWidth,
      itemDefaultColor: other.itemDefaultColor,
      itemDisabledColor: other.itemDisabledColor,
      itemDisabledBackgroundColor: other.itemDisabledBackgroundColor,
      backgroundColor: other.backgroundColor,
      descColor: other.descColor,
      disabledOpacity: other.disabledOpacity,
    );
  }

  static FlanPaginationThemeData lerp(
      FlanPaginationThemeData? a, FlanPaginationThemeData? b, double t) {
    return FlanPaginationThemeData(
      height: lerpDouble(a?.height, b?.height, t),
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t),
      itemWidth: lerpDouble(a?.itemWidth, b?.itemWidth, t),
      itemDefaultColor: Color.lerp(a?.itemDefaultColor, b?.itemDefaultColor, t),
      itemDisabledColor:
          Color.lerp(a?.itemDisabledColor, b?.itemDisabledColor, t),
      itemDisabledBackgroundColor: Color.lerp(
          a?.itemDisabledBackgroundColor, b?.itemDisabledBackgroundColor, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      descColor: Color.lerp(a?.descColor, b?.descColor, t),
      disabledOpacity: lerpDouble(a?.disabledOpacity, b?.disabledOpacity, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      height,
      fontSize,
      itemWidth,
      itemDefaultColor,
      itemDisabledColor,
      itemDisabledBackgroundColor,
      backgroundColor,
      descColor,
      disabledOpacity,
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
    return other is FlanPaginationThemeData &&
        other.height == height &&
        other.fontSize == fontSize &&
        other.itemWidth == itemWidth &&
        other.itemDefaultColor == itemDefaultColor &&
        other.itemDisabledColor == itemDisabledColor &&
        other.itemDisabledBackgroundColor == itemDisabledBackgroundColor &&
        other.backgroundColor == backgroundColor &&
        other.descColor == descColor &&
        other.disabledOpacity == disabledOpacity;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('height', height, defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('itemWidth', itemWidth,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'itemDefaultColor', itemDefaultColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'itemDisabledColor', itemDisabledColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'itemDisabledBackgroundColor', itemDisabledBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('descColor', descColor, defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'disabledOpacity', disabledOpacity,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
