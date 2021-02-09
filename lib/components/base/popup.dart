import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './icon.dart' show FlanIcons;

/// ### FlanPopup 列布局
/// 弹出层容器，用于展示弹窗、信息提示等内容，支持多个弹出层叠加展示。
class FlanPopup extends StatelessWidget {
  const FlanPopup({
    Key key,
    this.show = false,
    this.overlay = true,
    this.position = FlanPopupPosition.center,
    this.style,
    this.overlayStyle,
    this.duration = const Duration(milliseconds: 300),
    this.round = false,
    this.lockScroll = true,
    this.lazyRender = true,
    this.closeOnPopstate = false,
    this.closeOnClickOverlay = true,
    this.closeable = false,
    this.closeIconData = FlanIcons.cross,
    this.closeIconUrl,
    this.closeIconPosition = FlanPopupCloseIconPosition.topRight,
    this.transition,
    this.transitionAppear = false,
    this.safeAreaInsetBottom = false,
    this.onChange,
    this.onClick,
    this.onClickOverlay,
    this.onClickCloseIcon,
    this.onOpen,
    this.onClose,
    this.onOpened,
    this.onClosed,
    this.child,
  })  : assert(show != null),
        assert(overlay != null),
        assert(position != null && position is FlanPopupPosition),
        assert(duration != null && duration is Duration),
        assert(round != null),
        assert(lockScroll != null),
        assert(lazyRender != null),
        assert(closeOnPopstate != null),
        assert(closeOnClickOverlay != null),
        assert(closeable != null),
        assert(closeIconPosition != null &&
            closeIconPosition is FlanPopupCloseIconPosition),
        assert(transitionAppear != null),
        assert(safeAreaInsetBottom != null),
        super(key: key);

  // ****************** Props ******************
  /// 是否显示弹出层
  final bool show;

  /// 是否显示遮罩层
  final bool overlay;

  /// 弹出位置，可选值为 `top` `bottom` `right` `left` `center`
  final FlanPopupPosition position;

  /// 弹窗的样式
  final BoxDecoration style;

  /// 自定义遮罩层样式
  final BoxDecoration overlayStyle;

  /// 动画时长，单位秒
  final Duration duration;

  /// 是否显示圆角
  final bool round;

  /// 是否锁定背景滚动
  final bool lockScroll;

  /// 是否在显示弹层时才渲染节点
  final bool lazyRender;

  /// 是否在页面回退时自动关闭
  final bool closeOnPopstate;

  /// 是否在点击遮罩层后关闭
  final bool closeOnClickOverlay;

  /// 是否显示关闭图标
  final bool closeable;

  /// 关闭图标名称
  final IconData closeIconData;

  /// 关闭图片链接
  final String closeIconUrl;

  /// 关闭图标位置，可选值为 `topleft` `topRight` `bottomLeft` `bottomRight`
  final FlanPopupCloseIconPosition closeIconPosition;

  /// 动画类名，等价于 transtion 的name属性
  final String transition;

  /// 是否在初始渲染时启用过渡动画
  final bool transitionAppear;

  /// 是否开启底部安全区适配
  final bool safeAreaInsetBottom;

  // ****************** Events ******************
  /// 弹窗变化回调
  final ValueChanged<bool> onChange;

  /// 点击弹出层时触发
  final GestureTapCallback onClick;

  /// 点击遮罩层时触发
  final GestureTapCallback onClickOverlay;

  /// 点击关闭图标时触发
  final GestureTapCallback onClickCloseIcon;

  /// 打开弹出层时触发
  final VoidCallback onOpen;

  /// 关闭弹出层时触发
  final VoidCallback onClose;

  /// 打开弹出层且动画结束后触发
  final VoidCallback onOpened;

  /// 关闭弹出层且动画结束后触发
  final VoidCallback onClosed;

  // ****************** Slots ******************
  /// 内容
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<bool>("show", show, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>("overlay", overlay, defaultValue: true));
    properties.add(DiagnosticsProperty<FlanPopupPosition>("position", position,
        defaultValue: FlanPopupPosition.center));
    properties
        .add(DiagnosticsProperty<BoxDecoration>("overlayStyle", overlayStyle));
    properties.add(DiagnosticsProperty<Duration>("duration", duration,
        defaultValue: const Duration(milliseconds: 300)));
    properties
        .add(DiagnosticsProperty<bool>("round", round, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>("lockScroll", lockScroll,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>("lazyRender", lazyRender,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>("closeOnPopstate", closeOnPopstate,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        "closeOnClickOverlay", closeOnClickOverlay,
        defaultValue: true));
    properties.add(
        DiagnosticsProperty<bool>("closeable", closeable, defaultValue: false));
    properties.add(DiagnosticsProperty<IconData>("closeIconData", closeIconData,
        defaultValue: FlanIcons.cross));
    properties.add(DiagnosticsProperty<String>("closeIconUrl", closeIconUrl));
    properties.add(DiagnosticsProperty<FlanPopupCloseIconPosition>(
        "closeIconPosition", closeIconPosition,
        defaultValue: FlanPopupCloseIconPosition.topRight));
    properties.add(DiagnosticsProperty<String>("transition", transition));
    properties.add(DiagnosticsProperty<bool>(
        "transitionAppear", transitionAppear,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        "safeAreaInsetBottom", safeAreaInsetBottom,
        defaultValue: false));
    super.debugFillProperties(properties);
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
