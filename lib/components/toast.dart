import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../styles/var.dart';
import 'icon.dart';
import 'loading.dart';
import 'style.dart';

int tUuid = 0;

void showToast(
  BuildContext context, {
  bool show = false,
  FlanToastType type = FlanToastType.text,
  FlanToastPosition position = FlanToastPosition.middle,
  String message = '',
  int? iconName,
  String? iconUrl,
  String iconPrefix = kFlanIconsFamily,
  bool overlay = false,
  bool forbidClick = false,
  bool closeOnClick = false,
  bool closeOnClickOverlay = false,
  FlanLoadingType loadingType = FlanLoadingType.circular,
  Duration duration = const Duration(seconds: 2),
  FlanTransitionBuilder transitionBuilder = kFlanFadeTransitionBuilder,
  VoidCallback? onOpened,
  VoidCallback? onClose,
}) {
  final OverlayEntry entry = OverlayEntry(
    builder: (BuildContext context) {
      return FlanToast(
        show: show,
        type: type,
        position: position,
        message: message,
        iconName: iconName,
        iconUrl: iconUrl,
        iconPrefix: iconPrefix,
        overlay: overlay,
        forbidClick: forbidClick,
        closeOnClick: closeOnClick,
        closeOnClickOverlay: closeOnClickOverlay,
        loadingType: loadingType,
        duration: duration,
        transitionBuilder: transitionBuilder,
        onOpened: onOpened,
        onClose: onClose,
      );
    },
  );
  Overlay.of(context, rootOverlay: true)?.insert(entry);
  Future<dynamic>.delayed(const Duration(seconds: 2))
      .then((dynamic value) => entry.remove());
  // return entry;
}

class FlanToast extends StatelessWidget {
  const FlanToast({
    Key? key,
    this.show = false,
    this.type = FlanToastType.text,
    this.position = FlanToastPosition.middle,
    this.message = '',
    this.iconName,
    this.iconUrl,
    this.iconPrefix = kFlanIconsFamily,
    this.overlay = false,
    this.forbidClick = false,
    this.closeOnClick = false,
    this.closeOnClickOverlay = false,
    this.loadingType = FlanLoadingType.circular,
    this.duration = const Duration(seconds: 2),
    this.transitionBuilder = kFlanFadeTransitionBuilder,
    this.onOpened,
    this.onClose,
  })  : assert(type is FlanToastType),
        assert(position is FlanToastPosition),
        super(key: key);

  // ****************** Props ******************
  final bool show;

  /// 提示类型，可选值为 `loading` `success` `fail` `html` `text`
  final FlanToastType type;

  /// 位置，可选值为 `top` `middle` `bottom`
  final FlanToastPosition position;

  /// 文本内容,支持通过`\n`换行
  final String message;

  /// 自定义图标，支持传入图标名称
  final int? iconName;

  /// 自定义图标，支持传入图片链接
  final String? iconUrl;

  /// 图标类名前缀，同 Icon 组件的 class-prefix 属性
  final String iconPrefix;

  /// 是否显示背景遮罩层
  final bool overlay;

  /// 是否禁止背景点击
  final bool forbidClick;

  /// 是否在点击后关闭
  final bool closeOnClick;

  /// 是否在点击遮罩层后关闭
  final bool closeOnClickOverlay;

  /// 加载图标类型, 可选值为 `spinner`
  final FlanLoadingType loadingType;

  /// 展示时长值为 `Duration.zero` 时，toast 不会消失
  final Duration duration;

  /// 动画类名，等价于 transtion 的`name`属性
  final FlanTransitionBuilder transitionBuilder;

  // ****************** Events ******************

  /// 完全展示后的回调函数
  final VoidCallback? onOpened;

  /// 关闭时的回调函数
  final VoidCallback? onClose;

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isText = type == FlanToastType.text;
    final bool hasIcon = iconName != null || iconUrl != null;

    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Align(
        alignment: _position,
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: ThemeVars.toastTextColor,
            fontSize: ThemeVars.toastFontSize,
            // height: ThemeVars.toastLineHeight / ThemeVars.toastFontSize,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: ThemeVars.toastMaxWidth * size.width,
              minWidth: ThemeVars.toastDefaultWidth,
              minHeight: isText ? 0.0 : ThemeVars.toastDefaultMinHeight,
            ),
            padding: isText
                ? ThemeVars.toastTextPadding
                : ThemeVars.toastDefaultPadding,
            decoration: BoxDecoration(
              color: ThemeVars.toastBackgroundColor,
              borderRadius: BorderRadius.circular(ThemeVars.toastBorderRadius),
            ),
            child: Wrap(
              direction: Axis.vertical,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                _buildIcon(),
                SizedBox(
                  height: isText && !hasIcon ? 0.0 : ThemeVars.paddingXs,
                ),
                _buildMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Alignment get _position {
    switch (position) {
      case FlanToastPosition.top:
        return const Alignment(0.0, -0.6);
      case FlanToastPosition.middle:
        return const Alignment(0.0, 0.0);
      case FlanToastPosition.bottom:
        return const Alignment(0.0, 0.6);
    }
  }

  Widget _buildIcon() {
    final bool hasIcon = iconName != null ||
        iconUrl != null ||
        type == FlanToastType.success ||
        type == FlanToastType.fail;

    if (hasIcon) {
      int? name = iconName;
      if (type == FlanToastType.success) {
        name = FlanIcons.success;
      }

      if (type == FlanToastType.fail) {
        name = FlanIcons.fail;
      }

      return FlanIcon(
        iconName: name,
        iconUrl: iconUrl,
        size: ThemeVars.toastIconSize,
        classPrefix: iconPrefix,
        color: iconUrl != null ? null : ThemeVars.toastTextColor,
      );
    }

    if (type == FlanToastType.loading) {
      return Padding(
        padding: const EdgeInsets.all(ThemeVars.paddingBase),
        child: FlanLoading(
          type: loadingType,
          color: ThemeVars.toastLoadingIconColor,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildMessage() {
    if (message.isNotEmpty) {
      return Text(message);
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
