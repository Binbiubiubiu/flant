// 🐦 Flutter imports:
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../styles/components/swipe_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';

typedef FlanSwipeIndicatorBuilder = Widget Function(int active);

/// ### ImagePreview 图片预览
class FlanImagePreview extends StatefulWidget {
  const FlanImagePreview({
    Key? key,
    this.autoplay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
    this.initialSwipe = 0,
    this.controller,
    // this.width,
    required this.height,
    // this.loop = true,
    this.showIndicators = true,
    this.vertical = false,
    this.touchable = true,
    this.stopPropagation = true,
    // this.lazyRender = false,
    this.indicatorColor,
    this.onChange,
    this.children = const <Widget>[],
    this.indicatorBuilder,
  }) : super(key: key);

  // ****************** Props ******************
  /// 自动轮播间隔，单位为 ms
  final Duration autoplay;

  /// 动画时长，单位为 ms
  final Duration duration;

  /// 初始位置索引值
  final int initialSwipe;

  /// 控制器
  final FlanSwipeController? controller;

  // /// 滑块宽度
  // final double? width;

  /// 滑块高度
  final double height;

  // /// 是否开启循环播放
  // final bool loop;

  /// 是否显示指示器
  final bool showIndicators;

  /// 是否为纵向滚动
  final bool vertical;

  /// 是否可以通过手势滑动
  final bool touchable;

  /// 是否阻止滑动事件冒泡
  final bool stopPropagation;

  // /// 是否延迟渲染未展示的轮播
  // final bool lazyRender;

  /// 指示器颜色
  final Color? indicatorColor;

  // ****************** Events ******************

  /// 每一页轮播结束后触发
  final ValueChanged<int>? onChange;

  // ****************** Slots ******************

  /// 轮播内容
  final List<Widget> children;

  /// 自定义指示器
  final FlanSwipeIndicatorBuilder? indicatorBuilder;

  @override
  _FlanImagePreviewState createState() => _FlanImagePreviewState();
}

class _FlanImagePreviewState extends State<FlanImagePreview> {
  late FlanSwipeController _controller;
  late ValueNotifier<int> current;

  Timer? _loopTimer;

