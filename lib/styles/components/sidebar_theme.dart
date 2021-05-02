import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanSidebarTheme extends InheritedTheme {
  const FlanSidebarTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanSidebarThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanSidebarTheme(
          key: key,
          data: FlanSidebarTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanSidebarThemeData data;

  static FlanSidebarThemeData of(BuildContext context) {
    final FlanSidebarTheme? sidebarTheme =
        context.dependOnInheritedWidgetOfExactType<FlanSidebarTheme>();
    return sidebarTheme?.data ?? FlanTheme.of(context).sidebarTheme;
  }

  @override
  bool updateShouldNotify(FlanSidebarTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanSidebarTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanSidebarThemeData with Diagnosticable {
  factory FlanSidebarThemeData({
    double? width,
    double? fontSize,
    double? lineHeight,
    Color? textColor,
    Color? disabledTextColor,
    EdgeInsets? padding,
    Color? activeColor,
    Color? backgroundColor,
    FontWeight? selectedFontWeight,
    Color? selectedTextColor,
    double? selectedBorderWidth,
    double? selectedBorderHeight,
    Color? selectedBorderColor,
    Color? selectedBackgroundColor,
  }) {
    final double _fonSize = fontSize ?? FlanThemeVars.fontSizeMd.rpx;
    return FlanSidebarThemeData.raw(
      width: width ?? 80.0.rpx,
      fontSize: _fonSize,
      lineHeight: lineHeight ?? (FlanThemeVars.lineHeightMd.rpx / _fonSize),
      textColor: textColor ?? FlanThemeVars.textColor,
      disabledTextColor: disabledTextColor ?? FlanThemeVars.gray5,
      padding: padding ??
          EdgeInsets.symmetric(
              vertical: 20.0.rpx, horizontal: FlanThemeVars.paddingSm.rpx),
      activeColor: activeColor ?? FlanThemeVars.activeColor,
      backgroundColor: backgroundColor ?? FlanThemeVars.backgroundColor,
      selectedFontWeight: selectedFontWeight ?? FlanThemeVars.fontWeightBold,
      selectedTextColor: selectedTextColor ?? FlanThemeVars.textColor,
      selectedBorderWidth: selectedBorderWidth ?? 4.0.rpx,
      selectedBorderHeight: selectedBorderHeight ?? 16.0.rpx,
      selectedBorderColor: selectedBorderColor ?? FlanThemeVars.red,
      selectedBackgroundColor: selectedBackgroundColor ?? FlanThemeVars.white,
    );
  }

  const FlanSidebarThemeData.raw({
    required this.width,
    required this.fontSize,
    required this.lineHeight,
    required this.textColor,
    required this.disabledTextColor,
    required this.padding,
    required this.activeColor,
    required this.backgroundColor,
    required this.selectedFontWeight,
    required this.selectedTextColor,
    required this.selectedBorderWidth,
    required this.selectedBorderHeight,
    required this.selectedBorderColor,
    required this.selectedBackgroundColor,
  });

  final double width;
  final double fontSize;
  final double lineHeight;
  final Color textColor;
  final Color disabledTextColor;
  final EdgeInsets padding;
  final Color activeColor;
  final Color backgroundColor;
  final FontWeight selectedFontWeight;
  final Color selectedTextColor;
  final double selectedBorderWidth;
  final double selectedBorderHeight;
  final Color selectedBorderColor;
  final Color selectedBackgroundColor;

  FlanSidebarThemeData copyWith({
    double? width,
    double? fontSize,
    double? lineHeight,
    Color? textColor,
    Color? disabledTextColor,
    EdgeInsets? padding,
    Color? activeColor,
    Color? backgroundColor,
    FontWeight? selectedFontWeight,
    Color? selectedTextColor,
    double? selectedBorderWidth,
    double? selectedBorderHeight,
    Color? selectedBorderColor,
    Color? selectedBackgroundColor,
  }) {
    return FlanSidebarThemeData(
      width: width ?? this.width,
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      padding: padding ?? this.padding,
      activeColor: activeColor ?? this.activeColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedFontWeight: selectedFontWeight ?? this.selectedFontWeight,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      selectedBorderWidth: selectedBorderWidth ?? this.selectedBorderWidth,
      selectedBorderHeight: selectedBorderHeight ?? this.selectedBorderHeight,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
    );
  }

  FlanSidebarThemeData merge(FlanSidebarThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      width: other.width,
      fontSize: other.fontSize,
      lineHeight: other.lineHeight,
      textColor: other.textColor,
      disabledTextColor: other.disabledTextColor,
      padding: other.padding,
      activeColor: other.activeColor,
      backgroundColor: other.backgroundColor,
      selectedFontWeight: other.selectedFontWeight,
      selectedTextColor: other.selectedTextColor,
      selectedBorderWidth: other.selectedBorderWidth,
      selectedBorderHeight: other.selectedBorderHeight,
      selectedBorderColor: other.selectedBorderColor,
      selectedBackgroundColor: other.selectedBackgroundColor,
    );
  }

  static FlanSidebarThemeData lerp(
      FlanSidebarThemeData? a, FlanSidebarThemeData? b, double t) {
    return FlanSidebarThemeData(
      width: lerpDouble(a?.width, b?.width, t),
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t),
      lineHeight: lerpDouble(a?.lineHeight, b?.lineHeight, t),
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      disabledTextColor:
          Color.lerp(a?.disabledTextColor, b?.disabledTextColor, t),
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      activeColor: Color.lerp(a?.activeColor, b?.activeColor, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      selectedFontWeight:
          FontWeight.lerp(a?.selectedFontWeight, b?.selectedFontWeight, t),
      selectedTextColor:
          Color.lerp(a?.selectedTextColor, b?.selectedTextColor, t),
      selectedBorderWidth:
          lerpDouble(a?.selectedBorderWidth, b?.selectedBorderWidth, t),
      selectedBorderHeight:
          lerpDouble(a?.selectedBorderHeight, b?.selectedBorderHeight, t),
      selectedBorderColor:
          Color.lerp(a?.selectedBorderColor, b?.selectedBorderColor, t),
      selectedBackgroundColor:
          Color.lerp(a?.selectedBackgroundColor, b?.selectedBackgroundColor, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      width,
      fontSize,
      lineHeight,
      textColor,
      disabledTextColor,
      padding,
      activeColor,
      backgroundColor,
      selectedFontWeight,
      selectedTextColor,
      selectedBorderWidth,
      selectedBorderHeight,
      selectedBorderColor,
      selectedBackgroundColor,
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
    return other is FlanSidebarThemeData &&
        other.width == width &&
        other.fontSize == fontSize &&
        other.lineHeight == lineHeight &&
        other.textColor == textColor &&
        other.disabledTextColor == disabledTextColor &&
        other.padding == padding &&
        other.activeColor == activeColor &&
        other.backgroundColor == backgroundColor &&
        other.selectedFontWeight == selectedFontWeight &&
        other.selectedTextColor == selectedTextColor &&
        other.selectedBorderWidth == selectedBorderWidth &&
        other.selectedBorderHeight == selectedBorderHeight &&
        other.selectedBorderColor == selectedBorderColor &&
        other.selectedBackgroundColor == selectedBackgroundColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('width', width, defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('lineHeight', lineHeight,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'disabledTextColor', disabledTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('activeColor', activeColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<FontWeight>(
        'selectedFontWeight', selectedFontWeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'selectedTextColor', selectedTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'selectedBorderWidth', selectedBorderWidth,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'selectedBorderHeight', selectedBorderHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'selectedBorderColor', selectedBorderColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'selectedBackgroundColor', selectedBackgroundColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
