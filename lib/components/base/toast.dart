import 'package:flant/components/base/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './icon.dart';
import '../../styles/var.dart';

int tUuid = 0;

void showToast(
  BuildContext context, {
  bool show = false,
  FlanToastType type = FlanToastType.text,
  FlanToastPosition position = FlanToastPosition.middle,
  String message = "",
  int iconName,
  String iconUrl,
  String iconPrefix = kFlanIconsFamily,
  bool overlay = false,
  bool forbidClick = false,
  bool closeOnClick = false,
  bool closeOnClickOverlay = false,
  String loadingType = "circle",
  Duration duration = const Duration(seconds: 2),
  FlanTransitionBuilder transitionBuilder = kFlanFadeTransitionBuilder,
  VoidCallback onOpened,
  VoidCallback onClose,
}) {
  OverlayEntry entry = OverlayEntry(
    builder: (context) {
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
  Overlay.of(context, rootOverlay: true).insert(entry);
  Future.delayed(const Duration(seconds: 2)).then((value) => entry.remove());
  // return entry;
}

class FlanToast extends StatelessWidget {
  const FlanToast({
    Key key,
    this.show = false,
    this.type = FlanToastType.text,
    this.position = FlanToastPosition.middle,
    this.message = "",
    this.iconName,
    this.iconUrl,
    this.iconPrefix = kFlanIconsFamily,
    this.overlay = false,
    this.forbidClick = false,
    this.closeOnClick = false,
    this.closeOnClickOverlay = false,
    this.loadingType = "circle",
    this.duration = const Duration(seconds: 2),
    this.transitionBuilder = kFlanFadeTransitionBuilder,
    this.onOpened,
    this.onClose,
  })  : assert(type != null && type is FlanToastType),
        assert(position != null && position is FlanToastPosition),
        assert(message != null),
        assert(iconPrefix != null),
        assert(overlay != null),
        assert(forbidClick != null),
        assert(closeOnClick != null),
        assert(closeOnClickOverlay != null),
        assert(loadingType != null),
        assert(duration != null),
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
  final int iconName;

  /// 自定义图标，支持传入图片链接
  final String iconUrl;

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
  final String loadingType;

  /// 展示时长值为 `Duration.zero` 时，toast 不会消失
  final Duration duration;

  /// 动画类名，等价于 transtion 的`name`属性
  final FlanTransitionBuilder transitionBuilder;

  // ****************** Events ******************

  /// 完全展示后的回调函数
  final VoidCallback onOpened;

  /// 关闭时的回调函数
  final VoidCallback onClose;

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isText = this.type == FlanToastType.text;
    final hasIcon = this.iconName != null || this.iconUrl != null;

    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Align(
        alignment: this._position,
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
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
              children: [
                this._buildIcon(),
                isText && !hasIcon
                    ? null
                    : SizedBox(height: ThemeVars.paddingXs),
                this._buildMessage(),
              ].where((element) => element != null).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Alignment get _position {
    switch (this.position) {
      case FlanToastPosition.top:
        return Alignment(0.0, -0.6);
      case FlanToastPosition.middle:
        return Alignment(0.0, 0.0);
      case FlanToastPosition.bottom:
        return Alignment(0.0, 0.6);
    }

    return Alignment(0.0, 0.0);
  }

  Widget _buildIcon() {
    final hasIcon = this.iconName != null ||
        this.iconUrl != null ||
        this.type == FlanToastType.success ||
        this.type == FlanToastType.fail;

    if (hasIcon) {
      int name = this.iconName;
      if (this.type == FlanToastType.success) {
        name = FlanIcons.success;
      }

      if (this.type == FlanToastType.fail) {
        name = FlanIcons.fail;
      }

      return FlanIcon(
        iconName: name,
        iconUrl: this.iconUrl,
        size: ThemeVars.toastIconSize,
        classPrefix: this.iconPrefix,
      );
    }

    if (this.type == FlanToastType.loading) {
      return FlanIcon(iconName: Icons.ac_unit.codePoint);
    }
    return null;
  }

  Widget _buildMessage() {
    if (this.message != null && this.message.isNotEmpty) {
      return Text(this.message);
    }
    return null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement debugFillProperties
    super.debugFillProperties(properties);
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
