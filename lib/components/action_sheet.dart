// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/var.dart';
import 'icon.dart';

/// ### FlanActionSheet 动作面板
/// 底部弹起的模态面板，包含与当前情境相关的多个选项。
class FlanActionSheet extends StatelessWidget {
  const FlanActionSheet({
    Key? key,
    this.show = false,
    this.actions = const <FlanActionSheetAction>[],
    this.title = '',
    this.cancelText = '',
    this.description = '',
    this.closeable = true,
    this.closeIconName = FlanIcons.cross,
    this.closeIconString,
    this.duration,
    this.round = true,
    this.overlay = true,
    this.overlayStyle,
    this.lockScroll = true,
    this.lazyRender = true,
    this.closeOnPopstate = false,
    this.closeOnClickAction = false,
    this.closeOnClickOverlay = true,
    this.safeAreaInsetBottom = true,
    this.onSelect,
    this.onCancel,
    this.onOpen,
    this.onClose,
    this.onOpened,
    this.onClosed,
    this.onClickOverlay,
    this.child,
    this.descriptionSlot,
    this.cancelSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 是否显示动作面板
  final bool show;

  /// 面板选项列表
  final List<FlanActionSheetAction> actions;

  /// 顶部标题
  final String title;

  /// 取消按钮文字
  final String cancelText;

  /// 选项上方的描述信息
  final String description;

  /// 是否显示关闭图标
  final bool closeable;

  /// 关闭图标名称
  final int closeIconName;

  /// 关闭图片链接
  final String? closeIconString;

  /// 动画时长
  final Duration? duration;

  /// 是否显示圆角
  final bool round;

  /// 是否显示遮罩层
  final bool overlay;

  /// 自定义遮罩层样式
  final BoxDecoration? overlayStyle;

  /// 是否锁定背景滚动
  final bool lockScroll;

  /// 是否在显示弹层时才渲染节点
  final bool lazyRender;

  /// 是否在页面回退时自动关闭
  final bool closeOnPopstate;

  /// 是否在点击选项后关闭
  final bool closeOnClickAction;

  /// 是否在点击遮罩层后关闭
  final bool closeOnClickOverlay;

  /// 是否开启底部安全区适配
  final bool safeAreaInsetBottom;

  // ****************** Events ******************

  /// 点击选项时触发，禁用或加载状态下不会触发
  final void Function(FlanActionSheetAction action, int index)? onSelect;

  /// 点击取消按钮时触发
  final VoidCallback? onCancel;

  /// 打开面板时触发
  final VoidCallback? onOpen;

  /// 关闭面板时触发
  final VoidCallback? onClose;

  /// 打开面板且动画结束后触发
  final VoidCallback? onOpened;

  /// 关闭面板且动画结束后触发
  final VoidCallback? onClosed;

  /// 点击遮罩层时触发
  final VoidCallback? onClickOverlay;

  // ****************** Slots ******************
  /// 自定义面板的展示内容
  final Widget? child;

  /// 自定义描述文案
  final Widget? descriptionSlot;

  /// 自定义取消按钮内容
  final Widget? cancelSlot;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<bool>('show', show, defaultValue: false));
    properties.add(DiagnosticsProperty<List<FlanActionSheetAction>>(
        'actions', actions,
        defaultValue: const <FlanActionSheetAction>[]));
    properties
        .add(DiagnosticsProperty<String>('title', title, defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('cancelText', cancelText,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('description', description,
        defaultValue: ''));
    properties.add(
        DiagnosticsProperty<bool>('closeable', closeable, defaultValue: true));
    properties.add(DiagnosticsProperty<int>('closeIconName', closeIconName,
        defaultValue: FlanIcons.cross));
    properties
        .add(DiagnosticsProperty<String>('closeIconString', closeIconString));
    properties.add(DiagnosticsProperty<Duration>('duration', duration));
    properties
        .add(DiagnosticsProperty<bool>('round', round, defaultValue: true));
    properties
        .add(DiagnosticsProperty<bool>('overlay', overlay, defaultValue: true));
    properties
        .add(DiagnosticsProperty<BoxDecoration>('overlayStyle', overlayStyle));
    properties.add(DiagnosticsProperty<bool>('lockScroll', lockScroll,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('lazyRender', lazyRender,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('closeOnPopstate', closeOnPopstate,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'closeOnClickAction', closeOnClickAction,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'closeOnClickOverlay', closeOnClickOverlay,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>(
        'safeAreaInsetBottom', safeAreaInsetBottom,
        defaultValue: true));

    super.debugFillProperties(properties);
  }
}

class FlanActionSheetAction {
  FlanActionSheetAction({
    required this.name,
    required this.color,
    required this.subname,
    this.loading = false,
    this.disabled = false,
    required this.callback,
    // this.className,
  });

  /// 标题
  final String name;

  /// 选项文字颜色
  final Color color;

  /// 二级标题
  final String subname;

  /// 是否为加载状态
  final bool loading;

  /// 是否为禁用状态
  final bool disabled;

  /// 点击时触发的回调函数
  final void Function(FlanActionSheetAction action) callback;

  /// 为对应列添加额外的 class
  // final String className;
}
