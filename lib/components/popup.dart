import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

import '../styles/var.dart';
import './icon.dart' show FlanIcon, FlanIcons;

const Symbol FLANPOPUP_CLOSE_FROM = Symbol('flanpopup_close_from');
enum FlanPopupCloseFromType {
  backBtn,
  closeBtn,
  overlay,
}

/// ### FlanPopup 列布局
/// 弹出层容器，用于展示弹窗、信息提示等内容，支持多个弹出层叠加展示。
class FlanPopup extends StatefulWidget {
  const FlanPopup({
    Key? key,
    required this.show,
    required this.onChange,
    this.overlay = true,
    this.position = FlanPopupPosition.center,
    this.style,
    this.overlayStyle,
    this.duration,
    this.round = false,
    // this.lockScroll = true,
    // this.lazyRender = true,
    this.closeOnPopstate = false,
    this.closeOnClickOverlay = true,
    this.closeable = false,
    this.closeIconName = FlanIcons.cross,
    this.closeIconUrl,
    this.closeIconPosition = FlanPopupCloseIconPosition.topRight,
    this.transitionBuilder,
    this.transitionAppearBuilder,
    this.transitionAppear = false,
    this.safeAreaInsetBottom = false,
    this.onClick,
    this.onClickOverlay,
    this.onClickCloseIcon,
    this.onOpen,
    this.onClose,
    this.onOpened,
    this.onClosed,
    required this.child,
  })   : assert(!transitionAppear ||
            transitionAppear && transitionAppearBuilder != null),
        super(key: key);

  // ****************** Props ******************
  /// 是否显示弹出层
  final bool show;

  /// 是否显示遮罩层
  final bool overlay;

  /// 弹出位置，可选值为 `top` `bottom` `right` `left` `center`
  final FlanPopupPosition position;

  /// 弹窗的样式
  final BoxDecoration? style;

  /// 自定义遮罩层样式
  final BoxDecoration? overlayStyle;

  /// 动画时长，单位秒
  final Duration? duration;

  /// 是否显示圆角
  final bool round;

  // /// 是否锁定背景滚动
  // final bool lockScroll;

  // /// 是否在显示弹层时才渲染节点
  // final bool lazyRender;

  /// 是否在页面回退时自动关闭
  final bool closeOnPopstate;

  /// 是否在点击遮罩层后关闭
  final bool closeOnClickOverlay;

  /// 是否显示关闭图标
  final bool closeable;

  /// 关闭图标名称
  final int closeIconName;

  /// 关闭图片链接
  final String? closeIconUrl;

  /// 关闭图标位置，可选值为 `topleft` `topRight` `bottomLeft` `bottomRight`
  final FlanPopupCloseIconPosition closeIconPosition;

  /// 动画类名，等价于 transtion 的name属性
  final RouteTransitionsBuilder? transitionBuilder;

  /// 动画类名，等价于 transtion 的name属性
  final RouteTransitionsBuilder? transitionAppearBuilder;

  /// 是否在初始渲染时启用过渡动画
  final bool transitionAppear;

  /// 是否开启底部安全区适配
  final bool safeAreaInsetBottom;

  // ****************** Events ******************
  /// 弹窗变化回调
  final ValueChanged<bool> onChange;

  /// 点击弹出层时触发
  final GestureTapCallback? onClick;

  // /// 点击遮罩层时触发
  final GestureTapCallback? onClickOverlay;

  /// 点击关闭图标时触发
  final GestureTapCallback? onClickCloseIcon;

  /// 打开弹出层时触发
  final VoidCallback? onOpen;

  /// 关闭弹出层时触发
  final VoidCallback? onClose;

  /// 打开弹出层且动画结束后触发
  final VoidCallback? onOpened;

  /// 关闭弹出层且动画结束后触发
  final VoidCallback? onClosed;

  // ****************** Slots ******************
  /// 内容
  final Widget child;

  @override
  _FlanPopupState createState() => _FlanPopupState();
}

class _FlanPopupState extends State<FlanPopup> {
  bool opened = false;
  bool isFirstOpen = true;

  @override
  void initState() {
    super.initState();
    if (widget.show) {
      openPopup();
    }
  }

  @override
  void didUpdateWidget(covariant FlanPopup oldWidget) {
    if (!oldWidget.show && widget.show) {
      openPopup();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  Alignment get _popupAlign {
    return <FlanPopupPosition, Alignment>{
      FlanPopupPosition.center: Alignment.center,
      FlanPopupPosition.bottom: Alignment.bottomLeft,
      FlanPopupPosition.top: Alignment.topLeft,
      FlanPopupPosition.left: Alignment.centerLeft,
      FlanPopupPosition.right: Alignment.centerRight,
    }[widget.position]!;
  }

  BorderRadius get _roundRadius {
    const ui.Radius radius = Radius.circular(ThemeVars.popupRoundBorderRadius);
    switch (widget.position) {
      case FlanPopupPosition.top:
        return const BorderRadius.only(bottomLeft: radius, bottomRight: radius);
      case FlanPopupPosition.bottom:
        return const BorderRadius.only(topLeft: radius, topRight: radius);
      case FlanPopupPosition.right:
        return const BorderRadius.only(topLeft: radius, bottomLeft: radius);
      case FlanPopupPosition.left:
        return const BorderRadius.only(topRight: radius, bottomRight: radius);
      case FlanPopupPosition.center:
        return const BorderRadius.all(radius);
    }
  }

  RouteTransitionsBuilder get _popupTransitionsBuilder {
    if (widget.transitionAppear && isFirstOpen) {
      return widget.transitionAppearBuilder!;
    }

    return widget.transitionBuilder ?? _buildMaterialDialogTransitions;
  }

  void closePopup() {
    if (opened) {
      opened = false;
      if (widget.onClose != null) {
        widget.onClose!();
      }
      widget.onChange(false);
    }
  }

  void openPopup() {
    if (opened) {
      return;
    }
    opened = true;

    if (widget.onOpen != null) {
      widget.onOpen!();
    }

    WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
      Navigator.of(context, rootNavigator: true)
          .push<dynamic>(_FlanPopupRoute<dynamic>(
            pageBuilder: (
              BuildContext buildContext,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              Widget dialog = _buildPopupContent();
              if (widget.safeAreaInsetBottom) {
                dialog = SafeArea(child: dialog);
              }
              return dialog;
            },
            popupPosition: _popupAlign,
            onOverlayClick: widget.onClickOverlay,
            barrierDismissible: widget.closeOnClickOverlay,
            closeOnPopstate: widget.closeOnPopstate,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor:
                widget.overlayStyle?.color ?? ThemeVars.overlayBackgroundColor,
            transitionDuration:
                widget.duration ?? ThemeVars.popupTransitionDuration,
            transitionBuilder: _popupTransitionsBuilder,
            onTransitionRouteEnter: () {
              if (isFirstOpen) {
                isFirstOpen = false;
              }
              if (widget.onOpened != null) {
                widget.onOpened!();
              }
            },
            onTransitionRouteLeave: () {
              if (widget.onClosed != null) {
                widget.onClosed!();
              }
            },
          ))
          .then((dynamic value) => closePopup());
    });
  }

  Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final Animation<double> curve = animation.drive(
      CurveTween(
        curve: widget.show
            ? ThemeVars.animationTimingFunctionEnter
            : ThemeVars.animationTimingFunctionLeave,
      ),
    );

