import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../styles/theme.dart';
import 'style.dart';

/// Overlay 遮罩层
class FlanOverlay extends StatelessWidget {
  const FlanOverlay({
    Key? key,
    this.show = false,
    this.duration = const Duration(milliseconds: 200),
    this.lockScroll = true,
    this.customStyle,
    this.onClick,
    this.child,
  }) : super(key: key);

  // ****************** Props ******************
  /// 是否展示遮罩层
  final bool show;

  /// 动画时长，单位秒
  final Duration duration;

  /// 自定义样式
  final BoxDecoration? customStyle;

  /// 是否锁定滚动，锁定时蒙层里的内容也将无法滚动
  final bool lockScroll;

  // ****************** Events ******************

  /// 点击时触发
  final VoidCallback? onClick;

  // ****************** Slots ******************

  /// 默认插槽
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Color themeColor = FlanTheme.of(context).overlayBackgroundColor;
    return FlanTransitionVisiable.fade(
      duration: duration,
      // appear: true,
      visible: show,
      child: GestureDetector(
        onTap: onClick,
        child: DecoratedBox(
          decoration: customStyle ?? BoxDecoration(color: themeColor),
          child: _buildChild(),
        ),
      ),
    );
  }

  Widget? _buildChild() {
    if (child != null) {
      return IgnorePointer(
        ignoring: lockScroll,
        child: child,
      );
    }
    return null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<bool>('show', show, defaultValue: false));
    properties.add(DiagnosticsProperty<Duration>('duration', duration,
        defaultValue: const Duration(milliseconds: 200)));
    properties
        .add(DiagnosticsProperty<BoxDecoration>('customStyle', customStyle));
    super.debugFillProperties(properties);
  }
}
