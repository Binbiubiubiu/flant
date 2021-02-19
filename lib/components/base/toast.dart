import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './icon.dart';
import '../../styles/var.dart';

class FlanToast extends StatelessWidget {
  const FlanToast({
    Key key,
    this.type = FlanToastType.text,
    this.position = FlanToastPosition.middle,
    this.message = "",
    this.iconName,
    this.iconUrl,
    this.iconPrefix = kFlanIconsFamily,
    this.overlay,
    this.forbidClick,
    this.closeOnClick,
    this.closeOnClickOverlay,
    this.loadingType,
    this.duration,
    this.transitionBuilder,
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
  final RouteTransitionsBuilder transitionBuilder;

  // ****************** Events ******************

  /// 完全展示后的回调函数
  final VoidCallback onOpened;

  /// 关闭时的回调函数
  final VoidCallback onClose;

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    return Container();
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
  html,
}
