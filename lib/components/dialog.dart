// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../locale/l10n.dart';
import '../styles/var.dart';
import 'action_bar.dart';
import 'action_bar_button.dart';
import 'button.dart';
import 'popup.dart';
import 'style.dart';

Widget kDialogTransitions(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final Animation<double> curve = animation.drive(
    Tween<double>(begin: 0.7, end: 0.9),
  );

  return FadeTransition(
    opacity: animation,
    child: ScaleTransition(
      scale: curve,
      child: child,
    ),
  );
}

class FlanDialog extends StatefulWidget {
  const FlanDialog({
    Key? key,
    required this.show,
    this.title = '',
    this.width,
    this.message = '',
    this.messageAlign = TextAlign.left,
    this.theme = FlanDialogTheme.normal,
    this.showConfirmButton = true,
    this.showCancelButton = false,
    this.confirmButtonText = '',
    this.confirmButtonColor,
    this.cancelButtonText = '',
    this.cancelButtonColor,
    this.overlay = true,
    this.overlayStyle,
    this.closeOnPopstate = true,
    this.closeOnClickOverlay = false,
    // this.lockScroll = true,
    // this.allowHtml = false,
    // this.lazyRender = true,
    this.callback,
    this.beforeClose,
    this.transitionBuilder,
    required this.onChange,
    this.onConfirm,
    this.onCancel,
    this.onOpen,
    this.onClose,
    this.onOpened,
    this.onClosed,
    this.child,
    this.titleSlot,
    this.footerSlot,
  }) : super(key: key);

  static void alert(
    BuildContext context, {
    GlobalKey? key,
    String title = '',
    double? width,
    String message = '',
    TextAlign messageAlign = TextAlign.left,
    FlanDialogTheme theme = FlanDialogTheme.normal,
    bool showConfirmButton = true,
    bool showCancelButton = false,
    String confirmButtonText = '',
    Color? confirmButtonColor,
    String cancelButtonText = '',
    Color? cancelButtonColor,
    bool overlay = true,
    BoxDecoration? overlayStyle,
    bool closeOnPopstate = true,
    bool closeOnClickOverlay = false,
    void Function(FlanDialogAction)? callback,
    Future<bool> Function(FlanDialogAction)? beforeClose,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    VoidCallback? onOpen,
    VoidCallback? onClose,
    VoidCallback? onOpened,
    VoidCallback? onClosed,
    Widget? child,
    Widget? titleSlot,
    Widget? footerSlot,
  }) {
    // FlanDialog.apiKey = GlobalKey();
    OverlayEntry? o;
    bool show = true;
    o = OverlayEntry(
      builder: (BuildContext context) {
        return StatefulBuilder(
          // key: FlanDialog.apiKey,
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return FlanDialog(
              show: show,
              onChange: (bool value) {
                print(value);
                setState(() {
                  show = value;
                });
              },
              title: title,
              width: width,
              message: message,
              messageAlign: messageAlign,
              theme: theme,
              showConfirmButton: showConfirmButton,
              showCancelButton: showCancelButton,
              confirmButtonText: confirmButtonText,
              confirmButtonColor: confirmButtonColor,
              cancelButtonText: cancelButtonText,
              cancelButtonColor: cancelButtonColor,
              overlay: overlay,
              overlayStyle: overlayStyle,
              closeOnPopstate: closeOnPopstate,
              closeOnClickOverlay: closeOnClickOverlay,
              callback: callback,
              beforeClose: beforeClose,
              transitionBuilder: transitionBuilder,
              onConfirm: onConfirm,
              onCancel: onCancel,
              onOpen: onOpen,
              onClose: onClose,
              onOpened: onOpened,
              onClosed: () {
                if (onClosed != null) {
                  onClosed();
                }
                o?.remove();
              },
              child: child,
              titleSlot: titleSlot,
              footerSlot: footerSlot,
            );
          },
        );
      },
    );

