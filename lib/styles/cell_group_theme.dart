import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/widget.dart';
import 'theme.dart';
import 'var.dart';

class FlanCellGroupTheme extends InheritedTheme {
  const FlanCellGroupTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanCellGroupThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanCellGroupTheme(
          key: key,
          data: FlanCellGroupTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanCellGroupThemeData data;

  static FlanCellGroupThemeData of(BuildContext context) {
    final FlanCellGroupTheme? cellGroupTheme =
        context.dependOnInheritedWidgetOfExactType<FlanCellGroupTheme>();
    return cellGroupTheme?.data ?? FlanTheme.of(context).cellGroupTheme;
  }

  @override
  bool updateShouldNotify(FlanCellGroupTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanCellGroupTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanCellGroupThemeData with Diagnosticable {
  factory FlanCellGroupThemeData({
    Color? backgroundColor,
    Color? titleColor,
    EdgeInsets? titlePadding,
    double? titleFontSize,
    double? titleLineHeight,
  }) {
    return FlanCellGroupThemeData.raw(
      backgroundColor: backgroundColor ?? FlanThemeVars.white,
      titleColor: titleColor ?? FlanThemeVars.gray6,
      titlePadding: titlePadding ??
          EdgeInsets.only(
              top: FlanThemeVars.paddingMd,
              left: FlanThemeVars.paddingMd,
              right: FlanThemeVars.paddingMd,
              bottom: FlanThemeVars.paddingXs),
      titleFontSize: titleFontSize ?? FlanThemeVars.fontSizeMd.rpx,
      titleLineHeight: titleLineHeight ?? 16.0.rpx,
    );
  }

  const FlanCellGroupThemeData.raw({
    required this.backgroundColor,
    required this.titleColor,
    required this.titlePadding,
    required this.titleFontSize,
    required this.titleLineHeight,
  });

  final Color backgroundColor;
  final Color titleColor;
  final EdgeInsets titlePadding;
  final double titleFontSize;
  final double titleLineHeight;

  FlanCellGroupThemeData copyWith({
    Color? backgroundColor,
    Color? titleColor,
    EdgeInsets? titlePadding,
    double? titleFontSize,
    double? titleLineHeight,
  }) {
    return FlanCellGroupThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      titlePadding: titlePadding ?? this.titlePadding,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      titleLineHeight: titleLineHeight ?? this.titleLineHeight,
    );
  }

  FlanCellGroupThemeData merge(FlanCellGroupThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      backgroundColor: other.backgroundColor,
      titleColor: other.titleColor,
      titlePadding: other.titlePadding,
      titleFontSize: other.titleFontSize,
      titleLineHeight: other.titleLineHeight,
    );
  }

  static FlanCellGroupThemeData lerp(
      FlanCellGroupThemeData? a, FlanCellGroupThemeData? b, double t) {
    return FlanCellGroupThemeData(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t)!,
      titleColor: Color.lerp(a?.titleColor, b?.titleColor, t)!,
      titlePadding: EdgeInsets.lerp(a?.titlePadding, b?.titlePadding, t)!,
      titleFontSize: lerpDouble(a?.titleFontSize, b?.titleFontSize, t)!,
      titleLineHeight: lerpDouble(a?.titleLineHeight, b?.titleLineHeight, t)!,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      backgroundColor,
      titleColor,
      titlePadding,
      titleFontSize,
      titleLineHeight,
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
    return other is FlanCellGroupThemeData &&
        other.backgroundColor == backgroundColor &&
        other.titleColor == titleColor &&
        other.titlePadding == titlePadding &&
        other.titleFontSize == titleFontSize &&
        other.titleLineHeight == titleLineHeight;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('titleColor', titleColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('titlePadding', titlePadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('titleFontSize', titleFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'titleLineHeight', titleLineHeight,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
