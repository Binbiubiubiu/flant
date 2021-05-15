// 🐦 Flutter imports:
import 'dart:async';

import 'package:flant/flant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/components/toast_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'icon.dart';
import 'loading.dart';
import 'style.dart';

List<CustomOverlayEntry> _queue = <CustomOverlayEntry>[];
bool _allowMultiple = false;
Map<FlanToastType, FlanToastOption> _defaultOptions =
    <FlanToastType, FlanToastOption>{
  FlanToastType.fail: const FlanToastOption(),
  FlanToastType.success: const FlanToastOption(),
  FlanToastType.text: const FlanToastOption(),
  FlanToastType.loading: const FlanToastOption(),
};

FlanToastOption _getDefaultOption(FlanToastType type) {
  return _defaultOptions[type] ?? const FlanToastOption();
}

class FlanToastOption {
  const FlanToastOption({
    // this.type = FlanToastType.text,
    this.position = FlanToastPosition.middle,
    this.message = '',
    this.iconName,
    this.iconUrl,
    this.iconSize,
    this.overlay = false,
    this.forbidClick = false,
    this.closeOnClick = false,
    this.closeOnClickOverlay = false,
    this.loadingType = FlanLoadingType.circular,
    this.duration = const Duration(seconds: 2),
    this.transitionBuilder = kFlanFadeTransitionBuilder,
    this.onClose,
    this.onOpened,
  });

  // final FlanToastType type;
  final FlanToastPosition position;
  final String message;
  final IconData? iconName;
  final String? iconUrl;
  final double? iconSize;
  final bool overlay;
  final bool forbidClick;
  final bool closeOnClick;
  final bool closeOnClickOverlay;
  final FlanLoadingType loadingType;
  final Duration duration;
  final FlanTransitionBuilder transitionBuilder;
  final VoidCallback? onOpened;
  final VoidCallback? onClose;

  FlanToastOption merge(FlanToastOption? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      // type: other.type,
      position: other.position,
      message: other.message,
      iconName: other.iconName,
      iconUrl: other.iconUrl,
      iconSize: other.iconSize,
      overlay: other.overlay,
      forbidClick: other.forbidClick,
      closeOnClick: other.closeOnClick,
      closeOnClickOverlay: other.closeOnClickOverlay,
      loadingType: other.loadingType,
      duration: other.duration,
      transitionBuilder: other.transitionBuilder,
      onOpened: other.onOpened,
      onClose: other.onClose,
    );
  }

  FlanToastOption copyWith({
    // FlanToastType? type,
    FlanToastPosition? position,
    String? message,
    IconData? iconName,
    String? iconUrl,
    double? iconSize,
    bool? overlay,
    bool? forbidClick,
    bool? closeOnClick,
    bool? closeOnClickOverlay,
    FlanLoadingType? loadingType,
    Duration? duration,
    FlanTransitionBuilder? transitionBuilder,
    VoidCallback? onOpened,
    VoidCallback? onClose,
  }) {
    return FlanToastOption(
      // type: type ?? this.type,
      position: position ?? this.position,
      message: message ?? this.message,
      iconName: iconName ?? this.iconName,
      iconUrl: iconUrl ?? this.iconUrl,
      iconSize: iconSize ?? this.iconSize,
      overlay: overlay ?? this.overlay,
      forbidClick: forbidClick ?? this.forbidClick,
      closeOnClick: closeOnClick ?? this.closeOnClick,
      closeOnClickOverlay: closeOnClickOverlay ?? this.closeOnClickOverlay,
      loadingType: loadingType ?? this.loadingType,
      duration: duration ?? this.duration,
      transitionBuilder: transitionBuilder ?? this.transitionBuilder,
      onOpened: onOpened ?? this.onOpened,
      onClose: onClose ?? this.onClose,
    );
  }
}

class CustomOverlayEntry extends OverlayEntry {
  factory CustomOverlayEntry({
    required Widget child,
    required ValueWidgetBuilder<bool> transitionBuilder,
  }) {
    final ValueNotifier<bool> visiable = ValueNotifier<bool>(true);
    late CustomOverlayEntry entry;
    entry = CustomOverlayEntry.raw(
      visiable: visiable,
      child: child,
      builder: (BuildContext context) {
        return ValueListenableBuilder<bool>(
          valueListenable: entry.visiable,
          builder: transitionBuilder,
          child: entry.child,
        );
      },
    );
    return entry;
  }

