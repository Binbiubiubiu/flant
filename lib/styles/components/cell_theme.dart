// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanCellTheme extends InheritedTheme {
  const FlanCellTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanCellThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanCellTheme(
          key: key,
          data: FlanCellTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanCellThemeData data;

  static FlanCellThemeData of(BuildContext context) {
    final FlanCellTheme? cellTheme =
        context.dependOnInheritedWidgetOfExactType<FlanCellTheme>();
    return cellTheme?.data ?? FlanTheme.of(context).cellTheme;
  }

  @override
  bool updateShouldNotify(FlanCellTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanCellTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanCellThemeData with Diagnosticable {
  factory FlanCellThemeData({
    double? fontSize,
    double? lineHeight,
    double? verticalPadding,
    double? horizontalPadding,
    Color? textColor,
    Color? backgroundColor,
    Color? borderColor,
    Color? activeColor,
    Color? requiredColor,
    Color? labelColor,
    double? labelFontSize,
    double? labelLineHeight,
    double? labelMarginTop,
    Color? valueColor,
    double? iconSize,
    Color? rightIconColor,
    double? largeVerticalPadding,
    double? largeTitleFontSize,
    double? largeLabelFontSize,
  }) {
    final double _fontSize = fontSize ?? FlanThemeVars.fontSizeMd.rpx;
    final double _labelFontSize = labelFontSize ?? FlanThemeVars.fontSizeSm.rpx;
    return FlanCellThemeData.raw(
      fontSize: _fontSize,
      lineHeight: lineHeight ?? (24.0.rpx / _fontSize),
      verticalPadding: verticalPadding ?? 10.0.rpx,
      horizontalPadding: horizontalPadding ?? FlanThemeVars.paddingMd.rpx,
      textColor: textColor ?? FlanThemeVars.textColor,
      backgroundColor: backgroundColor ?? FlanThemeVars.white,
      borderColor: borderColor ?? FlanThemeVars.borderColor,
      activeColor: activeColor ?? FlanThemeVars.activeColor,
      requiredColor: requiredColor ?? FlanThemeVars.red,
      labelColor: labelColor ?? FlanThemeVars.gray6,
      labelFontSize: _labelFontSize,
      labelLineHeight:
          labelLineHeight ?? (FlanThemeVars.lineHeightSm.rpx / _labelFontSize),
      labelMarginTop: labelMarginTop ?? FlanThemeVars.paddingBase.rpx,
      valueColor: valueColor ?? FlanThemeVars.gray6,
      iconSize: iconSize ?? 16.0.rpx,
      rightIconColor: rightIconColor ?? FlanThemeVars.gray6,
      largeVerticalPadding: largeVerticalPadding ?? FlanThemeVars.paddingSm.rpx,
      largeTitleFontSize: largeTitleFontSize ?? FlanThemeVars.fontSizeLg.rpx,
      largeLabelFontSize: largeLabelFontSize ?? FlanThemeVars.fontSizeMd.rpx,
    );
  }

  const FlanCellThemeData.raw({
    required this.fontSize,
    required this.lineHeight,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.activeColor,
    required this.requiredColor,
    required this.labelColor,
    required this.labelFontSize,
    required this.labelLineHeight,
    required this.labelMarginTop,
    required this.valueColor,
    required this.iconSize,
    required this.rightIconColor,
    required this.largeVerticalPadding,
    required this.largeTitleFontSize,
    required this.largeLabelFontSize,
  });

  final double fontSize;
  final double lineHeight;
  final double verticalPadding;
  final double horizontalPadding;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color activeColor;
  final Color requiredColor;
  final Color labelColor;
  final double labelFontSize;
  final double labelLineHeight;
  final double labelMarginTop;
  final Color valueColor;
  final double iconSize;
  final Color rightIconColor;
  final double largeVerticalPadding;
  final double largeTitleFontSize;
  final double largeLabelFontSize;

  FlanCellThemeData copyWith({
    double? fontSize,
    double? lineHeight,
    double? verticalPadding,
    double? horizontalPadding,
    Color? textColor,
    Color? backgroundColor,
    Color? borderColor,
    Color? activeColor,
    Color? requiredColor,
    Color? labelColor,
    double? labelFontSize,
    double? labelLineHeight,
    double? labelMarginTop,
    Color? valueColor,
    double? iconSize,
    Color? rightIconColor,
    double? largeVerticalPadding,
    double? largeTitleFontSize,
    double? largeLabelFontSize,
  }) {
    return FlanCellThemeData(
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      verticalPadding: verticalPadding ?? this.verticalPadding,
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      activeColor: activeColor ?? this.activeColor,
      requiredColor: requiredColor ?? this.requiredColor,
      labelColor: labelColor ?? this.labelColor,
      labelFontSize: labelFontSize ?? this.labelFontSize,
      labelLineHeight: labelLineHeight ?? this.labelLineHeight,
      labelMarginTop: labelMarginTop ?? this.labelMarginTop,
      valueColor: valueColor ?? this.valueColor,
      iconSize: iconSize ?? this.iconSize,
      rightIconColor: rightIconColor ?? this.rightIconColor,
      largeVerticalPadding: largeVerticalPadding ?? this.largeVerticalPadding,
      largeTitleFontSize: largeTitleFontSize ?? this.largeTitleFontSize,
      largeLabelFontSize: largeLabelFontSize ?? this.largeLabelFontSize,
    );
  }

  FlanCellThemeData merge(FlanCellThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      fontSize: other.fontSize,
      lineHeight: other.lineHeight,
      verticalPadding: other.verticalPadding,
      horizontalPadding: other.horizontalPadding,
      textColor: other.textColor,
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      activeColor: other.activeColor,
      requiredColor: other.requiredColor,
      labelColor: other.labelColor,
      labelFontSize: other.labelFontSize,
      labelLineHeight: other.labelLineHeight,
      labelMarginTop: other.labelMarginTop,
      valueColor: other.valueColor,
      iconSize: other.iconSize,
      rightIconColor: other.rightIconColor,
      largeVerticalPadding: other.largeVerticalPadding,
      largeTitleFontSize: other.largeTitleFontSize,
      largeLabelFontSize: other.largeLabelFontSize,
    );
  }

  static FlanCellThemeData lerp(
      FlanCellThemeData? a, FlanCellThemeData? b, double t) {
    return FlanCellThemeData(
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t),
      lineHeight: lerpDouble(a?.lineHeight, b?.lineHeight, t),
      verticalPadding: lerpDouble(a?.verticalPadding, b?.verticalPadding, t),
      horizontalPadding:
          lerpDouble(a?.horizontalPadding, b?.horizontalPadding, t),
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      borderColor: Color.lerp(a?.borderColor, b?.borderColor, t),
      activeColor: Color.lerp(a?.activeColor, b?.activeColor, t),
      requiredColor: Color.lerp(a?.requiredColor, b?.requiredColor, t),
      labelColor: Color.lerp(a?.labelColor, b?.labelColor, t),
      labelFontSize: lerpDouble(a?.labelFontSize, b?.labelFontSize, t),
      labelLineHeight: lerpDouble(a?.labelLineHeight, b?.labelLineHeight, t),
      labelMarginTop: lerpDouble(a?.labelMarginTop, b?.labelMarginTop, t),
      valueColor: Color.lerp(a?.valueColor, b?.valueColor, t),
      iconSize: lerpDouble(a?.iconSize, b?.iconSize, t),
      rightIconColor: Color.lerp(a?.rightIconColor, b?.rightIconColor, t),
      largeVerticalPadding:
          lerpDouble(a?.largeVerticalPadding, b?.largeVerticalPadding, t),
      largeTitleFontSize:
          lerpDouble(a?.largeTitleFontSize, b?.largeTitleFontSize, t),
      largeLabelFontSize:
          lerpDouble(a?.largeLabelFontSize, b?.largeLabelFontSize, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      fontSize,
      lineHeight,
      verticalPadding,
      horizontalPadding,
      textColor,
      backgroundColor,
      borderColor,
      activeColor,
      requiredColor,
      labelColor,
      labelFontSize,
      labelLineHeight,
      labelMarginTop,
      valueColor,
      iconSize,
      rightIconColor,
      largeVerticalPadding,
      largeTitleFontSize,
      largeLabelFontSize,
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
    return other is FlanCellThemeData &&
        other.fontSize == fontSize &&
        other.lineHeight == lineHeight &&
        other.verticalPadding == verticalPadding &&
        other.horizontalPadding == horizontalPadding &&
        other.textColor == textColor &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.activeColor == activeColor &&
        other.requiredColor == requiredColor &&
        other.labelColor == labelColor &&
        other.labelFontSize == labelFontSize &&
        other.labelLineHeight == labelLineHeight &&
        other.labelMarginTop == labelMarginTop &&
        other.valueColor == valueColor &&
        other.iconSize == iconSize &&
        other.rightIconColor == rightIconColor &&
        other.largeVerticalPadding == largeVerticalPadding &&
        other.largeTitleFontSize == largeTitleFontSize &&
        other.largeLabelFontSize == largeLabelFontSize;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('lineHeight', lineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'verticalPadding', verticalPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'horizontalPadding', horizontalPadding,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('borderColor', borderColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('activeColor', activeColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('requiredColor', requiredColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('labelColor', labelColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('labelFontSize', labelFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'labelLineHeight', labelLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('labelMarginTop', labelMarginTop,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('valueColor', valueColor,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('iconSize', iconSize, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('rightIconColor', rightIconColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'largeVerticalPadding', largeVerticalPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'largeTitleFontSize', largeTitleFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'largeLabelFontSize', largeLabelFontSize,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
