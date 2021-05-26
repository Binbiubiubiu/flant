// 🐦 Flutter imports:
import 'dart:async';

import 'package:flant/flant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/components/notify_theme.dart';
import '../styles/theme.dart';
import 'common/custom_entry.dart';
import 'style.dart';

CustomOverlayEntry? _instance;

class FlanNotifyOption {
  const FlanNotifyOption({
    // this.type = FlanNotifyType.primary,
    this.message = '',
    this.duration = const Duration(seconds: 3),
    this.color,
    this.background,
    this.lockScroll = false,
    this.customStyle,
    this.onClick,
    this.onClose,
    this.onOpened,
  });

  // final FlanNotifyType type;
  final String message;
  final Duration duration;
  final Color? color;
  final Color? background;
  final bool lockScroll;
  final BoxDecoration? customStyle;
  final VoidCallback? onClick;
  final VoidCallback? onOpened;
  final VoidCallback? onClose;

  FlanNotifyOption merge(FlanNotifyOption? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      // type: other.type,
      message: other.message,
      duration: other.duration,
      color: other.color,
      background: other.background,
      lockScroll: other.lockScroll,
      customStyle: other.customStyle,
      onClick: other.onClick,
      onOpened: other.onOpened,
      onClose: other.onClose,
    );
  }

  FlanNotifyOption copyWith({
    // FlanNotifyType? type,
    String? message,
    Duration? duration,
    Color? color,
    Color? background,
    BoxDecoration? customStyle,
    bool? lockScroll,
    VoidCallback? onClick,
    VoidCallback? onOpened,
    VoidCallback? onClose,
  }) {
    return FlanNotifyOption(
      // type: type ?? this.type,
      message: message ?? this.message,
      duration: duration ?? this.duration,
      color: color ?? this.color,
      background: background ?? this.background,
      customStyle: customStyle ?? this.customStyle,
      lockScroll: lockScroll ?? this.lockScroll,
      onClick: onClick ?? this.onClick,
      onOpened: onOpened ?? this.onOpened,
      onClose: onClose ?? this.onClose,
    );
  }
}

class FlanNotify {
  factory FlanNotify(
    BuildContext context, {
    FlanNotifyType? type,
    Duration? duration,
    String? message,
    Color? color,
    Color? background,
    BoxDecoration? customStyle,
    bool? lockScroll,
    VoidCallback? onClick,
    VoidCallback? onOpened,
    VoidCallback? onClose,
    Widget? child,
  }) {
    final FlanNotifyType _type = type ?? FlanNotifyType.primary;
    final FlanNotifyOption _defaultOption = FlanNotify.currentOptions;

    void open([String? msg]) {
      final Widget notify = UnconstrainedBox(
        child: child ??
            FlanNotifyWidget(
              type: _type,
              message: msg ?? message ?? _defaultOption.message,
              color: color ?? _defaultOption.color,
              background: background ?? _defaultOption.background,
              customStyle: customStyle ?? _defaultOption.customStyle,
              onClick: onClick ?? _defaultOption.onClick,
            ),
      );

      duration ??= _defaultOption.duration;
      if (_instance != null) {
        _instance!.update(notify, duration!);
        return;
      }
      void watchToastOpen() {
        onOpened ??= _defaultOption.onOpened;
        if (onOpened != null) {
          onOpened!();
        }
        if (duration != Duration.zero) {
          _instance?.timer = Timer(duration!, () {
            _instance?.close();
          });
        }
      }

      void watchToastClose() {
        _instance
          ?..removeListener(watchToastOpen)
          ..remove();
        _instance = null;

        onClose ??= _defaultOption.onClose;
        if (onClose != null) {
          onClose!();
        }
      }

      _instance = CustomOverlayEntry(
        lockScroll: lockScroll ?? _defaultOption.lockScroll,
        layoutBuilder: (BuildContext context, Widget child) {
          return Align(
            alignment: Alignment.topCenter,
            child: child,
          );
        },
        transitionBuilder: (BuildContext context, bool visible, Widget? child) {
          return FlanTransitionVisiable(
            transitionBuilder: kFlanSlideDownTransitionBuilder,
            visible: visible,
            duration: const Duration(milliseconds: 200),
            appear: true,
            onDismissed: watchToastClose,
            child: child!,
          );
        },
        child: notify,
      );
      _instance!.addListener(watchToastOpen);
      Overlay.of(context, rootOverlay: true)?.insert(_instance!);
    }

    open();
    return const FlanNotify._();
  }

  const FlanNotify._();

  static void setDefaultOptions(FlanNotifyOption other) {
    FlanNotify.currentOptions = FlanNotify.currentOptions.merge(other);
  }

  static void resetDefaultOptions() {
    FlanNotify.currentOptions = const FlanNotifyOption();
  }

  static void clear() {
    if (_instance != null) {
      _instance!.close();
      _instance = null;
    }
  }

  static FlanNotifyOption currentOptions = const FlanNotifyOption();
}

class FlanNotifyWidget extends StatelessWidget {
  const FlanNotifyWidget({
    Key? key,
    required this.type,
    this.message = '',
    this.color,
    this.background,
    this.customStyle,
    this.safeTopArea = true,
    this.onClick,
    this.child,
  })  : assert(type is FlanNotifyType),
        super(key: key);

  // ****************** Props ******************

  /// 类型，可选值为 `primary` `success` `warning` `danger`
  final FlanNotifyType type;

  /// 文本内容,支持通过`\n`换行
  final String message;

  /// 字体颜色
  final Color? color;

  /// 背景颜色
  final Color? background;

  /// 自定义样式,使用`background`和默认样式会失效
  final BoxDecoration? customStyle;

  /// 顶部 安全区域
  final bool safeTopArea;

  // ****************** Events ******************
  final VoidCallback? onClick;

  // ****************** Slots ******************
  /// 内容
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final FlanNotifyThemeData themeData = FlanTheme.of(context).notifyTheme;
    final double maxWidth = MediaQuery.of(context).size.width;
    final Color textColor = color ?? themeData.textColor;

    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: maxWidth,
        decoration: customStyle ??
            BoxDecoration(
              color: background ?? getBgColor(themeData),
            ),
        padding: themeData.padding,
        alignment: Alignment.center,
        child: SafeArea(
          top: safeTopArea,
          left: false,
          right: false,
          bottom: false,
          child: DefaultTextStyle(
            style: TextStyle(
              color: textColor,
              fontSize: themeData.fontSize,
              height: themeData.lineHeight,
            ),
            child: child != null
                ? IconTheme(
                    data: IconThemeData(
                      color: textColor,
                      size: themeData.fontSize,
                    ),
                    child: child!,
                  )
                : Text(
                    message,
                    textAlign: TextAlign.center,
                    textHeightBehavior: FlanThemeVars.textHeightBehavior,
                  ),
          ),
        ),
      ),
    );
  }

  Color getBgColor(FlanNotifyThemeData themeData) {
    switch (type) {
      case FlanNotifyType.primary:
        return themeData.primaryBackgroundColor;
      case FlanNotifyType.success:
        return themeData.successBackgroundColor;
      case FlanNotifyType.warning:
        return themeData.warningBackgroundColor;
      case FlanNotifyType.danger:
        return themeData.dangerBackgroundColor;
    }
  }
}

/// Toast类型集合
enum FlanNotifyType {
  primary,
  success,
  warning,
  danger,
}
