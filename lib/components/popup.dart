import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import './icon.dart' show FlanIcon, FlanIcons;
import '../styles/var.dart';

/// ### FlanPopup 列布局
/// 弹出层容器，用于展示弹窗、信息提示等内容，支持多个弹出层叠加展示。
class FlanPopup extends StatefulWidget {
  const FlanPopup({
    Key? key,
    required this.show,
    this.overlay = true,
    this.position = FlanPopupPosition.center,
    this.style,
    this.overlayStyle,
    this.duration,
    this.round = false,
    // this.lockScroll = true,
    // this.lazyRender = true,
    // this.closeOnPopstate = false,
    this.closeOnClickOverlay = true,
    this.closeable = false,
    this.closeIconName = FlanIcons.cross,
    this.closeIconUrl,
    this.closeIconPosition = FlanPopupCloseIconPosition.topRight,
    this.transitionBuilder,
    this.transitionAppearBuilder,
    this.transitionAppear = false,
    this.safeAreaInsetBottom = false,
    required this.onChange,
    this.onClick,
    // this.onClickOverlay,
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

  // /// 是否在页面回退时自动关闭
  // final bool closeOnPopstate;

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
  // final GestureTapCallback onClickOverlay;

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
    if (this.widget.show) {
      this.openPopup();
    }
  }

  @override
  void didUpdateWidget(covariant FlanPopup oldWidget) {
    if (!oldWidget.show && this.widget.show) {
      this.openPopup();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }

  Alignment get _popupAlign {
    return {
      FlanPopupPosition.center: Alignment.center,
      FlanPopupPosition.bottom: Alignment.bottomLeft,
      FlanPopupPosition.top: Alignment.topLeft,
      FlanPopupPosition.left: Alignment.centerLeft,
      FlanPopupPosition.right: Alignment.centerRight,
    }[this.widget.position]!;
  }

  BorderRadius get _roundRadius {
    const radius = Radius.circular(ThemeVars.popupRoundBorderRadius);
    switch (this.widget.position) {
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

  RouteTransitionsBuilder get _popupTransitionsBuilder {
    if (this.widget.transitionAppear && this.isFirstOpen) {
      return this.widget.transitionAppearBuilder!;
    }

    return this.widget.transitionBuilder ??
        this._buildMaterialDialogTransitions;
  }

  void closePopup() {
    if (this.opened) {
      this.opened = false;
      if (this.widget.onClose != null) {
        this.widget.onClose!();
      }
      this.widget.onChange(false);
    }
  }

  void openPopup() {
    if (this.opened) {
      return;
    }
    this.opened = true;

    if (this.widget.onOpen != null) {
      this.widget.onOpen!();
    }

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.of(context, rootNavigator: true)
          .push(_FlanPopupRoute(
            pageBuilder: (
              BuildContext buildContext,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              Widget dialog = this._buildPopupContent();
              if (this.widget.safeAreaInsetBottom) {
                dialog = SafeArea(child: dialog);
              }
              return dialog;
            },
            barrierDismissible: this.widget.closeOnClickOverlay,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: this.widget.overlayStyle?.color ??
                ThemeVars.overlayBackgroundColor,
            transitionDuration:
                this.widget.duration ?? ThemeVars.popupTransitionDuration,
            transitionBuilder: this._popupTransitionsBuilder,
            onTransitionRouteEnter: () {
              if (this.isFirstOpen) {
                this.isFirstOpen = false;
              }
              if (this.widget.onOpened != null) {
                this.widget.onOpened!();
              }
            },
            onTransitionRouteLeave: () {
              if (this.widget.onClosed != null) {
                this.widget.onClosed!();
              }
            },
          ))
          .then((value) => this.closePopup());
    });
  }

  Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = CurvedAnimation(
      parent: animation,
      curve: this.widget.show
          ? ThemeVars.animationTimingFunctionEnter
          : ThemeVars.animationTimingFunctionLeave,
    );

    switch (this.widget.position) {
      case FlanPopupPosition.top:
        return SlideTransition(
          position: Tween(
            begin: Offset(0, -1),
            end: Offset(0, 0),
          ).animate(curve),
          child: child,
        );
      case FlanPopupPosition.bottom:
        return SlideTransition(
          position: Tween(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ).animate(curve),
          child: child,
        );
      case FlanPopupPosition.right:
        return SlideTransition(
          position: Tween(
            begin: Offset(1, 0),
            end: Offset(0, 0),
          ).animate(curve),
          child: child,
        );
      case FlanPopupPosition.left:
        return SlideTransition(
          position: Tween(
            begin: Offset(-1, 0),
            end: Offset(0, 0),
          ).animate(curve),
          child: child,
        );
      case FlanPopupPosition.center:
        FadeTransition(
          opacity: curve,
          child: child,
        );
    }

    return FadeTransition(
      opacity: curve,
      child: child,
    );
  }

  Widget _buildPopupContent() {
    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Align(
        alignment: this._popupAlign,
        child: SizedBox(
          width: this.widget.position == FlanPopupPosition.top ||
                  this.widget.position == FlanPopupPosition.bottom
              ? double.infinity
              : null,
          child: GestureDetector(
            onTap: this.widget.onClick,
            child: Material(
              borderRadius: this.widget.round ? this._roundRadius : null,
              color: ThemeVars.popupBackgroundColor,
              type: MaterialType.card,
              child: Stack(
                children: [
                  this.widget.closeable
                      ? this._buildCloseIcon()
                      : SizedBox.shrink(),
                  this.widget.child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseIcon() {
    final icon = _FlanPopupCloseIcon(
      closeIconName: this.widget.closeIconName,
      closeIconUrl: this.widget.closeIconUrl,
      onPress: this.widget.onClickCloseIcon,
    );

    switch (this.widget.closeIconPosition) {
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
        DiagnosticsProperty<bool>("show", widget.show, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>("overlay", widget.overlay,
        defaultValue: true));
    properties.add(DiagnosticsProperty<FlanPopupPosition>(
        "position", widget.position,
        defaultValue: FlanPopupPosition.center));
    properties.add(DiagnosticsProperty<BoxDecoration>(
        "overlayStyle", widget.overlayStyle));
    properties.add(DiagnosticsProperty<Duration>("duration", widget.duration,
        defaultValue: const Duration(milliseconds: 300)));
    properties.add(
        DiagnosticsProperty<bool>("round", widget.round, defaultValue: false));
    // properties.add(DiagnosticsProperty<bool>("lockScroll", widget.lockScroll,
    //     defaultValue: true));
    // properties.add(DiagnosticsProperty<bool>("lazyRender", widget.lazyRender,
    //     defaultValue: true));
    // properties.add(DiagnosticsProperty<bool>(
    //     "closeOnPopstate", widget.closeOnPopstate,
    //     defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        "closeOnClickOverlay", widget.closeOnClickOverlay,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>("closeable", widget.closeable,
        defaultValue: false));
    properties.add(DiagnosticsProperty<int>(
        "closeIconName", widget.closeIconName,
        defaultValue: FlanIcons.cross));
    properties
        .add(DiagnosticsProperty<String>("closeIconUrl", widget.closeIconUrl));
    properties.add(DiagnosticsProperty<FlanPopupCloseIconPosition>(
        "closeIconPosition", widget.closeIconPosition,
        defaultValue: FlanPopupCloseIconPosition.topRight));
    properties.add(DiagnosticsProperty<RouteTransitionsBuilder>(
        "transition", widget.transitionBuilder));
    properties.add(DiagnosticsProperty<bool>(
        "transitionAppear", widget.transitionAppear,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        "safeAreaInsetBottom", widget.safeAreaInsetBottom,
        defaultValue: false));
    super.debugFillProperties(properties);
  }
}

class _FlanPopupRoute<T> extends PopupRoute<T> {
  _FlanPopupRoute({
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = true,
    String? barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    RouteSettings? settings,
    this.appear = false,
    this.onTransitionRouteEnter,
    this.onTransitionRouteLeave,
  })  : _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel!,
        _barrierColor = barrierColor,
        _transitionDuration = transitionDuration,
        _transitionBuilder = transitionBuilder!,
        super(settings: settings);

  final RoutePageBuilder _pageBuilder;

  final bool appear;
  final VoidCallback? onTransitionRouteEnter;
  final VoidCallback? onTransitionRouteLeave;

  void _onFlanPopupTransitionChange(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        if (this.onTransitionRouteLeave != null) {
          this.onTransitionRouteLeave!();
        }
        break;
      case AnimationStatus.forward:
        break;
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.completed:
        if (this.onTransitionRouteEnter != null) {
          this.onTransitionRouteEnter!();
        }
        break;
    }
  }

  @override
  void install() {
    super.install();
    this.animation?.addStatusListener(this._onFlanPopupTransitionChange);
  }

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String get barrierLabel => _barrierLabel;
  final String _barrierLabel;

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

  activeText() {
    this.setState(() {
      this.active = true;
    });
  }

  disactiveText() {
    this.setState(() {
      this.active = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: this.widget.onPress != null,
      sortKey: const OrdinalSortKey(0.0),
      child: InkResponse(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (this.widget.onPress != null) {
            this.widget.onPress!();
          }
          Navigator.of(context).pop();
          this.disactiveText();
        },
        onTapDown: (e) {
          this.activeText();
        },
        onTapCancel: this.disactiveText,
        child: FlanIcon(
          iconName: this.widget.closeIconName,
          iconUrl: this.widget.closeIconUrl,
          color: this.active
              ? ThemeVars.popupCloseIconActiveColor
              : ThemeVars.popupCloseIconColor,
        ),
      ),
    );
  }
}
