// 🐦 Flutter imports:
import 'package:flant/components/loading.dart';
import 'package:flant/components/popup.dart';
import 'package:flant/components/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 🌎 Project imports:
import '../styles/var.dart';
import 'icon.dart';

/// ### FlanActionSheet 动作面板
/// 底部弹起的模态面板，包含与当前情境相关的多个选项。
class FlanActionSheet extends StatelessWidget {
  const FlanActionSheet({
    Key? key,
    required this.show,
    this.actions = const <FlanActionSheetAction>[],
    this.title = '',
    this.cancelText = '',
    this.description = '',
    this.closeable = true,
    this.closeIconName = FlanIcons.cross,
    this.closeIconUrl,
    this.duration = const Duration(milliseconds: 300),
    this.round = true,
    this.overlay = true,
    this.overlayStyle,
    // this.lockScroll = true,
    // this.lazyRender = true,
    this.closeOnPopstate = false,
    this.closeOnClickAction = false,
    this.closeOnClickOverlay = true,
    this.safeAreaInsetBottom = true,
    required this.onShowChange,
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
  final String? closeIconUrl;

  /// 动画时长
  final Duration duration;

  /// 是否显示圆角
  final bool round;

  /// 是否显示遮罩层
  final bool overlay;

  /// 自定义遮罩层样式
  final BoxDecoration? overlayStyle;

  // /// 是否锁定背景滚动
  // final bool lockScroll;

  // /// 是否在显示弹层时才渲染节点
  // final bool lazyRender;

  /// 是否在页面回退时自动关闭
  final bool closeOnPopstate;

  /// 是否在点击选项后关闭
  final bool closeOnClickAction;

  /// 是否在点击遮罩层后关闭
  final bool closeOnClickOverlay;

  /// 是否开启底部安全区适配
  final bool safeAreaInsetBottom;

  // ****************** Events ******************
  /// 是否显示变化
  final void Function(bool show) onShowChange;

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
    final Size size = MediaQuery.of(context).size;
    return FlanPopup(
      show: show,
      onChange: _updateShow,
      position: FlanPopupPosition.bottom,
      round: true,
      overlay: overlay,
      overlayStyle: overlayStyle,
      duration: duration,
      closeOnClickOverlay: closeOnClickOverlay,
      safeAreaInsetBottom: safeAreaInsetBottom,
      closeOnPopstate: closeOnPopstate,
      onClose: onClose,
      onOpen: onOpen,
      onOpened: onOpened,
      onClosed: onClosed,
      onClickOverlay: onClickOverlay,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: ThemeVars.actionSheetItemTextColor,
        ),
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildDescription(),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    size.height * (ThemeVars.actionSheetMaxHeight - 0.05),
              ),
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: <Widget>[
                  ..._buildOptions(),
                  child ?? const SizedBox.shrink(),
                ],
              ),
            ),
            ..._buildCancel(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (title.isNotEmpty) {
      return Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: ThemeVars.actionSheetHeaderHeight,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: ThemeVars.fontWeightBold,
                fontSize: ThemeVars.actionSheetHeaderFontSize,
                // height: ThemeVars.actionSheetHeaderHeight /
                //     ThemeVars.actionSheetHeaderFontSize,
              ),
            ),
          ),
          if (closeable)
            Positioned(
              top: 0.0,
              right: 0.0,
              child: _FlanPopupCloseIcon(
                closeIconName: closeIconName,
                closeIconUrl: closeIconUrl,
                onPress: _onCancel,
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  List<Widget> _buildCancel() {
    if (cancelSlot != null || cancelText.isNotEmpty) {
      return <Widget>[
        Container(
          color: ThemeVars.actionSheetCancelPaddingColor,
          height: ThemeVars.actionSheetCancelPaddingTop,
        ),
        _FlanActionSheetCancelButton(
          onClick: _onCancel,
          child: DefaultTextStyle(
            style: const TextStyle(color: ThemeVars.actionSheetCancelTextColor),
            child: cancelSlot ?? Text(cancelText),
          ),
        ),
      ];
    }
    return <Widget>[];
  }

  Widget _buildOption(FlanActionSheetAction item, int index) {
    Widget content;
    if (item.loading) {
      content = const FlanLoading(
        color: ThemeVars.actionSheetItemDisabledTextColor,
        size: ThemeVars.actionSheetLoadingIconSize,
      );
    } else {
      final List<Widget> children = <Widget>[
        Text(item.name),
      ];
      if (item.subname.isNotEmpty) {
        children.addAll(<Widget>[
          const SizedBox(height: ThemeVars.paddingXs),
          Text(
            item.subname,
            style: const TextStyle(
              color: ThemeVars.actionSheetSubnameColor,
              fontSize: ThemeVars.actionSheetSubnameFontSize,
              // height: ThemeVars.actionSheetSubnameLineHeight /
              //     ThemeVars.actionSheetSubnameFontSize,
            ),
          ),
        ]);
      }
      content = Column(children: children);
    }

    return _FlanActionSheetCancelButton(
      loading: item.loading,
      disabled: item.disabled,
      onClick: () {
        if (item.disabled || item.loading) {
          return;
        }

        if (item.callback != null) {
          item.callback!(item);
        }

        if (closeOnClickAction) {
          _updateShow(false);
        }

        if (onSelect != null) {
          onSelect!(item, index);
        }
      },
      child: content,
    );
  }

  Widget _buildDescription() {
    if (description.isNotEmpty || descriptionSlot != null) {
      return Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: ThemeVars.paddingMd),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: const BoxDecoration(border: Border(bottom: FlanHairLine())),
        child: DefaultTextStyle(
          style: const TextStyle(
            color: ThemeVars.actionSheetDescriptionColor,
            fontSize: ThemeVars.actionSheetDescriptionFontSize,
            // height: ThemeVars.actionSheetDescriptionLineHeight /
            //     ThemeVars.actionSheetDescriptionFontSize,
          ),
          child: descriptionSlot ?? Text(description),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  List<Widget> _buildOptions() {
    if (actions.isNotEmpty) {
      return List<Widget>.generate(
          actions.length, (int index) => _buildOption(actions[index], index));
    }
    return <Widget>[];
  }

  void _updateShow(bool show) => onShowChange(show);

  void _onCancel() {
    _updateShow(false);

    if (onCancel != null) {
      onCancel!();
    }
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
    properties.add(DiagnosticsProperty<String>('closeIconUrl', closeIconUrl));
    properties.add(DiagnosticsProperty<Duration>('duration', duration));
    properties
        .add(DiagnosticsProperty<bool>('round', round, defaultValue: true));
    properties
        .add(DiagnosticsProperty<bool>('overlay', overlay, defaultValue: true));
    properties
        .add(DiagnosticsProperty<BoxDecoration>('overlayStyle', overlayStyle));
    // properties.add(DiagnosticsProperty<bool>('lockScroll', lockScroll,
    //     defaultValue: true));
    // properties.add(DiagnosticsProperty<bool>('lazyRender', lazyRender,
    //     defaultValue: true));
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

class _FlanActionSheetCancelButton extends StatefulWidget {
  const _FlanActionSheetCancelButton({
    Key? key,
    this.text = '',
    this.disabled = false,
    this.loading = false,
    required this.child,
    this.onClick,
  }) : super(key: key);

  final String text;
  final bool disabled;
  final bool loading;
  final VoidCallback? onClick;
  final Widget child;

  @override
  __FlanActionSheetCancelButtonState createState() =>
      __FlanActionSheetCancelButtonState();
}

class __FlanActionSheetCancelButtonState
    extends State<_FlanActionSheetCancelButton> {
  bool isPressed = false;

  void doActive() {
    setState(() => isPressed = true);
  }

  void doDisActive() {
    setState(() => isPressed = false);
  }

  Color get bgColor =>
      isPressed ? ThemeVars.activeColor : ThemeVars.actionSheetItemBackground;

  @override
  Widget build(BuildContext context) {
    final bool disabled = widget.disabled || widget.loading;

    return Semantics(
      button: true,
      child: IgnorePointer(
        ignoring: disabled,
        child: MouseRegion(
          cursor: widget.disabled
              ? SystemMouseCursors.forbidden
              : widget.loading
                  ? SystemMouseCursors.basic
                  : SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onClick,
            onTapDown: (TapDownDetails e) => doActive(),
            onTapCancel: () => doDisActive(),
            onTapUp: (TapUpDetails e) => doDisActive(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 14.0,
                horizontal: ThemeVars.paddingMd,
              ),
              color: bgColor,
              alignment: Alignment.center,
              child: DefaultTextStyle(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: disabled
                      ? ThemeVars.actionSheetItemDisabledTextColor
                      : ThemeVars.actionSheetItemTextColor,
                  fontSize: ThemeVars.actionSheetItemFontSize,
                  height: ThemeVars.actionSheetItemLineHeight /
                      ThemeVars.actionSheetItemFontSize,
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FlanActionSheetAction {
  const FlanActionSheetAction({
    this.name = '',
    this.color,
    this.subname = '',
    this.loading = false,
    this.disabled = false,
    this.callback,
    // this.className,
  });

  /// 标题
  final String name;

  /// 选项文字颜色
  final Color? color;

  /// 二级标题
  final String subname;

  /// 是否为加载状态
  final bool loading;

  /// 是否为禁用状态
  final bool disabled;

  /// 点击时触发的回调函数
  final void Function(FlanActionSheetAction action)? callback;

  /// 为对应列添加额外的 class
  // final String className;
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
    setState(() => active = true);
  }

  void disactiveText() {
    setState(() => active = false);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: widget.onPress != null,
      child: GestureDetector(
        onTap: widget.onPress,
        onTapUp: (TapUpDetails details) => disactiveText(),
        onTapDown: (TapDownDetails e) {
          activeText();
        },
        onTapCancel: disactiveText,
        child: Container(
          height: ThemeVars.actionSheetHeaderHeight,
          padding: ThemeVars.actionSheetCloseIconPadding,
          alignment: Alignment.center,
          child: FlanIcon(
            iconName: widget.closeIconName,
            iconUrl: widget.closeIconUrl,
            size: ThemeVars.actionSheetCloseIconSize,
            color: active
                ? ThemeVars.actionSheetCloseIconActiveColor
                : ThemeVars.actionSheetCloseIconColor,
          ),
        ),
      ),
    );
  }
}
