// 🐦 Flutter imports:
import 'package:flant/flant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 🌎 Project imports:
import '../styles/var.dart';

class FlanShareSheetIcons {
  FlanShareSheetIcons._();

  static String qq = getIconURL('qq');
  static String link = getIconURL('link');
  static String weibo = getIconURL('weibo');
  static String wechat = getIconURL('wechat');
  static String poster = getIconURL('poster');
  static String qrcode = getIconURL('qrcode');
  static String weappQrcode = getIconURL('weapp-qrcode');
  static String wechatMoments = getIconURL('wechat-moments');

  static String getIconURL(String icon) =>
      'https://img.yzcdn.cn/vant/share-sheet-$icon.png';
}

class FlanShareSheet<T extends dynamic> extends StatelessWidget {
  const FlanShareSheet({
    Key? key,
    required this.show,
    this.overlay = true,
    this.duration = const Duration(milliseconds: 300),
    this.overlayStyle,
    this.transitionAppear = false,
    this.closeOnClickOverlay = true,
    this.title = '',
    this.cancelText,
    this.description = '',
    this.closeOnPopState = true,
    this.safeAreaInsetBottom = true,
    required this.options,
    required this.onShowChange,
    this.onSelect,
    this.onCancel,
    this.onOpen,
    this.onClose,
    this.onOpened,
    this.onClosed,
    this.onClickOverlay,
    this.titleSlot,
    this.descriptionSlot,
    this.cancelSlot,
  })  : assert(options is List<FlanShareSheetOption> ||
            options is List<List<FlanShareSheetOption>>),
        super(key: key);

  // ****************** Props ******************
  /// 是否显示分享面板
  final bool show;

  /// 是否显示遮罩层
  final bool overlay;

  /// 动画时长
  final Duration duration;
  // /// 是否锁定背景滚动
  // final bool lockScroll;

  // /// 是否在显示弹层时才渲染节点
  // final bool lazyRender;

  /// 自定义遮罩层样式
  final BoxDecoration? overlayStyle;

  /// 是否在初始渲染时启用过渡动画
  final bool transitionAppear;

  /// 是否在点击遮罩层后关闭
  final bool closeOnClickOverlay;

  /// 顶部标题
  final String title;

  /// 取消按钮文字，传入空字符串可以隐藏按钮
  final String? cancelText;

  /// 标题下方的辅助描述文字
  final String description;

  /// 是否在页面回退时自动关闭
  final bool closeOnPopState;

  /// 是否开启底部安全区适配
  final bool safeAreaInsetBottom;

  /// 分享选项
  final List<T> options;

  // ****************** Events ******************
  /// 显示分享面板变化
  final void Function(bool show) onShowChange;

  /// 点击分享选项时触发
  final void Function(FlanShareSheetOption option, int index)? onSelect;

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
  /// 自定义顶部标题
  final Widget? titleSlot;

  /// 自定义描述文字
  final Widget? descriptionSlot;

  /// 自定义取消按钮内容
  final Widget? cancelSlot;