    switch (widget.position) {
      case FlanPopupPosition.top:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: const Offset(0.0, 0.0),
          ).animate(curve),
          child: child,
        );
      case FlanPopupPosition.bottom:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: const Offset(0.0, 0.0),
          ).animate(curve),
          child: child,
        );
      case FlanPopupPosition.right:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(curve),
          child: child,
        );
      case FlanPopupPosition.left:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(curve),
          child: child,
        );
      case FlanPopupPosition.center:
        return FadeTransition(
          opacity: curve,
          child: child,
        );
    }
  }

  Widget _buildPopupContent() {
    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Align(
        alignment: _popupAlign,
        child: SizedBox(
          width: widget.position == FlanPopupPosition.top ||
                  widget.position == FlanPopupPosition.bottom
              ? MediaQuery.of(context).size.width
              : null,
          height: widget.position == FlanPopupPosition.left ||
                  widget.position == FlanPopupPosition.right
              ? MediaQuery.of(context).size.height
              : null,
          child: GestureDetector(
            onTap: widget.onClick,
            child: Material(
              borderRadius: widget.round ? _roundRadius : null,
              color: ThemeVars.popupBackgroundColor,
              type: MaterialType.card,
              child: Stack(
                children: <Widget>[
                  if (widget.closeable)
                    _buildCloseIcon()
                  else
                    const SizedBox.shrink(),
                  widget.child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseIcon() {
    final _FlanPopupCloseIcon icon = _FlanPopupCloseIcon(
      closeIconName: widget.closeIconName,
      closeIconUrl: widget.closeIconUrl,
      onPress: widget.onClickCloseIcon,
    );

    switch (widget.closeIconPosition) {
      case FlanPopupCloseIconPosition.topLeft:
        return Positioned(
          top: ThemeVars.popupCloseIconMargin,
          left: ThemeVars.popupCloseIconMargin,
          child: icon,
        );
      case FlanPopupCloseIconPosition.topRight:
        return Positioned(
          top: ThemeVars.popupCloseIconMargin,
          right: ThemeVars.popupCloseIconMargin,
          child: icon,
        );
      case FlanPopupCloseIconPosition.bottomLeft:
        return Positioned(
          bottom: ThemeVars.popupCloseIconMargin,
          left: ThemeVars.popupCloseIconMargin,
          child: icon,
        );
      case FlanPopupCloseIconPosition.bottomRight:
        return Positioned(
          bottom: ThemeVars.popupCloseIconMargin,
          right: ThemeVars.popupCloseIconMargin,
          child: icon,
        );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<bool>('show', widget.show, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('overlay', widget.overlay,
        defaultValue: true));
    properties.add(DiagnosticsProperty<FlanPopupPosition>(
        'position', widget.position,
        defaultValue: FlanPopupPosition.center));
    properties.add(DiagnosticsProperty<BoxDecoration>(
        'overlayStyle', widget.overlayStyle));
    properties.add(DiagnosticsProperty<Duration>('duration', widget.duration,
        defaultValue: const Duration(milliseconds: 300)));
    properties.add(
        DiagnosticsProperty<bool>('round', widget.round, defaultValue: false));
    // properties.add(DiagnosticsProperty<bool>("lockScroll", widget.lockScroll,
    //     defaultValue: true));
    // properties.add(DiagnosticsProperty<bool>("lazyRender", widget.lazyRender,
    //     defaultValue: true));
    properties.add(DiagnosticsProperty<bool>(
        'closeOnPopstate', widget.closeOnPopstate,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'closeOnClickOverlay', widget.closeOnClickOverlay,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('closeable', widget.closeable,
        defaultValue: false));
    properties.add(DiagnosticsProperty<int>(
        'closeIconName', widget.closeIconName,
        defaultValue: FlanIcons.cross));
    properties
        .add(DiagnosticsProperty<String>('closeIconUrl', widget.closeIconUrl));
    properties.add(DiagnosticsProperty<FlanPopupCloseIconPosition>(
        'closeIconPosition', widget.closeIconPosition,
        defaultValue: FlanPopupCloseIconPosition.topRight));
    properties.add(DiagnosticsProperty<RouteTransitionsBuilder>(
        'transition', widget.transitionBuilder));
    properties.add(DiagnosticsProperty<bool>(
        'transitionAppear', widget.transitionAppear,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'safeAreaInsetBottom', widget.safeAreaInsetBottom,
        defaultValue: false));
    super.debugFillProperties(properties);
  }
}

class _FlanPopupRoute<T extends dynamic> extends FlanPopupRoute<T> {
  _FlanPopupRoute({
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = true,
    bool closeOnPopstate = false,
    String? barrierLabel,
    required Color barrierColor,
    required Duration transitionDuration,
    RouteTransitionsBuilder? transitionBuilder,
    RouteSettings? settings,
    VoidCallback? onOverlayClick,
    this.appear = false,
    this.onTransitionRouteEnter,
    this.onTransitionRouteLeave,
    required Alignment popupPosition,
  })   : _pageBuilder = pageBuilder,
        _onOverlayClick = onOverlayClick,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel!,
        _barrierColor = barrierColor,
        _closeOnPopstate = closeOnPopstate,
        _transitionDuration = transitionDuration,
        _transitionBuilder = transitionBuilder!,
        _popupPosition = popupPosition,
        super(settings: settings);

  final RoutePageBuilder _pageBuilder;
  final Alignment _popupPosition;
  @override
  Alignment get popupPosition => _popupPosition;

  final bool appear;

  final VoidCallback? onTransitionRouteEnter;
  final VoidCallback? onTransitionRouteLeave;

  void _onFlanPopupTransitionChange(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        if (onTransitionRouteLeave != null) {
          onTransitionRouteLeave!();
        }
        break;
      case AnimationStatus.forward:
        break;
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.completed:
        if (onTransitionRouteEnter != null) {
          onTransitionRouteEnter!();
        }
        break;
    }
  }

  @override
  void install() {
    animation?.addStatusListener(_onFlanPopupTransitionChange);
    super.install();
  }

  @override
  void dispose() {
    animation?.removeStatusListener(_onFlanPopupTransitionChange);
    super.dispose();
  }

  @override
  bool didPop(T? result) {
    final dynamic from =
        result?[FLANPOPUP_CLOSE_FROM] ?? FlanPopupCloseFromType.backBtn;
    result?.remove(FlanPopupCloseFromType);

    return !((!closeOnPopstate) &&
            (from as FlanPopupCloseFromType) ==
                FlanPopupCloseFromType.backBtn) &&
        super.didPop(result);
  }

  @override
  VoidCallback? get onOverlayClick => _onOverlayClick;
  final VoidCallback? _onOverlayClick;

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String get barrierLabel => _barrierLabel;
  final String _barrierLabel;

  @override
  bool get closeOnPopstate => _closeOnPopstate;
  final bool _closeOnPopstate;

  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor;

  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;

  final RouteTransitionsBuilder _transitionBuilder;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Semantics(
      child: _pageBuilder(context, animation, secondaryAnimation),
      scopesRoute: true,
      explicitChildNodes: true,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return _transitionBuilder(context, animation, secondaryAnimation, child);
  }
}

class _FlanPopupProvider extends InheritedWidget {
  const _FlanPopupProvider({
    Key? key,
    this.onOverlayClick,
    required Widget child,
  }) : super(key: key, child: child);

  final VoidCallback? onOverlayClick;

  static _FlanPopupProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_FlanPopupProvider>();
  }

  @override
  bool updateShouldNotify(_FlanPopupProvider oldWidget) {
    return onOverlayClick != oldWidget.onOverlayClick;
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

/// 关闭图标位置
enum FlanPopupCloseIconPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// 弹窗关闭图标按钮
class _FlanPopupCloseIcon extends StatefulWidget {
  const _FlanPopupCloseIcon({
    Key? key,
    this.closeIconName,
    this.closeIconUrl,
    this.onPress,
  }) : super(key: key);

  /// 图标属性
  final int? closeIconName;

  /// 图标链接
  final String? closeIconUrl;

  /// 图标点击事件
  final VoidCallback? onPress;

  @override
  __FlanPopupCloseIconState createState() => __FlanPopupCloseIconState();
}

class __FlanPopupCloseIconState extends State<_FlanPopupCloseIcon> {
  bool active = false;

  void activeText() {
    setState(() {
      active = true;
    });
  }

  void disactiveText() {
    setState(() {
      active = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: widget.onPress != null,
      sortKey: const OrdinalSortKey(0.0),
      child: InkResponse(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (widget.onPress != null) {
            widget.onPress!();
          }
          Navigator.of(context).maybePop(<Symbol, FlanPopupCloseFromType>{
            FLANPOPUP_CLOSE_FROM: FlanPopupCloseFromType.closeBtn,
          });
          disactiveText();
        },
        onTapDown: (TapDownDetails e) {
          activeText();
        },
        onTapCancel: disactiveText,
        child: FlanIcon(
          iconName: widget.closeIconName,
          iconUrl: widget.closeIconUrl,
          color: active
              ? ThemeVars.popupCloseIconActiveColor
              : ThemeVars.popupCloseIconColor,
        ),
      ),
    );
  }
}

abstract class FlanPopupRoute<T> extends FlanModalRoute<T> {
  /// Initializes the [PopupRoute].
  FlanPopupRoute({
    RouteSettings? settings,
    ui.ImageFilter? filter,
  }) : super(
          filter: filter,
          settings: settings,
        );

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;
}

abstract class FlanModalRoute<T> extends FlanTransitionRoute<T>
    with LocalHistoryRoute<T> {
  /// Creates a route that blocks interaction with previous routes.
  FlanModalRoute({
    RouteSettings? settings,
    this.filter,
  }) : super(settings: settings);

  /// The filter to add to the barrier.
  ///
  /// If given, this filter will be applied to the modal barrier using
  /// [BackdropFilter]. This allows blur effects, for example.
  final ui.ImageFilter? filter;

  // The API for general users of this class

  /// Returns the modal route most closely associated with the given context.
  ///
  /// Returns null if the given context is not associated with a modal route.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ModalRoute route = ModalRoute.of(context);
  /// ```
  ///
  /// The given [BuildContext] will be rebuilt if the state of the route changes
  /// while it is visible (specifically, if [isCurrent] or [canPop] change value).
  @optionalTypeArgs
  static ModalRoute<T>? of<T extends Object?>(BuildContext context) {
    final _ModalScopeStatus? widget =
        context.dependOnInheritedWidgetOfExactType<_ModalScopeStatus>();
    return widget?.route as ModalRoute<T>?;
  }

  /// Schedule a call to [buildTransitions].
  ///
  /// Whenever you need to change internal state for a [ModalRoute] object, make
  /// the change in a function that you pass to [setState], as in:
  ///
  /// ```dart
  /// setState(() { myState = newValue });
  /// ```
  ///
  /// If you just change the state directly without calling [setState], then the
  /// route will not be scheduled for rebuilding, meaning that its rendering
  /// will not be updated.
  @protected
  void setState(VoidCallback fn) {
    if (_scopeKey.currentState != null) {
      _scopeKey.currentState!._routeSetState(fn);
    } else {
      // The route isn't currently visible, so we don't have to call its setState
      // method, but we do still need to call the fn callback, otherwise the state
      // in the route won't be updated!
      fn();
    }
  }

  /// Returns a predicate that's true if the route has the specified name and if
  /// popping the route will not yield the same route, i.e. if the route's
  /// [willHandlePopInternally] property is false.
  ///
  /// This function is typically used with [Navigator.popUntil()].
  static RoutePredicate withName(String name) {
    return (Route<dynamic> route) {
      return !route.willHandlePopInternally &&
          route is ModalRoute &&
          route.settings.name == name;
    };
  }

  // The API for subclasses to override - used by _ModalScope

  /// Override this method to build the primary content of this route.
  ///
  /// The arguments have the following meanings:
  ///
  ///  * `context`: The context in which the route is being built.
  ///  * [animation]: The animation for this route's transition. When entering,
  ///    the animation runs forward from 0.0 to 1.0. When exiting, this animation
  ///    runs backwards from 1.0 to 0.0.
  ///  * [secondaryAnimation]: The animation for the route being pushed on top of
  ///    this route. This animation lets this route coordinate with the entrance
  ///    and exit transition of routes pushed on top of this route.
  ///
  /// This method is only called when the route is first built, and rarely
  /// thereafter. In particular, it is not automatically called again when the
  /// route's state changes unless it uses [ModalRoute.of]. For a builder that
  /// is called every time the route's state changes, consider
  /// [buildTransitions]. For widgets that change their behavior when the
  /// route's state changes, consider [ModalRoute.of] to obtain a reference to
  /// the route; this will cause the widget to be rebuilt each time the route
  /// changes state.
  ///
  /// In general, [buildPage] should be used to build the page contents, and
  /// [buildTransitions] for the widgets that change as the page is brought in
  /// and out of view. Avoid using [buildTransitions] for content that never
  /// changes; building such content once from [buildPage] is more efficient.
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation);

  /// Override this method to wrap the [child] with one or more transition
  /// widgets that define how the route arrives on and leaves the screen.
  ///
  /// By default, the child (which contains the widget returned by [buildPage])
  /// is not wrapped in any transition widgets.
  ///
  /// The [buildTransitions] method, in contrast to [buildPage], is called each
  /// time the [Route]'s state changes while it is visible (e.g. if the value of
  /// [canPop] changes on the active route).
  ///
  /// The [buildTransitions] method is typically used to define transitions
  /// that animate the new topmost route's comings and goings. When the
  /// [Navigator] pushes a route on the top of its stack, the new route's
  /// primary [animation] runs from 0.0 to 1.0. When the Navigator pops the
  /// topmost route, e.g. because the use pressed the back button, the
  /// primary animation runs from 1.0 to 0.0.
  ///
  /// The following example uses the primary animation to drive a
  /// [SlideTransition] that translates the top of the new route vertically
  /// from the bottom of the screen when it is pushed on the Navigator's
  /// stack. When the route is popped the SlideTransition translates the
  /// route from the top of the screen back to the bottom.
  ///
  /// ```dart
  /// PageRouteBuilder(
  ///   pageBuilder: (BuildContext context,
  ///       Animation<double> animation,
  ///       Animation<double> secondaryAnimation,
  ///       Widget child,
  ///   ) {
  ///     return Scaffold(
  ///       appBar: AppBar(title: Text('Hello')),
  ///       body: Center(
  ///         child: Text('Hello World'),
  ///       ),
  ///     );
  ///   },
  ///   transitionsBuilder: (
  ///       BuildContext context,
  ///       Animation<double> animation,
  ///       Animation<double> secondaryAnimation,
  ///       Widget child,
  ///    ) {
  ///     return SlideTransition(
  ///       position: Tween<Offset>(
  ///         begin: const Offset(0.0, 1.0),
  ///         end: Offset.zero,
  ///       ).animate(animation),
  ///       child: child, // child is the value returned by pageBuilder
  ///     );
  ///   },
  /// );
  /// ```
  ///
  /// We've used [PageRouteBuilder] to demonstrate the [buildTransitions] method
  /// here. The body of an override of the [buildTransitions] method would be
  /// defined in the same way.
  ///
  /// When the [Navigator] pushes a route on the top of its stack, the
  /// [secondaryAnimation] can be used to define how the route that was on
  /// the top of the stack leaves the screen. Similarly when the topmost route
  /// is popped, the secondaryAnimation can be used to define how the route
  /// below it reappears on the screen. When the Navigator pushes a new route
  /// on the top of its stack, the old topmost route's secondaryAnimation
  /// runs from 0.0 to 1.0. When the Navigator pops the topmost route, the
  /// secondaryAnimation for the route below it runs from 1.0 to 0.0.
  ///
  /// The example below adds a transition that's driven by the
  /// [secondaryAnimation]. When this route disappears because a new route has
  /// been pushed on top of it, it translates in the opposite direction of
  /// the new route. Likewise when the route is exposed because the topmost
  /// route has been popped off.
  ///
  /// ```dart
  ///   transitionsBuilder: (
  ///       BuildContext context,
  ///       Animation<double> animation,
  ///       Animation<double> secondaryAnimation,
  ///       Widget child,
  ///   ) {
  ///     return SlideTransition(
  ///       position: AlignmentTween(
  ///         begin: const Offset(0.0, 1.0),
  ///         end: Offset.zero,
  ///       ).animate(animation),
  ///       child: SlideTransition(
  ///         position: TweenOffset(
  ///           begin: Offset.zero,
  ///           end: const Offset(0.0, 1.0),
  ///         ).animate(secondaryAnimation),
  ///         child: child,
  ///       ),
  ///     );
  ///   }
  /// ```
  ///
  /// In practice the `secondaryAnimation` is used pretty rarely.
  ///
  /// The arguments to this method are as follows:
  ///
  ///  * `context`: The context in which the route is being built.
  ///  * [animation]: When the [Navigator] pushes a route on the top of its stack,
  ///    the new route's primary [animation] runs from 0.0 to 1.0. When the [Navigator]
  ///    pops the topmost route this animation runs from 1.0 to 0.0.
  ///  * [secondaryAnimation]: When the Navigator pushes a new route
  ///    on the top of its stack, the old topmost route's [secondaryAnimation]
  ///    runs from 0.0 to 1.0. When the [Navigator] pops the topmost route, the
  ///    [secondaryAnimation] for the route below it runs from 1.0 to 0.0.
  ///  * `child`, the page contents, as returned by [buildPage].
  ///
  /// See also:
  ///
  ///  * [buildPage], which is used to describe the actual contents of the page,
  ///    and whose result is passed to the `child` argument of this method.
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }

  @override
  void install() {
    super.install();
    _animationProxy = ProxyAnimation(super.animation);
    _secondaryAnimationProxy = ProxyAnimation(super.secondaryAnimation);
  }

  @override
  TickerFuture didPush() {
    if (_scopeKey.currentState != null) {
      navigator!.focusScopeNode
          .setFirstFocus(_scopeKey.currentState!.focusScopeNode);
    }
    return super.didPush();
  }

  @override
  void didAdd() {
    if (_scopeKey.currentState != null) {
      navigator!.focusScopeNode
          .setFirstFocus(_scopeKey.currentState!.focusScopeNode);
    }
    super.didAdd();
  }

  bool get closeOnPopstate;
  Alignment get popupPosition;

  // The API for subclasses to override - used by this class

  /// {@template flutter.widgets.ModalRoute.barrierDismissible}
  /// Whether you can dismiss this route by tapping the modal barrier.
  ///
  /// The modal barrier is the scrim that is rendered behind each route, which
  /// generally prevents the user from interacting with the route below the
  /// current route, and normally partially obscures such routes.
  ///
  /// For example, when a dialog is on the screen, the page below the dialog is
  /// usually darkened by the modal barrier.
  ///
  /// If [barrierDismissible] is true, then tapping this barrier will cause the
  /// current route to be popped (see [Navigator.pop]) with null as the value.
  ///
  /// If [barrierDismissible] is false, then tapping the barrier has no effect.
  ///
  /// If this getter would ever start returning a different value,
  /// either [changedInternalState] or [changedExternalState] should
  /// be invoked so that the change can take effect.
  ///
  /// It is safe to use `navigator.context` to look up inherited
  /// widgets here, because the [Navigator] calls
  /// [changedExternalState] whenever its dependencies change, and
  /// [changedExternalState] causes the modal barrier to rebuild.
  ///
  /// See also:
  ///
  ///  * [barrierColor], which controls the color of the scrim for this route.
  ///  * [ModalBarrier], the widget that implements this feature.
  /// {@endtemplate}
  bool get barrierDismissible;

  /// Whether the semantics of the modal barrier are included in the
  /// semantics tree.
  ///
  /// The modal barrier is the scrim that is rendered behind each route, which
  /// generally prevents the user from interacting with the route below the
  /// current route, and normally partially obscures such routes.
  ///
  /// If [semanticsDismissible] is true, then modal barrier semantics are
  /// included in the semantics tree.
  ///
  /// If [semanticsDismissible] is false, then modal barrier semantics are
  /// excluded from the semantics tree and tapping on the modal barrier
  /// has no effect.
  ///
  /// If this getter would ever start returning a different value,
  /// either [changedInternalState] or [changedExternalState] should
  /// be invoked so that the change can take effect.
  ///
  /// It is safe to use `navigator.context` to look up inherited
  /// widgets here, because the [Navigator] calls
  /// [changedExternalState] whenever its dependencies change, and
  /// [changedExternalState] causes the modal barrier to rebuild.
  bool get semanticsDismissible => true;

  /// {@template flutter.widgets.ModalRoute.barrierColor}
  /// The color to use for the modal barrier. If this is null, the barrier will
  /// be transparent.
  ///
  /// The modal barrier is the scrim that is rendered behind each route, which
  /// generally prevents the user from interacting with the route below the
  /// current route, and normally partially obscures such routes.
  ///
  /// For example, when a dialog is on the screen, the page below the dialog is
  /// usually darkened by the modal barrier.
  ///
  /// The color is ignored, and the barrier made invisible, when
  /// [ModalRoute.offstage] is true.
  ///
  /// While the route is animating into position, the color is animated from
  /// transparent to the specified color.
  /// {@endtemplate}
  ///
  /// If this getter would ever start returning a different color, one
  /// of the [changedInternalState] or [changedExternalState] methods
  /// should be invoked so that the change can take effect.
  ///
  /// It is safe to use `navigator.context` to look up inherited
  /// widgets here, because the [Navigator] calls
  /// [changedExternalState] whenever its dependencies change, and
  /// [changedExternalState] causes the modal barrier to rebuild.
  ///
  /// {@tool snippet}
  ///
  /// For example, to make the barrier color use the theme's
  /// background color, one could say:
  ///
  /// ```dart
  /// Color get barrierColor => Theme.of(navigator.context).backgroundColor;
  /// ```
  ///
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [barrierDismissible], which controls the behavior of the barrier when
  ///    tapped.
  ///  * [ModalBarrier], the widget that implements this feature.
  Color? get barrierColor;

  /// {@template flutter.widgets.ModalRoute.barrierLabel}
  /// The semantic label used for a dismissible barrier.
  ///
  /// If the barrier is dismissible, this label will be read out if
  /// accessibility tools (like VoiceOver on iOS) focus on the barrier.
  ///
  /// The modal barrier is the scrim that is rendered behind each route, which
  /// generally prevents the user from interacting with the route below the
  /// current route, and normally partially obscures such routes.
  ///
  /// For example, when a dialog is on the screen, the page below the dialog is
  /// usually darkened by the modal barrier.
  /// {@endtemplate}
  ///
  /// If this getter would ever start returning a different label,
  /// either [changedInternalState] or [changedExternalState] should
  /// be invoked so that the change can take effect.
  ///
  /// It is safe to use `navigator.context` to look up inherited
  /// widgets here, because the [Navigator] calls
  /// [changedExternalState] whenever its dependencies change, and
  /// [changedExternalState] causes the modal barrier to rebuild.
  ///
  /// See also:
  ///
  ///  * [barrierDismissible], which controls the behavior of the barrier when
  ///    tapped.
  ///  * [ModalBarrier], the widget that implements this feature.
  String? get barrierLabel;

  /// The curve that is used for animating the modal barrier in and out.
  ///
  /// The modal barrier is the scrim that is rendered behind each route, which
  /// generally prevents the user from interacting with the route below the
  /// current route, and normally partially obscures such routes.
  ///
  /// For example, when a dialog is on the screen, the page below the dialog is
  /// usually darkened by the modal barrier.
  ///
  /// While the route is animating into position, the color is animated from
  /// transparent to the specified [barrierColor].
  ///
  /// If this getter would ever start returning a different curve,
  /// either [changedInternalState] or [changedExternalState] should
  /// be invoked so that the change can take effect.
  ///
  /// It is safe to use `navigator.context` to look up inherited
  /// widgets here, because the [Navigator] calls
  /// [changedExternalState] whenever its dependencies change, and
  /// [changedExternalState] causes the modal barrier to rebuild.
  ///
  /// It defaults to [Curves.ease].
  ///
  /// See also:
  ///
  ///  * [barrierColor], which determines the color that the modal transitions
  ///    to.
  ///  * [Curves] for a collection of common curves.
  ///  * [AnimatedModalBarrier], the widget that implements this feature.
  Curve get barrierCurve => Curves.ease;

  /// {@template flutter.widgets.ModalRoute.maintainState}
  /// Whether the route should remain in memory when it is inactive.
  ///
  /// If this is true, then the route is maintained, so that any futures it is
  /// holding from the next route will properly resolve when the next route
  /// pops. If this is not necessary, this can be set to false to allow the
  /// framework to entirely discard the route's widget hierarchy when it is not
  /// visible.
  /// {@endtemplate}
  ///
  /// If this getter would ever start returning a different value, the
  /// [changedInternalState] should be invoked so that the change can take
  /// effect.
  bool get maintainState;

  // The API for _ModalScope and HeroController

  /// Whether this route is currently offstage.
  ///
  /// On the first frame of a route's entrance transition, the route is built
  /// [Offstage] using an animation progress of 1.0. The route is invisible and
  /// non-interactive, but each widget has its final size and position. This
  /// mechanism lets the [HeroController] determine the final local of any hero
  /// widgets being animated as part of the transition.
  ///
  /// The modal barrier, if any, is not rendered if [offstage] is true (see
  /// [barrierColor]).
  ///
  /// Whenever this changes value, [changedInternalState] is called.
  bool get offstage => _offstage;
  bool _offstage = false;
  set offstage(bool value) {
    if (_offstage == value) {
      return;
    }
    setState(() {
      _offstage = value;
    });
    _animationProxy!.parent =
        _offstage ? kAlwaysCompleteAnimation : super.animation;
    _secondaryAnimationProxy!.parent =
        _offstage ? kAlwaysDismissedAnimation : super.secondaryAnimation;
    changedInternalState();
  }

  /// The build context for the subtree containing the primary content of this route.
  BuildContext? get subtreeContext => _subtreeKey.currentContext;

  @override
  Animation<double>? get animation => _animationProxy;
  ProxyAnimation? _animationProxy;

  @override
  Animation<double>? get secondaryAnimation => _secondaryAnimationProxy;
  ProxyAnimation? _secondaryAnimationProxy;

  final List<WillPopCallback> _willPopCallbacks = <WillPopCallback>[];

  /// Returns [RoutePopDisposition.doNotPop] if any of callbacks added with
  /// [addScopedWillPopCallback] returns either false or null. If they all
  /// return true, the base [Route.willPop]'s result will be returned. The
  /// callbacks will be called in the order they were added, and will only be
  /// called if all previous callbacks returned true.
  ///
  /// Typically this method is not overridden because applications usually
  /// don't create modal routes directly, they use higher level primitives
  /// like [showDialog]. The scoped [WillPopCallback] list makes it possible
  /// for ModalRoute descendants to collectively define the value of `willPop`.
  ///
  /// See also:
  ///
  ///  * [Form], which provides an `onWillPop` callback that uses this mechanism.
  ///  * [addScopedWillPopCallback], which adds a callback to the list this
  ///    method checks.
  ///  * [removeScopedWillPopCallback], which removes a callback from the list
  ///    this method checks.
  @override
  Future<RoutePopDisposition> willPop() async {
    final _ModalScopeState<T>? scope = _scopeKey.currentState;
    assert(scope != null);
    for (final WillPopCallback callback
        in List<WillPopCallback>.from(_willPopCallbacks)) {
      if (await callback() != true) {
        return RoutePopDisposition.doNotPop;
      }
    }
    return await super.willPop();
  }

  /// Enables this route to veto attempts by the user to dismiss it.
  ///
  /// This callback is typically added using a [WillPopScope] widget. That
  /// widget finds the enclosing [ModalRoute] and uses this function to register
  /// this callback:
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return WillPopScope(
  ///     onWillPop: askTheUserIfTheyAreSure,
  ///     child: ...,
  ///   );
  /// }
  /// ```
  ///
  /// This callback runs asynchronously and it's possible that it will be called
  /// after its route has been disposed. The callback should check [State.mounted]
  /// before doing anything.
  ///
  /// A typical application of this callback would be to warn the user about
  /// unsaved [Form] data if the user attempts to back out of the form. In that
  /// case, use the [Form.onWillPop] property to register the callback.
  ///
  /// To register a callback manually, look up the enclosing [ModalRoute] in a
  /// [State.didChangeDependencies] callback:
  ///
  /// ```dart
  /// ModalRoute<dynamic> _route;
  ///
  /// @override
  /// void didChangeDependencies() {
  ///  super.didChangeDependencies();
  ///  _route?.removeScopedWillPopCallback(askTheUserIfTheyAreSure);
  ///  _route = ModalRoute.of(context);
  ///  _route?.addScopedWillPopCallback(askTheUserIfTheyAreSure);
  /// }
  /// ```
  ///
  /// If you register a callback manually, be sure to remove the callback with
  /// [removeScopedWillPopCallback] by the time the widget has been disposed. A
  /// stateful widget can do this in its dispose method (continuing the previous
  /// example):
  ///
  /// ```dart
  /// @override
  /// void dispose() {
  ///   _route?.removeScopedWillPopCallback(askTheUserIfTheyAreSure);
  ///   _route = null;
  ///   super.dispose();
  /// }
  /// ```
  ///
  /// See also:
  ///
  ///  * [WillPopScope], which manages the registration and unregistration
  ///    process automatically.
  ///  * [Form], which provides an `onWillPop` callback that uses this mechanism.
  ///  * [willPop], which runs the callbacks added with this method.
  ///  * [removeScopedWillPopCallback], which removes a callback from the list
  ///    that [willPop] checks.
  void addScopedWillPopCallback(WillPopCallback callback) {
    assert(_scopeKey.currentState != null,
        'Tried to add a willPop callback to a route that is not currently in the tree.');
    _willPopCallbacks.add(callback);
  }

  /// Remove one of the callbacks run by [willPop].
  ///
  /// See also:
  ///
  ///  * [Form], which provides an `onWillPop` callback that uses this mechanism.
  ///  * [addScopedWillPopCallback], which adds callback to the list
  ///    checked by [willPop].
  void removeScopedWillPopCallback(WillPopCallback callback) {
    assert(_scopeKey.currentState != null,
        'Tried to remove a willPop callback from a route that is not currently in the tree.');
    _willPopCallbacks.remove(callback);
  }

  /// True if one or more [WillPopCallback] callbacks exist.
  ///
  /// This method is used to disable the horizontal swipe pop gesture supported
  /// by [MaterialPageRoute] for [TargetPlatform.iOS] and
  /// [TargetPlatform.macOS]. If a pop might be vetoed, then the back gesture is
  /// disabled.
  ///
  /// The [buildTransitions] method will not be called again if this changes,
  /// since it can change during the build as descendants of the route add or
  /// remove callbacks.
  ///
  /// See also:
  ///
  ///  * [addScopedWillPopCallback], which adds a callback.
  ///  * [removeScopedWillPopCallback], which removes a callback.
  ///  * [willHandlePopInternally], which reports on another reason why
  ///    a pop might be vetoed.
  @protected
  bool get hasScopedWillPopCallback {
    return _willPopCallbacks.isNotEmpty;
  }

  @override
  void didChangePrevious(Route<dynamic>? previousRoute) {
    super.didChangePrevious(previousRoute);
    changedInternalState();
  }

  @override
  void changedInternalState() {
    super.changedInternalState();
    setState(() {/* internal state already changed */});
    _modalBarrier.markNeedsBuild();
    _modalScope.maintainState = maintainState;
  }

  @override
  void changedExternalState() {
    super.changedExternalState();
    _modalBarrier.markNeedsBuild();
    if (_scopeKey.currentState != null)
      _scopeKey.currentState!._forceRebuildPage();
  }

  /// Whether this route can be popped.
  ///
  /// A route can be popped if there is at least one active route below it, or
  /// if [willHandlePopInternally] returns true.
  ///
  /// When this changes, if the route is visible, the route will
  /// rebuild, and any widgets that used [ModalRoute.of] will be
  /// notified.
  bool get canPop => hasActiveRouteBelow || willHandlePopInternally;

  // Internals

  final GlobalKey<_ModalScopeState<T>> _scopeKey =
      GlobalKey<_ModalScopeState<T>>();
  final GlobalKey _subtreeKey = GlobalKey();
  final PageStorageBucket _storageBucket = PageStorageBucket();

  // one of the builders
  late OverlayEntry _modalBarrier;
  Widget _buildModalBarrier(BuildContext context) {
    Widget barrier;
    if (barrierColor != null && barrierColor!.alpha != 0 && !offstage) {
      // changedInternalState is called if barrierColor or offstage updates
      assert(barrierColor != barrierColor!.withOpacity(0.0));
      final Animation<Color?> color = animation!.drive(
        ColorTween(
          begin: barrierColor!.withOpacity(0.0),
          end:
              barrierColor, // changedInternalState is called if barrierColor updates
        ).chain(CurveTween(
            curve:
                barrierCurve)), // changedInternalState is called if barrierCurve updates
      );
      barrier = FlanAnimatedModalBarrier(
        color: color,
        dismissible:
            barrierDismissible, // changedInternalState is called if barrierDismissible updates
        semanticsLabel:
            barrierLabel, // changedInternalState is called if barrierLabel updates
        barrierSemanticsDismissible: semanticsDismissible,
      );
    } else {
      barrier = FlanModalBarrier(
        dismissible:
            barrierDismissible, // changedInternalState is called if barrierDismissible updates
        semanticsLabel:
            barrierLabel, // changedInternalState is called if barrierLabel updates
        barrierSemanticsDismissible: semanticsDismissible,
      );
    }
    if (filter != null) {
      barrier = BackdropFilter(
        filter: filter!,
        child: barrier,
      );
    }
    barrier = IgnorePointer(
      ignoring: animation!.status ==
              AnimationStatus
                  .reverse || // changedInternalState is called when animation.status updates
          animation!.status ==
              AnimationStatus
                  .dismissed, // dismissed is possible when doing a manual pop gesture
      child: barrier,
    );
    if (semanticsDismissible && barrierDismissible) {
      // To be sorted after the _modalScope.
      barrier = Semantics(
        sortKey: const OrdinalSortKey(1.0),
        child: barrier,
      );
    }
    return _FlanPopupProvider(
      onOverlayClick: onOverlayClick,
      child: barrier,
    );
  }

  // We cache the part of the modal scope that doesn't change from frame to
  // frame so that we minimize the amount of building that happens.
  Widget? _modalScopeCache;

  // one of the builders
  Widget _buildModalScope(BuildContext context) {
    // To be sorted before the _modalBarrier.
    return _modalScopeCache ??= Semantics(
        sortKey: const OrdinalSortKey(0.0),
        child: _ModalScope<T>(
          key: _scopeKey,
          route: this,
          // _ModalScope calls buildTransitions() and buildChild(), defined above
        ));
  }

  late OverlayEntry _modalScope;

  @override
  Iterable<OverlayEntry> createOverlayEntries() sync* {
    yield _modalBarrier = OverlayEntry(builder: _buildModalBarrier);
    yield _modalScope =
        OverlayEntry(builder: _buildModalScope, maintainState: maintainState);
  }

  @override
  String toString() =>
      '${objectRuntimeType(this, 'ModalRoute')}($settings, animation: $_animation)';
}

abstract class FlanTransitionRoute<T> extends FlanOverlayRoute<T> {
  /// Creates a route that animates itself when it is pushed or popped.
  FlanTransitionRoute({
    RouteSettings? settings,
  }) : super(settings: settings);

  /// This future completes only once the transition itself has finished, after
  /// the overlay entries have been removed from the navigator's overlay.
  ///
  /// This future completes once the animation has been dismissed. That will be
  /// after [popped], because [popped] typically completes before the animation
  /// even starts, as soon as the route is popped.
  Future<T?> get completed => _transitionCompleter.future;
  final Completer<T?> _transitionCompleter = Completer<T?>();

  /// {@template flutter.widgets.TransitionRoute.transitionDuration}
  /// The duration the transition going forwards.
  ///
  /// See also:
  ///
  /// * [reverseTransitionDuration], which controls the duration of the
  /// transition when it is in reverse.
  /// {@endtemplate}
  Duration get transitionDuration;

  /// {@template flutter.widgets.TransitionRoute.reverseTransitionDuration}
  /// The duration the transition going in reverse.
  ///
  /// By default, the reverse transition duration is set to the value of
  /// the forwards [transitionDuration].
  /// {@endtemplate}
  Duration get reverseTransitionDuration => transitionDuration;

  /// {@template flutter.widgets.TransitionRoute.opaque}
  /// Whether the route obscures previous routes when the transition is complete.
  ///
  /// When an opaque route's entrance transition is complete, the routes behind
  /// the opaque route will not be built to save resources.
  /// {@endtemplate}
  bool get opaque;

  // This ensures that if we got to the dismissed state while still current,
  // we will still be disposed when we are eventually popped.
  //
  // This situation arises when dealing with the Cupertino dismiss gesture.
  @override
  bool get finishedWhenPopped =>
      _controller!.status == AnimationStatus.dismissed;

  /// The animation that drives the route's transition and the previous route's
  /// forward transition.
  Animation<double>? get animation => _animation;
  Animation<double>? _animation;

  /// The animation controller that the route uses to drive the transitions.
  ///
  /// The animation itself is exposed by the [animation] property.
  @protected
  AnimationController? get controller => _controller;
  AnimationController? _controller;

  /// The animation for the route being pushed on top of this route. This
  /// animation lets this route coordinate with the entrance and exit transition
  /// of route pushed on top of this route.
  Animation<double>? get secondaryAnimation => _secondaryAnimation;
  final ProxyAnimation _secondaryAnimation =
      ProxyAnimation(kAlwaysDismissedAnimation);

  /// Called to create the animation controller that will drive the transitions to
  /// this route from the previous one, and back to the previous route from this
  /// one.
  AnimationController createAnimationController() {
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    final Duration duration = transitionDuration;
    final Duration reverseDuration = reverseTransitionDuration;
    assert(duration >= Duration.zero);
    return AnimationController(
      duration: duration,
      reverseDuration: reverseDuration,
      debugLabel: debugLabel,
      vsync: navigator!,
    );
  }

  /// Called to create the animation that exposes the current progress of
  /// the transition controlled by the animation controller created by
  /// [createAnimationController()].
  Animation<double> createAnimation() {
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    assert(_controller != null);
    return _controller!.view;
  }

  T? _result;

  void _handleStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        if (overlayEntries.isNotEmpty) {
          overlayEntries.first.opaque = opaque;
        }
        break;
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        if (overlayEntries.isNotEmpty) {
          overlayEntries.first.opaque = false;
        }
        break;
      case AnimationStatus.dismissed:
        // We might still be an active route if a subclass is controlling the
        // transition and hits the dismissed status. For example, the iOS
        // back gesture drives this animation to the dismissed status before
        // removing the route and disposing it.
        if (!isActive) {
          navigator!.finalizeRoute(this);
        }
        break;
    }
  }

  @override
  void install() {
    assert(!_transitionCompleter.isCompleted,
        'Cannot install a $runtimeType after disposing it.');
    _controller = createAnimationController();
    assert(_controller != null,
        '$runtimeType.createAnimationController() returned null.');
    _animation = createAnimation()..addStatusListener(_handleStatusChanged);
    assert(_animation != null, '$runtimeType.createAnimation() returned null.');
    super.install();
    if (_animation!.isCompleted && overlayEntries.isNotEmpty) {
      overlayEntries.first.opaque = opaque;
    }
  }

  @override
  TickerFuture didPush() {
    assert(_controller != null,
        '$runtimeType.didPush called before calling install() or after calling dispose().');
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    super.didPush();
    return _controller!.forward();
  }

  @override
  void didAdd() {
    assert(_controller != null,
        '$runtimeType.didPush called before calling install() or after calling dispose().');
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    super.didAdd();
    _controller!.value = _controller!.upperBound;
  }

  @override
  void didReplace(Route<dynamic>? oldRoute) {
    assert(_controller != null,
        '$runtimeType.didReplace called before calling install() or after calling dispose().');
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    if (oldRoute is FlanTransitionRoute)
      _controller!.value = oldRoute._controller!.value;
    super.didReplace(oldRoute);
  }

  @override
  bool didPop(T? result) {
    assert(_controller != null,
        '$runtimeType.didPop called before calling install() or after calling dispose().');
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    _result = result;
    _controller!.reverse();
    return super.didPop(result);
  }

  @override
  void didPopNext(Route<dynamic> nextRoute) {
    assert(_controller != null,
        '$runtimeType.didPopNext called before calling install() or after calling dispose().');
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    _updateSecondaryAnimation(nextRoute);
    super.didPopNext(nextRoute);
  }

  @override
  void didChangeNext(Route<dynamic>? nextRoute) {
    assert(_controller != null,
        '$runtimeType.didChangeNext called before calling install() or after calling dispose().');
    assert(!_transitionCompleter.isCompleted,
        'Cannot reuse a $runtimeType after disposing it.');
    _updateSecondaryAnimation(nextRoute);
    super.didChangeNext(nextRoute);
  }

  // A callback method that disposes existing train hopping animation and
  // removes its listener.
  //
  // This property is non-null if there is a train hopping in progress, and the
  // caller must reset this property to null after it is called.
  VoidCallback? _trainHoppingListenerRemover;

  void _updateSecondaryAnimation(Route<dynamic>? nextRoute) {
    // There is an existing train hopping in progress. Unfortunately, we cannot
    // dispose current train hopping animation until we replace it with a new
    // animation.
    final VoidCallback? previousTrainHoppingListenerRemover =
        _trainHoppingListenerRemover;
    _trainHoppingListenerRemover = null;

    if (nextRoute is FlanTransitionRoute<dynamic> &&
        canTransitionTo(nextRoute) &&
        nextRoute.canTransitionFrom(this)) {
      final Animation<double>? current = _secondaryAnimation.parent;
      if (current != null) {
        final Animation<double> currentTrain = (current is TrainHoppingAnimation
            ? current.currentTrain
            : current)!;
        final Animation<double> nextTrain = nextRoute._animation!;
        if (currentTrain.value == nextTrain.value ||
            nextTrain.status == AnimationStatus.completed ||
            nextTrain.status == AnimationStatus.dismissed) {
          _setSecondaryAnimation(nextTrain, nextRoute.completed);
        } else {
          // Two trains animate at different values. We have to do train hopping.
          // There are three possibilities of train hopping:
          //  1. We hop on the nextTrain when two trains meet in the middle using
          //     TrainHoppingAnimation.
          //  2. There is no chance to hop on nextTrain because two trains never
          //     cross each other. We have to directly set the animation to
          //     nextTrain once the nextTrain stops animating.
          //  3. A new _updateSecondaryAnimation is called before train hopping
          //     finishes. We leave a listener remover for the next call to
          //     properly clean up the existing train hopping.
          TrainHoppingAnimation? newAnimation;
          void _jumpOnAnimationEnd(AnimationStatus status) {
            switch (status) {
              case AnimationStatus.completed:
              case AnimationStatus.dismissed:
                // The nextTrain has stopped animating without train hopping.
                // Directly sets the secondary animation and disposes the
                // TrainHoppingAnimation.
                _setSecondaryAnimation(nextTrain, nextRoute.completed);
                if (_trainHoppingListenerRemover != null) {
                  _trainHoppingListenerRemover!();
                  _trainHoppingListenerRemover = null;
                }
                break;
              case AnimationStatus.forward:
              case AnimationStatus.reverse:
                break;
            }
          }

          _trainHoppingListenerRemover = () {
            nextTrain.removeStatusListener(_jumpOnAnimationEnd);
            newAnimation?.dispose();
          };
          nextTrain.addStatusListener(_jumpOnAnimationEnd);
          newAnimation = TrainHoppingAnimation(
            currentTrain,
            nextTrain,
            onSwitchedTrain: () {
              assert(_secondaryAnimation.parent == newAnimation);
              assert(newAnimation!.currentTrain == nextRoute._animation);
              // We can hop on the nextTrain, so we don't need to listen to
              // whether the nextTrain has stopped.
              _setSecondaryAnimation(
                  newAnimation!.currentTrain, nextRoute.completed);
              if (_trainHoppingListenerRemover != null) {
                _trainHoppingListenerRemover!();
                _trainHoppingListenerRemover = null;
              }
            },
          );
          _setSecondaryAnimation(newAnimation, nextRoute.completed);
        }
      } else {
        _setSecondaryAnimation(nextRoute._animation, nextRoute.completed);
      }
    } else {
      _setSecondaryAnimation(kAlwaysDismissedAnimation);
    }
    // Finally, we dispose any previous train hopping animation because it
    // has been successfully updated at this point.
    if (previousTrainHoppingListenerRemover != null) {
      previousTrainHoppingListenerRemover();
    }
  }

  void _setSecondaryAnimation(Animation<double>? animation,
      [Future<dynamic>? disposed]) {
    _secondaryAnimation.parent = animation;
    // Releases the reference to the next route's animation when that route
    // is disposed.
    disposed?.then((dynamic _) {
      if (_secondaryAnimation.parent == animation) {
        _secondaryAnimation.parent = kAlwaysDismissedAnimation;
        if (animation is TrainHoppingAnimation) {
          animation.dispose();
        }
      }
    });
  }

  /// Returns true if this route supports a transition animation that runs
  /// when [nextRoute] is pushed on top of it or when [nextRoute] is popped
  /// off of it.
  ///
  /// Subclasses can override this method to restrict the set of routes they
  /// need to coordinate transitions with.
  ///
  /// If true, and `nextRoute.canTransitionFrom()` is true, then the
  /// [ModalRoute.buildTransitions] `secondaryAnimation` will run from 0.0 - 1.0
  /// when [nextRoute] is pushed on top of this one.  Similarly, if
  /// the [nextRoute] is popped off of this route, the
  /// `secondaryAnimation` will run from 1.0 - 0.0.
  ///
  /// If false, this route's [ModalRoute.buildTransitions] `secondaryAnimation` parameter
  /// value will be [kAlwaysDismissedAnimation]. In other words, this route
  /// will not animate when when [nextRoute] is pushed on top of it or when
  /// [nextRoute] is popped off of it.
  ///
  /// Returns true by default.
  ///
  /// See also:
  ///
  ///  * [canTransitionFrom], which must be true for [nextRoute] for the
  ///    [ModalRoute.buildTransitions] `secondaryAnimation` to run.
  bool canTransitionTo(FlanTransitionRoute<dynamic> nextRoute) => true;

  /// Returns true if [previousRoute] should animate when this route
  /// is pushed on top of it or when then this route is popped off of it.
  ///
  /// Subclasses can override this method to restrict the set of routes they
  /// need to coordinate transitions with.
  ///
  /// If true, and `previousRoute.canTransitionTo()` is true, then the
  /// previous route's [ModalRoute.buildTransitions] `secondaryAnimation` will
  /// run from 0.0 - 1.0 when this route is pushed on top of
  /// it. Similarly, if this route is popped off of [previousRoute]
  /// the previous route's `secondaryAnimation` will run from 1.0 - 0.0.
  ///
  /// If false, then the previous route's [ModalRoute.buildTransitions]
  /// `secondaryAnimation` value will be kAlwaysDismissedAnimation. In
  /// other words [previousRoute] will not animate when this route is
  /// pushed on top of it or when then this route is popped off of it.
  ///
  /// Returns true by default.
  ///
  /// See also:
  ///
  ///  * [canTransitionTo], which must be true for [previousRoute] for its
  ///    [ModalRoute.buildTransitions] `secondaryAnimation` to run.
  bool canTransitionFrom(FlanTransitionRoute<dynamic> previousRoute) => true;

  @override
  void dispose() {
    assert(!_transitionCompleter.isCompleted,
        'Cannot dispose a $runtimeType twice.');
    _controller?.dispose();
    _transitionCompleter.complete(_result);
    super.dispose();
  }

  /// A short description of this route useful for debugging.
  String get debugLabel => objectRuntimeType(this, 'TransitionRoute');

  @override
  String toString() =>
      '${objectRuntimeType(this, 'FlanTransitionRoute')}(animation: $_controller)';
}

/// A route that displays widgets in the [Navigator]'s [Overlay].
abstract class FlanOverlayRoute<T> extends Route<T> {
  /// Creates a route that knows how to interact with an [Overlay].
  FlanOverlayRoute({
    RouteSettings? settings,
  }) : super(settings: settings);

  /// Subclasses should override this getter to return the builders for the overlay.
  @factory
  Iterable<OverlayEntry> createOverlayEntries();

  @override
  List<OverlayEntry> get overlayEntries => _overlayEntries;
  final List<OverlayEntry> _overlayEntries = <OverlayEntry>[];

  @override
  void install() {
    assert(_overlayEntries.isEmpty);
    _overlayEntries.addAll(createOverlayEntries());
    super.install();
  }

  /// Controls whether [didPop] calls [NavigatorState.finalizeRoute].
  ///
  /// If true, this route removes its overlay entries during [didPop].
  /// Subclasses can override this getter if they want to delay finalization
  /// (for example to animate the route's exit before removing it from the
  /// overlay).
  ///
  /// Subclasses that return false from [finishedWhenPopped] are responsible for
  /// calling [NavigatorState.finalizeRoute] themselves.
  @protected
  bool get finishedWhenPopped => true;

  VoidCallback? get onOverlayClick => null;

  @override
  bool didPop(T? result) {
    final bool returnValue = super.didPop(result);
    assert(returnValue);
    if (finishedWhenPopped) {
      navigator!.finalizeRoute(this);
    }
    return returnValue;
  }

  @override
  void dispose() {
    _overlayEntries.clear();
    super.dispose();
  }
}

class _ModalScopeStatus extends InheritedWidget {
  const _ModalScopeStatus({
    Key? key,
    required this.isCurrent,
    required this.canPop,
    required this.route,
    required Widget child,
  }) : super(key: key, child: child);

  final bool isCurrent;
  final bool canPop;
  final Route<dynamic> route;

  @override
  bool updateShouldNotify(_ModalScopeStatus old) {
    return isCurrent != old.isCurrent ||
        canPop != old.canPop ||
        route != old.route;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(FlagProperty('isCurrent',
        value: isCurrent, ifTrue: 'active', ifFalse: 'inactive'));
    description.add(FlagProperty('canPop', value: canPop, ifTrue: 'can pop'));
  }
}

class _ModalScope<T> extends StatefulWidget {
  const _ModalScope({
    Key? key,
    required this.route,
  }) : super(key: key);

  final FlanModalRoute<T> route;

  @override
  _ModalScopeState<T> createState() => _ModalScopeState<T>();
}

class _ModalScopeState<T> extends State<_ModalScope<T>> {
  // We cache the result of calling the route's buildPage, and clear the cache
  // whenever the dependencies change. This implements the contract described in
  // the documentation for buildPage, namely that it gets called once, unless
  // something like a ModalRoute.of() dependency triggers an update.
  Widget? _page;

  // This is the combination of the two animations for the route.
  late Listenable _listenable;

  /// The node this scope will use for its root [FocusScope] widget.
  final FocusScopeNode focusScopeNode =
      FocusScopeNode(debugLabel: '$_ModalScopeState Focus Scope');
  final ScrollController primaryScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final List<Listenable> animations = <Listenable>[
      if (widget.route.animation != null) widget.route.animation!,
      if (widget.route.secondaryAnimation != null)
        widget.route.secondaryAnimation!,
    ];
    _listenable = Listenable.merge(animations);
    if (widget.route.isCurrent) {
      widget.route.navigator!.focusScopeNode.setFirstFocus(focusScopeNode);
    }
  }

  @override
  void didUpdateWidget(_ModalScope<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.route == oldWidget.route);
    if (widget.route.isCurrent) {
      widget.route.navigator!.focusScopeNode.setFirstFocus(focusScopeNode);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _page = null;
  }

  void _forceRebuildPage() {
    setState(() {
      _page = null;
    });
  }

  @override
  void dispose() {
    focusScopeNode.dispose();
    super.dispose();
  }

  bool get _shouldIgnoreFocusRequest {
    return widget.route.animation?.status == AnimationStatus.reverse ||
        (widget.route.navigator?.userGestureInProgress ?? false);
  }

  // This should be called to wrap any changes to route.isCurrent, route.canPop,
  // and route.offstage.
  void _routeSetState(VoidCallback fn) {
    if (widget.route.isCurrent && !_shouldIgnoreFocusRequest) {
      widget.route.navigator!.focusScopeNode.setFirstFocus(focusScopeNode);
    }
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.route.restorationScopeId,
      builder: (BuildContext context, Widget? child) {
        assert(child != null);
        return RestorationScope(
          restorationId: widget.route.restorationScopeId.value,
          child: child!,
        );
      },
      child: _ModalScopeStatus(
        route: widget.route,
        isCurrent:
            widget.route.isCurrent, // _routeSetState is called if this updates
        canPop: widget.route.canPop, // _routeSetState is called if this updates
        child: Offstage(
          offstage:
              widget.route.offstage, // _routeSetState is called if this updates
          child: PageStorage(
            bucket: widget.route._storageBucket, // immutable
            child: Builder(
              builder: (BuildContext context) {
                return Actions(
                  actions: <Type, Action<Intent>>{
                    DismissIntent: _DismissModalAction(context),
                  },
                  child: PrimaryScrollController(
                    controller: primaryScrollController,
                    child: FocusScope(
                      node: focusScopeNode, // immutable
                      child: RepaintBoundary(
                        child: Align(
                          alignment: widget.route.popupPosition,
                          child: UnconstrainedBox(
                            child: AnimatedBuilder(
                              animation: _listenable, // immutable
                              builder: (BuildContext context, Widget? child) {
                                return widget.route.buildTransitions(
                                  context,
                                  widget.route.animation!,
                                  widget.route.secondaryAnimation!,
                                  // This additional AnimatedBuilder is include because if the
                                  // value of the userGestureInProgressNotifier changes, it's
                                  // only necessary to rebuild the IgnorePointer widget and set
                                  // the focus node's ability to focus.
                                  AnimatedBuilder(
                                    animation: widget.route.navigator
                                            ?.userGestureInProgressNotifier ??
                                        ValueNotifier<bool>(false),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      final bool ignoreEvents =
                                          _shouldIgnoreFocusRequest;
                                      focusScopeNode.canRequestFocus =
                                          !ignoreEvents;
                                      return IgnorePointer(
                                        ignoring: ignoreEvents,
                                        child: child,
                                      );
                                    },
                                    child: child,
                                  ),
                                );
                              },
                              child: _page ??= RepaintBoundary(
                                key: widget.route._subtreeKey, // immutable
                                child: Builder(
                                  builder: (BuildContext context) {
                                    return widget.route.buildPage(
                                      context,
                                      widget.route.animation!,
                                      widget.route.secondaryAnimation!,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _DismissModalAction extends DismissAction {
  _DismissModalAction(this.context);

  final BuildContext context;

  @override
  bool isEnabled(DismissIntent intent) {
    final ModalRoute<dynamic> route = ModalRoute.of<dynamic>(context)!;
    return route.barrierDismissible;
  }

  @override
  Object invoke(DismissIntent intent) {
    return Navigator.of(context).maybePop(<Symbol, FlanPopupCloseFromType>{
      FLANPOPUP_CLOSE_FROM: FlanPopupCloseFromType.backBtn
    });
  }
}

/// A widget that prevents the user from interacting with widgets behind itself.
///
/// The modal barrier is the scrim that is rendered behind each route, which
/// generally prevents the user from interacting with the route below the
/// current route, and normally partially obscures such routes.
///
/// For example, when a dialog is on the screen, the page below the dialog is
/// usually darkened by the modal barrier.
///
/// See also:
///
///  * [ModalRoute], which indirectly uses this widget.
///  * [AnimatedModalBarrier], which is similar but takes an animated [color]
///    instead of a single color value.
class FlanModalBarrier extends StatelessWidget {
  /// Creates a widget that blocks user interaction.
  const FlanModalBarrier({
    Key? key,
    this.color,
    this.dismissible = true,
    this.semanticsLabel,
    this.barrierSemanticsDismissible = true,
  }) : super(key: key);

  /// If non-null, fill the barrier with this color.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierColor], which controls this property for the
  ///    [ModalBarrier] built by [ModalRoute] pages.
  final Color? color;

  /// Whether touching the barrier will pop the current route off the [Navigator].
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierDismissible], which controls this property for the
  ///    [ModalBarrier] built by [ModalRoute] pages.
  final bool dismissible;

  /// Whether the modal barrier semantics are included in the semantics tree.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.semanticsDismissible], which controls this property for
  ///    the [ModalBarrier] built by [ModalRoute] pages.
  final bool? barrierSemanticsDismissible;

  /// Semantics label used for the barrier if it is [dismissible].
  ///
  /// The semantics label is read out by accessibility tools (e.g. TalkBack
  /// on Android and VoiceOver on iOS) when the barrier is focused.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierLabel], which controls this property for the
  ///    [ModalBarrier] built by [ModalRoute] pages.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    assert(!dismissible ||
        semanticsLabel == null ||
        debugCheckHasDirectionality(context));
    final bool platformSupportsDismissingBarrier;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        platformSupportsDismissingBarrier = false;
        break;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        platformSupportsDismissingBarrier = true;
        break;
    }
    final bool semanticsDismissible =
        dismissible && platformSupportsDismissingBarrier;
    final bool modalBarrierSemanticsDismissible =
        barrierSemanticsDismissible ?? semanticsDismissible;
    return BlockSemantics(
      child: ExcludeSemantics(
        // On Android, the back button is used to dismiss a modal. On iOS, some
        // modal barriers are not dismissible in accessibility mode.
        excluding: !semanticsDismissible || !modalBarrierSemanticsDismissible,
        child: _ModalBarrierGestureDetector(
          onDismiss: () {
            final VoidCallback? onOverlayClick =
                _FlanPopupProvider.of(context)?.onOverlayClick;
            if (onOverlayClick != null) {
              onOverlayClick();
            }
            if (dismissible)
              Navigator.maybePop(
                context,
                <Symbol, FlanPopupCloseFromType>{
                  FLANPOPUP_CLOSE_FROM: FlanPopupCloseFromType.overlay
                },
              );
            else
              SystemSound.play(SystemSoundType.alert);
          },
          child: Semantics(
            label: semanticsDismissible ? semanticsLabel : null,
            textDirection: semanticsDismissible && semanticsLabel != null
                ? Directionality.of(context)
                : null,
            child: MouseRegion(
              cursor: SystemMouseCursors.basic,
              opaque: true,
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: color == null
                    ? null
                    : ColoredBox(
                        color: color!,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget that prevents the user from interacting with widgets behind itself,
/// and can be configured with an animated color value.
///
/// The modal barrier is the scrim that is rendered behind each route, which
/// generally prevents the user from interacting with the route below the
/// current route, and normally partially obscures such routes.
///
/// For example, when a dialog is on the screen, the page below the dialog is
/// usually darkened by the modal barrier.
///
/// This widget is similar to [ModalBarrier] except that it takes an animated
/// [color] instead of a single color.
///
/// See also:
///
///  * [ModalRoute], which uses this widget.
class FlanAnimatedModalBarrier extends AnimatedWidget {
  /// Creates a widget that blocks user interaction.
  const FlanAnimatedModalBarrier({
    Key? key,
    required Animation<Color?> color,
    this.dismissible = true,
    this.semanticsLabel,
    this.barrierSemanticsDismissible,
  }) : super(key: key, listenable: color);

  /// If non-null, fill the barrier with this color.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierColor], which controls this property for the
  ///    [AnimatedModalBarrier] built by [ModalRoute] pages.
  Animation<Color?> get color => listenable as Animation<Color?>;

  /// Whether touching the barrier will pop the current route off the [Navigator].
  ///
  /// See also:
  ///
  ///  * [ModalRoute.barrierDismissible], which controls this property for the
  ///    [AnimatedModalBarrier] built by [ModalRoute] pages.
  final bool dismissible;

  /// Semantics label used for the barrier if it is [dismissible].
  ///
  /// The semantics label is read out by accessibility tools (e.g. TalkBack
  /// on Android and VoiceOver on iOS) when the barrier is focused.
  /// See also:
  ///
  ///  * [ModalRoute.barrierLabel], which controls this property for the
  ///    [ModalBarrier] built by [ModalRoute] pages.
  final String? semanticsLabel;

  /// Whether the modal barrier semantics are included in the semantics tree.
  ///
  /// See also:
  ///
  ///  * [ModalRoute.semanticsDismissible], which controls this property for
  ///    the [ModalBarrier] built by [ModalRoute] pages.
  final bool? barrierSemanticsDismissible;

  @override
  Widget build(BuildContext context) {
    return FlanModalBarrier(
      color: color.value,
      dismissible: dismissible,
      semanticsLabel: semanticsLabel,
      barrierSemanticsDismissible: barrierSemanticsDismissible,
    );
  }
}

// Recognizes tap down by any pointer button.
//
// It is similar to [TapGestureRecognizer.onTapDown], but accepts any single
// button, which means the gesture also takes parts in gesture arenas.
class _AnyTapGestureRecognizer extends BaseTapGestureRecognizer {
  _AnyTapGestureRecognizer({Object? debugOwner})
      : super(debugOwner: debugOwner);

  VoidCallback? onAnyTapUp;

  @protected
  @override
  bool isPointerAllowed(PointerDownEvent event) {
    if (onAnyTapUp == null) {
      return false;
    }
    return super.isPointerAllowed(event);
  }

  @protected
  @override
  void handleTapDown({PointerDownEvent? down}) {
    // Do nothing.
  }

  @protected
  @override
  void handleTapUp({PointerDownEvent? down, PointerUpEvent? up}) {
    if (onAnyTapUp != null) {
      onAnyTapUp!();
    }
  }

  @protected
  @override
  void handleTapCancel(
      {PointerDownEvent? down, PointerCancelEvent? cancel, String? reason}) {
    // Do nothing.
  }

  @override
  String get debugDescription => 'any tap';
}

class _ModalBarrierSemanticsDelegate extends SemanticsGestureDelegate {
  const _ModalBarrierSemanticsDelegate({this.onDismiss});

  final VoidCallback? onDismiss;

  @override
  void assignSemantics(RenderSemanticsGestureHandler renderObject) {
    renderObject.onTap = onDismiss;
  }
}

class _AnyTapGestureRecognizerFactory
    extends GestureRecognizerFactory<_AnyTapGestureRecognizer> {
  const _AnyTapGestureRecognizerFactory({this.onAnyTapUp});

  final VoidCallback? onAnyTapUp;

  @override
  _AnyTapGestureRecognizer constructor() => _AnyTapGestureRecognizer();

  @override
  void initializer(_AnyTapGestureRecognizer instance) {
    instance.onAnyTapUp = onAnyTapUp;
  }
}

// A GestureDetector used by ModalBarrier. It only has one callback,
// [onAnyTapDown], which recognizes tap down unconditionally.
class _ModalBarrierGestureDetector extends StatelessWidget {
  const _ModalBarrierGestureDetector({
    Key? key,
    required this.child,
    required this.onDismiss,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  /// See [RawGestureDetector.child].
  final Widget child;

  /// Immediately called when an event that should dismiss the modal barrier
  /// has happened.
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final Map<Type, GestureRecognizerFactory> gestures =
        <Type, GestureRecognizerFactory>{
      _AnyTapGestureRecognizer:
          _AnyTapGestureRecognizerFactory(onAnyTapUp: onDismiss),
    };

    return RawGestureDetector(
      gestures: gestures,
      behavior: HitTestBehavior.opaque,
      semantics: _ModalBarrierSemanticsDelegate(onDismiss: onDismiss),
      child: child,
    );
  }
}
