import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanActionSheetTheme extends InheritedTheme {
  const FlanActionSheetTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanActionSheetThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanActionSheetTheme(
          key: key,
          data: FlanActionSheetTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanActionSheetThemeData data;

  static FlanActionSheetThemeData of(BuildContext context) {
    final FlanActionSheetTheme? actionSheetTheme =
        context.dependOnInheritedWidgetOfExactType<FlanActionSheetTheme>();
    return actionSheetTheme?.data ?? FlanTheme.of(context).actionSheetTheme;
  }

  @override
  bool updateShouldNotify(FlanActionSheetTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanActionSheetTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanActionSheetThemeData with Diagnosticable {
  factory FlanActionSheetThemeData({
    double? maxHeightFactor,
    double? headerHeight,
    double? headerFontSize,
    Color? descriptionColor,
    double? descriptionFontSize,
    double? descriptionLineHeight,
    Color? itemBackground,
    double? itemFontSize,
    double? itemLineHeight,
    Color? itemTextColor,
    Color? itemDisabledTextColor,
    Color? subnameColor,
    double? subnameFontSize,
    double? subnameLineHeight,
    double? closeIconSize,
    Color? closeIconColor,
    Color? closeIconActiveColor,
    EdgeInsets? closeIconPadding,
    Color? cancelTextColor,
    double? cancelPaddingTop,
    Color? cancelPaddingColor,
    double? loadingIconSize,
  }) {
    final double _subnameFontSize =
        subnameFontSize ?? FlanThemeVars.fontSizeSm.rpx;
    final double _itemFontSize = itemFontSize ?? FlanThemeVars.fontSizeLg.rpx;
    final double _headerFontSize =
        headerFontSize ?? FlanThemeVars.fontSizeLg.rpx;
    final double _descriptionFontSize =
        descriptionFontSize ?? FlanThemeVars.fontSizeMd.rpx;
    return FlanActionSheetThemeData.raw(
      maxHeightFactor: maxHeightFactor ?? .8,
      headerHeight: headerHeight ?? (48.0.rpx / _headerFontSize),
      headerFontSize: _headerFontSize,
      descriptionColor: descriptionColor ?? FlanThemeVars.gray6,
      descriptionFontSize: _descriptionFontSize,
      descriptionLineHeight: descriptionLineHeight ??
          (FlanThemeVars.lineHeightMd.rpx / _descriptionFontSize),
      itemBackground: itemBackground ?? FlanThemeVars.white,
      itemFontSize: _itemFontSize,
      itemLineHeight:
          itemLineHeight ?? (FlanThemeVars.lineHeightLg.rpx / _itemFontSize),
      itemTextColor: itemTextColor ?? FlanThemeVars.textColor,
      itemDisabledTextColor: itemDisabledTextColor ?? FlanThemeVars.gray5,
      subnameColor: subnameColor ?? FlanThemeVars.gray6,
      subnameFontSize: _subnameFontSize,
      subnameLineHeight: subnameLineHeight ??
          (FlanThemeVars.lineHeightSm.rpx / _subnameFontSize),
      closeIconSize: closeIconSize ?? 22.0.rpx,
      closeIconColor: closeIconColor ?? FlanThemeVars.gray5,
      closeIconActiveColor: closeIconActiveColor ?? FlanThemeVars.gray6,
      closeIconPadding: closeIconPadding ??
          EdgeInsets.symmetric(
              vertical: 0.0, horizontal: FlanThemeVars.paddingMd.rpx),
      cancelTextColor: cancelTextColor ?? FlanThemeVars.gray7,
      cancelPaddingTop: cancelPaddingTop ?? FlanThemeVars.paddingXs.rpx,
      cancelPaddingColor: cancelPaddingColor ?? FlanThemeVars.backgroundColor,
      loadingIconSize: loadingIconSize ?? 22.0.rpx,
    );
  }

  const FlanActionSheetThemeData.raw({
    required this.maxHeightFactor,
    required this.headerHeight,
    required this.headerFontSize,
    required this.descriptionColor,
    required this.descriptionFontSize,
    required this.descriptionLineHeight,
    required this.itemBackground,
    required this.itemFontSize,
    required this.itemLineHeight,
    required this.itemTextColor,
    required this.itemDisabledTextColor,
    required this.subnameColor,
    required this.subnameFontSize,
    required this.subnameLineHeight,
    required this.closeIconSize,
    required this.closeIconColor,
    required this.closeIconActiveColor,
    required this.closeIconPadding,
    required this.cancelTextColor,
    required this.cancelPaddingTop,
    required this.cancelPaddingColor,
    required this.loadingIconSize,
  });

  final double maxHeightFactor;
  final double headerHeight;
  final double headerFontSize;
  final Color descriptionColor;
  final double descriptionFontSize;
  final double descriptionLineHeight;
  final Color itemBackground;
  final double itemFontSize;
  final double itemLineHeight;
  final Color itemTextColor;
  final Color itemDisabledTextColor;
  final Color subnameColor;
  final double subnameFontSize;
  final double subnameLineHeight;
  final double closeIconSize;
  final Color closeIconColor;
  final Color closeIconActiveColor;
  final EdgeInsets closeIconPadding;
  final Color cancelTextColor;
  final double cancelPaddingTop;
  final Color cancelPaddingColor;
  final double loadingIconSize;

  FlanActionSheetThemeData copyWith({
    double? maxHeightFactor,
    double? headerHeight,
    double? headerFontSize,
    Color? descriptionColor,
    double? descriptionFontSize,
    double? descriptionLineHeight,
    Color? itemBackground,
    double? itemFontSize,
    double? itemLineHeight,
    Color? itemTextColor,
    Color? itemDisabledTextColor,
    Color? subnameColor,
    double? subnameFontSize,
    double? subnameLineHeight,
    double? closeIconSize,
    Color? closeIconColor,
    Color? closeIconActiveColor,
    EdgeInsets? closeIconPadding,
    Color? cancelTextColor,
    double? cancelPaddingTop,
    Color? cancelPaddingColor,
    double? loadingIconSize,
  }) {
    return FlanActionSheetThemeData(
      maxHeightFactor: maxHeightFactor ?? this.maxHeightFactor,
      headerHeight: headerHeight ?? this.headerHeight,
      headerFontSize: headerFontSize ?? this.headerFontSize,
      descriptionColor: descriptionColor ?? this.descriptionColor,
      descriptionFontSize: descriptionFontSize ?? this.descriptionFontSize,
      descriptionLineHeight:
          descriptionLineHeight ?? this.descriptionLineHeight,
      itemBackground: itemBackground ?? this.itemBackground,
      itemFontSize: itemFontSize ?? this.itemFontSize,
      itemLineHeight: itemLineHeight ?? this.itemLineHeight,
      itemTextColor: itemTextColor ?? this.itemTextColor,
      itemDisabledTextColor:
          itemDisabledTextColor ?? this.itemDisabledTextColor,
      subnameColor: subnameColor ?? this.subnameColor,
      subnameFontSize: subnameFontSize ?? this.subnameFontSize,
      subnameLineHeight: subnameLineHeight ?? this.subnameLineHeight,
      closeIconSize: closeIconSize ?? this.closeIconSize,
      closeIconColor: closeIconColor ?? this.closeIconColor,
      closeIconActiveColor: closeIconActiveColor ?? this.closeIconActiveColor,
      closeIconPadding: closeIconPadding ?? this.closeIconPadding,
      cancelTextColor: cancelTextColor ?? this.cancelTextColor,
      cancelPaddingTop: cancelPaddingTop ?? this.cancelPaddingTop,
      cancelPaddingColor: cancelPaddingColor ?? this.cancelPaddingColor,
      loadingIconSize: loadingIconSize ?? this.loadingIconSize,
    );
  }

  FlanActionSheetThemeData merge(FlanActionSheetThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      maxHeightFactor: other.maxHeightFactor,
      headerHeight: other.headerHeight,
      headerFontSize: other.headerFontSize,
      descriptionColor: other.descriptionColor,
      descriptionFontSize: other.descriptionFontSize,
      descriptionLineHeight: other.descriptionLineHeight,
      itemBackground: other.itemBackground,
      itemFontSize: other.itemFontSize,
      itemLineHeight: other.itemLineHeight,
      itemTextColor: other.itemTextColor,
      itemDisabledTextColor: other.itemDisabledTextColor,
      subnameColor: other.subnameColor,
      subnameFontSize: other.subnameFontSize,
      subnameLineHeight: other.subnameLineHeight,
      closeIconSize: other.closeIconSize,
      closeIconColor: other.closeIconColor,
      closeIconActiveColor: other.closeIconActiveColor,
      closeIconPadding: other.closeIconPadding,
      cancelTextColor: other.cancelTextColor,
      cancelPaddingTop: other.cancelPaddingTop,
      cancelPaddingColor: other.cancelPaddingColor,
      loadingIconSize: other.loadingIconSize,
    );
  }

  static FlanActionSheetThemeData lerp(
      FlanActionSheetThemeData? a, FlanActionSheetThemeData? b, double t) {
    return FlanActionSheetThemeData(
      maxHeightFactor: lerpDouble(a?.maxHeightFactor, b?.maxHeightFactor, t),
      headerHeight: lerpDouble(a?.headerHeight, b?.headerHeight, t),
      headerFontSize: lerpDouble(a?.headerFontSize, b?.headerFontSize, t),
      descriptionColor: Color.lerp(a?.descriptionColor, b?.descriptionColor, t),
      descriptionFontSize:
          lerpDouble(a?.descriptionFontSize, b?.descriptionFontSize, t),
      descriptionLineHeight:
          lerpDouble(a?.descriptionLineHeight, b?.descriptionLineHeight, t),
      itemBackground: Color.lerp(a?.itemBackground, b?.itemBackground, t),
      itemFontSize: lerpDouble(a?.itemFontSize, b?.itemFontSize, t),
      itemLineHeight: lerpDouble(a?.itemLineHeight, b?.itemLineHeight, t),
      itemTextColor: Color.lerp(a?.itemTextColor, b?.itemTextColor, t),
      itemDisabledTextColor:
          Color.lerp(a?.itemDisabledTextColor, b?.itemDisabledTextColor, t),
      subnameColor: Color.lerp(a?.subnameColor, b?.subnameColor, t),
      subnameFontSize: lerpDouble(a?.subnameFontSize, b?.subnameFontSize, t),
      subnameLineHeight:
          lerpDouble(a?.subnameLineHeight, b?.subnameLineHeight, t),
      closeIconSize: lerpDouble(a?.closeIconSize, b?.closeIconSize, t),
      closeIconColor: Color.lerp(a?.closeIconColor, b?.closeIconColor, t),
      closeIconActiveColor:
          Color.lerp(a?.closeIconActiveColor, b?.closeIconActiveColor, t),
      closeIconPadding:
          EdgeInsets.lerp(a?.closeIconPadding, b?.closeIconPadding, t),
      cancelTextColor: Color.lerp(a?.cancelTextColor, b?.cancelTextColor, t),
      cancelPaddingTop: lerpDouble(a?.cancelPaddingTop, b?.cancelPaddingTop, t),
      cancelPaddingColor:
          Color.lerp(a?.cancelPaddingColor, b?.cancelPaddingColor, t),
      loadingIconSize: lerpDouble(a?.loadingIconSize, b?.loadingIconSize, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      maxHeightFactor,
      headerHeight,
      headerFontSize,
      descriptionColor,
      descriptionFontSize,
      descriptionLineHeight,
      itemBackground,
      itemFontSize,
      itemLineHeight,
      itemTextColor,
      itemDisabledTextColor,
      subnameColor,
      subnameFontSize,
      subnameLineHeight,
      closeIconSize,
      closeIconColor,
      closeIconActiveColor,
      closeIconPadding,
      cancelTextColor,
      cancelPaddingTop,
      cancelPaddingColor,
      loadingIconSize,
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
    return other is FlanActionSheetThemeData &&
        other.maxHeightFactor == maxHeightFactor &&
        other.headerHeight == headerHeight &&
        other.headerFontSize == headerFontSize &&
        other.descriptionColor == descriptionColor &&
        other.descriptionFontSize == descriptionFontSize &&
        other.descriptionLineHeight == descriptionLineHeight &&
        other.itemBackground == itemBackground &&
        other.itemFontSize == itemFontSize &&
        other.itemLineHeight == itemLineHeight &&
        other.itemTextColor == itemTextColor &&
        other.itemDisabledTextColor == itemDisabledTextColor &&
        other.subnameColor == subnameColor &&
        other.subnameFontSize == subnameFontSize &&
        other.subnameLineHeight == subnameLineHeight &&
        other.closeIconSize == closeIconSize &&
        other.closeIconColor == closeIconColor &&
        other.closeIconActiveColor == closeIconActiveColor &&
        other.closeIconPadding == closeIconPadding &&
        other.cancelTextColor == cancelTextColor &&
        other.cancelPaddingTop == cancelPaddingTop &&
        other.cancelPaddingColor == cancelPaddingColor &&
        other.loadingIconSize == loadingIconSize;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<double>(
        'maxHeightFactor', maxHeightFactor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('headerHeight', headerHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('headerFontSize', headerFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'descriptionColor', descriptionColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'descriptionFontSize', descriptionFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'descriptionLineHeight', descriptionLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('itemBackground', itemBackground,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('itemFontSize', itemFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('itemLineHeight', itemLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('itemTextColor', itemTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'itemDisabledTextColor', itemDisabledTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('subnameColor', subnameColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'subnameFontSize', subnameFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'subnameLineHeight', subnameLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('closeIconSize', closeIconSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('closeIconColor', closeIconColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'closeIconActiveColor', closeIconActiveColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'closeIconPadding', closeIconPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'cancelTextColor', cancelTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'cancelPaddingTop', cancelPaddingTop,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'cancelPaddingColor', cancelPaddingColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'loadingIconSize', loadingIconSize,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
