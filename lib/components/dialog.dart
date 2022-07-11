// 🐦 Flutter imports:

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../locale/l10n.dart';
import '../styles/components/dialog_theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'action_bar.dart';
import 'action_bar_button.dart';
import 'button.dart';
import 'popup.dart';
import 'style.dart';

typedef FlanDialogBeforeClose = Future<bool> Function(FlanDialogAction action);

class FlanDialogOption {
  const FlanDialogOption({
    this.title = '',
    this.width,
    this.message = '',
    this.messageAlign = TextAlign.left,
    this.theme = FlanDialogThemeType.normal,
    this.showConfirmButton = true,
    this.showCancelButton = false,
    this.confirmButtonText = '',
    this.confirmButtonColor,
    this.cancelButtonText = '',
    this.cancelButtonColor,
    this.overlayColor,
    this.closeOnClickOverlay = false,
    this.beforeClose,
    this.transitionBuilder = kFlanDialogBounceTransition,
  });

  final String title;
  final double? width;
  final String message;
  final TextAlign messageAlign;
  final FlanDialogThemeType theme;
  final bool showConfirmButton;
  final bool showCancelButton;
  final String confirmButtonText;
  final Color? confirmButtonColor;
  final String cancelButtonText;
  final Color? cancelButtonColor;
  final Color? overlayColor;
  final bool closeOnClickOverlay;
  final FlanDialogBeforeClose? beforeClose;
  final FlanTransitionBuilder? transitionBuilder;

  FlanDialogOption merge(FlanDialogOption? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      title: other.title,
      width: other.width,
      message: message,
      messageAlign: messageAlign,
      theme: theme,
      showConfirmButton: showConfirmButton,
      showCancelButton: showCancelButton,
      confirmButtonText: confirmButtonText,
      confirmButtonColor: confirmButtonColor,
      cancelButtonText: cancelButtonText,
      cancelButtonColor: cancelButtonColor,
      overlayColor: overlayColor,
      closeOnClickOverlay: closeOnClickOverlay,
      beforeClose: beforeClose,
      transitionBuilder: transitionBuilder,
    );
  }

  FlanDialogOption copyWith({
    String? title,
    double? width,
    String? message,
    TextAlign? messageAlign,
    FlanDialogThemeType? theme,
    bool? showConfirmButton,
    bool? showCancelButton,
    String? confirmButtonText,
    Color? confirmButtonColor,
    String? cancelButtonText,
    Color? cancelButtonColor,
    Color? overlayColor,
    bool? closeOnClickOverlay,
    FlanDialogBeforeClose? beforeClose,
    FlanTransitionBuilder? transitionBuilder,
  }) {
    return FlanDialogOption(
      title: title ?? this.title,
      width: width ?? this.width,
      message: message ?? this.message,
      messageAlign: messageAlign ?? this.messageAlign,
      theme: theme ?? this.theme,
      showConfirmButton: showConfirmButton ?? this.showConfirmButton,
      showCancelButton: showCancelButton ?? this.showCancelButton,
      confirmButtonText: confirmButtonText ?? this.confirmButtonText,
      confirmButtonColor: confirmButtonColor ?? this.confirmButtonColor,
      cancelButtonText: cancelButtonText ?? this.cancelButtonText,
      cancelButtonColor: cancelButtonColor ?? this.cancelButtonColor,
      overlayColor: overlayColor ?? this.overlayColor,
      closeOnClickOverlay: closeOnClickOverlay ?? this.closeOnClickOverlay,
      beforeClose: beforeClose ?? this.beforeClose,
      transitionBuilder: transitionBuilder ?? this.transitionBuilder,
    );
  }
}

class FlanDialog {
  const FlanDialog._();