    Overlay.of(context)?.insert(o);
  }

  static void confirm(
    BuildContext context, {
    GlobalKey? key,
    String title = '',
    double? width,
    String message = '',
    TextAlign messageAlign = TextAlign.left,
    FlanDialogTheme theme = FlanDialogTheme.normal,
    bool showConfirmButton = true,
    bool showCancelButton = true,
    String confirmButtonText = '',
    Color? confirmButtonColor,
    String cancelButtonText = '',
    Color? cancelButtonColor,
    bool overlay = true,
    BoxDecoration? overlayStyle,
    bool closeOnPopstate = true,
    bool closeOnClickOverlay = false,
    void Function(FlanDialogAction)? callback,
    Future<bool> Function(FlanDialogAction)? beforeClose,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    VoidCallback? onOpen,
    VoidCallback? onClose,
    VoidCallback? onOpened,
    VoidCallback? onClosed,
    Widget? child,
    Widget? titleSlot,
    Widget? footerSlot,
  }) {
    FlanDialog.alert(
      context,
      key: key,
      title: title,
      width: width,
      message: message,
      messageAlign: messageAlign,
      theme: theme,
      showConfirmButton: showConfirmButton,
      showCancelButton: showCancelButton,
      confirmButtonText: confirmButtonText,
      confirmButtonColor: confirmButtonColor,
      cancelButtonText: cancelButtonText,
      cancelButtonColor: cancelButtonColor,
      overlay: overlay,
      overlayStyle: overlayStyle,
      closeOnPopstate: closeOnPopstate,
      closeOnClickOverlay: closeOnClickOverlay,
      callback: callback,
      beforeClose: beforeClose,
      transitionBuilder: transitionBuilder,
      onConfirm: onConfirm,
      onCancel: onCancel,
      onOpen: onOpen,
      onClose: onClose,
      onOpened: onOpened,
      onClosed: onClosed,
      child: child,
      titleSlot: titleSlot,
      footerSlot: footerSlot,
    );
  }

  static void close() {
    if (apiKey.currentState != null) {
      (apiKey.currentState as _FlanDialogState?)?.close();
    }
  }

  static GlobalKey apiKey = GlobalKey();

  // ****************** Props ******************
  /// 是否显示弹窗
  final bool show;

  /// 标题
  final String title;

  /// 弹窗宽度
  final double? width;

  /// 文本内容，支持通过 `\n` 换行
  final String message;

  /// 内容水平对齐方式，可选值为 `left` `right` `center`
  final TextAlign messageAlign;

  /// 式风格，可选值为 `roundButton` `normal`
  final FlanDialogTheme theme;

  /// 是否展示确认按钮
  final bool showConfirmButton;

  /// 是否展示取消按钮
  final bool showCancelButton;

  /// 确认按钮文案
  final String confirmButtonText;

  /// 确认按钮颜色
  final Color? confirmButtonColor;

  /// 取消按钮文案
  final String cancelButtonText;

  /// 取消按钮颜色
  final Color? cancelButtonColor;

  /// 是否展示遮罩层
  final bool overlay;

  /// 自定义遮罩层样式
  final BoxDecoration? overlayStyle;

  /// 是否在页面回退时自动关闭
  final bool closeOnPopstate;

  /// 是否在点击遮罩层后关闭弹窗
  final bool closeOnClickOverlay;

  // /// 是否在显示弹层时才渲染节点
  // final bool lazyRender;

  // /// 	是否锁定背景滚动
  // final bool lockScroll;

  // /// 是否允许 message 内容中渲染 HTML
  // final bool allowHtml;

  /// 关闭前的回调函数，返回 `false` 可阻止关闭
  final Future<bool> Function(FlanDialogAction action)? beforeClose;

  /// 关闭前的回调函数，
  final void Function(FlanDialogAction action)? callback;

  /// 动画类名
  final RouteTransitionsBuilder? transitionBuilder;

  // ****************** Events ******************
  /// 弹窗变化回调
  final ValueChanged<bool> onChange;

  /// 点击确认按钮时触发
  final VoidCallback? onConfirm;

  /// 点击取消按钮时触发
  final VoidCallback? onCancel;

  /// 打开弹窗时触发
  final VoidCallback? onOpen;

  /// 关闭弹窗时触发
  final VoidCallback? onClose;

  /// 打开弹窗且动画结束后触发
  final VoidCallback? onOpened;

  /// 关闭弹窗且动画结束后触发
  final VoidCallback? onClosed;

  // ****************** Slots ******************
  /// 自定义内容
  final Widget? child;

  /// 自定义标题
  final Widget? titleSlot;

  /// 自定义底部按钮区域
  final Widget? footerSlot;

  @override
  _FlanDialogState createState() => _FlanDialogState();
}

class _FlanDialogState extends State<FlanDialog> {
  bool confirm = false;
  bool cancel = false;

