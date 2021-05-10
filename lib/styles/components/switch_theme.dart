import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import '../theme.dart';
import '../var.dart';

class FlanSwitchTheme extends InheritedTheme {
  const FlanSwitchTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FlanSwitchThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FlanSwitchTheme(
          key: key,
          data: FlanSwitchTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FlanSwitchThemeData data;

  static FlanSwitchThemeData of(BuildContext context) {
    final FlanSwitchTheme? switchTheme =
        context.dependOnInheritedWidgetOfExactType<FlanSwitchTheme>();
    return switchTheme?.data ?? FlanTheme.of(context).switchTheme;
  }

  @override
  bool updateShouldNotify(FlanSwitchTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlanSwitchTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FlanSwitchThemeData with Diagnosticable {
  factory FlanSwitchThemeData({
    double? size,
    double? width,
    double? height,
    double? nodeSize,
    Color? nodeBackgroundColor,
    List<BoxShadow>? nodeBoxShadow,
    Color? backgroundColor,
    Color? onBackgroundColor,
    Duration? transitionDuration,
    double? disabledOpacity,
    BorderSide? border,
  }) {
    return FlanSwitchThemeData.raw(
      size: size ?? 30.0.rpx,
      width: width ?? 2.0,
      height: height ?? 1.0,
      nodeSize: nodeSize ?? 1.0,
      nodeBackgroundColor: nodeBackgroundColor ?? FlanThemeVars.white,
      nodeBoxShadow: nodeBoxShadow ??
          <BoxShadow>[
            BoxShadow(
              offset: Offset(0.0, 3.0.rpx),
              blurRadius: 1.0.rpx,
              spreadRadius: 0.0,
              color: const Color.fromRGBO(0, 0, 0, 0.05),
            ),
            BoxShadow(
              offset: Offset(0.0, 2.0.rpx),
              blurRadius: 2.0.rpx,
              spreadRadius: 0.0,
              color: const Color.fromRGBO(0, 0, 0, 0.1),
            ),
            BoxShadow(
              offset: Offset(0.0, 3.0.rpx),
              blurRadius: 3.0.rpx,
              spreadRadius: 0.0,
              color: const Color.fromRGBO(0, 0, 0, 0.05),
            ),
          ],
      backgroundColor: backgroundColor ?? FlanThemeVars.white,
      onBackgroundColor: onBackgroundColor ?? FlanThemeVars.blue,
      transitionDuration:
          transitionDuration ?? FlanThemeVars.animationDurationBase,
      disabledOpacity: disabledOpacity ?? FlanThemeVars.disabledOpacity.rpx,
      border: border ??
          BorderSide(
            width: FlanThemeVars.borderWidthBase.rpx,
            style: BorderStyle.solid,
            color: const Color.fromRGBO(0, 0, 0, .1),
          ),
    );
  }

  const FlanSwitchThemeData.raw({
    required this.size,
    required this.width,
    required this.height,
    required this.nodeSize,
    required this.nodeBackgroundColor,
    required this.nodeBoxShadow,
    required this.backgroundColor,
    required this.onBackgroundColor,
    required this.transitionDuration,
    required this.disabledOpacity,
    required this.border,
  });

  final double size;
  final double width;
  final double height;
  final double nodeSize;
  final Color nodeBackgroundColor;
  final List<BoxShadow>? nodeBoxShadow;
  final Color backgroundColor;
  final Color onBackgroundColor;
  final Duration transitionDuration;
  final double disabledOpacity;
  final BorderSide border;

  FlanSwitchThemeData copyWith({
    double? size,
    double? width,
    double? height,
    double? nodeSize,
    Color? nodeBackgroundColor,
    List<BoxShadow>? nodeBoxShadow,
    Color? backgroundColor,
    Color? onBackgroundColor,
    Duration? transitionDuration,
    double? disabledOpacity,
    BorderSide? border,
  }) {
    return FlanSwitchThemeData(
      size: size ?? this.size,
      width: width ?? this.width,
      height: height ?? this.height,
      nodeSize: nodeSize ?? this.nodeSize,
      nodeBackgroundColor: nodeBackgroundColor ?? this.nodeBackgroundColor,
      nodeBoxShadow: nodeBoxShadow ?? this.nodeBoxShadow,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      onBackgroundColor: onBackgroundColor ?? this.onBackgroundColor,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
      border: border ?? this.border,
    );
  }

  FlanSwitchThemeData merge(FlanSwitchThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      size: other.size,
      width: other.width,
      height: other.height,
      nodeSize: other.nodeSize,
      nodeBackgroundColor: other.nodeBackgroundColor,
      nodeBoxShadow: other.nodeBoxShadow,
      backgroundColor: other.backgroundColor,
      onBackgroundColor: other.onBackgroundColor,
      transitionDuration: other.transitionDuration,
      disabledOpacity: other.disabledOpacity,
      border: other.border,
    );
  }

  static FlanSwitchThemeData lerp(
      FlanSwitchThemeData? a, FlanSwitchThemeData? b, double t) {
    return FlanSwitchThemeData(
      size: lerpDouble(a?.size, b?.size, t),
      width: lerpDouble(a?.width, b?.width, t),
      height: lerpDouble(a?.height, b?.height, t),
      nodeSize: lerpDouble(a?.nodeSize, b?.nodeSize, t),
      nodeBackgroundColor:
          Color.lerp(a?.nodeBackgroundColor, b?.nodeBackgroundColor, t),
      nodeBoxShadow: BoxShadow.lerpList(a?.nodeBoxShadow, b?.nodeBoxShadow, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      onBackgroundColor:
          Color.lerp(a?.onBackgroundColor, b?.onBackgroundColor, t),
      transitionDuration: lerpDuration(a?.transitionDuration ?? Duration.zero,
          b?.transitionDuration ?? Duration.zero, t),
      disabledOpacity: lerpDouble(a?.disabledOpacity, b?.disabledOpacity, t),
      border: BorderSide.lerp(
          a?.border ?? BorderSide.none, b?.border ?? BorderSide.none, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      size,
      width,
      height,
      nodeSize,
      nodeBackgroundColor,
      nodeBoxShadow,
      backgroundColor,
      onBackgroundColor,
      transitionDuration,
      disabledOpacity,
      border,
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
    return other is FlanSwitchThemeData &&
        other.size == size &&
        other.width == width &&
        other.height == height &&
        other.nodeSize == nodeSize &&
        other.nodeBackgroundColor == nodeBackgroundColor &&
        other.nodeBoxShadow == nodeBoxShadow &&
        other.backgroundColor == backgroundColor &&
        other.onBackgroundColor == onBackgroundColor &&
        other.transitionDuration == transitionDuration &&
        other.disabledOpacity == disabledOpacity &&
        other.border == border;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('size', size, defaultValue: null));
    properties
        .add(DiagnosticsProperty<double>('width', width, defaultValue: null));
    properties
        .add(DiagnosticsProperty<double>('height', height, defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('nodeSize', nodeSize, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'nodeBackgroundColor', nodeBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<List<BoxShadow>>(
        'nodeBoxShadow', nodeBoxShadow,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'onBackgroundColor', onBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Duration>(
        'transitionDuration', transitionDuration,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'disabledOpacity', disabledOpacity,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<BorderSide>('border', border, defaultValue: null));
    super.debugFillProperties(properties);
  }
}