  static Future<FlanDialogAction?> alert(
    BuildContext context, {

    /// 标题
    String? title,

    /// 弹窗宽度
    double? width,

    /// 文本内容，支持通过 `\n` 换行
    String? message,

    /// 内容水平对齐方式，可选值为 `left` `right` `center`
    TextAlign? messageAlign,

    /// 式风格，可选值为 `roundButton` `normal`
    FlanDialogThemeType? theme,

    /// 是否展示确认按钮
    bool? showConfirmButton,

    /// 是否展示取消按钮
    bool? showCancelButton,

    /// 确认按钮文案
    String? confirmButtonText,

    /// 确认按钮颜色
    Color? confirmButtonColor,

    /// 取消按钮文案
    String? cancelButtonText,

    /// 取消按钮颜色
    Color? cancelButtonColor,

    /// 自定义遮罩层样式
    Color? overlayColor,

    /// 是否在点击遮罩层后关闭
    bool? closeOnClickOverlay,

    /// 关闭前判断, `return false` 不关闭
    FlanDialogBeforeClose? beforeClose,

    /// 动画
    FlanTransitionBuilder? transitionBuilder,

    /// 点击确认按钮时触发
    VoidCallback? onConfirm,

    /// 点击取消按钮时触发
    VoidCallback? onCancel,

    /// 打开面板时触发
    VoidCallback? onOpen,

    /// 关闭面板时触发
    VoidCallback? onClose,

    /// 打开面板且动画结束后触发
    VoidCallback? onOpened,

    /// 关闭面板且动画结束后触发
    VoidCallback? onClosed,

    /// 自定义内容
    WidgetBuilder? builder,

    /// 自定义标题
    WidgetBuilder? titleBuilder,

    /// 自定义底部按钮区域
    WidgetBuilder? footerBuilder,
  }) async {
    FlanDialog.isInstanceShow = true;
    final FlanDialogThemeData themeData = FlanDialogTheme.of(context);
    final FlanDialogOption _defaultOptions = FlanDialog.currentOptions;
    final FlanDialogAction? action = await showFlanPopup<FlanDialogAction>(
      context,
      builder: (BuildContext context) {
        return FlanDialogWidget(
          title: title ?? _defaultOptions.title,
          width: width ?? _defaultOptions.width,
          message: message ?? _defaultOptions.message,
          messageAlign: messageAlign ?? _defaultOptions.messageAlign,
          theme: theme ?? _defaultOptions.theme,
          showConfirmButton:
              showConfirmButton ?? _defaultOptions.showConfirmButton,
          showCancelButton:
              showCancelButton ?? _defaultOptions.showCancelButton,
          confirmButtonText:
              confirmButtonText ?? _defaultOptions.confirmButtonText,
          confirmButtonColor:
              confirmButtonColor ?? _defaultOptions.confirmButtonColor,
          cancelButtonText:
              cancelButtonText ?? _defaultOptions.cancelButtonText,
          cancelButtonColor:
              cancelButtonColor ?? _defaultOptions.cancelButtonColor,
          beforeClose: beforeClose ?? _defaultOptions.beforeClose,
          onConfirm: onConfirm,
          onCancel: onCancel,
          child: builder?.call(context),
          titleSlot: titleBuilder?.call(context),
          footerSlot: footerBuilder?.call(context),
        );
      },
      position: FlanPopupPosition.center,
      overlayColor: overlayColor ?? _defaultOptions.overlayColor,
      closeOnClickOverlay:
          closeOnClickOverlay ?? _defaultOptions.closeOnClickOverlay,
      transitionBuilder: transitionBuilder ?? _defaultOptions.transitionBuilder,
      backgroundColor: themeData.backgroundColor,
      borderRadius: BorderRadius.circular(themeData.borderRadius),
      round: true,
      onOpen: onOpen,
      onClose: onClose,
      onOpened: onOpened,
      onClosed: onClosed,
    );
    FlanDialog.isInstanceShow = false;
    return action;
  }