  @override
  Widget build(BuildContext context) {
    final Widget? cancelButton = _buildCancelButton(context);

    return FlanPopup(
      show: show,
      onChange: onShowChange,
      position: FlanPopupPosition.bottom,
      round: true,
      overlay: overlay,
      overlayStyle: overlayStyle,
      duration: duration,
      transitionAppear: transitionAppear,
      closeOnClickOverlay: closeOnClickOverlay,
      safeAreaInsetBottom: safeAreaInsetBottom,
      closeOnPopstate: closeOnPopState,
      onClose: onClose,
      onOpen: onOpen,
      onOpened: onOpened,
      onClosed: onClosed,
      onClickOverlay: onClickOverlay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          ..._buildRows(),
          if (cancelButton != null)
            Container(
              width: double.infinity,
              height: ThemeVars.paddingXs,
              color: ThemeVars.backgroundColor,
            )
          else
            const SizedBox.shrink(),
          cancelButton ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final Widget? title = titleSlot ??
        (this.title.isNotEmpty
            ? Text(
                this.title,
                style: const TextStyle(
                  fontSize: ThemeVars.shareSheetTitleFontSize,
                  color: ThemeVars.shareSheetTitleColor,
                  fontWeight: FontWeight.normal,
                  height: ThemeVars.shareSheetTitleLineHeight /
                      ThemeVars.shareSheetTitleFontSize,
                ),
              )
            : null);
    final Widget? description = descriptionSlot ??
        (this.description.isNotEmpty
            ? Text(
                this.description,
                style: const TextStyle(
                  fontSize: ThemeVars.shareSheetDescriptionFontSize,
                  color: ThemeVars.shareSheetDescriptionColor,
                  height: ThemeVars.shareSheetDescriptionLineHeight /
                      ThemeVars.shareSheetDescriptionFontSize,
                ),
              )
            : null);
    if (title != null || description != null) {
      return Padding(
        padding: ThemeVars.shareSheetHeaderPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: ThemeVars.paddingXs),
            title ?? const SizedBox.shrink(),
            const SizedBox(height: ThemeVars.paddingXs),
            description ?? const SizedBox.shrink(),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildOption(FlanShareSheetOption option, int index) {
    return _FlanShareSheetOption(
      option: option,
      onClick: () => _onSelect(option, index),
    );
  }

  Widget _buildOptions(List<FlanShareSheetOption> options,
      {bool border = false}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
        top: ThemeVars.paddingMd,
        bottom: ThemeVars.paddingMd,
        left: ThemeVars.paddingXs,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.generate(
          options.length,
          (int index) => _buildOption(options[index], index),
        ),
      ),
    );
  }

  List<Widget> _buildRows() {
    if (options[0] is List<FlanShareSheetOption>) {
      List<Widget> content = <Widget>[];
      for (int i = 0; i < options.length; i++) {
        if (i != 0) {
          content.add(const Divider(
            color: ThemeVars.borderColor,
            height: 0.5,
            indent: ThemeVars.paddingMd,
          ));
        }
        content.add(_buildOptions(options[i] as List<FlanShareSheetOption>));
      }
      return content;
    }
    return <Widget>[_buildOptions(options as List<FlanShareSheetOption>)];
  }

  Widget? _buildCancelButton(BuildContext context) {
    final String cancelText = this.cancelText ?? FlanS.of(context).cancel;
    if (cancelSlot != null || cancelText.isNotEmpty) {
      return _FlanShareSheetCancelButton(
        onClick: _onCancel,
        child: cancelSlot ?? Text(cancelText),
      );
    }
  }

  void _onUpdateShow(bool value) {
    onShowChange(value);
  }

  void _onCancel() {
    _onUpdateShow(false);
    if (onCancel != null) {
      onCancel!();
    }
  }

  void _onSelect(FlanShareSheetOption option, int index) {
    if (onSelect != null) {
      onSelect!(option, index);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<bool>('show', show, defaultValue: false));

    properties
        .add(DiagnosticsProperty<bool>('overlay', overlay, defaultValue: true));
    properties.add(DiagnosticsProperty<Duration>('duration', duration,
        defaultValue: const Duration(milliseconds: 300)));
    properties
        .add(DiagnosticsProperty<BoxDecoration>('overlayStyle', overlayStyle));
    properties.add(DiagnosticsProperty<bool>(
        'transitionAppear', transitionAppear,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'closeOnClickOverlay', closeOnClickOverlay,
        defaultValue: true));
    properties
        .add(DiagnosticsProperty<String>('title', title, defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('cancelText', cancelText));
    properties.add(DiagnosticsProperty<String>('description', description,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<bool>('closeOnPopState', closeOnPopState,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>(
        'safeAreaInsetBottom', safeAreaInsetBottom,
        defaultValue: true));
    properties.add(DiagnosticsProperty<List<T>>('options', options,
        defaultValue: const <FlanShareSheetOption>[]));

    super.debugFillProperties(properties);
  }
}

class _FlanShareSheetCancelButton extends StatefulWidget {
  const _FlanShareSheetCancelButton({
    Key? key,
    required this.child,
    this.onClick,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onClick;

  @override
  __FlanShareSheetCancelButtonState createState() =>
      __FlanShareSheetCancelButtonState();
}

class __FlanShareSheetCancelButtonState
    extends State<_FlanShareSheetCancelButton> {
  bool isPressed = false;

  void doActive() {
    setState(() => isPressed = true);
  }

  void doDisActive() {
    setState(() => isPressed = false);
  }

  Color get bgColor => isPressed
      ? ThemeVars.activeColor
      : ThemeVars.shareSheetCancelButtonBackground;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onClick,
          onTapDown: (TapDownDetails e) => doActive(),
          onTapCancel: () => doDisActive(),
          onTapUp: (TapUpDetails e) => doDisActive(),
          child: Container(
            width: double.infinity,
            height: ThemeVars.shareSheetCancelButtonHeight,
            color: bgColor,
            alignment: Alignment.center,
            child: DefaultTextStyle(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: ThemeVars.textColor,
                fontSize: ThemeVars.shareSheetCancelButtonFontSize,
                // height: ThemeVars.shareSheetCancelButtonHeight /
                //     ThemeVars.shareSheetCancelButtonFontSize,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class _FlanShareSheetOption extends StatefulWidget {
  const _FlanShareSheetOption({
    Key? key,
    required this.option,
    required this.onClick,
  }) : super(key: key);

  final FlanShareSheetOption option;
  final VoidCallback onClick;

  @override
  __FlanShareSheetOptionState createState() => __FlanShareSheetOptionState();
}

class __FlanShareSheetOptionState extends State<_FlanShareSheetOption> {
  bool isPressed = false;

  void doActive() {
    setState(() => isPressed = true);
  }

  void doDisActive() {
    setState(() => isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onClick,
          onTapDown: (TapDownDetails e) => doActive(),
          onTapCancel: () => doDisActive(),
          onTapUp: (TapUpDetails e) => doDisActive(),
          child: Opacity(
            opacity: isPressed ? ThemeVars.activeOpacity : 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ThemeVars.paddingMd,
                  ),
                  child: Image.network(
                    widget.option.icon,
                    width: ThemeVars.shareSheetIconSize,
                    height: ThemeVars.shareSheetIconSize,
                  ),
                ),
                const SizedBox(height: ThemeVars.paddingXs),
                if (widget.option.name.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ThemeVars.paddingBase,
                    ),
                    child: Text(
                      widget.option.name,
                      style: const TextStyle(
                        color: ThemeVars.shareSheetOptionNameColor,
                        fontSize: ThemeVars.shareSheetOptionNameFontSize,
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                if (widget.option.description != null &&
                    widget.option.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ThemeVars.paddingBase,
                    ),
                    child: Text(
                      widget.option.description!,
                      style: const TextStyle(
                        color: ThemeVars.shareSheetDescriptionColor,
                        fontSize: ThemeVars.shareSheetDescriptionFontSize,
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FlanShareSheetOption {
  const FlanShareSheetOption({
    required this.name,
    required this.icon,
    this.description,
  });

  /// 分享渠道名称
  final String name;

  /// 图标，可选值为 `wechat` `weibo` `qq` `link` `qrcode` `poster` `weapp-qrcode` `wechat-moments`，支持传入图片 URL;
  final String icon;

  /// 分享选项描述
  final String? description;
}
