import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../styles/var.dart';

/// 格式化百分比
double _formatRate(double rate) => math.min(math.max(rate, 0), 100);

/// ### FlanCircle 环形进度条
/// 圆环形的进度条组件，支持进度渐变动画。
class FlanCircle extends StatefulWidget {
  FlanCircle({
    Key? key,
    this.currentRate = 0.0,
    this.rate = 100.0,
    this.size = 100.0,
    this.color = Colors.blue,
    this.gradient,
    this.layerColor = Colors.white,
    this.fill,
    this.speed = 0.0,
    this.text,
    this.strokeWidth = 4.0,
    this.strokeLineCap = StrokeCap.round,
    this.clockwise = true,
    required this.onChange,
    this.child,
  })  : assert(currentRate >= 0.0 && currentRate <= 100.0),
        assert(rate >= 0.0 && rate <= 100.0),
        assert(size >= 0.0),
        assert(speed >= 0.0),
        assert(strokeWidth > 0.0),
        super(key: key);

  // ****************** Props ******************
  /// 当前进度
  final double currentRate;

  /// 目标进度
  final double rate;

  /// 圆环直径
  final double size;

  /// 进度条颜色
  final Color color;

  /// 进度条颜色，传入对象格式可以定义渐变色
  final Gradient? gradient;

  /// final Color layerColor;
  final Color layerColor;

  ///填充颜色
  final Color? fill;

  /// 动画速度（单位为 rate/s）
  final double speed;

  /// 文字
  final String? text;

  /// 进度条宽度
  final double strokeWidth;

  /// 进度条端点的形状，可选值为 `sqaure` `butt`
  final StrokeCap strokeLineCap;

  /// 是否顺时针增加
  final bool clockwise;

  // ****************** Events ******************

  // ****************** Slots ******************
  final Widget? child;
  final ValueChanged onChange;

  @override
  _FlanCircleState createState() => _FlanCircleState();
}