  CustomOverlayEntry.raw({
    required this.visiable,
    required this.child,
    required WidgetBuilder builder,
  }) : super(builder: builder);

  ValueNotifier<bool> visiable;

  Widget child;

  Timer? timer;

  void update(Widget child, Duration duration) {
    clearTimer();

    this.child = child;
    markNeedsBuild();
    if (duration != Duration.zero) {
      timer = Timer(duration, close);
    }
  }

  void clearTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  void close() {
    clearTimer();
    visiable.value = false;
  }

  // @override
  // void remove() {
  //   visiable.dispose();
  //   super.remove();
  // }
}

class FlanToast {
  factory FlanToast(
    BuildContext context, {
    FlanToastType? type,
    FlanToastPosition? position,
    String? message,
    IconData? iconName,
    String? iconUrl,
    double? iconSize,
    bool? overlay,
    bool? forbidClick,
    bool? closeOnClick,
    bool? closeOnClickOverlay,
    FlanLoadingType? loadingType,
    BoxDecoration? toastStyle,
    BoxDecoration? overlayStyle,
    Duration? duration,
    FlanTransitionBuilder? transitionBuilder,
    VoidCallback? onOpened,
    VoidCallback? onClose,
  }) {
    CustomOverlayEntry? entry = FlanToast._getCurrentEntry();

    void close() {
      entry?.close();
    }

    final FlanToastType _type = type ?? FlanToastType.text;
    final FlanToastOption _defaultOption = _getDefaultOption(_type);

    void open([String? msg]) {
      final Widget toast = IgnorePointer(
        ignoring: forbidClick ?? _defaultOption.forbidClick,
        child: FlanToastBlock(
          type: _type,
          position: position ?? _defaultOption.position,
          message: msg ?? message ?? _defaultOption.message,
          iconName: iconName ?? _defaultOption.iconName,
          iconUrl: iconUrl ?? _defaultOption.iconUrl,
          iconSize: iconSize ?? _defaultOption.iconSize,
          overlay: overlay ?? _defaultOption.overlay,
          toastStyle: toastStyle,
          overlayStyle: overlayStyle,
          onClick: (closeOnClick ?? _defaultOption.closeOnClick) ? close : null,
          onClickOverlay:
              (closeOnClickOverlay ?? _defaultOption.closeOnClickOverlay)
                  ? close
                  : null,
          loadingType: loadingType ?? _defaultOption.loadingType,
        ),
      );

      duration ??= const Duration(seconds: 2);
      if (entry != null) {
        entry!.update(toast, duration!);
        return;
      }
      void watchToastOpen() {
        onOpened ??= _defaultOption.onOpened;
        if (onOpened != null) {
          onOpened!();
        }
        if (duration != Duration.zero) {
          entry?.timer = Timer(duration!, () {
            entry?.close();
          });
        }
      }

      void watchToastClose() {
        entry
          ?..removeListener(watchToastOpen)
          ..remove();
        _queue.remove(entry);
        entry = null;

        onClose ??= _defaultOption.onClose;
        if (onClose != null) {
          onClose!();
        }
      }

      entry = CustomOverlayEntry(
        transitionBuilder: (BuildContext context, bool value, Widget? child) {
          return FlanTransitionVisiable(
            transitionBuilder: transitionBuilder ?? kFlanFadeTransitionBuilder,
            visible: value,
            appearAnimatable: true,
            onDismissed: watchToastClose,
            child: child!,
          );
        },
        child: toast,
      );
      entry!.addListener(watchToastOpen);
      Overlay.of(context, rootOverlay: true)?.insert(entry!);
      _queue.add(entry!);
    }

    open();
    return FlanToast._(open: open, clear: close);
  }

