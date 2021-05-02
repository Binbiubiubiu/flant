import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanContactCardTheme extends InheritedTheme {
  const FlanContactCardTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanContactCardThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanContactCardTheme(
          key: key,
          data: FlanContactCardTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanContactCardThemeData data;

  static FlanContactCardThemeData of(BuildContext context) {
    final FlanContactCardTheme? contactCardTheme =
        context.dependOnInheritedWidgetOfExactType<FlanContactCardTheme>();
    return contactCardTheme?.data ?? FlanTheme.of(context).contactCardTheme;
  }

  @override
  bool updateShouldNotify(FlanContactCardTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanContactCardTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanContactCardThemeData with Diagnosticable {
  factory FlanContactCardThemeData({
    double? padding,
    double? addIconSize,
    Color? addIconColor,
    double? valueLineHeight,
  }) {
    return FlanContactCardThemeData.raw(
      padding: padding ?? FlanThemeVars.paddingMd.rpx,
      addIconSize: addIconSize ?? 40.0.rpx,
      addIconColor: addIconColor ?? FlanThemeVars.blue,
      valueLineHeight: valueLineHeight ??
          (FlanThemeVars.lineHeightMd / FlanThemeVars.fontSizeMd).rpx,
    );
  }

  const FlanContactCardThemeData.raw({
    required this.padding,
    required this.addIconSize,
    required this.addIconColor,
    required this.valueLineHeight,
  });

  final double padding;
  final double addIconSize;
  final Color addIconColor;
  final double valueLineHeight;

  FlanContactCardThemeData copyWith({
    double? padding,
    double? addIconSize,
    Color? addIconColor,
    double? valueLineHeight,
  }) {
    return FlanContactCardThemeData(
      padding: padding ?? this.padding,
      addIconSize: addIconSize ?? this.addIconSize,
      addIconColor: addIconColor ?? this.addIconColor,
      valueLineHeight: valueLineHeight ?? this.valueLineHeight,
    );
  }

  FlanContactCardThemeData merge(FlanContactCardThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      padding: other.padding,
      addIconSize: other.addIconSize,
      addIconColor: other.addIconColor,
      valueLineHeight: other.valueLineHeight,
    );
  }

  static FlanContactCardThemeData lerp(
      FlanContactCardThemeData? a, FlanContactCardThemeData? b, double t) {
    return FlanContactCardThemeData(
      padding: lerpDouble(a?.padding, b?.padding, t),
      addIconSize: lerpDouble(a?.addIconSize, b?.addIconSize, t),
      addIconColor: Color.lerp(a?.addIconColor, b?.addIconColor, t),
      valueLineHeight: lerpDouble(a?.valueLineHeight, b?.valueLineHeight, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      padding,
      addIconSize,
      addIconColor,
      valueLineHeight,
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
    return other is FlanContactCardThemeData &&
        other.padding == padding &&
        other.addIconSize == addIconSize &&
        other.addIconColor == addIconColor &&
        other.valueLineHeight == valueLineHeight;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<double>('padding', padding, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('addIconSize', addIconSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('addIconColor', addIconColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'valueLineHeight', valueLineHeight,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
