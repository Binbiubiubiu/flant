// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanEmptyTheme extends InheritedTheme {
  const FlanEmptyTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanEmptyThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanEmptyTheme(
          key: key,
          data: FlanEmptyTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanEmptyThemeData data;

  static FlanEmptyThemeData of(BuildContext context) {
    final FlanEmptyTheme? emptyTheme =
        context.dependOnInheritedWidgetOfExactType<FlanEmptyTheme>();
    return emptyTheme?.data ?? FlanTheme.of(context).emptyTheme;
  }

  @override
  bool updateShouldNotify(FlanEmptyTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanEmptyTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanEmptyThemeData with Diagnosticable {
  factory FlanEmptyThemeData({
    EdgeInsets? padding,
    double? imageSize,
    double? descriptionMarginTop,
    EdgeInsets? descriptionPadding,
    Color? descriptionColor,
    double? descriptionFontSize,
    double? descriptionLineHeight,
    double? bottomMarginTop,
  }) {
    final double _descriptionFontSize =
        descriptionFontSize ?? FlanThemeVars.fontSizeMd.rpx;
    return FlanEmptyThemeData.raw(
      padding: padding ??
          EdgeInsets.symmetric(
              vertical: FlanThemeVars.paddingXl.rpx, horizontal: 0),
      imageSize: imageSize ?? 160.0.rpx,
      descriptionMarginTop: descriptionMarginTop ?? FlanThemeVars.paddingMd.rpx,
      descriptionPadding: descriptionPadding ??
          const EdgeInsets.symmetric(vertical: 0, horizontal: 60.0),
      descriptionColor: descriptionColor ?? FlanThemeVars.gray6,
      descriptionFontSize: _descriptionFontSize,
      descriptionLineHeight: descriptionLineHeight ??
          (FlanThemeVars.lineHeightMd.rpx / _descriptionFontSize),
      bottomMarginTop: bottomMarginTop ?? 24.0.rpx,
    );
  }

  const FlanEmptyThemeData.raw({
    required this.padding,
    required this.imageSize,
    required this.descriptionMarginTop,
    required this.descriptionPadding,
    required this.descriptionColor,
    required this.descriptionFontSize,
    required this.descriptionLineHeight,
    required this.bottomMarginTop,
  });

  final EdgeInsets padding;
  final double imageSize;
  final double descriptionMarginTop;
  final EdgeInsets descriptionPadding;
  final Color descriptionColor;
  final double descriptionFontSize;
  final double descriptionLineHeight;
  final double bottomMarginTop;

  FlanEmptyThemeData copyWith({
    EdgeInsets? padding,
    double? imageSize,
    double? descriptionMarginTop,
    EdgeInsets? descriptionPadding,
    Color? descriptionColor,
    double? descriptionFontSize,
    double? descriptionLineHeight,
    double? bottomMarginTop,
  }) {
    return FlanEmptyThemeData(
      padding: padding ?? this.padding,
      imageSize: imageSize ?? this.imageSize,
      descriptionMarginTop: descriptionMarginTop ?? this.descriptionMarginTop,
      descriptionPadding: descriptionPadding ?? this.descriptionPadding,
      descriptionColor: descriptionColor ?? this.descriptionColor,
      descriptionFontSize: descriptionFontSize ?? this.descriptionFontSize,
      descriptionLineHeight:
          descriptionLineHeight ?? this.descriptionLineHeight,
      bottomMarginTop: bottomMarginTop ?? this.bottomMarginTop,
    );
  }

  FlanEmptyThemeData merge(FlanEmptyThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      padding: other.padding,
      imageSize: other.imageSize,
      descriptionMarginTop: other.descriptionMarginTop,
      descriptionPadding: other.descriptionPadding,
      descriptionColor: other.descriptionColor,
      descriptionFontSize: other.descriptionFontSize,
      descriptionLineHeight: other.descriptionLineHeight,
      bottomMarginTop: other.bottomMarginTop,
    );
  }

  static FlanEmptyThemeData lerp(
      FlanEmptyThemeData? a, FlanEmptyThemeData? b, double t) {
    return FlanEmptyThemeData(
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      imageSize: lerpDouble(a?.imageSize, b?.imageSize, t),
      descriptionMarginTop:
          lerpDouble(a?.descriptionMarginTop, b?.descriptionMarginTop, t),
      descriptionPadding:
          EdgeInsets.lerp(a?.descriptionPadding, b?.descriptionPadding, t),
      descriptionColor: Color.lerp(a?.descriptionColor, b?.descriptionColor, t),
      descriptionFontSize:
          lerpDouble(a?.descriptionFontSize, b?.descriptionFontSize, t),
      descriptionLineHeight:
          lerpDouble(a?.descriptionLineHeight, b?.descriptionLineHeight, t),
      bottomMarginTop: lerpDouble(a?.bottomMarginTop, b?.bottomMarginTop, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      padding,
      imageSize,
      descriptionMarginTop,
      descriptionPadding,
      descriptionColor,
      descriptionFontSize,
      descriptionLineHeight,
      bottomMarginTop,
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
    return other is FlanEmptyThemeData &&
        other.padding == padding &&
        other.imageSize == imageSize &&
        other.descriptionMarginTop == descriptionMarginTop &&
        other.descriptionPadding == descriptionPadding &&
        other.descriptionColor == descriptionColor &&
        other.descriptionFontSize == descriptionFontSize &&
        other.descriptionLineHeight == descriptionLineHeight &&
        other.bottomMarginTop == bottomMarginTop;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('imageSize', imageSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'descriptionMarginTop', descriptionMarginTop,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'descriptionPadding', descriptionPadding,
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
    properties.add(DiagnosticsProperty<double>(
        'bottomMarginTop', bottomMarginTop,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