  factory FlanToast.success(
    BuildContext context, {
    FlanToastPosition? position,
    String? message,
    IconData? iconName,
    String? iconUrl,
    bool? overlay,
    bool? forbidClick,
    bool? closeOnClick,
    bool? closeOnClickOverlay,
    FlanLoadingType? loadingType,
    BoxDecoration? toastStyle,
    BoxDecoration? overlayStyle,
    Duration? duration,
    FlanTransitionBuilder? transitionBuilder,
    VoidCallback? onOpened,
    VoidCallback? onClose,
  }) {
    return FlanToast(
      context,
      type: FlanToastType.success,
      position: position,
      message: message,
      iconName: iconName,
      iconUrl: iconUrl,
      overlay: overlay,
      toastStyle: toastStyle,
      overlayStyle: overlayStyle,
      forbidClick: forbidClick,
      closeOnClick: closeOnClick,
      closeOnClickOverlay: closeOnClickOverlay,
      loadingType: loadingType,
      duration: duration,
      transitionBuilder: transitionBuilder,
      onOpened: onOpened,
      onClose: onClose,
    );
  }

  factory FlanToast.fail(
    BuildContext context, {
    FlanToastPosition? position,
    String? message,
    IconData? iconName,
    String? iconUrl,
    bool? overlay,
    bool? forbidClick,
    bool? closeOnClick,
    bool? closeOnClickOverlay,
    FlanLoadingType? loadingType,
    BoxDecoration? toastStyle,
    BoxDecoration? overlayStyle,
    Duration? duration,
    FlanTransitionBuilder? transitionBuilder,
    VoidCallback? onOpened,
    VoidCallback? onClose,
  }) {
    return FlanToast(
      context,
      type: FlanToastType.fail,
      position: position,
      message: message,
      iconName: iconName,
      iconUrl: iconUrl,
      overlay: overlay,
      toastStyle: toastStyle,
      overlayStyle: overlayStyle,
      forbidClick: forbidClick,
      closeOnClick: closeOnClick,
      closeOnClickOverlay: closeOnClickOverlay,
      loadingType: loadingType,
      duration: duration,
      transitionBuilder: transitionBuilder,
      onOpened: onOpened,
      onClose: onClose,
    );
  }

  factory FlanToast.loading(
    BuildContext context, {
    FlanToastPosition? position,
    String? message,
    IconData? iconName,
    String? iconUrl,
    bool? overlay,
    bool? forbidClick,
    bool? closeOnClick,
    bool? closeOnClickOverlay,
    FlanLoadingType? loadingType,
    BoxDecoration? toastStyle,
    BoxDecoration? overlayStyle,
    Duration? duration,
    FlanTransitionBuilder? transitionBuilder,
    VoidCallback? onOpened,
    VoidCallback? onClose,
  }) {
    return FlanToast(
      context,
      type: FlanToastType.loading,
      position: position,
      message: message,
      iconName: iconName,
      iconUrl: iconUrl,
      overlay: overlay,
      toastStyle: toastStyle,
      overlayStyle: overlayStyle,
      forbidClick: forbidClick,
      closeOnClick: closeOnClick,
      closeOnClickOverlay: closeOnClickOverlay,
      loadingType: loadingType,
      duration: duration,
      transitionBuilder: transitionBuilder,
      onOpened: onOpened,
      onClose: onClose,
    );
  }

  const FlanToast._({
    required this.clear,
    required this.open,
  });

  static CustomOverlayEntry? _getCurrentEntry() {
    if (_queue.isNotEmpty && !_allowMultiple) {
      return _queue[0];
    }
    return null;
  }

  static void allowMultiple([bool value = true]) {
    _allowMultiple = value;
  }

  static void setDefaultOptions(FlanToastOption other, {FlanToastType? type}) {
    if (type != null) {
      _defaultOptions[type] = _defaultOptions[type]!.merge(other);
    } else {
      for (final FlanToastType type in _defaultOptions.keys) {
        _defaultOptions[type] = _defaultOptions[type]!.merge(other);
      }
    }
  }

  static void resetDefaultOptions({FlanToastType? type}) {
    if (type != null) {
      _defaultOptions[type] = const FlanToastOption();
    } else {
      for (final FlanToastType type in _defaultOptions.keys) {
        _defaultOptions[type] = const FlanToastOption();
      }
    }
  }

  static void clearAll([bool all = true]) {
    if (_queue.isNotEmpty) {
      if (all) {
        for (int i = 0; i < _queue.length; i++) {
          _queue[i].close();
        }
        _queue.clear();
      } else if (!_allowMultiple) {
        _queue[0].close();
      } else {
        _queue[0].close();
      }
    }
  }

  final VoidCallback clear;
  final void Function(String message) open;
}