  @override
  Widget build(BuildContext context) {
    final double winWidth = MediaQuery.of(context).size.width;

    return FlanPopup(
      show: widget.show,
      onChange: widget.onChange,
      round: true,
      backgroundColor: ThemeVars.dialogBackgroundColor,
      borderRadius: BorderRadius.circular(ThemeVars.dialogBorderRadius),
      child: SizedBox(
        width: winWidth < 321.0
            ? ThemeVars.dialogSmallScreenWidth * winWidth
            : ThemeVars.dialogWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTitle(),
            _buildContent(),
            _buildFooter(),
          ],
        ),
      ),
      overlay: widget.overlay,
      overlayStyle: widget.overlayStyle,
      closeOnPopstate: widget.closeOnPopstate,
      closeOnClickOverlay: widget.closeOnClickOverlay,
      duration: ThemeVars.animationDurationBase,
      transitionBuilder: widget.transitionBuilder ?? kDialogTransitions,
    );
  }

  Widget _buildTitle() {
    if (widget.titleSlot != null || widget.title.isNotEmpty) {
      final bool isolated = widget.message.isEmpty && widget.child == null;
      return Container(
        padding: isolated
            ? ThemeVars.dialogHeaderIsolatedPadding
            : const EdgeInsets.only(top: ThemeVars.dialogHeaderPaddingTop),
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: ThemeVars.dialogFontSize,
            color: ThemeVars.textColor,
            fontWeight: ThemeVars.dialogHeaderFontWeight,
            // height: ThemeVars.dialogHeaderLineHeight / ThemeVars.dialogFontSize,
          ),
          child: widget.titleSlot ?? Text(widget.title),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildContent() {
    if (widget.child != null) {
      return widget.child!;
    }
    final double winHeight = MediaQuery.of(context).size.height;
    final bool hasTitle = widget.title.isNotEmpty || widget.titleSlot != null;
    if (widget.message.isNotEmpty) {
      return Container(
        constraints: BoxConstraints(
          maxHeight: ThemeVars.dialogMessageMaxHeight * winHeight,
        ),
        padding: EdgeInsets.only(
          top: hasTitle ? ThemeVars.dialogHasTitleMessagePaddingTop : 26.0,
          bottom: isRoundTheme ? ThemeVars.paddingMd : 26.0,
          left: ThemeVars.dialogMessagePadding,
          right: ThemeVars.dialogMessagePadding,
        ),
        child: Text(
          widget.message,
          style: TextStyle(
            fontSize: ThemeVars.dialogMessageFontSize,
            height: ThemeVars.dialogMessageLineHeight /
                ThemeVars.dialogMessageFontSize,
            color: hasTitle ? ThemeVars.dialogHasTitleMessageTextColor : null,
          ),
          textAlign: widget.messageAlign,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  bool get isRoundTheme => widget.theme == FlanDialogTheme.roundButton;

  Widget _buildButtons() {
    print(cancel);
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: FlanHairLine()),
      ),
      height: ThemeVars.dialogButtonHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (widget.showCancelButton) ...<Widget>[
            Expanded(
              child: FlanButton(
                border: false,
                size: FlanButtonSize.large,
                text: widget.cancelButtonText.isNotEmpty
                    ? widget.cancelButtonText
                    : FlanS.of(context).cancel,
                textColor: widget.cancelButtonColor,
                loading: cancel,
                onClick: _onCancel,
              ),
            ),
            const VerticalDivider(
              width: .5,
              color: ThemeVars.borderColor,
            ),
          ] else
            const SizedBox.shrink(),
          if (widget.showConfirmButton)
            Expanded(
              child: FlanButton(
                border: false,
                size: FlanButtonSize.large,
                text: widget.confirmButtonText.isNotEmpty
                    ? widget.confirmButtonText
                    : FlanS.of(context).confirm,
                textColor: widget.confirmButtonColor ??
                    ThemeVars.dialogConfirmButtonTextColor,
                loading: confirm,
                onClick: _onConfirm,
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildRoundButtons() {
    return Container(
      padding: const EdgeInsets.only(
        top: ThemeVars.paddingXs,
        left: ThemeVars.paddingLg,
        right: ThemeVars.paddingLg,
        bottom: ThemeVars.paddingMd,
      ),
      child: FlanActionBar(
        children: <Widget>[
          if (widget.showCancelButton)
            FlanActionBarButton(
              type: FlanButtonType.warning,
              text: widget.cancelButtonText.isNotEmpty
                  ? widget.cancelButtonText
                  : FlanS.of(context).cancel,
              color: widget.cancelButtonColor,
              loading: cancel,
              onClick: _onCancel,
              height: ThemeVars.dialogRoundButtonHeight,
            )
          else
            const SizedBox.shrink(),
          if (widget.showConfirmButton)
            FlanActionBarButton(
              type: FlanButtonType.danger,
              text: widget.confirmButtonText.isNotEmpty
                  ? widget.confirmButtonText
                  : FlanS.of(context).confirm,
              color: widget.confirmButtonColor,
              loading: confirm,
              onClick: _onConfirm,
              height: ThemeVars.dialogRoundButtonHeight,
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    if (widget.footerSlot != null) {
      return widget.footerSlot!;
    }
    return widget.theme == FlanDialogTheme.roundButton
        ? _buildRoundButtons()
        : _buildButtons();
  }

  void _updateShow(bool value) => widget.onChange(value);

  void _close(FlanDialogAction action) {
    _updateShow(false);
    if (widget.callback != null) {
      widget.callback!(action);
    }
  }

  void _onConfirm() => _getActionHandler(FlanDialogAction.confirm);

  void _onCancel() => _getActionHandler(FlanDialogAction.cancel);

  Future<void> _getActionHandler(FlanDialogAction action) async {
    if (!widget.show) {
      return;
    }

    switch (action) {
      case FlanDialogAction.confirm:
        if (widget.onConfirm != null) {
          widget.onConfirm!();
        }
        break;
      case FlanDialogAction.cancel:
        if (widget.onCancel != null) {
          widget.onCancel!();
        }
        break;
    }

    if (widget.beforeClose != null) {
      setLoading(action, true);

      final bool flag = await widget.beforeClose!(action);

      if (flag) {
        _close(action);
        setLoading(action, false);
      } else {
        setLoading(action, false);
      }
    } else {
      _close(action);
    }
  }

  void setLoading(FlanDialogAction action, bool loading) {
    switch (action) {
      case FlanDialogAction.confirm:
        confirm = loading;
        break;
      case FlanDialogAction.cancel:
        cancel = loading;
        break;
    }
    setState(() {});
  }

  void close() {
    Navigator.of(context).pop();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<bool>('show', widget.show));
    properties.add(
        DiagnosticsProperty<String>('title', widget.title, defaultValue: ''));
    properties.add(DiagnosticsProperty<double>('width', widget.width));
    properties.add(DiagnosticsProperty<String>('message', widget.message,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<TextAlign>(
        'messageAlign', widget.messageAlign,
        defaultValue: TextAlign.left));
    properties.add(DiagnosticsProperty<FlanDialogTheme>('theme', widget.theme,
        defaultValue: FlanDialogTheme.normal));
    properties.add(DiagnosticsProperty<bool>(
        'showConfirmButton', widget.showConfirmButton,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>(
        'showCancelButton', widget.showCancelButton,
        defaultValue: false));
    properties.add(DiagnosticsProperty<String>(
        'confirmButtonText', widget.confirmButtonText,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<Color>(
        'confirmButtonColor', widget.confirmButtonColor));
    properties.add(DiagnosticsProperty<String>(
        'cancelButtonText', widget.cancelButtonText,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<Color>(
        'cancelButtonColor', widget.cancelButtonColor));
    properties.add(DiagnosticsProperty<bool>('overlay', widget.overlay,
        defaultValue: true));
    properties.add(DiagnosticsProperty<BoxDecoration>(
        'overlayStyle', widget.overlayStyle));
    properties.add(DiagnosticsProperty<bool>(
        'closeOnPopstate', widget.closeOnPopstate,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>(
        'closeOnClickOverlay', widget.closeOnClickOverlay,
        defaultValue: false));
    //  properties
    //       .add(DiagnosticsProperty<bool>('lockScroll', lockScroll,defaultValue: true));
    // properties.add(
    //     DiagnosticsProperty<bool>('allowHtml', allowHtml, defaultValue: false));
    properties.add(DiagnosticsProperty<Future<bool> Function(FlanDialogAction)>(
        'beforeClose', widget.beforeClose));
    properties.add(DiagnosticsProperty<
        Widget Function(BuildContext, Animation<double>, Animation<double>,
            Widget)>('transitionBuilder', widget.transitionBuilder));

    super.debugFillProperties(properties);
  }
}

enum FlanDialogTheme {
  normal,
  roundButton,
}

enum FlanDialogAction {
  confirm,
  cancel,
}
