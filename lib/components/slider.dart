import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../styles/var.dart';

/// ### Slider 滑块
/// 滑动输入条，用于在给定的范围内选择一个值。
class FlanSlider<T> extends StatefulWidget {
  const FlanSlider({
    Key? key,
    T? value,
    this.max = 100.0,
    this.min = 0.0,
    this.step = 1.0,
    this.barHeight,
    this.buttonSize,
    this.activeColor,
    this.inActiveColor,
    this.range = false,
    this.disabled = false,
    this.readonly = false,
    this.vertical = false,
    this.onValueChange,
    this.onChange,
    this.onDragStart,
    this.onDragEnd,
    this.buttonSlot,
  })  : assert(value is T || value is List<T>),
        value = value ?? 0.0 as T,
        super(key: key);

  // ****************** Props ******************
  /// 当前进度百分比
  final T value;

  /// 最大值
  final double max;

  /// 最小值
  final double min;

  /// 步长
  final double step;

  /// 进度条高度
  final double? barHeight;

  /// 滑块按钮大小
  final double? buttonSize;

  /// 进度条激活态颜色
  final Color? activeColor;

  /// 进度条非激活态颜色
  final Color? inActiveColor;

  /// 是否开启双滑块模式
  final bool range;

  /// 是否禁用滑块
  final bool disabled;

  /// 是否为只读状态，只读状态下无法修改滑块的值
  final bool readonly;

  /// 是否垂直展示
  final bool vertical;

  // ****************** Events ******************
  /// 进度变化监听
  final ValueChanged<T>? onValueChange;

  /// 进度变化且结束拖动后触发
  final ValueChanged<T>? onChange;

  /// 开始拖动时触发
  final VoidCallback? onDragStart;

  /// 结束拖动时触发
  final VoidCallback? onDragEnd;

  // ****************** Slots ******************

  /// 自定义滑动按钮
  final Widget? buttonSlot;

  @override
  _FlanSliderState<T> createState() => _FlanSliderState<T>();
}

class _FlanSliderState<T> extends State<FlanSlider<T>> {
  int? buttonIndex;
  T? startValue;
  T? currentValue;

  // GlobalKey root = GlobalKey();

  FlanSliderDragStatus dragStatus = FlanSliderDragStatus.none;