class FlanToastBlock extends StatelessWidget {
  const FlanToastBlock({
    Key? key,
    required this.type,
    required this.position,
    required this.message,
    this.iconName,
    this.iconUrl,
    this.iconSize,
    required this.overlay,
    required this.loadingType,
    this.toastStyle,
    this.overlayStyle,
    this.onClick,
    this.onClickOverlay,
  })  : assert(type is FlanToastType),
        assert(position is FlanToastPosition),
        super(key: key);

  // ****************** Props ******************

  /// 提示类型，可选值为 `loading` `success` `fail` `html` `text`
  final FlanToastType type;

  /// 位置，可选值为 `top` `middle` `bottom`
  final FlanToastPosition position;

  /// 文本内容,支持通过`\n`换行
  final String message;

  /// 自定义图标，支持传入图标名称
  final IconData? iconName;

  /// 自定义图标，支持传入图片链接
  final String? iconUrl;

  /// 图标大小
  final double? iconSize;

  /// 是否显示背景遮罩层
  final bool overlay;

  /// 加载图标类型, 可选值为 `spinner`
  final FlanLoadingType loadingType;

  /// 自定义样式
  final BoxDecoration? toastStyle;

  /// 自定义遮罩样式
  final BoxDecoration? overlayStyle;

  // ****************** Events ******************
  final VoidCallback? onClick;

  final VoidCallback? onClickOverlay;

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isText =
        type == FlanToastType.text && iconName == null && iconUrl == null;

    final FlanThemeData theme = FlanTheme.of(context);
    final FlanToastThemeData themeData = theme.toastTheme;
    final Color overlayColor = theme.overlayBackgroundColor;

    return Stack(
      children: <Widget>[
        Visibility(
          visible: overlay,
          child: Positioned.fill(
            child: GestureDetector(
              onTap: onClickOverlay,
              child: Container(
                decoration: overlayStyle ?? BoxDecoration(color: overlayColor),
              ),
            ),
          ),
        ),
        Align(
          alignment: _position,
          child: DefaultTextStyle(
            style: TextStyle(
              color: themeData.textColor,
              fontSize: themeData.fontSize,
              height: themeData.lineHeight,
            ),
            child: GestureDetector(
              onTap: onClick,
              child: DecoratedBox(
                decoration: toastStyle ??
                    BoxDecoration(
                      color: themeData.backgroundColor,
                      borderRadius:
                          BorderRadius.circular(themeData.borderRadius),
                    ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: themeData.maxWidth * size.width,
                    minWidth: themeData.defaultWidth,
                    minHeight: isText ? 0.0 : themeData.defaultMinHeight,
                  ),
                  margin:
                      isText ? themeData.textPadding : themeData.defaultPadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildIcon(themeData),
                      SizedBox(
                        height: isText ? 0.0 : FlanThemeVars.paddingXs.rpx,
                      ),
                      _buildText(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Alignment get _position {
    switch (position) {
      case FlanToastPosition.top:
        return const Alignment(0.0, -0.6);
      case FlanToastPosition.middle:
        return const Alignment(0.0, 0.0);
      case FlanToastPosition.bottom:
        return const Alignment(0.0, 0.6);
    }
  }

  Widget _buildIcon(FlanToastThemeData themeData) {
    final bool hasIcon = iconName != null ||
        iconUrl != null ||
        type == FlanToastType.success ||
        type == FlanToastType.fail;

    if (hasIcon) {
      IconData? name = iconName;
      if (type == FlanToastType.success) {
        name = FlanIcons.success;
      }

      if (type == FlanToastType.fail) {
        name = FlanIcons.fail;
      }

      return FlanIcon(
        iconName: name,
        iconUrl: iconUrl,
        size: iconSize ?? themeData.iconSize,
        color: iconUrl != null ? null : themeData.textColor,
      );
    }

    if (type == FlanToastType.loading) {
      return Padding(
        padding: EdgeInsets.all(FlanThemeVars.paddingBase.rpx),
        child: FlanLoading(
          type: loadingType,
          color: themeData.loadingIconColor,
          size: iconSize,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildText() {
    if (message.isNotEmpty) {
      return Text(message);
    }
    return const SizedBox.shrink();
  }
}

/// Toast位置集合
enum FlanToastPosition {
  top,
  middle,
  bottom,
}

/// Toast类型集合
enum FlanToastType {
  text,
  loading,
  success,
  fail,
  // html,
}
