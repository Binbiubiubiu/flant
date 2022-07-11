import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanDialogTheme extends InheritedTheme {
  const FlanDialogTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanDialogThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanDialogTheme(
          key: key,
          data: FlanDialogTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanDialogThemeData data;

  static FlanDialogThemeData of(BuildContext context) {
    final FlanDialogTheme? dialogTheme =
        context.dependOnInheritedWidgetOfExactType<FlanDialogTheme>();
    return dialogTheme?.data ?? FlanTheme.of(context).dialogTheme;
  }

  @override
  bool updateShouldNotify(FlanDialogTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanDialogTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanDialogThemeData with Diagnosticable {
  factory FlanDialogThemeData({
    double? width,
    double? smallScreenWidthFactor,
    double? fontSize,
    Duration? transition,
    double? borderRadius,
    Color? backgroundColor,
    FontWeight? headerFontWeight,
    double? headerLineHeight,
    double? headerPaddingTop,
    EdgeInsets? headerIsolatedPadding,
    double? messagePadding,
    double? messageFontSize,
    double? messageLineHeight,
    double? messageMaxHeight,
    Color? hasTitleMessageTextColor,
    double? hasTitleMessagePaddingTop,
    double? buttonHeight,
    double? roundButtonHeight,
    Color? confirmButtonTextColor,
  }) {
    final double _fontSize = fontSize ?? FlanThemeVars.fontSizeLg.rpx;
    final double _messageFontSize =
        messageFontSize ?? FlanThemeVars.fontSizeMd.rpx;
    return FlanDialogThemeData.raw(
      width: width ?? 320.0.rpx,
      smallScreenWidthFactor: smallScreenWidthFactor ?? .9,
      fontSize: _fontSize,
      transition: transition ?? FlanThemeVars.animationDurationBase,
      borderRadius: borderRadius ?? 16.0.rpx,
      backgroundColor: backgroundColor ?? FlanThemeVars.white,
      headerFontWeight: headerFontWeight ?? FlanThemeVars.fontWeightBold,
      headerLineHeight: headerLineHeight ?? (24.0.rpx / _fontSize),
      headerPaddingTop: headerPaddingTop ?? 26.0.rpx,
      headerIsolatedPadding: headerIsolatedPadding ??
          EdgeInsets.symmetric(
              vertical: FlanThemeVars.paddingLg.rpx, horizontal: 0.0),
      messagePadding: messagePadding ?? FlanThemeVars.paddingLg.rpx,
      messageFontSize: _messageFontSize,
      messageLineHeight: messageLineHeight ??
          (FlanThemeVars.lineHeightMd.rpx / _messageFontSize),
      messageMaxHeight: messageMaxHeight ?? .6.rpx,
      hasTitleMessageTextColor: hasTitleMessageTextColor ?? FlanThemeVars.gray7,
      hasTitleMessagePaddingTop:
          hasTitleMessagePaddingTop ?? FlanThemeVars.paddingXs.rpx,
      buttonHeight: buttonHeight ?? 48.0.rpx,
      roundButtonHeight: roundButtonHeight ?? 36.0.rpx,
      confirmButtonTextColor: confirmButtonTextColor ?? FlanThemeVars.red,
    );
  }

  const FlanDialogThemeData.raw({
    required this.width,
    required this.smallScreenWidthFactor,
    required this.fontSize,
    required this.transition,
    required this.borderRadius,
    required this.backgroundColor,
    required this.headerFontWeight,
    required this.headerLineHeight,
    required this.headerPaddingTop,
    required this.headerIsolatedPadding,
    required this.messagePadding,
    required this.messageFontSize,
    required this.messageLineHeight,
    required this.messageMaxHeight,
    required this.hasTitleMessageTextColor,
    required this.hasTitleMessagePaddingTop,
    required this.buttonHeight,
    required this.roundButtonHeight,
    required this.confirmButtonTextColor,
  });

  final double width;
  final double smallScreenWidthFactor;
  final double fontSize;
  final Duration transition;
  final double borderRadius;
  final Color backgroundColor;
  final FontWeight headerFontWeight;
  final double headerLineHeight;
  final double headerPaddingTop;
  final EdgeInsets headerIsolatedPadding;
  final double messagePadding;
  final double messageFontSize;
  final double messageLineHeight;
  final double messageMaxHeight;
  final Color hasTitleMessageTextColor;
  final double hasTitleMessagePaddingTop;
  final double buttonHeight;
  final double roundButtonHeight;
  final Color confirmButtonTextColor;

  FlanDialogThemeData copyWith({
    double? width,
    double? smallScreenWidthFactor,
    double? fontSize,
    Duration? transition,
    double? borderRadius,
    Color? backgroundColor,
    FontWeight? headerFontWeight,
    double? headerLineHeight,
    double? headerPaddingTop,
    EdgeInsets? headerIsolatedPadding,
    double? messagePadding,
    double? messageFontSize,
    double? messageLineHeight,
    double? messageMaxHeight,
    Color? hasTitleMessageTextColor,
    double? hasTitleMessagePaddingTop,
    double? buttonHeight,
    double? roundButtonHeight,
    Color? confirmButtonTextColor,
  }) {
    return FlanDialogThemeData(
      width: width ?? this.width,
      smallScreenWidthFactor:
          smallScreenWidthFactor ?? this.smallScreenWidthFactor,
      fontSize: fontSize ?? this.fontSize,
      transition: transition ?? this.transition,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerFontWeight: headerFontWeight ?? this.headerFontWeight,
      headerLineHeight: headerLineHeight ?? this.headerLineHeight,
      headerPaddingTop: headerPaddingTop ?? this.headerPaddingTop,
      headerIsolatedPadding:
          headerIsolatedPadding ?? this.headerIsolatedPadding,
      messagePadding: messagePadding ?? this.messagePadding,
      messageFontSize: messageFontSize ?? this.messageFontSize,
      messageLineHeight: messageLineHeight ?? this.messageLineHeight,
      messageMaxHeight: messageMaxHeight ?? this.messageMaxHeight,
      hasTitleMessageTextColor:
          hasTitleMessageTextColor ?? this.hasTitleMessageTextColor,
      hasTitleMessagePaddingTop:
          hasTitleMessagePaddingTop ?? this.hasTitleMessagePaddingTop,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      roundButtonHeight: roundButtonHeight ?? this.roundButtonHeight,
      confirmButtonTextColor:
          confirmButtonTextColor ?? this.confirmButtonTextColor,
    );
  }

  FlanDialogThemeData merge(FlanDialogThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      width: other.width,
      smallScreenWidthFactor: other.smallScreenWidthFactor,
      fontSize: other.fontSize,
      transition: other.transition,
      borderRadius: other.borderRadius,
      backgroundColor: other.backgroundColor,
      headerFontWeight: other.headerFontWeight,
      headerLineHeight: other.headerLineHeight,
      headerPaddingTop: other.headerPaddingTop,
      headerIsolatedPadding: other.headerIsolatedPadding,
      messagePadding: other.messagePadding,
      messageFontSize: other.messageFontSize,
      messageLineHeight: other.messageLineHeight,
      messageMaxHeight: other.messageMaxHeight,
      hasTitleMessageTextColor: other.hasTitleMessageTextColor,
      hasTitleMessagePaddingTop: other.hasTitleMessagePaddingTop,
      buttonHeight: other.buttonHeight,
      roundButtonHeight: other.roundButtonHeight,
      confirmButtonTextColor: other.confirmButtonTextColor,
    );
  }

  static FlanDialogThemeData lerp(
      FlanDialogThemeData? a, FlanDialogThemeData? b, double t) {
    return FlanDialogThemeData(
      width: lerpDouble(a?.width, b?.width, t),
      smallScreenWidthFactor:
          lerpDouble(a?.smallScreenWidthFactor, b?.smallScreenWidthFactor, t),
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t),
      transition: b
          ?.transition, // transition: lerpDuration(a?.transition, b?.transition, t),
      borderRadius: lerpDouble(a?.borderRadius, b?.borderRadius, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      headerFontWeight:
          FontWeight.lerp(a?.headerFontWeight, b?.headerFontWeight, t),
      headerLineHeight: lerpDouble(a?.headerLineHeight, b?.headerLineHeight, t),
      headerPaddingTop: lerpDouble(a?.headerPaddingTop, b?.headerPaddingTop, t),
      headerIsolatedPadding: EdgeInsets.lerp(
          a?.headerIsolatedPadding, b?.headerIsolatedPadding, t),
      messagePadding: lerpDouble(a?.messagePadding, b?.messagePadding, t),
      messageFontSize: lerpDouble(a?.messageFontSize, b?.messageFontSize, t),
      messageLineHeight:
          lerpDouble(a?.messageLineHeight, b?.messageLineHeight, t),
      messageMaxHeight: lerpDouble(a?.messageMaxHeight, b?.messageMaxHeight, t),
      hasTitleMessageTextColor: Color.lerp(
          a?.hasTitleMessageTextColor, b?.hasTitleMessageTextColor, t),
      hasTitleMessagePaddingTop: lerpDouble(
          a?.hasTitleMessagePaddingTop, b?.hasTitleMessagePaddingTop, t),
      buttonHeight: lerpDouble(a?.buttonHeight, b?.buttonHeight, t),
      roundButtonHeight:
          lerpDouble(a?.roundButtonHeight, b?.roundButtonHeight, t),
      confirmButtonTextColor:
          Color.lerp(a?.confirmButtonTextColor, b?.confirmButtonTextColor, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      width,
      smallScreenWidthFactor,
      fontSize,
      transition,
      borderRadius,
      backgroundColor,
      headerFontWeight,
      headerLineHeight,
      headerPaddingTop,
      headerIsolatedPadding,
      messagePadding,
      messageFontSize,
      messageLineHeight,
      messageMaxHeight,
      hasTitleMessageTextColor,
      hasTitleMessagePaddingTop,
      buttonHeight,
      roundButtonHeight,
      confirmButtonTextColor,
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
    return other is FlanDialogThemeData &&
        other.width == width &&
        other.smallScreenWidthFactor == smallScreenWidthFactor &&
        other.fontSize == fontSize &&
        other.transition == transition &&
        other.borderRadius == borderRadius &&
        other.backgroundColor == backgroundColor &&
        other.headerFontWeight == headerFontWeight &&
        other.headerLineHeight == headerLineHeight &&
        other.headerPaddingTop == headerPaddingTop &&
        other.headerIsolatedPadding == headerIsolatedPadding &&
        other.messagePadding == messagePadding &&
        other.messageFontSize == messageFontSize &&
        other.messageLineHeight == messageLineHeight &&
        other.messageMaxHeight == messageMaxHeight &&
        other.hasTitleMessageTextColor == hasTitleMessageTextColor &&
        other.hasTitleMessagePaddingTop == hasTitleMessagePaddingTop &&
        other.buttonHeight == buttonHeight &&
        other.roundButtonHeight == roundButtonHeight &&
        other.confirmButtonTextColor == confirmButtonTextColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('width', width, defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'smallScreenWidthFactor', smallScreenWidthFactor,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<Duration>('transition', transition,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('borderRadius', borderRadius,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<FontWeight>(
        'headerFontWeight', headerFontWeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'headerLineHeight', headerLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'headerPaddingTop', headerPaddingTop,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'headerIsolatedPadding', headerIsolatedPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('messagePadding', messagePadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'messageFontSize', messageFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'messageLineHeight', messageLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'messageMaxHeight', messageMaxHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'hasTitleMessageTextColor', hasTitleMessageTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'hasTitleMessagePaddingTop', hasTitleMessagePaddingTop,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('buttonHeight', buttonHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'roundButtonHeight', roundButtonHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'confirmButtonTextColor', confirmButtonTextColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
