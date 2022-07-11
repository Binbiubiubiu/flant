import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import './icon.dart' show FlanIcon, FlanIcons;
import '../styles/components/popup_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import 'common/active_response.dart';
import 'style.dart';

/// ### FlanPopup 列布局
/// 弹出层容器，用于展示弹窗、信息提示等内容，支持多个弹出层叠加展示。
Future<T?> showFlanPopup<T extends Object?>(
  BuildContext context, {
  FlanPopupPosition position = FlanPopupPosition.center,
  Color? backgroundColor,
  BorderRadius? borderRadius,
  Color? overlayColor,
  Duration? duration,
  bool round = false,
  bool closeOnClickOverlay = true,
  bool closeable = false,
  IconData closeIconName = FlanIcons.cross,
  String? closeIconUrl,
  FlanPopupCloseIconPosition closeIconPosition =
      FlanPopupCloseIconPosition.topRight,
  FlanTransitionBuilder? transitionBuilder,
  bool safeAreaInsetBottom = false,
  VoidCallback? onClickCloseIcon,
  VoidCallback? onClick,
  VoidCallback? onOpen,
  VoidCallback? onClose,
  VoidCallback? onOpened,
  VoidCallback? onClosed,
  required WidgetBuilder builder,
}) {
  final FlanPopupThemeData popupThemeData = FlanPopupTheme.of(context);
  final Color overlayThemeBackgroundColor =
      FlanTheme.of(context).overlayBackgroundColor;

  return Navigator.of(context, rootNavigator: true).push<T>(
    _FlanPopupRoute<T>(
      builder: (BuildContext context) {
        Widget content = builder(context);
        if (closeable) {
          content = _FlanCloseableScope(
            closeIconName: closeIconName,
            closeIconUrl: closeIconUrl,
            closeIconPosition: closeIconPosition,
            onClickCloseIcon: onClickCloseIcon,
            child: content,
          );
        }

        return _FlanPopupWrapper(
          position: position,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          round: round,
          safeAreaInsetBottom: safeAreaInsetBottom,
          child: content,
        );
      },
      // popupPosition: _getPopupAlign(position),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierDismissible: closeOnClickOverlay,
      barrierColor: overlayColor ?? overlayThemeBackgroundColor,

      transitionDuration: duration ?? popupThemeData.transitionDuration,
      transitionBuilder: transitionBuilder ?? _getPopupTransition(position),
      onTransitionRouteEnter: onOpened,
      onTransitionRouteLeave: onClosed,
      onOpen: onOpen,
      onClose: onClose,
    ),
  );
}

class _FlanPopupWrapper extends StatelessWidget {
  const _FlanPopupWrapper({
    Key? key,
    required this.position,
    this.backgroundColor,
    this.borderRadius,
    required this.round,
    required this.safeAreaInsetBottom,
    // ignore: unused_element
    this.onClick,
    this.child,
  }) : super(key: key);

  // ****************** Props ******************

  /// 弹出位置，可选值为 `top` `bottom` `right` `left` `center`
  final FlanPopupPosition position;

  /// 弹窗的样式
  final Color? backgroundColor;

  /// 圆角大小
  final BorderRadius? borderRadius;

  /// 是否显示圆角
  final bool round;

  /// 是否开启底部安全区适配
  final bool safeAreaInsetBottom;

  // ****************** Events ******************

  /// 点击事件
  final VoidCallback? onClick;

  // ****************** Slots ******************
  /// 内容
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData win = MediaQuery.of(context);
    final FlanPopupThemeData themeData = FlanPopupTheme.of(context);

    Widget content = Material(
      color: backgroundColor ?? themeData.backgroundColor,
      borderRadius:
          round ? _getRoundRadius(themeData, position) : BorderRadius.zero,
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: needWidthFilled ? win.size.width : null,
        height: needHeightFilled ? win.size.height : null,
        padding: safeAreaInsetBottom
            ? EdgeInsets.only(bottom: win.padding.bottom)
            : null,
        child: child,
      ),
    );

    if (onClick != null) {
      content = GestureDetector(
        onTap: onClick,
        child: content,
      );
    }
    return Align(
      alignment: _popupAlign,
      child: content,
    );
  }

  bool get needWidthFilled =>
      position == FlanPopupPosition.top || position == FlanPopupPosition.bottom;

  bool get needHeightFilled =>
      position == FlanPopupPosition.left || position == FlanPopupPosition.right;

  Alignment get _popupAlign {
    switch (position) {
      case FlanPopupPosition.top:
        return Alignment.topCenter;
      case FlanPopupPosition.bottom:
        return Alignment.bottomCenter;
      case FlanPopupPosition.right:
        return Alignment.centerRight;
      case FlanPopupPosition.left:
        return Alignment.centerLeft;
      case FlanPopupPosition.center:
        return Alignment.center;
    }
  }

  BorderRadius _getRoundRadius(
      FlanPopupThemeData themeData, FlanPopupPosition position) {
    if (borderRadius != null) {
      return borderRadius!;
    }

    final ui.Radius radius = Radius.circular(themeData.roundBorderRadius);
    switch (position) {
      case FlanPopupPosition.top:
        return BorderRadius.only(bottomLeft: radius, bottomRight: radius);
      case FlanPopupPosition.bottom:
        return BorderRadius.only(topLeft: radius, topRight: radius);
      case FlanPopupPosition.right:
        return BorderRadius.only(topLeft: radius, bottomLeft: radius);
      case FlanPopupPosition.left:
        return BorderRadius.only(topRight: radius, bottomRight: radius);
      case FlanPopupPosition.center:
        return BorderRadius.all(radius);
    }
  }
}