  static Future<FlanDialogAction?> confirm(
    BuildContext context, {

    /// 标题
    String? title,

    /// 弹窗宽度
    double? width,

    /// 文本内容，支持通过 `\n` 换行
    String? message,

    /// 内容水平对齐方式，可选值为 `left` `right` `center`
    TextAlign? messageAlign,

    /// 式风格，可选值为 `roundButton` `normal`
    FlanDialogThemeType? theme,

    /// 是否展示确认按钮
    bool? showConfirmButton,

    /// 是否展示取消按钮
    bool? showCancelButton,

    /// 确认按钮文案
    String? confirmButtonText,

    /// 确认按钮颜色
    Color? confirmButtonColor,

    /// 取消按钮文案
    String? cancelButtonText,

    /// 取消按钮颜色
    Color? cancelButtonColor,

    /// 自定义遮罩层样式
    Color? overlayColor,

    /// 是否在点击遮罩层后关闭
    bool? closeOnClickOverlay,

    /// 关闭前判断, `return false` 不关闭
    FlanDialogBeforeClose? beforeClose,

    /// 动画
    FlanTransitionBuilder? transitionBuilder,

    /// 点击确认按钮时触发
    VoidCallback? onConfirm,

    /// 点击取消按钮时触发
    VoidCallback? onCancel,

    /// 打开面板时触发
    VoidCallback? onOpen,

    /// 关闭面板时触发
    VoidCallback? onClose,

    /// 打开面板且动画结束后触发
    VoidCallback? onOpened,

    /// 关闭面板且动画结束后触发
    VoidCallback? onClosed,

    /// 自定义内容
    WidgetBuilder? builder,

    /// 自定义标题
    WidgetBuilder? titleBuilder,

    /// 自定义底部按钮区域
    WidgetBuilder? footerBuilder,
  }) async {
    return alert(
      context,
      title: title,
      width: width,
      message: message,
      messageAlign: messageAlign,
      theme: theme,
      showConfirmButton: showConfirmButton,
      showCancelButton: showCancelButton ?? true,
      confirmButtonText: confirmButtonText,
      confirmButtonColor: confirmButtonColor,
      cancelButtonText: cancelButtonText,
      cancelButtonColor: cancelButtonColor,
      overlayColor: overlayColor,
      closeOnClickOverlay: closeOnClickOverlay,
      beforeClose: beforeClose,
      transitionBuilder: transitionBuilder,
      onConfirm: onConfirm,
      onCancel: onCancel,
      onOpen: onOpen,
      onClose: onClose,
      onOpened: onOpened,
      onClosed: onClosed,
      builder: builder,
      titleBuilder: titleBuilder,
      footerBuilder: footerBuilder,
    );
  }

  static bool isInstanceShow = false;

  static void close(BuildContext context) {
    if (isInstanceShow) {
      Navigator.of(context).maybePop();
    }
  }

  static FlanDialogOption currentOptions = const FlanDialogOption();

  static void setDefaultOptions(FlanDialogOption option) {
    currentOptions = currentOptions.merge(option);
  }

  static void resetDefaultOptions(FlanDialogOption option) {
    currentOptions = const FlanDialogOption();
  }
}

