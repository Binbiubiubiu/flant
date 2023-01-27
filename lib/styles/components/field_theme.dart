import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanFieldTheme extends InheritedTheme {
  const FlanFieldTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanFieldThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanFieldTheme(
          key: key,
          data: FlanFieldTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanFieldThemeData data;

  static FlanFieldThemeData of(BuildContext context) {
    final FlanFieldTheme? fieldTheme =
        context.dependOnInheritedWidgetOfExactType<FlanFieldTheme>();
    return fieldTheme?.data ?? FlanTheme.of(context).fieldTheme;
  }

  @override
  bool updateShouldNotify(FlanFieldTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanFieldTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanFieldThemeData with Diagnosticable {
  factory FlanFieldThemeData({
    double? labelWidth,
    Color? labelColor,
    double? labelMarginRight,
    Color? inputTextColor,
    Color? inputErrorTextColor,
    Color? inputDisabledTextColor,
    Color? placeholderTextColor,
    double? iconSize,
    double? clearIconSize,
    Color? clearIconColor,
    Color? rightIconColor,
    Color? errorMessageColor,
    double? errorMessageTextColor,
    double? textAreaMinHeight,
    Color? wordLimitColor,
    double? wordLimitFontSize,
    double? wordLimitLineHeight,
    Color? disabledTextColor,
  }) {
    return FlanFieldThemeData.raw(
      labelWidth: labelWidth ?? 6.2 * FlanThemeVars.fontSizeMd.rpx,
      labelColor: labelColor ?? FlanThemeVars.gray7,
      labelMarginRight: labelMarginRight ?? FlanThemeVars.paddingSm.rpx,
      inputTextColor: inputTextColor ?? FlanThemeVars.textColor,
      inputErrorTextColor: inputErrorTextColor ?? FlanThemeVars.red,
      inputDisabledTextColor: inputDisabledTextColor ?? FlanThemeVars.gray5,
      placeholderTextColor: placeholderTextColor ?? FlanThemeVars.gray5,
      iconSize: iconSize ?? 16.0.rpx,
      clearIconSize: clearIconSize ?? 16.0.rpx,
      clearIconColor: clearIconColor ?? FlanThemeVars.gray5,
      rightIconColor: rightIconColor ?? FlanThemeVars.gray6,
      errorMessageColor: errorMessageColor ?? FlanThemeVars.red,
      errorMessageTextColor: errorMessageTextColor ?? 12.0.rpx,
      textAreaMinHeight: textAreaMinHeight ?? 60.0.rpx,
      wordLimitColor: wordLimitColor ?? FlanThemeVars.gray7,
      wordLimitFontSize: wordLimitFontSize ?? FlanThemeVars.fontSizeSm.rpx,
      wordLimitLineHeight: wordLimitLineHeight ?? 16.0.rpx,
      disabledTextColor: disabledTextColor ?? FlanThemeVars.gray5,
    );
  }

  const FlanFieldThemeData.raw({
    required this.labelWidth,
    required this.labelColor,
    required this.labelMarginRight,
    required this.inputTextColor,
    required this.inputErrorTextColor,
    required this.inputDisabledTextColor,
    required this.placeholderTextColor,
    required this.iconSize,
    required this.clearIconSize,
    required this.clearIconColor,
    required this.rightIconColor,
    required this.errorMessageColor,
    required this.errorMessageTextColor,
    required this.textAreaMinHeight,
    required this.wordLimitColor,
    required this.wordLimitFontSize,
    required this.wordLimitLineHeight,
    required this.disabledTextColor,
  });

  final double labelWidth;
  final Color labelColor;
  final double labelMarginRight;
  final Color inputTextColor;
  final Color inputErrorTextColor;
  final Color inputDisabledTextColor;
  final Color placeholderTextColor;
  final double iconSize;
  final double clearIconSize;
  final Color clearIconColor;
  final Color rightIconColor;
  final Color errorMessageColor;
  final double errorMessageTextColor;
  final double textAreaMinHeight;
  final Color wordLimitColor;
  final double wordLimitFontSize;
  final double wordLimitLineHeight;
  final Color disabledTextColor;

  FlanFieldThemeData copyWith({
    double? labelWidth,
    Color? labelColor,
    double? labelMarginRight,
    Color? inputTextColor,
    Color? inputErrorTextColor,
    Color? inputDisabledTextColor,
    Color? placeholderTextColor,
    double? iconSize,
    double? clearIconSize,
    Color? clearIconColor,
    Color? rightIconColor,
    Color? errorMessageColor,
    double? errorMessageTextColor,
    double? textAreaMinHeight,
    Color? wordLimitColor,
    double? wordLimitFontSize,
    double? wordLimitLineHeight,
    Color? disabledTextColor,
  }) {
    return FlanFieldThemeData(
      labelWidth: labelWidth ?? this.labelWidth,
      labelColor: labelColor ?? this.labelColor,
      labelMarginRight: labelMarginRight ?? this.labelMarginRight,
      inputTextColor: inputTextColor ?? this.inputTextColor,
      inputErrorTextColor: inputErrorTextColor ?? this.inputErrorTextColor,
      inputDisabledTextColor:
          inputDisabledTextColor ?? this.inputDisabledTextColor,
      placeholderTextColor: placeholderTextColor ?? this.placeholderTextColor,
      iconSize: iconSize ?? this.iconSize,
      clearIconSize: clearIconSize ?? this.clearIconSize,
      clearIconColor: clearIconColor ?? this.clearIconColor,
      rightIconColor: rightIconColor ?? this.rightIconColor,
      errorMessageColor: errorMessageColor ?? this.errorMessageColor,
      errorMessageTextColor:
          errorMessageTextColor ?? this.errorMessageTextColor,
      textAreaMinHeight: textAreaMinHeight ?? this.textAreaMinHeight,
      wordLimitColor: wordLimitColor ?? this.wordLimitColor,
      wordLimitFontSize: wordLimitFontSize ?? this.wordLimitFontSize,
      wordLimitLineHeight: wordLimitLineHeight ?? this.wordLimitLineHeight,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
    );
  }

  FlanFieldThemeData merge(FlanFieldThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      labelWidth: other.labelWidth,
      labelColor: other.labelColor,
      labelMarginRight: other.labelMarginRight,
      inputTextColor: other.inputTextColor,
      inputErrorTextColor: other.inputErrorTextColor,
      inputDisabledTextColor: other.inputDisabledTextColor,
      placeholderTextColor: other.placeholderTextColor,
      iconSize: other.iconSize,
      clearIconSize: other.clearIconSize,
      clearIconColor: other.clearIconColor,
      rightIconColor: other.rightIconColor,
      errorMessageColor: other.errorMessageColor,
      errorMessageTextColor: other.errorMessageTextColor,
      textAreaMinHeight: other.textAreaMinHeight,
      wordLimitColor: other.wordLimitColor,
      wordLimitFontSize: other.wordLimitFontSize,
      wordLimitLineHeight: other.wordLimitLineHeight,
      disabledTextColor: other.disabledTextColor,
    );
  }

  static FlanFieldThemeData lerp(
      FlanFieldThemeData? a, FlanFieldThemeData? b, double t) {
    return FlanFieldThemeData(
      labelWidth: lerpDouble(a?.labelWidth, b?.labelWidth, t),
      labelColor: Color.lerp(a?.labelColor, b?.labelColor, t),
      labelMarginRight: lerpDouble(a?.labelMarginRight, b?.labelMarginRight, t),
      inputTextColor: Color.lerp(a?.inputTextColor, b?.inputTextColor, t),
      inputErrorTextColor:
          Color.lerp(a?.inputErrorTextColor, b?.inputErrorTextColor, t),
      inputDisabledTextColor:
          Color.lerp(a?.inputDisabledTextColor, b?.inputDisabledTextColor, t),
      placeholderTextColor:
          Color.lerp(a?.placeholderTextColor, b?.placeholderTextColor, t),
      iconSize: lerpDouble(a?.iconSize, b?.iconSize, t),
      clearIconSize: lerpDouble(a?.clearIconSize, b?.clearIconSize, t),
      clearIconColor: Color.lerp(a?.clearIconColor, b?.clearIconColor, t),
      rightIconColor: Color.lerp(a?.rightIconColor, b?.rightIconColor, t),
      errorMessageColor:
          Color.lerp(a?.errorMessageColor, b?.errorMessageColor, t),
      errorMessageTextColor:
          lerpDouble(a?.errorMessageTextColor, b?.errorMessageTextColor, t),
      textAreaMinHeight:
          lerpDouble(a?.textAreaMinHeight, b?.textAreaMinHeight, t),
      wordLimitColor: Color.lerp(a?.wordLimitColor, b?.wordLimitColor, t),
      wordLimitFontSize:
          lerpDouble(a?.wordLimitFontSize, b?.wordLimitFontSize, t),
      wordLimitLineHeight:
          lerpDouble(a?.wordLimitLineHeight, b?.wordLimitLineHeight, t),
      disabledTextColor:
          Color.lerp(a?.disabledTextColor, b?.disabledTextColor, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      labelWidth,
      labelColor,
      labelMarginRight,
      inputTextColor,
      inputErrorTextColor,
      inputDisabledTextColor,
      placeholderTextColor,
      iconSize,
      clearIconSize,
      clearIconColor,
      rightIconColor,
      errorMessageColor,
      errorMessageTextColor,
      textAreaMinHeight,
      wordLimitColor,
      wordLimitFontSize,
      wordLimitLineHeight,
      disabledTextColor,
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
    return other is FlanFieldThemeData &&
        other.labelWidth == labelWidth &&
        other.labelColor == labelColor &&
        other.labelMarginRight == labelMarginRight &&
        other.inputTextColor == inputTextColor &&
        other.inputErrorTextColor == inputErrorTextColor &&
        other.inputDisabledTextColor == inputDisabledTextColor &&
        other.placeholderTextColor == placeholderTextColor &&
        other.iconSize == iconSize &&
        other.clearIconSize == clearIconSize &&
        other.clearIconColor == clearIconColor &&
        other.rightIconColor == rightIconColor &&
        other.errorMessageColor == errorMessageColor &&
        other.errorMessageTextColor == errorMessageTextColor &&
        other.textAreaMinHeight == textAreaMinHeight &&
        other.wordLimitColor == wordLimitColor &&
        other.wordLimitFontSize == wordLimitFontSize &&
        other.wordLimitLineHeight == wordLimitLineHeight &&
        other.disabledTextColor == disabledTextColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<double>('labelWidth', labelWidth,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('labelColor', labelColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'labelMarginRight', labelMarginRight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('inputTextColor', inputTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'inputErrorTextColor', inputErrorTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'inputDisabledTextColor', inputDisabledTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'placeholderTextColor', placeholderTextColor,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('iconSize', iconSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('clearIconSize', clearIconSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('clearIconColor', clearIconColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('rightIconColor', rightIconColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'errorMessageColor', errorMessageColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'errorMessageTextColor', errorMessageTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'textAreaMinHeight', textAreaMinHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('wordLimitColor', wordLimitColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'wordLimitFontSize', wordLimitFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'wordLimitLineHeight', wordLimitLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'disabledTextColor', disabledTextColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