class _FlanCloseableScope extends StatelessWidget {
  const _FlanCloseableScope({
    Key? key,
    required this.closeIconName,
    this.closeIconUrl,
    required this.closeIconPosition,
    this.onClickCloseIcon,
    this.child,
  }) : super(key: key);

  // ****************** Props ******************

  /// 关闭图标名称
  final IconData closeIconName;

  /// 关闭图片链接
  final String? closeIconUrl;

  /// 关闭图标位置，可选值为 `topleft` `topRight` `bottomLeft` `bottomRight`
  final FlanPopupCloseIconPosition closeIconPosition;

  // ****************** Events ******************

  /// 点击关闭图标时触发
  final GestureTapCallback? onClickCloseIcon;

  // ****************** Slots ******************
  /// 内容
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final FlanPopupThemeData themeData = FlanPopupTheme.of(context);
    return Stack(
      children: <Widget>[
        child ?? const SizedBox.shrink(),
        _buildCloseIcon(context, themeData),
      ],
    );
  }

  Widget _buildCloseIcon(BuildContext context, FlanPopupThemeData themeData) {
    final Widget icon = Semantics(
      button: true,
      enabled: onClickCloseIcon != null,
      child: FlanActiveResponse(
        onClick: () {
          onClickCloseIcon?.call();
          Navigator.of(context).maybePop();
        },
        builder: (BuildContext contenxt, bool active, Widget? child) {
          return FlanIcon(
            iconName: closeIconName,
            iconUrl: closeIconUrl,
            color: active
                ? themeData.closeIconActiveColor
                : themeData.closeIconColor,
          );
        },
      ),
    );

    switch (closeIconPosition) {
      case FlanPopupCloseIconPosition.topLeft:
        return Positioned(
          top: themeData.closeIconMargin,
          left: themeData.closeIconMargin,
          child: icon,
        );
      case FlanPopupCloseIconPosition.topRight:
        return Positioned(
          top: themeData.closeIconMargin,
          right: themeData.closeIconMargin,
          child: icon,
        );
      case FlanPopupCloseIconPosition.bottomLeft:
        return Positioned(
          bottom: themeData.closeIconMargin,
          left: themeData.closeIconMargin,
          child: icon,
        );
      case FlanPopupCloseIconPosition.bottomRight:
        return Positioned(
          bottom: themeData.closeIconMargin,
          right: themeData.closeIconMargin,
          child: icon,
        );
    }
  }
}

class _FlanPopupRoute<T extends Object?> extends PopupRoute<T> {
  _FlanPopupRoute({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    String? barrierLabel,
    required Color barrierColor,
    required Duration transitionDuration,
    RouteSettings? settings,
    required this.transitionBuilder,
    this.onOpen,
    this.onClose,
    this.onTransitionRouteEnter,
    this.onTransitionRouteLeave,
  })  : _builder = builder,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _barrierColor = barrierColor,
        _transitionDuration = transitionDuration,
        super(settings: settings);

  final WidgetBuilder _builder;

  final VoidCallback? onTransitionRouteEnter;
  final VoidCallback? onTransitionRouteLeave;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;

  final FlanTransitionBuilder transitionBuilder;

  void _onFlanPopupTransitionChange(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        onTransitionRouteLeave?.call();
        break;
      case AnimationStatus.forward:
        break;
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.completed:
        onTransitionRouteEnter?.call();
        break;
    }
  }

  @override
  void install() {
    onOpen?.call();
    super.install();
    controller?.addStatusListener(_onFlanPopupTransitionChange);
  }

  @override
  void dispose() {
    controller?.removeStatusListener(_onFlanPopupTransitionChange);
    super.dispose();
    onClose?.call();
  }

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String? get barrierLabel => _barrierLabel;
  final String? _barrierLabel;

  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor;

  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Semantics(
      child: FlanTransitionVisiable(
        animation: animation,
        transitionBuilder: transitionBuilder,
        child: _builder(context),
      ),
      scopesRoute: true,
      explicitChildNodes: true,
    );
  }

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: FlanThemeVars.animationTimingFunctionEnter,
      reverseCurve: FlanThemeVars.animationTimingFunctionLeave,
    );
  }
}

/// 弹窗位置集合
enum FlanPopupPosition {
  top,
  bottom,
  right,
  left,
  center,
}

FlanTransitionBuilder _getPopupTransition(FlanPopupPosition position) {
  switch (position) {
    case FlanPopupPosition.top:
      return FlanPopupTransition.slideToBottom;
    case FlanPopupPosition.bottom:
      return FlanPopupTransition.slideToTop;
    case FlanPopupPosition.right:
      return FlanPopupTransition.slideToLeft;
    case FlanPopupPosition.left:
      return FlanPopupTransition.slideToRight;
    default:
      return FlanPopupTransition.fade;
  }
}

// ignore: avoid_classes_with_only_static_members
class FlanPopupTransition {
  static Widget slideToBottom(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static Widget slideToTop(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static Widget slideToLeft(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static Widget slideToRight(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static Widget fade(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

/// 关闭图标位置
enum FlanPopupCloseIconPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}
