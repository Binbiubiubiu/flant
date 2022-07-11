import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanButtonTheme extends InheritedTheme {
  const FlanButtonTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanButtonThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanButtonTheme(
          key: key,
          data: FlanButtonTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanButtonThemeData data;

  static FlanButtonThemeData of(BuildContext context) {
    final FlanButtonTheme? buttonTheme =
        context.dependOnInheritedWidgetOfExactType<FlanButtonTheme>();
    return buttonTheme?.data ?? FlanTheme.of(context).buttonTheme;
  }

  @override
  bool updateShouldNotify(FlanButtonTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanButtonTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanButtonThemeData with Diagnosticable {
  factory FlanButtonThemeData({
    double? miniHeight,
    EdgeInsets? miniPadding,
    double? miniFontSize,
    double? smallHeight,
    EdgeInsets? smallPadding,
    double? smallFontSize,
    EdgeInsets? normalPadding,
    double? normalFontSize,
    double? largeHeight,
    double? defaultHeight,
    double? defaultLineHeight,
    double? defaultFontSize,
    Color? defaultColor,
    Color? defaultBackgroundColor,
    Color? defaultBorderColor,
    Color? primaryColor,
    Color? primaryBackgroundColor,
    Color? primaryBorderColor,
    Color? successColor,
    Color? successBackgroundColor,
    Color? successBorderColor,
    Color? dangerColor,
    Color? dangerBackgroundColor,
    Color? dangerBorderColor,
    Color? warningColor,
    Color? warningBackgroundColor,
    Color? warningBorderColor,
    double? borderWidth,
    double? borderRadius,
    double? roundBorderRadius,
    Color? plainBackgroundColor,
    double? disabledOpacity,
    double? iconSize,
    double? loadingIconSize,
  }) {
    return FlanButtonThemeData.raw(
      miniHeight: miniHeight ?? 24.0.rpx,
      miniPadding: miniPadding ??
          EdgeInsets.symmetric(horizontal: FlanThemeVars.paddingBase.rpx),
      miniFontSize: miniFontSize ?? FlanThemeVars.fontSizeXs.rpx,
      smallHeight: smallHeight ?? 32.0.rpx,
      smallPadding: smallPadding ??
          EdgeInsets.symmetric(horizontal: FlanThemeVars.paddingXs.rpx),
      smallFontSize: smallFontSize ?? FlanThemeVars.fontSizeSm.rpx,
      normalPadding:
          normalPadding ?? EdgeInsets.symmetric(horizontal: 15.0.rpx),
      normalFontSize: normalFontSize ?? FlanThemeVars.fontSizeMd.rpx,
      largeHeight: largeHeight ?? 50.0.rpx,
      defaultHeight: defaultHeight ?? 44.0.rpx,
      defaultLineHeight: defaultLineHeight ?? 1.2,
      defaultFontSize: defaultFontSize ?? FlanThemeVars.fontSizeLg.rpx,
      defaultColor: defaultColor ?? FlanThemeVars.textColor,
      defaultBackgroundColor: defaultBackgroundColor ?? FlanThemeVars.white,
      defaultBorderColor: defaultBorderColor ?? FlanThemeVars.borderColor,
      primaryColor: primaryColor ?? FlanThemeVars.white,
      primaryBackgroundColor: primaryBackgroundColor ?? FlanThemeVars.blue,
      primaryBorderColor: primaryBorderColor ?? FlanThemeVars.blue,
      successColor: successColor ?? FlanThemeVars.white,
      successBackgroundColor: successBackgroundColor ?? FlanThemeVars.green,
      successBorderColor: successBorderColor ?? FlanThemeVars.green,
      dangerColor: dangerColor ?? FlanThemeVars.white,
      dangerBackgroundColor: dangerBackgroundColor ?? FlanThemeVars.red,
      dangerBorderColor: dangerBorderColor ?? FlanThemeVars.red,
      warningColor: warningColor ?? FlanThemeVars.white,
      warningBackgroundColor: warningBackgroundColor ?? FlanThemeVars.orange,
      warningBorderColor: warningBorderColor ?? FlanThemeVars.orange,
      borderWidth: borderWidth ?? FlanThemeVars.borderWidthBase.rpx,
      borderRadius: borderRadius ?? FlanThemeVars.borderRadiusSm.rpx,
      roundBorderRadius: roundBorderRadius ?? FlanThemeVars.borderRadiusMax.rpx,
      plainBackgroundColor: plainBackgroundColor ?? FlanThemeVars.white,
      disabledOpacity: disabledOpacity ?? FlanThemeVars.disabledOpacity,
      iconSize: iconSize ?? (FlanThemeVars.fontSizeLg * 1.2).rpx,
      loadingIconSize: loadingIconSize ?? 20.0.rpx,
    );
  }

  const FlanButtonThemeData.raw({
    required this.miniHeight,
    required this.miniPadding,
    required this.miniFontSize,
    required this.smallHeight,
    required this.smallPadding,
    required this.smallFontSize,
    required this.normalPadding,
    required this.normalFontSize,
    required this.largeHeight,
    required this.defaultHeight,
    required this.defaultLineHeight,
    required this.defaultFontSize,
    required this.defaultColor,
    required this.defaultBackgroundColor,
    required this.defaultBorderColor,
    required this.primaryColor,
    required this.primaryBackgroundColor,
    required this.primaryBorderColor,
    required this.successColor,
    required this.successBackgroundColor,
    required this.successBorderColor,
    required this.dangerColor,
    required this.dangerBackgroundColor,
    required this.dangerBorderColor,
    required this.warningColor,
    required this.warningBackgroundColor,
    required this.warningBorderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.roundBorderRadius,
    required this.plainBackgroundColor,
    required this.disabledOpacity,
    required this.iconSize,
    required this.loadingIconSize,
  });

  final double miniHeight;
  final EdgeInsets miniPadding;
  final double miniFontSize;
  final double smallHeight;
  final EdgeInsets smallPadding;
  final double smallFontSize;
  final EdgeInsets normalPadding;
  final double normalFontSize;
  final double largeHeight;
  final double defaultHeight;
  final double defaultLineHeight;
  final double defaultFontSize;
  final Color defaultColor;
  final Color defaultBackgroundColor;
  final Color defaultBorderColor;
  final Color primaryColor;
  final Color primaryBackgroundColor;
  final Color primaryBorderColor;
  final Color successColor;
  final Color successBackgroundColor;
  final Color successBorderColor;
  final Color dangerColor;
  final Color dangerBackgroundColor;
  final Color dangerBorderColor;
  final Color warningColor;
  final Color warningBackgroundColor;
  final Color warningBorderColor;
  final double borderWidth;
  final double borderRadius;
  final double roundBorderRadius;
  final Color plainBackgroundColor;
  final double disabledOpacity;
  final double iconSize;
  final double loadingIconSize;

  FlanButtonThemeData copyWith({
    double? miniHeight,
    EdgeInsets? miniPadding,
    double? miniFontSize,
    double? smallHeight,
    EdgeInsets? smallPadding,
    double? smallFontSize,
    EdgeInsets? normalPadding,
    double? normalFontSize,
    double? largeHeight,
    double? defaultHeight,
    double? defaultLineHeight,
    double? defaultFontSize,
    Color? defaultColor,
    Color? defaultBackgroundColor,
    Color? defaultBorderColor,
    Color? primaryColor,
    Color? primaryBackgroundColor,
    Color? primaryBorderColor,
    Color? successColor,
    Color? successBackgroundColor,
    Color? successBorderColor,
    Color? dangerColor,
    Color? dangerBackgroundColor,
    Color? dangerBorderColor,
    Color? warningColor,
    Color? warningBackgroundColor,
    Color? warningBorderColor,
    double? borderWidth,
    double? borderRadius,
    double? roundBorderRadius,
    Color? plainBackgroundColor,
    double? disabledOpacity,
    double? iconSize,
    double? loadingIconSize,
  }) {
    return FlanButtonThemeData(
      miniHeight: miniHeight ?? this.miniHeight,
      miniPadding: miniPadding ?? this.miniPadding,
      miniFontSize: miniFontSize ?? this.miniFontSize,
      smallHeight: smallHeight ?? this.smallHeight,
      smallPadding: smallPadding ?? this.smallPadding,
      smallFontSize: smallFontSize ?? this.smallFontSize,
      normalPadding: normalPadding ?? this.normalPadding,
      normalFontSize: normalFontSize ?? this.normalFontSize,
      largeHeight: largeHeight ?? this.largeHeight,
      defaultHeight: defaultHeight ?? this.defaultHeight,
      defaultLineHeight: defaultLineHeight ?? this.defaultLineHeight,
      defaultFontSize: defaultFontSize ?? this.defaultFontSize,
      defaultColor: defaultColor ?? this.defaultColor,
      defaultBackgroundColor:
          defaultBackgroundColor ?? this.defaultBackgroundColor,
      defaultBorderColor: defaultBorderColor ?? this.defaultBorderColor,
      primaryColor: primaryColor ?? this.primaryColor,
      primaryBackgroundColor:
          primaryBackgroundColor ?? this.primaryBackgroundColor,
      primaryBorderColor: primaryBorderColor ?? this.primaryBorderColor,
      successColor: successColor ?? this.successColor,
      successBackgroundColor:
          successBackgroundColor ?? this.successBackgroundColor,
      successBorderColor: successBorderColor ?? this.successBorderColor,
      dangerColor: dangerColor ?? this.dangerColor,
      dangerBackgroundColor:
          dangerBackgroundColor ?? this.dangerBackgroundColor,
      dangerBorderColor: dangerBorderColor ?? this.dangerBorderColor,
      warningColor: warningColor ?? this.warningColor,
      warningBackgroundColor:
          warningBackgroundColor ?? this.warningBackgroundColor,
      warningBorderColor: warningBorderColor ?? this.warningBorderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      roundBorderRadius: roundBorderRadius ?? this.roundBorderRadius,
      plainBackgroundColor: plainBackgroundColor ?? this.plainBackgroundColor,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
      iconSize: iconSize ?? this.iconSize,
      loadingIconSize: loadingIconSize ?? this.loadingIconSize,
    );
  }

  FlanButtonThemeData merge(FlanButtonThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      miniHeight: other.miniHeight,
      miniPadding: other.miniPadding,
      miniFontSize: other.miniFontSize,
      smallHeight: other.smallHeight,
      smallPadding: other.smallPadding,
      smallFontSize: other.smallFontSize,
      normalPadding: other.normalPadding,
      normalFontSize: other.normalFontSize,
      largeHeight: other.largeHeight,
      defaultHeight: other.defaultHeight,
      defaultLineHeight: other.defaultLineHeight,
      defaultFontSize: other.defaultFontSize,
      defaultColor: other.defaultColor,
      defaultBackgroundColor: other.defaultBackgroundColor,
      defaultBorderColor: other.defaultBorderColor,
      primaryColor: other.primaryColor,
      primaryBackgroundColor: other.primaryBackgroundColor,
      primaryBorderColor: other.primaryBorderColor,
      successColor: other.successColor,
      successBackgroundColor: other.successBackgroundColor,
      successBorderColor: other.successBorderColor,
      dangerColor: other.dangerColor,
      dangerBackgroundColor: other.dangerBackgroundColor,
      dangerBorderColor: other.dangerBorderColor,
      warningColor: other.warningColor,
      warningBackgroundColor: other.warningBackgroundColor,
      warningBorderColor: other.warningBorderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      roundBorderRadius: other.roundBorderRadius,
      plainBackgroundColor: other.plainBackgroundColor,
      disabledOpacity: other.disabledOpacity,
      iconSize: other.iconSize,
      loadingIconSize: other.loadingIconSize,
    );
  }

  static FlanButtonThemeData lerp(
      FlanButtonThemeData? a, FlanButtonThemeData? b, double t) {
    return FlanButtonThemeData(
      miniHeight: lerpDouble(a?.miniHeight, b?.miniHeight, t),
      miniPadding: EdgeInsets.lerp(a?.miniPadding, b?.miniPadding, t),
      miniFontSize: lerpDouble(a?.miniFontSize, b?.miniFontSize, t),
      smallHeight: lerpDouble(a?.smallHeight, b?.smallHeight, t),
      smallPadding: EdgeInsets.lerp(a?.smallPadding, b?.smallPadding, t),
      smallFontSize: lerpDouble(a?.smallFontSize, b?.smallFontSize, t),
      normalPadding: EdgeInsets.lerp(a?.normalPadding, b?.normalPadding, t),
      normalFontSize: lerpDouble(a?.normalFontSize, b?.normalFontSize, t),
      largeHeight: lerpDouble(a?.largeHeight, b?.largeHeight, t),
      defaultHeight: lerpDouble(a?.defaultHeight, b?.defaultHeight, t),
      defaultLineHeight:
          lerpDouble(a?.defaultLineHeight, b?.defaultLineHeight, t),
      defaultFontSize: lerpDouble(a?.defaultFontSize, b?.defaultFontSize, t),
      defaultColor: Color.lerp(a?.defaultColor, b?.defaultColor, t),
      defaultBackgroundColor:
          Color.lerp(a?.defaultBackgroundColor, b?.defaultBackgroundColor, t),
      defaultBorderColor:
          Color.lerp(a?.defaultBorderColor, b?.defaultBorderColor, t),
      primaryColor: Color.lerp(a?.primaryColor, b?.primaryColor, t),
      primaryBackgroundColor:
          Color.lerp(a?.primaryBackgroundColor, b?.primaryBackgroundColor, t),
      primaryBorderColor:
          Color.lerp(a?.primaryBorderColor, b?.primaryBorderColor, t),
      successColor: Color.lerp(a?.successColor, b?.successColor, t),
      successBackgroundColor:
          Color.lerp(a?.successBackgroundColor, b?.successBackgroundColor, t),
      successBorderColor:
          Color.lerp(a?.successBorderColor, b?.successBorderColor, t),
      dangerColor: Color.lerp(a?.dangerColor, b?.dangerColor, t),
      dangerBackgroundColor:
          Color.lerp(a?.dangerBackgroundColor, b?.dangerBackgroundColor, t),
      dangerBorderColor:
          Color.lerp(a?.dangerBorderColor, b?.dangerBorderColor, t),
      warningColor: Color.lerp(a?.warningColor, b?.warningColor, t),
      warningBackgroundColor:
          Color.lerp(a?.warningBackgroundColor, b?.warningBackgroundColor, t),
      warningBorderColor:
          Color.lerp(a?.warningBorderColor, b?.warningBorderColor, t),
      borderWidth: lerpDouble(a?.borderWidth, b?.borderWidth, t),
      borderRadius: lerpDouble(a?.borderRadius, b?.borderRadius, t),
      roundBorderRadius:
          lerpDouble(a?.roundBorderRadius, b?.roundBorderRadius, t),
      plainBackgroundColor:
          Color.lerp(a?.plainBackgroundColor, b?.plainBackgroundColor, t),
      disabledOpacity: lerpDouble(a?.disabledOpacity, b?.disabledOpacity, t),
      iconSize: lerpDouble(a?.iconSize, b?.iconSize, t),
      loadingIconSize: lerpDouble(a?.loadingIconSize, b?.loadingIconSize, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      miniHeight,
      miniPadding,
      miniFontSize,
      smallHeight,
      smallPadding,
      smallFontSize,
      normalPadding,
      normalFontSize,
      largeHeight,
      defaultHeight,
      defaultLineHeight,
      defaultFontSize,
      defaultColor,
      defaultBackgroundColor,
      defaultBorderColor,
      primaryColor,
      primaryBackgroundColor,
      primaryBorderColor,
      successColor,
      successBackgroundColor,
      successBorderColor,
      dangerColor,
      dangerBackgroundColor,
      dangerBorderColor,
      warningColor,
      warningBackgroundColor,
      warningBorderColor,
      borderWidth,
      borderRadius,
      roundBorderRadius,
      plainBackgroundColor,
      disabledOpacity,
      iconSize,
      loadingIconSize,
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
    return other is FlanButtonThemeData &&
        other.miniHeight == miniHeight &&
        other.miniPadding == miniPadding &&
        other.miniFontSize == miniFontSize &&
        other.smallHeight == smallHeight &&
        other.smallPadding == smallPadding &&
        other.smallFontSize == smallFontSize &&
        other.normalPadding == normalPadding &&
        other.normalFontSize == normalFontSize &&
        other.largeHeight == largeHeight &&
        other.defaultHeight == defaultHeight &&
        other.defaultLineHeight == defaultLineHeight &&
        other.defaultFontSize == defaultFontSize &&
        other.defaultColor == defaultColor &&
        other.defaultBackgroundColor == defaultBackgroundColor &&
        other.defaultBorderColor == defaultBorderColor &&
        other.primaryColor == primaryColor &&
        other.primaryBackgroundColor == primaryBackgroundColor &&
        other.primaryBorderColor == primaryBorderColor &&
        other.successColor == successColor &&
        other.successBackgroundColor == successBackgroundColor &&
        other.successBorderColor == successBorderColor &&
        other.dangerColor == dangerColor &&
        other.dangerBackgroundColor == dangerBackgroundColor &&
        other.dangerBorderColor == dangerBorderColor &&
        other.warningColor == warningColor &&
        other.warningBackgroundColor == warningBackgroundColor &&
        other.warningBorderColor == warningBorderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.roundBorderRadius == roundBorderRadius &&
        other.plainBackgroundColor == plainBackgroundColor &&
        other.disabledOpacity == disabledOpacity &&
        other.iconSize == iconSize &&
        other.loadingIconSize == loadingIconSize;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<double>('miniHeight', miniHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('miniPadding', miniPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('miniFontSize', miniFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('smallHeight', smallHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('smallPadding', smallPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('smallFontSize', smallFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'normalPadding', normalPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('normalFontSize', normalFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('largeHeight', largeHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('defaultHeight', defaultHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'defaultLineHeight', defaultLineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'defaultFontSize', defaultFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('defaultColor', defaultColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'defaultBackgroundColor', defaultBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'defaultBorderColor', defaultBorderColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('primaryColor', primaryColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'primaryBackgroundColor', primaryBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'primaryBorderColor', primaryBorderColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('successColor', successColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'successBackgroundColor', successBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'successBorderColor', successBorderColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('dangerColor', dangerColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'dangerBackgroundColor', dangerBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'dangerBorderColor', dangerBorderColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('warningColor', warningColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'warningBackgroundColor', warningBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'warningBorderColor', warningBorderColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('borderWidth', borderWidth,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('borderRadius', borderRadius,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'roundBorderRadius', roundBorderRadius,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'plainBackgroundColor', plainBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'disabledOpacity', disabledOpacity,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('iconSize', iconSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'loadingIconSize', loadingIconSize,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
