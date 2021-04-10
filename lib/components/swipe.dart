// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/components/button.dart';
import 'package:flant/flant.dart';
import '../styles/var.dart';

/// ### Swipe 轮播
class FlanSwipe extends StatelessWidget {
  const FlanSwipe({
    Key? key,
    this.autoplay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
    this.initialSwipe = 0,
    this.width,
    this.height,
    this.loop = true,
    this.showIndicators = true,
    this.vertical = false,
    this.touchable = true,
    this.stopPropagation = true,
    this.lazyRender = false,
    this.indicatorColor,
    this.onChange,
    this.child,
    this.indicatorSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 自动轮播间隔，单位为 ms
  final Duration autoplay;

  /// 动画时长，单位为 ms
  final Duration duration;

  /// 初始位置索引值
  final int initialSwipe;

  /// 滑块宽度
  final double? width;

  /// 滑块高度
  final double? height;

  /// 是否开启循环播放
  final bool loop;

  /// 是否显示指示器
  final bool showIndicators;

  /// 是否为纵向滚动
  final bool vertical;

  /// 是否可以通过手势滑动
  final bool touchable;

  /// 是否阻止滑动事件冒泡
  final bool stopPropagation;

  /// 是否延迟渲染未展示的轮播
  final bool lazyRender;

  /// 指示器颜色
  final Color? indicatorColor;

  // ****************** Events ******************

  /// 每一页轮播结束后触发
  final ValueChanged<int>? onChange;

  // ****************** Slots ******************

  /// 轮播内容
  final Widget? child;

  /// 自定义指示器
  final Widget? indicatorSlot;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Duration>('autoplay', autoplay,
        defaultValue: Duration.zero));
    properties.add(DiagnosticsProperty<Duration>('duration', duration,
        defaultValue: const Duration(milliseconds: 500)));
    properties.add(DiagnosticsProperty<int>('initialSwipe', initialSwipe,
        defaultValue: 0));
    properties.add(DiagnosticsProperty<double>('width', width));
    properties.add(DiagnosticsProperty<double>('height', height));
    properties.add(DiagnosticsProperty<bool>('loop', loop, defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('showIndicators', showIndicators,
        defaultValue: true));
    properties.add(
        DiagnosticsProperty<bool>('vertical', vertical, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('touchable', touchable, defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('stopPropagation', stopPropagation,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('lazyRender', lazyRender,
        defaultValue: false));
    properties
        .add(DiagnosticsProperty<Color>('indicatorColor', indicatorColor));

    super.debugFillProperties(properties);
  }
}
