import 'dart:async';

import 'package:flutter/material.dart';

import '../styles/components/toast_theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'common/custom_entry.dart';
import 'icon.dart';
import 'loading.dart';
import 'overlay.dart';
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
    this.customStyle,
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
  final BoxDecoration? customStyle;
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
      customStyle: other.customStyle,
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
    BoxDecoration? customStyle,
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
      customStyle: customStyle ?? this.customStyle,
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
    BoxDecoration? customStyle,
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
      final Widget toast = Align(
        alignment: FlanToast.getPosition(position ?? _defaultOption.position),
        child: UnconstrainedBox(
          child: _FlanToastBlock(
            type: _type,
            message: msg ?? message ?? _defaultOption.message,
            iconName: iconName ?? _defaultOption.iconName,
            iconUrl: iconUrl ?? _defaultOption.iconUrl,
            iconSize: iconSize ?? _defaultOption.iconSize,
            customStyle: customStyle ?? _defaultOption.customStyle,
            onClick:
                (closeOnClick ?? _defaultOption.closeOnClick) ? close : null,
            loadingType: loadingType ?? _defaultOption.loadingType,
          ),
        ),
      );

      duration ??= _defaultOption.duration;
      if (entry != null) {
        entry!.update(toast, duration!);
        return;
      }
      void watchToastOpen() {
        onOpened ??= _defaultOption.onOpened;
        onOpened?.call();

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

        onClose?.call();
      }

      final VoidCallback? onClickOverlay =
          (closeOnClickOverlay ?? _defaultOption.closeOnClickOverlay)
              ? close
              : null;

      entry = CustomOverlayEntry(
        lockScroll: false,
        layoutBuilder: (BuildContext context, Widget child) {
          return IgnorePointer(
            ignoring: forbidClick ?? _defaultOption.forbidClick,
            child: child,
          );
        },
        transitionBuilder: (BuildContext context, bool visible, Widget? child) {
          return Stack(
            children: <Widget>[
              Positioned.fill(
                child: FlanOverlay(
                  show: (overlay ?? _defaultOption.overlay) && visible,
                  onClick: onClickOverlay,
                  customStyle: overlayStyle ?? _defaultOption.customStyle,
                ),
              ),
              FlanTransitionVisiable(
                transitionBuilder:
                    transitionBuilder ?? kFlanFadeTransitionBuilder,
                visible: visible,
                appear: true,
                onDismissed: watchToastClose,
                child: child!,
              ),
            ],
          );
        },
        child: toast,
      );
      entry!.addListener(watchToastOpen);
      Overlay.maybeOf(context, rootOverlay: true)?.insert(entry!);
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
    BoxDecoration? customStyle,
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
      customStyle: customStyle,
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
    BoxDecoration? customStyle,
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
      customStyle: customStyle,
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
    BoxDecoration? customStyle,
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
      customStyle: customStyle,
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

  static Alignment getPosition(FlanToastPosition position) {
    switch (position) {
      case FlanToastPosition.top:
        return const Alignment(0.0, -0.6);
      case FlanToastPosition.middle:
        return const Alignment(0.0, 0.0);
      case FlanToastPosition.bottom:
        return const Alignment(0.0, 0.6);
    }
  }

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

class _FlanToastBlock extends StatelessWidget {
  const _FlanToastBlock({
    Key? key,
    required this.type,
    required this.message,
    this.iconName,
    this.iconUrl,
    this.iconSize,
    required this.loadingType,
    this.customStyle,
    this.onClick,
    // ignore: unnecessary_type_check
  })  : assert(type is FlanToastType),
        super(key: key);

  // ****************** Props ******************

  /// 提示类型，可选值为 `loading` `success` `fail` `html` `text`
  final FlanToastType type;

  /// 文本内容,支持通过`\n`换行
  final String message;

  /// 自定义图标，支持传入图标名称
  final IconData? iconName;

  /// 自定义图标，支持传入图片链接
  final String? iconUrl;

  /// 图标大小
  final double? iconSize;

  /// 加载图标类型, 可选值为 `spinner`
  final FlanLoadingType loadingType;

  /// 自定义样式
  final BoxDecoration? customStyle;

  // ****************** Events ******************
  final VoidCallback? onClick;

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isText =
        type == FlanToastType.text && iconName == null && iconUrl == null;

    final FlanToastThemeData themeData = FlanToastTheme.of(context);

    return DefaultTextStyle(
      style: TextStyle(
        color: themeData.textColor,
        fontSize: themeData.fontSize,
        height: themeData.lineHeight,
      ),
      child: GestureDetector(
        onTap: onClick,
        child: DecoratedBox(
          decoration: customStyle ??
              BoxDecoration(
                color: themeData.backgroundColor,
                borderRadius: BorderRadius.circular(themeData.borderRadius),
              ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: themeData.maxWidth * size.width,
              minWidth: themeData.defaultWidth,
              minHeight: isText ? 0.0 : themeData.defaultMinHeight,
            ),
            margin: isText ? themeData.textPadding : themeData.defaultPadding,
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
    );
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
      return Text(
        message,
        textHeightBehavior: FlanThemeVars.textHeightBehavior,
      );
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