  Offset lastPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapUp: onClick,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: ThemeVars.sliderButtonHeight / 2.0,
                ),
                child: Container(
                  // key: root,
                  width: double.infinity,
                  height: ThemeVars.sliderBarHeight,
                  decoration: BoxDecoration(
                    color: ThemeVars.sliderInactiveBackgroundColor,
                    borderRadius: BorderRadius.circular(
                      ThemeVars.borderRadiusMax,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Positioned(
                left: widget.vertical
                    ? null
                    : calcOffset() / 100 * constraints.maxWidth,
                top: widget.vertical
                    ? calcOffset() / 100 * constraints.maxWidth
                    : null,
                width: calcMainAxis() / 100.0 * constraints.maxWidth,
                child: Opacity(
                  opacity:
                      widget.disabled ? ThemeVars.sliderDisabledOpacity : 1.0,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: ThemeVars.sliderButtonHeight / 2.0,
                        ),
                        child: Container(
                          height: ThemeVars.sliderBarHeight,
                          decoration: BoxDecoration(
                            color: widget.activeColor ??
                                ThemeVars.sliderActiveBackgroundColor,
                            borderRadius: BorderRadius.circular(
                                ThemeVars.borderRadiusMax),
                          ),
                        ),
                      ),
                      ...widget.range
                          ? <Widget>[
                              _buildButton(index: 0),
                              _buildButton(index: 1)
                            ]
                          : <Widget>[_buildButton()]
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  bool isRange(T? val) => widget.range && val is List<num>;

  double calcMainAxis() {
    if (isRange(widget.value)) {
      final List<double> value = widget.value as List<double>;
      return (value[1] - value[0]) * 100 / scope;
    }
    final double value = widget.value as double;
    return (value - widget.min) * 100 / scope;
  }

  double calcOffset() {
    if (isRange(widget.value)) {
      final List<double> value = widget.value as List<double>;
      return (value[0] - widget.min) * 100 / scope;
    }

    return 0;
  }

  double format(double value) {
    value = math.max(widget.min, math.min(value, widget.max));
    return (value / widget.step).round() * widget.step;
  }

  bool isSameValue(T? newValue, T? oldValue) => newValue == oldValue;

  List<double> handleOverlap(List<double> value) {
    if (value[0] > value[1]) {
      return value.reversed.toList();
    }
    return value;
  }

  void updateValue(T value, {bool end = false}) {
    if (isRange(value)) {
      print(value);
      value = handleOverlap(value as List<double>).map(format).toList() as T;
    } else {
      value = format(value as double) as T;
    }
    if (!isSameValue(value, widget.value)) {
      if (widget.onValueChange != null) {
        widget.onValueChange!(value);
      }
    }

    if (end && !isSameValue(value, startValue)) {
      if (widget.onChange != null) {
        widget.onChange!(value);
      }
    }
  }

  Rect get rect {
    return context.findRenderObject()!.paintBounds;
  }

  void onClick(TapUpDetails details) {
    if (widget.disabled || widget.readonly) {
      return;
    }

    final double delta =
        widget.vertical ? details.localPosition.dy : details.localPosition.dx;

    final double total = widget.vertical ? rect.height : rect.width;
    final double value = widget.min + (delta / total) * scope;
    if (isRange(widget.value)) {
      final List<double> modelValue = widget.value as List<double>;
      final double left = modelValue[0];
      final double right = modelValue[1];
      final double middle = (left + right) / 2;

      if (value <= middle) {
        updateValue(<double>[value, right] as T, end: true);
      } else {
        updateValue(<double>[left, value] as T, end: true);
      }
    } else {
      updateValue(value as T, end: true);
    }
  }

  void onTouchStart(DragStartDetails details) {
    if (widget.disabled || widget.readonly) {
      return;
    }

    currentValue = widget.value;
    if (isRange(currentValue)) {
      startValue = (currentValue as List<double>).map(format).toList() as T;
    } else {
      startValue = format(currentValue as double) as T;
    }
    lastPosition = details.globalPosition;
    dragStatus = FlanSliderDragStatus.start;
  }

  void onTouchMove(DragUpdateDetails details) {
    if (widget.disabled || widget.readonly) {
      return;
    }
    if (dragStatus == FlanSliderDragStatus.start) {
      if (widget.onDragStart != null) {
        widget.onDragStart!();
      }
    }
    final double delta = widget.vertical
        ? details.globalPosition.dy
        : (details.globalPosition - lastPosition).dx;
    final double total = widget.vertical ? rect.height : rect.width;
    final double diff = (delta / total) * scope;

    dragStatus = FlanSliderDragStatus.draging;
    if (isRange(startValue)) {
      (currentValue as List<double>)[buttonIndex!] =
          (startValue as List<double>)[buttonIndex!] + diff;
    } else {
      currentValue = (startValue as double) + diff as T;
    }
    updateValue(currentValue!);
  }

  void onTouchEnd() {
    if (widget.disabled || widget.readonly) {
      return;
    }
    if (dragStatus == FlanSliderDragStatus.draging) {
      updateValue(currentValue!, end: true);
      if (widget.onDragEnd != null) {
        widget.onDragEnd!();
      }
    }

    dragStatus = FlanSliderDragStatus.none;
  }

  Widget _buildButton({int? index}) {
    final bool isLeft = index != null && index > 0;
    final double currentValue = index != null
        ? (widget.value as List<double>)[index]
        : widget.value as double;

    return Positioned(
      left: isLeft ? -ThemeVars.sliderButtonWidth / 2.0 : null,
      right: isLeft ? null : -ThemeVars.sliderButtonWidth / 2.0,
      child: Semantics(
        label: 'slider',
        slider: true,
        value: '$currentValue',
        child: MouseRegion(
          cursor: widget.disabled
              ? SystemMouseCursors.forbidden
              : SystemMouseCursors.grab,
          child: GestureDetector(
            dragStartBehavior: DragStartBehavior.down,
            behavior: HitTestBehavior.opaque,
            onPanStart: (DragStartDetails detail) {
              if (index != null) {
                buttonIndex = index;
              }
              onTouchStart(detail);
            },
            onPanUpdate: onTouchMove,
            onPanEnd: (DragEndDetails details) => onTouchEnd(),
            onPanCancel: onTouchEnd,
            child: widget.buttonSlot ??
                Container(
                  width: ThemeVars.sliderButtonWidth,
                  height: ThemeVars.sliderButtonHeight,
                  decoration: const BoxDecoration(
                    color: ThemeVars.sliderButtonBackgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: ThemeVars.sliderButtonBoxShadow,
                  ),
                ),
          ),
        ),
      ),
    );
  }

  double get scope => widget.max - widget.min;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement debugFillProperties
    super.debugFillProperties(properties);
  }
}

enum FlanSliderDragStatus {
  start,
  draging,
  none,
}
