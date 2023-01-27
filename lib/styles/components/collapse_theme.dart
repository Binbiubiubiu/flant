import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanCollapseTheme extends InheritedTheme {
  const FlanCollapseTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanCollapseThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanCollapseTheme(
          key: key,
          data: FlanCollapseTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanCollapseThemeData data;

  static FlanCollapseThemeData of(BuildContext context) {
    final FlanCollapseTheme? collapseTheme =
        context.dependOnInheritedWidgetOfExactType<FlanCollapseTheme>();
    return collapseTheme?.data ?? FlanTheme.of(context).collapseTheme;
  }

  @override
  bool updateShouldNotify(FlanCollapseTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanCollapseTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanCollapseThemeData with Diagnosticable {
  factory FlanCollapseThemeData({
    Duration? itemTransitionDuration,
    EdgeInsets? itemContentPadding,
    double? itemContentFontSize,
    double? itemContentLineHeight,
    Color? itemContentTextColor,
    Color? itemContentBackgroundColor,
    Color? itemTitleDisabledColor,
  }) {
    return FlanCollapseThemeData.raw(
      itemTransitionDuration:
          itemTransitionDuration ?? FlanThemeVars.animationDurationBase,
      itemContentPadding: itemContentPadding ??
          EdgeInsets.symmetric(
              vertical: FlanThemeVars.paddingSm.rpx,
              horizontal: FlanThemeVars.paddingMd.rpx),
      itemContentFontSize:
          itemContentFontSize ?? FlanThemeVars.fontSizeMd.rpx.rpx,
      itemContentLineHeight: itemContentLineHeight ?? 1.5,
      itemContentTextColor: itemContentTextColor ?? FlanThemeVars.gray6,
      itemContentBackgroundColor:
          itemContentBackgroundColor ?? FlanThemeVars.white,
      itemTitleDisabledColor: itemTitleDisabledColor ?? FlanThemeVars.gray5,
    );
  }

  const FlanCollapseThemeData.raw({
    required this.itemTransitionDuration,
    required this.itemContentPadding,
    required this.itemContentFontSize,
    required this.itemContentLineHeight,
    required this.itemContentTextColor,
    required this.itemContentBackgroundColor,
    required this.itemTitleDisabledColor,
  });

  final Duration itemTransitionDuration;
  final EdgeInsets itemContentPadding;
  final double itemContentFontSize;
  final double itemContentLineHeight;
  final Color itemContentTextColor;
  final Color itemContentBackgroundColor;
  final Color itemTitleDisabledColor;

  FlanCollapseThemeData copyWith({
    Duration? itemTransitionDuration,
    EdgeInsets? itemContentPadding,
    double? itemContentFontSize,
    double? itemContentLineHeight,
    Color? itemContentTextColor,
    Color? itemContentBackgroundColor,
    Color? itemTitleDisabledColor,
  }) {
    return FlanCollapseThemeData(
      itemTransitionDuration:
          itemTransitionDuration ?? this.itemTransitionDuration,
      itemContentPadding: itemContentPadding ?? this.itemContentPadding,
      itemContentFontSize: itemContentFontSize ?? this.itemContentFontSize,
      itemContentLineHeight:
          itemContentLineHeight ?? this.itemContentLineHeight,
      itemContentTextColor: itemContentTextColor ?? this.itemContentTextColor,
      itemContentBackgroundColor:
          itemContentBackgroundColor ?? this.itemContentBackgroundColor,
      itemTitleDisabledColor:
          itemTitleDisabledColor ?? this.itemTitleDisabledColor,
    );
  }

  FlanCollapseThemeData merge(FlanCollapseThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      itemTransitionDuration: other.itemTransitionDuration,
      itemContentPadding: other.itemContentPadding,
      itemContentFontSize: other.itemContentFontSize,
      itemContentLineHeight: other.itemContentLineHeight,
      itemContentTextColor: other.itemContentTextColor,
      itemContentBackgroundColor: other.itemContentBackgroundColor,
      itemTitleDisabledColor: other.itemTitleDisabledColor,
    );
  }

  static FlanCollapseThemeData lerp(
      FlanCollapseThemeData? a, FlanCollapseThemeData? b, double t) {
    return FlanCollapseThemeData(
      // itemTransitionDuration:
      //     lerpDuration(a?.itemTransitionDuration, b?.itemTransitionDuration, t),
      itemContentPadding:
          EdgeInsets.lerp(a?.itemContentPadding, b?.itemContentPadding, t),
      itemContentFontSize:
          lerpDouble(a?.itemContentFontSize, b?.itemContentFontSize, t),
      itemContentLineHeight:
          lerpDouble(a?.itemContentLineHeight, b?.itemContentLineHeight, t),
      itemContentTextColor:
          Color.lerp(a?.itemContentTextColor, b?.itemContentTextColor, t),
      itemContentBackgroundColor: Color.lerp(
          a?.itemContentBackgroundColor, b?.itemContentBackgroundColor, t),
      itemTitleDisabledColor:
          Color.lerp(a?.itemTitleDisabledColor, b?.itemTitleDisabledColor, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      itemTransitionDuration,
      itemContentPadding,
      itemContentFontSize,
      itemContentLineHeight,
      itemContentTextColor,
      itemContentBackgroundColor,
      itemTitleDisabledColor,
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
    return other is FlanCollapseThemeData &&
        other.itemTransitionDuration == itemTransitionDuration &&
        other.itemContentPadding == itemContentPadding &&
        other.itemContentFontSize == itemContentFontSize &&
        other.itemContentLineHeight == itemContentLineHeight &&
        other.itemContentTextColor == itemContentTextColor &&
        other.itemContentBackgroundColor == itemContentBackgroundColor &&
        other.itemTitleDisabledColor == itemTitleDisabledColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Duration>(
        'itemTransitionDuration', itemTransitionDuration,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'itemContentPadding', itemContentPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'itemContentFontSize', itemContentFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'itemContentLineHeight', itemContentLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'itemContentTextColor', itemContentTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'itemContentBackgroundColor', itemContentBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'itemTitleDisabledColor', itemTitleDisabledColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
