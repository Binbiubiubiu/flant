import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanImagePreviewTheme extends InheritedTheme {
  const FlanImagePreviewTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanImagePreviewThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanImagePreviewTheme(
          key: key,
          data: FlanImagePreviewTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanImagePreviewThemeData data;

  static FlanImagePreviewThemeData of(BuildContext context) {
    final FlanImagePreviewTheme? imagePreviewTheme =
        context.dependOnInheritedWidgetOfExactType<FlanImagePreviewTheme>();
    return imagePreviewTheme?.data ?? FlanTheme.of(context).imagePreviewTheme;
  }

  @override
  bool updateShouldNotify(FlanImagePreviewTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanImagePreviewTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanImagePreviewThemeData with Diagnosticable {
  factory FlanImagePreviewThemeData({
    Color? indexTextColor,
    double? indexFontSize,
    double? indexLineHeight,
    List<BoxShadow>? indexTextShadow,
    Color? overlayBackgroundColor,
    double? closeIconSize,
    Color? closeIconColor,
    Color? closeIconActiveColor,
    double? closeIconMargin,
  }) {
    final double _indexFontSize = indexFontSize ?? FlanThemeVars.fontSizeMd.rpx;
    return FlanImagePreviewThemeData.raw(
      indexTextColor: indexTextColor ?? FlanThemeVars.white,
      indexFontSize: _indexFontSize,
      indexLineHeight:
          indexLineHeight ?? (FlanThemeVars.lineHeightMd.rpx / _indexFontSize),
      indexTextShadow: indexTextShadow ??
          <BoxShadow>[
            const BoxShadow(
                offset: Offset(0.0, 1.0),
                blurRadius: 1.0,
                color: FlanThemeVars.gray8)
          ],
      overlayBackgroundColor:
          overlayBackgroundColor ?? const Color.fromRGBO(0, 0, 0, 0.9),
      closeIconSize: closeIconSize ?? 22.0.rpx,
      closeIconColor: closeIconColor ?? FlanThemeVars.gray5,
      closeIconActiveColor: closeIconActiveColor ?? FlanThemeVars.gray6,
      closeIconMargin: closeIconMargin ?? FlanThemeVars.paddingMd.rpx,
    );
  }

  const FlanImagePreviewThemeData.raw({
    required this.indexTextColor,
    required this.indexFontSize,
    required this.indexLineHeight,
    required this.indexTextShadow,
    required this.overlayBackgroundColor,
    required this.closeIconSize,
    required this.closeIconColor,
    required this.closeIconActiveColor,
    required this.closeIconMargin,
  });

  final Color indexTextColor;
  final double indexFontSize;
  final double indexLineHeight;
  final List<BoxShadow> indexTextShadow;
  final Color overlayBackgroundColor;
  final double closeIconSize;
  final Color closeIconColor;
  final Color closeIconActiveColor;
  final double closeIconMargin;

  FlanImagePreviewThemeData copyWith({
    Color? indexTextColor,
    double? indexFontSize,
    double? indexLineHeight,
    List<BoxShadow>? indexTextShadow,
    Color? overlayBackgroundColor,
    double? closeIconSize,
    Color? closeIconColor,
    Color? closeIconActiveColor,
    double? closeIconMargin,
  }) {
    return FlanImagePreviewThemeData(
      indexTextColor: indexTextColor ?? this.indexTextColor,
      indexFontSize: indexFontSize ?? this.indexFontSize,
      indexLineHeight: indexLineHeight ?? this.indexLineHeight,
      indexTextShadow: indexTextShadow ?? this.indexTextShadow,
      overlayBackgroundColor:
          overlayBackgroundColor ?? this.overlayBackgroundColor,
      closeIconSize: closeIconSize ?? this.closeIconSize,
      closeIconColor: closeIconColor ?? this.closeIconColor,
      closeIconActiveColor: closeIconActiveColor ?? this.closeIconActiveColor,
      closeIconMargin: closeIconMargin ?? this.closeIconMargin,
    );
  }

  FlanImagePreviewThemeData merge(FlanImagePreviewThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      indexTextColor: other.indexTextColor,
      indexFontSize: other.indexFontSize,
      indexLineHeight: other.indexLineHeight,
      indexTextShadow: other.indexTextShadow,
      overlayBackgroundColor: other.overlayBackgroundColor,
      closeIconSize: other.closeIconSize,
      closeIconColor: other.closeIconColor,
      closeIconActiveColor: other.closeIconActiveColor,
      closeIconMargin: other.closeIconMargin,
    );
  }

  static FlanImagePreviewThemeData lerp(
      FlanImagePreviewThemeData? a, FlanImagePreviewThemeData? b, double t) {
    return FlanImagePreviewThemeData(
      indexTextColor: Color.lerp(a?.indexTextColor, b?.indexTextColor, t),
      indexFontSize: lerpDouble(a?.indexFontSize, b?.indexFontSize, t),
      indexLineHeight: lerpDouble(a?.indexLineHeight, b?.indexLineHeight, t),
      indexTextShadow:
          BoxShadow.lerpList(a?.indexTextShadow, b?.indexTextShadow, t),
      overlayBackgroundColor:
          Color.lerp(a?.overlayBackgroundColor, b?.overlayBackgroundColor, t),
      closeIconSize: lerpDouble(a?.closeIconSize, b?.closeIconSize, t),
      closeIconColor: Color.lerp(a?.closeIconColor, b?.closeIconColor, t),
      closeIconActiveColor:
          Color.lerp(a?.closeIconActiveColor, b?.closeIconActiveColor, t),
      closeIconMargin: lerpDouble(a?.closeIconMargin, b?.closeIconMargin, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      indexTextColor,
      indexFontSize,
      indexLineHeight,
      indexTextShadow,
      overlayBackgroundColor,
      closeIconSize,
      closeIconColor,
      closeIconActiveColor,
      closeIconMargin,
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
    return other is FlanImagePreviewThemeData &&
        other.indexTextColor == indexTextColor &&
        other.indexFontSize == indexFontSize &&
        other.indexLineHeight == indexLineHeight &&
        other.indexTextShadow == indexTextShadow &&
        other.overlayBackgroundColor == overlayBackgroundColor &&
        other.closeIconSize == closeIconSize &&
        other.closeIconColor == closeIconColor &&
        other.closeIconActiveColor == closeIconActiveColor &&
        other.closeIconMargin == closeIconMargin;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Color>('indexTextColor', indexTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('indexFontSize', indexFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'indexLineHeight', indexLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<List<BoxShadow>>(
        'indexTextShadow', indexTextShadow,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'overlayBackgroundColor', overlayBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('closeIconSize', closeIconSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('closeIconColor', closeIconColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'closeIconActiveColor', closeIconActiveColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'closeIconMargin', closeIconMargin,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