  @override
  void initState() {
    _controller = widget.controller ?? FlanSwipeController(itemCount: count);
    current = ValueNotifier<int>(_controller.initialPage % count);
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    current.dispose();
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: <Widget>[
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification is UserScrollNotification &&
                  notification.direction == ScrollDirection.forward) {
                _stopTimer();
              }

              if (notification is ScrollEndNotification) {
                _startTimer();
              }
              return widget.stopPropagation;
            },
            child: IgnorePointer(
              ignoring: !widget.touchable,
              child: PageView.builder(
                controller: _controller,
                physics: const ClampingScrollPhysics(),
                scrollDirection:
                    widget.vertical ? Axis.vertical : Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return widget.children[index % count];
                },
                itemCount: _controller.loop ? null : count,
                onPageChanged: (int value) {
                  final int _current = value % count;
                  current.value = _current;
                  widget.onChange?.call(_current);

                  widget.onChange?.call(_current);
                },
              ),
            ),
          ),
          IgnorePointer(
            child: _buildIndicator(),
          ),
        ],
      ),
    );
  }

  void _startTimer() {
    if (widget.autoplay != Duration.zero && count > 0) {
      if (!_controller.loop && current.value == count - 1) {
        return;
      }
      _loopTimer = Timer(widget.autoplay, () {
        _controller.nextPage(duration: widget.duration, curve: Curves.linear);
      });
    }
  }

  void _stopTimer() {
    if (_loopTimer != null) {
      _loopTimer?.cancel();
      _loopTimer = null;
    }
  }

  int get count => widget.children.length;

  Widget _buildIndicator() {
    if (widget.indicatorBuilder != null) {
      return ValueListenableBuilder<int>(
        valueListenable: current,
        builder: (BuildContext context, int value, Widget? child) {
          return widget.indicatorBuilder!(current.value);
        },
      );
    }

    if (widget.showIndicators && count > 1) {
      return _FlanSwipeIndicator(
        current: current,
        itemCount: count,
        vertical: widget.vertical,
        activeColor: widget.indicatorColor,
      );
    }

    return const SizedBox.shrink();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Duration>('autoplay', widget.autoplay,
        defaultValue: Duration.zero));
    properties.add(DiagnosticsProperty<Duration>('duration', widget.duration,
        defaultValue: const Duration(milliseconds: 500)));
    properties.add(DiagnosticsProperty<int>('initialSwipe', widget.initialSwipe,
        defaultValue: 0));
    properties.add(
        DiagnosticsProperty<PageController>('controller', widget.controller));
    // properties.add(DiagnosticsProperty<double>('width', widget.width));
    properties.add(DiagnosticsProperty<double>('height', widget.height));
    // properties.add(
    //     DiagnosticsProperty<bool>('loop', widget.loop, defaultValue: true));
    properties.add(DiagnosticsProperty<bool>(
        'showIndicators', widget.showIndicators,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('vertical', widget.vertical,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('touchable', widget.touchable,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>(
        'stopPropagation', widget.stopPropagation,
        defaultValue: true));
    // properties.add(DiagnosticsProperty<bool>('lazyRender', lazyRender,
    //     defaultValue: false));
    properties.add(
        DiagnosticsProperty<Color>('indicatorColor', widget.indicatorColor));

    super.debugFillProperties(properties);
  }
}

class FlanSwipeController extends PageController {
  FlanSwipeController({
    int initialPage = 0,
    required this.itemCount,
    this.loop = true,
    bool keepPage = true,
    double viewportFraction = 1.0,
  })  : assert(initialPage >= 0),
        assert(viewportFraction >= .7),
        super(
          initialPage: initialPage + (loop ? itemCount * 500 : 0),
          keepPage: keepPage,
          viewportFraction: viewportFraction,
        );
  final bool loop;
  final int itemCount;
}

class _FlanSwipeIndicator extends StatelessWidget {
  const _FlanSwipeIndicator({
    Key? key,
    required this.current,
    required this.itemCount,
    required this.vertical,
    this.activeColor,
  }) : super(key: key);

  final ValueNotifier<int> current;

  final int itemCount;

  final bool vertical;

  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final FlanSwipeThemeData themeData = FlanTheme.of(context).swipeTheme;

    return Positioned(
      bottom: vertical ? 0.0 : themeData.indicatorMargin,
      left: vertical ? themeData.indicatorMargin : 0.0,
      right: vertical ? null : 0.0,
      top: vertical ? 0.0 : null,
      child: ValueListenableBuilder<int>(
        valueListenable: current,
        builder: (BuildContext context, Object? value, Widget? child) {
          return Wrap(
            direction: vertical ? Axis.vertical : Axis.horizontal,
            alignment: WrapAlignment.center,
            runSpacing: vertical ? themeData.indicatorSize : 0.0,
            spacing: themeData.indicatorSize,
            children: List<Widget>.generate(
              itemCount,
              (int index) => _buildDot(
                themeData,
                active: index == value,
                key: ValueKey<int>(index),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDot(
    FlanSwipeThemeData themeData, {
    bool active = false,
    required Key key,
  }) {
    final Color activeColor = this.activeColor ??
        themeData.indicatorActiveBackgroundColor
            .withOpacity(themeData.indicatorActiveOpacity);
    final Color inActiveColor = themeData.indicatorInactiveBackgroundColor
        .withOpacity(themeData.indicatorInactiveOpacity);

    return AnimatedContainer(
      key: key,
      width: themeData.indicatorSize,
      height: themeData.indicatorSize,
      decoration: BoxDecoration(
        color: active ? activeColor : inActiveColor,
        shape: BoxShape.circle,
      ),
      duration: FlanThemeVars.animationDurationFast,
    );
  }
}