class _FlanCircleState extends State<FlanCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController
      ..stop()
      ..dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanCircle oldWidget) {
    if (this.widget.rate != oldWidget.rate) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        this._watchRate(this.widget.rate, oldWidget.rate);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  /// 监听进度条的进度变化
  void _watchRate(double rate, double oldRate) {
    final startRate = this.widget.currentRate;
    final endRate = _formatRate(rate);
    final duration = (((startRate - endRate) * 1000) / this.widget.speed).abs();

    void animate() {
      final rate =
          lerpDouble(0, endRate - startRate, _animationController.value)! +
              startRate;

      this.widget.onChange(_formatRate(rate).roundToDouble());

      if (endRate > startRate ? rate >= endRate : rate <= endRate) {
        this._animationController..removeListener(animate);
      }
    }

    if (this.widget.speed > 0.0) {
      _animationController
        ..stop()
        ..reset();

      _animationController
        ..duration = Duration(milliseconds: duration.round())
        ..addListener(animate)
        ..forward();
    } else {
      this.widget.onChange(endRate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: TextStyle(
        fontWeight: ThemeVars.circleTextFontWeight,
        fontSize: ThemeVars.circleTextFontSize,
        height: ThemeVars.circleTextLineHeight / ThemeVars.circleTextFontSize,
        color: ThemeVars.circleTextColor,
      ),
      type: MaterialType.canvas,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              CustomPaint(
                key: ValueKey("layer"),
                size: Size.square(this.widget.size),
                painter: _FlanDividerCirclePainter(
                  rate: 100.0,
                  color: this.widget.layerColor,
                  strokeWidth: this.widget.strokeWidth,
                  strokeLineCap: this.widget.strokeLineCap,
                  fill: this.widget.fill,
                ),
              ),
              CustomPaint(
                key: ValueKey("hover"),
                size: Size.square(this.widget.size),
                painter: _FlanDividerCirclePainter(
                  rate: this.widget.currentRate,
                  color: this.widget.color,
                  gradient: this.widget.gradient,
                  strokeWidth: this.widget.strokeWidth,
                  strokeLineCap: this.widget.strokeLineCap,
                  clockwise: this.widget.clockwise,
                ),
                child: SizedBox(
                  width: this.widget.size,
                  height: this.widget.size,
                  child: Center(
                    child: this.widget.child ??
                        Text(this.widget.text ?? "${this.widget.currentRate}%"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<String>('text', widget.text, defaultValue: ""));
    properties.add(DiagnosticsProperty<StrokeCap>(
        'strokeLineCap', widget.strokeLineCap,
        defaultValue: StrokeCap.round));
    properties.add(DiagnosticsProperty<double>(
        'currentRate', widget.currentRate,
        defaultValue: 0.0));
    properties.add(
        DiagnosticsProperty<double>('speed', widget.speed, defaultValue: 0.0));
    properties.add(
        DiagnosticsProperty<double>('size', widget.size, defaultValue: 100.0));
    properties.add(DiagnosticsProperty<Color>('fill', widget.fill,
        defaultValue: Colors.transparent));

    properties.add(
        DiagnosticsProperty<double>('rate', widget.rate, defaultValue: 100.0));

    properties.add(DiagnosticsProperty<Color>('layerColor', widget.layerColor,
        defaultValue: Colors.white));

    properties.add(DiagnosticsProperty<Color>('color', widget.color,
        defaultValue: Colors.blue));

    properties.add(DiagnosticsProperty<Gradient>('gradient', widget.gradient));

    properties.add(DiagnosticsProperty<double>(
        'strokeWidth', widget.strokeWidth,
        defaultValue: 4.0));

    properties.add(DiagnosticsProperty<bool>('clockwise', widget.clockwise,
        defaultValue: true));
    super.debugFillProperties(properties);
  }
}

/// 环形进度条绘制工具类
class _FlanDividerCirclePainter extends CustomPainter {
  _FlanDividerCirclePainter({
    required this.rate,
    this.color = Colors.blue,
    this.gradient,
    this.fill,
    required this.strokeWidth,
    this.clockwise = true,
    this.strokeLineCap = StrokeCap.round,
  })  : assert(rate >= 0.0 && rate <= 100.0),
        assert(strokeWidth > 0.0),
        assert(strokeLineCap is StrokeCap),
        _paint = Paint()
          ..strokeWidth = strokeWidth
          ..strokeCap = strokeLineCap
          ..style = PaintingStyle.stroke,
        super();

  /// 进度条的进度
  final double rate;

  /// 进度条的颜色
  final Color color;

  /// 进度条的颜色(渐变色)
  final Gradient? gradient;

  /// 进度条的粗细
  final double strokeWidth;

  /// 进度条的背景色
  final Color? fill;

  /// 是否是顺时针
  final bool clockwise;

  /// 进度条的边界样式
  final StrokeCap strokeLineCap;

  /// 进度条的画笔
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: Offset(
        size.width * .5,
        size.height * .5,
      ),
      radius: size.width * .5,
    );
    // draw fill
    if (this.fill != null) {
      canvas.drawArc(
        rect,
        0,
        2 * math.pi,
        false,
        _paint
          ..style = PaintingStyle.fill
          ..color = this.fill!,
      );
    }
    // draw line
    if (this.gradient != null) {
      _paint.shader = this.gradient!.createShader(rect);
    }

    _paint.color = this.color;

    canvas.drawArc(
      rect,
      math.pi * -0.5,
      math.pi * 2 * this.rate / 100 * (this.clockwise ? 1 : -1),
      false,
      _paint..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(_FlanDividerCirclePainter oldDelegate) =>
      this.rate != oldDelegate.rate ||
      this.color != oldDelegate.color ||
      this.strokeWidth != oldDelegate.strokeWidth ||
      this.fill != oldDelegate.fill ||
      this.clockwise != oldDelegate.clockwise ||
      this.strokeLineCap != oldDelegate.strokeLineCap;
}
