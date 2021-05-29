// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanShareSheetTheme extends InheritedTheme {
  const FlanShareSheetTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanShareSheetThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanShareSheetTheme(
          key: key,
          data: FlanShareSheetTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanShareSheetThemeData data;

  static FlanShareSheetThemeData of(BuildContext context) {
    final FlanShareSheetTheme? shareSheetTheme =
        context.dependOnInheritedWidgetOfExactType<FlanShareSheetTheme>();
    return shareSheetTheme?.data ?? FlanTheme.of(context).shareSheetTheme;
  }

  @override
  bool updateShouldNotify(FlanShareSheetTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanShareSheetTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanShareSheetThemeData with Diagnosticable {
  factory FlanShareSheetThemeData({
    EdgeInsets? headerPadding,
    Color? titleColor,
    double? titleFontSize,
    double? titleLineHeight,
    Color? descriptionColor,
    double? descriptionFontSize,
    double? descriptionLineHeight,
    double? iconSize,
    Color? optionNameColor,
    double? optionNameFontSize,
    Color? optionDescriptionColor,
    double? optionDescriptionFontSize,
    double? cancelButtonFontSize,
    double? cancelButtonHeight,
    Color? cancelButtonBackground,
  }) {
    final double _titleFontSize = titleFontSize ?? FlanThemeVars.fontSizeMd.rpx;
    final double _descriptionFontSize =
        descriptionFontSize ?? FlanThemeVars.fontSizeSm.rpx;
    final double _cancelButtonFontSize =
        cancelButtonFontSize ?? FlanThemeVars.fontSizeLg.rpx;
    return FlanShareSheetThemeData.raw(
      headerPadding: headerPadding ??
          EdgeInsets.only(
            top: FlanThemeVars.paddingSm.rpx,
            left: FlanThemeVars.paddingMd.rpx,
            right: FlanThemeVars.paddingMd.rpx,
            bottom: FlanThemeVars.paddingBase.rpx,
          ),
      titleColor: titleColor ?? FlanThemeVars.textColor,
      titleFontSize: _titleFontSize,
      titleLineHeight:
          titleLineHeight ?? (FlanThemeVars.lineHeightMd.rpx / _titleFontSize),
      descriptionColor: descriptionColor ?? FlanThemeVars.gray6,
      descriptionFontSize: _descriptionFontSize,
      descriptionLineHeight:
          descriptionLineHeight ?? (16.0.rpx / _descriptionFontSize),
      iconSize: iconSize ?? 48.0.rpx,
      optionNameColor: optionNameColor ?? FlanThemeVars.gray7,
      optionNameFontSize: optionNameFontSize ?? FlanThemeVars.fontSizeSm.rpx,
      optionDescriptionColor: optionDescriptionColor ?? FlanThemeVars.gray5,
      optionDescriptionFontSize:
          optionDescriptionFontSize ?? FlanThemeVars.fontSizeSm.rpx,
      cancelButtonFontSize: _cancelButtonFontSize,
      cancelButtonHeight:
          cancelButtonHeight ?? (48.0.rpx / _cancelButtonFontSize),
      cancelButtonBackground: cancelButtonBackground ?? FlanThemeVars.white,
    );
  }

  const FlanShareSheetThemeData.raw({
    required this.headerPadding,
    required this.titleColor,
    required this.titleFontSize,
    required this.titleLineHeight,
    required this.descriptionColor,
    required this.descriptionFontSize,
    required this.descriptionLineHeight,
    required this.iconSize,
    required this.optionNameColor,
    required this.optionNameFontSize,
    required this.optionDescriptionColor,
    required this.optionDescriptionFontSize,
    required this.cancelButtonFontSize,
    required this.cancelButtonHeight,
    required this.cancelButtonBackground,
  });

  final EdgeInsets headerPadding;
  final Color titleColor;
  final double titleFontSize;
  final double titleLineHeight;
  final Color descriptionColor;
  final double descriptionFontSize;
  final double descriptionLineHeight;
  final double iconSize;
  final Color optionNameColor;
  final double optionNameFontSize;
  final Color optionDescriptionColor;
  final double optionDescriptionFontSize;
  final double cancelButtonFontSize;
  final double cancelButtonHeight;
  final Color cancelButtonBackground;

  FlanShareSheetThemeData copyWith({
    EdgeInsets? headerPadding,
    Color? titleColor,
    double? titleFontSize,
    double? titleLineHeight,
    Color? descriptionColor,
    double? descriptionFontSize,
    double? descriptionLineHeight,
    double? iconSize,
    Color? optionNameColor,
    double? optionNameFontSize,
    Color? optionDescriptionColor,
    double? optionDescriptionFontSize,
    double? cancelButtonFontSize,
    double? cancelButtonHeight,
    Color? cancelButtonBackground,
  }) {
    return FlanShareSheetThemeData(
      headerPadding: headerPadding ?? this.headerPadding,
      titleColor: titleColor ?? this.titleColor,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      titleLineHeight: titleLineHeight ?? this.titleLineHeight,
      descriptionColor: descriptionColor ?? this.descriptionColor,
      descriptionFontSize: descriptionFontSize ?? this.descriptionFontSize,
      descriptionLineHeight:
          descriptionLineHeight ?? this.descriptionLineHeight,
      iconSize: iconSize ?? this.iconSize,
      optionNameColor: optionNameColor ?? this.optionNameColor,
      optionNameFontSize: optionNameFontSize ?? this.optionNameFontSize,
      optionDescriptionColor:
          optionDescriptionColor ?? this.optionDescriptionColor,
      optionDescriptionFontSize:
          optionDescriptionFontSize ?? this.optionDescriptionFontSize,
      cancelButtonFontSize: cancelButtonFontSize ?? this.cancelButtonFontSize,
      cancelButtonHeight: cancelButtonHeight ?? this.cancelButtonHeight,
      cancelButtonBackground:
          cancelButtonBackground ?? this.cancelButtonBackground,
    );
  }

  FlanShareSheetThemeData merge(FlanShareSheetThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      headerPadding: other.headerPadding,
      titleColor: other.titleColor,
      titleFontSize: other.titleFontSize,
      titleLineHeight: other.titleLineHeight,
      descriptionColor: other.descriptionColor,
      descriptionFontSize: other.descriptionFontSize,
      descriptionLineHeight: other.descriptionLineHeight,
      iconSize: other.iconSize,
      optionNameColor: other.optionNameColor,
      optionNameFontSize: other.optionNameFontSize,
      optionDescriptionColor: other.optionDescriptionColor,
      optionDescriptionFontSize: other.optionDescriptionFontSize,
      cancelButtonFontSize: other.cancelButtonFontSize,
      cancelButtonHeight: other.cancelButtonHeight,
      cancelButtonBackground: other.cancelButtonBackground,
    );
  }

  static FlanShareSheetThemeData lerp(
      FlanShareSheetThemeData? a, FlanShareSheetThemeData? b, double t) {
    return FlanShareSheetThemeData(
      headerPadding: EdgeInsets.lerp(a?.headerPadding, b?.headerPadding, t),
      titleColor: Color.lerp(a?.titleColor, b?.titleColor, t),
      titleFontSize: lerpDouble(a?.titleFontSize, b?.titleFontSize, t),
      titleLineHeight: lerpDouble(a?.titleLineHeight, b?.titleLineHeight, t),
      descriptionColor: Color.lerp(a?.descriptionColor, b?.descriptionColor, t),
      descriptionFontSize:
          lerpDouble(a?.descriptionFontSize, b?.descriptionFontSize, t),
      descriptionLineHeight:
          lerpDouble(a?.descriptionLineHeight, b?.descriptionLineHeight, t),
      iconSize: lerpDouble(a?.iconSize, b?.iconSize, t),
      optionNameColor: Color.lerp(a?.optionNameColor, b?.optionNameColor, t),
      optionNameFontSize:
          lerpDouble(a?.optionNameFontSize, b?.optionNameFontSize, t),
      optionDescriptionColor:
          Color.lerp(a?.optionDescriptionColor, b?.optionDescriptionColor, t),
      optionDescriptionFontSize: lerpDouble(
          a?.optionDescriptionFontSize, b?.optionDescriptionFontSize, t),
      cancelButtonFontSize:
          lerpDouble(a?.cancelButtonFontSize, b?.cancelButtonFontSize, t),
      cancelButtonHeight:
          lerpDouble(a?.cancelButtonHeight, b?.cancelButtonHeight, t),
      cancelButtonBackground:
          Color.lerp(a?.cancelButtonBackground, b?.cancelButtonBackground, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      headerPadding,
      titleColor,
      titleFontSize,
      titleLineHeight,
      descriptionColor,
      descriptionFontSize,
      descriptionLineHeight,
      iconSize,
      optionNameColor,
      optionNameFontSize,
      optionDescriptionColor,
      optionDescriptionFontSize,
      cancelButtonFontSize,
      cancelButtonHeight,
      cancelButtonBackground,
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
    return other is FlanShareSheetThemeData &&
        other.headerPadding == headerPadding &&
        other.titleColor == titleColor &&
        other.titleFontSize == titleFontSize &&
        other.titleLineHeight == titleLineHeight &&
        other.descriptionColor == descriptionColor &&
        other.descriptionFontSize == descriptionFontSize &&
        other.descriptionLineHeight == descriptionLineHeight &&
        other.iconSize == iconSize &&
        other.optionNameColor == optionNameColor &&
        other.optionNameFontSize == optionNameFontSize &&
        other.optionDescriptionColor == optionDescriptionColor &&
        other.optionDescriptionFontSize == optionDescriptionFontSize &&
        other.cancelButtonFontSize == cancelButtonFontSize &&
        other.cancelButtonHeight == cancelButtonHeight &&
        other.cancelButtonBackground == cancelButtonBackground;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'headerPadding', headerPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('titleColor', titleColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('titleFontSize', titleFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'titleLineHeight', titleLineHeight,
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
    properties.add(
        DiagnosticsProperty<double>('iconSize', iconSize, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'optionNameColor', optionNameColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'optionNameFontSize', optionNameFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'optionDescriptionColor', optionDescriptionColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'optionDescriptionFontSize', optionDescriptionFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'cancelButtonFontSize', cancelButtonFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'cancelButtonHeight', cancelButtonHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'cancelButtonBackground', cancelButtonBackground,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