Widget kFlanDialogBounceTransition(
  BuildContext context,
  Animation<double> animation,
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

class FlanDialogWidget extends StatefulWidget {
  const FlanDialogWidget({
    Key? key,
    this.title = '',
    this.width,
    this.message = '',
    this.messageAlign = TextAlign.left,
    this.theme = FlanDialogThemeType.normal,
    this.showConfirmButton = true,
    this.showCancelButton = false,
    this.confirmButtonText = '',
    this.confirmButtonColor,
    this.cancelButtonText = '',
    this.cancelButtonColor,
    this.beforeClose,
    this.onConfirm,
    this.onCancel,
    this.child,
    this.titleSlot,
    this.footerSlot,
  }) : super(key: key);

  // ****************** Props ******************

  /// 标题
  final String title;

  /// 弹窗宽度
  final double? width;

  /// 文本内容，支持通过 `\n` 换行
  final String message;

  /// 内容水平对齐方式，可选值为 `left` `right` `center`
  final TextAlign messageAlign;

  /// 式风格，可选值为 `roundButton` `normal`
  final FlanDialogThemeType theme;

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

  /// 关闭前的回调函数，返回 `false` 可阻止关闭
  final FlanDialogBeforeClose? beforeClose;

  // ****************** Events ******************

  /// 点击确认按钮时触发
  final VoidCallback? onConfirm;

  /// 点击取消按钮时触发
  final VoidCallback? onCancel;

  // ****************** Slots ******************
  /// 自定义内容
  final Widget? child;

  /// 自定义标题
  final Widget? titleSlot;

  /// 自定义底部按钮区域
  final Widget? footerSlot;

  @override
  _FlanDialogWidgetState createState() => _FlanDialogWidgetState();
}

class _FlanDialogWidgetState extends State<FlanDialogWidget> {
  final ValueNotifier<bool> confirmLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> cancelLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final FlanDialogThemeData themeData = FlanDialogTheme.of(context);
    final double winWidth = MediaQuery.of(context).size.width;

    return Container(
      width: widget.width ??
          (winWidth < 321.0
              ? themeData.smallScreenWidthFactor * winWidth
              : themeData.width),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTitle(themeData),
          _buildContent(themeData),
          _buildFooter(themeData),
        ],
      ),
    );
  }

  bool get hasTitle => widget.titleSlot != null || widget.title.isNotEmpty;

  Widget _buildTitle(FlanDialogThemeData themeData) {
    final bool isolated = widget.message.isEmpty && widget.child == null;

    return Visibility(
      visible: hasTitle,
      child: Container(
        padding: isolated
            ? themeData.headerIsolatedPadding
            : EdgeInsets.only(top: themeData.headerPaddingTop),
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: themeData.fontSize,
            color: FlanThemeVars.textColor,
            fontWeight: themeData.headerFontWeight,
            height: themeData.headerLineHeight,
          ),
          child: widget.titleSlot ?? Text(widget.title),
        ),
      ),
    );
  }

  Widget _buildContent(FlanDialogThemeData themeData) {
    if (widget.child != null) {
      return widget.child!;
    }
    final double winHeight = MediaQuery.of(context).size.height;

    return Visibility(
      visible: widget.message.isNotEmpty,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: themeData.messageMaxHeight * winHeight,
        ),
        padding: EdgeInsets.only(
          top: hasTitle ? themeData.hasTitleMessagePaddingTop : 26.0.rpx,
          bottom: isRoundTheme ? FlanThemeVars.paddingMd.rpx : 26.0.rpx,
          left: themeData.messagePadding,
          right: themeData.messagePadding,
        ),
        child: Text(
          widget.message,
          style: TextStyle(
            fontSize: themeData.messageFontSize,
            height: themeData.messageLineHeight,
            color: hasTitle ? themeData.hasTitleMessageTextColor : null,
          ),
          textAlign: widget.messageAlign,
        ),
      ),
    );
  }

  bool get isRoundTheme => widget.theme == FlanDialogThemeType.roundButton;

  Widget _buildButtons(FlanDialogThemeData themeData) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: FlanHairLine()),
      ),
      height: themeData.buttonHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Visibility(
            visible: widget.showCancelButton,
            child: Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: cancelLoading,
                builder: (BuildContext context, bool loading, Widget? child) {
                  return FlanButton(
                    border: false,
                    size: FlanButtonSize.large,
                    text: widget.cancelButtonText.isNotEmpty
                        ? widget.cancelButtonText
                        : FlanS.of(context).cancel,
                    textColor: widget.cancelButtonColor,
                    loading: loading,
                    onClick: _onCancel,
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: widget.showCancelButton,
            child: const VerticalDivider(
              width: 1.0,
              color: FlanThemeVars.borderColor,
            ),
          ),
          Visibility(
            visible: widget.showConfirmButton,
            child: Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: confirmLoading,
                builder: (BuildContext context, bool loading, Widget? child) {
                  return FlanButton(
                    border: false,
                    size: FlanButtonSize.large,
                    text: widget.confirmButtonText.isNotEmpty
                        ? widget.confirmButtonText
                        : FlanS.of(context).confirm,
                    textColor: widget.confirmButtonColor ??
                        themeData.confirmButtonTextColor,
                    loading: loading,
                    onClick: _onConfirm,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRoundButtons(FlanDialogThemeData themeData) {
    return Container(
      padding: EdgeInsets.only(
        top: FlanThemeVars.paddingXs.rpx,
        left: FlanThemeVars.paddingLg.rpx,
        right: FlanThemeVars.paddingLg.rpx,
        bottom: FlanThemeVars.paddingMd.rpx,
      ),
      child: FlanActionBar(
        children: <Widget>[
          Visibility(
            visible: widget.showCancelButton,
            child: ValueListenableBuilder<bool>(
              valueListenable: cancelLoading,
              builder: (BuildContext context, bool loading, Widget? child) {
                return FlanActionBarButton(
                  type: FlanButtonType.warning,
                  text: widget.cancelButtonText.isNotEmpty
                      ? widget.cancelButtonText
                      : 'FlanS.of(context).cancel',
                  color: widget.cancelButtonColor,
                  loading: loading,
                  onClick: _onCancel,
                  height: themeData.roundButtonHeight,
                );
              },
            ),
          ),
          Visibility(
            visible: widget.showConfirmButton,
            child: ValueListenableBuilder<bool>(
              valueListenable: confirmLoading,
              builder: (BuildContext context, bool loading, Widget? child) {
                return FlanActionBarButton(
                  type: FlanButtonType.danger,
                  text: widget.confirmButtonText.isNotEmpty
                      ? widget.confirmButtonText
                      : FlanS.of(context).confirm,
                  color: widget.confirmButtonColor,
                  loading: loading,
                  onClick: _onConfirm,
                  height: themeData.roundButtonHeight,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(FlanDialogThemeData themeData) {
    if (widget.footerSlot != null) {
      return widget.footerSlot!;
    }
    return widget.theme == FlanDialogThemeType.roundButton
        ? _buildRoundButtons(themeData)
        : _buildButtons(themeData);
  }

  void _close(FlanDialogAction action) {
    Navigator.of(context).maybePop(action);
  }

  void _onConfirm() => _getActionHandler(FlanDialogAction.confirm);

  void _onCancel() => _getActionHandler(FlanDialogAction.cancel);

  Future<void> _getActionHandler(FlanDialogAction action) async {
    switch (action) {
      case FlanDialogAction.confirm:
        widget.onConfirm?.call();
        break;
      case FlanDialogAction.cancel:
        widget.onCancel?.call();
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
        confirmLoading.value = loading;
        break;
      case FlanDialogAction.cancel:
        cancelLoading.value = loading;
        break;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<String>('title', widget.title, defaultValue: ''));
    properties.add(DiagnosticsProperty<double>('width', widget.width));
    properties.add(DiagnosticsProperty<String>('message', widget.message,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<TextAlign>(
        'messageAlign', widget.messageAlign,
        defaultValue: TextAlign.left));
    properties.add(DiagnosticsProperty<FlanDialogThemeType>(
        'theme', widget.theme,
        defaultValue: FlanDialogThemeType.normal));
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
    properties.add(DiagnosticsProperty<Future<bool> Function(FlanDialogAction)>(
        'beforeClose', widget.beforeClose));
    super.debugFillProperties(properties);
  }
}

enum FlanDialogThemeType {
  normal,
  roundButton,
}

enum FlanDialogAction {
  confirm,
  cancel,
}
