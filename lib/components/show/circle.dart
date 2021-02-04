import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flant/styles/var.dart';

double formatRate(double rate) => math.min(math.max(rate, 0), 100);

const circleTextStyle = TextStyle(
  fontWeight: ThemeVars.circleTextFontWeight,
  fontSize: ThemeVars.circleTextFontSize,
  height: ThemeVars.circleTextLineHeight / ThemeVars.circleTextFontSize,
  color: ThemeVars.circleTextColor,
);

class FlanCircle extends StatefulWidget {
  FlanCircle({
    Key key,
    this.text,
    this.strokeLineCap = StrokeCap.round,
    this.currentRate = 0.0,
    this.speed = 0.0,
    this.size = 100.0,
    this.fill = Colors.transparent,
    this.rate = 100.0,
    this.layerColor = Colors.white,
    this.color = Colors.blue,
    this.strokeWidth = 4.0,
    this.clockwise = true,
    this.child,
    this.onChange,
  }) : super(key: key);

  final String text;
  final StrokeCap strokeLineCap;
  final double currentRate;
  final double speed;
  final double size;
  final Color fill;
  final double rate;
  final Color layerColor;
  final dynamic color;
  final double strokeWidth;
  final bool clockwise;
  final Widget child;
  final ValueChanged onChange;

  @override
  _FlanCircleState createState() => _FlanCircleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('text', text, defaultValue: ""));
    properties.add(DiagnosticsProperty<StrokeCap>(
      'strokeLineCap',
      strokeLineCap,
      defaultValue: StrokeCap.round,
    ));
    properties.add(DiagnosticsProperty<double>(
      'currentRate',
      currentRate,
      defaultValue: 0.0,
    ));
    properties.add(DiagnosticsProperty<double>(
      'speed',
      speed,
      defaultValue: 0.0,
    ));
    properties.add(DiagnosticsProperty<double>(
      'size',
      size,
      defaultValue: 100.0,
    ));
    properties.add(DiagnosticsProperty<Color>(
      'fill',
      fill,
      defaultValue: Colors.transparent,
    ));

    properties.add(DiagnosticsProperty<double>(
      'rate',
      rate,
      defaultValue: 100.0,
    ));

    properties.add(DiagnosticsProperty<Color>(
      'layerColor',
      layerColor,
      defaultValue: Colors.white,
    ));

    properties.add(DiagnosticsProperty<Color>(
      'color',
      color,
      defaultValue: Colors.blue,
    ));

    properties.add(DiagnosticsProperty<double>(
      'strokeWidth',
      strokeWidth,
      defaultValue: 4.0,
    ));

    properties.add(DiagnosticsProperty<bool>(
      'clockwise',
      clockwise,
      defaultValue: true,
    ));
    super.debugFillProperties(properties);
  }
}

class _FlanCircleState extends State<FlanCircle>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanCircle oldWidget) {
    if (this.widget.rate != oldWidget.rate) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        this.watchRate(this.widget.rate, oldWidget.rate);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  watchRate(double rate, double oldRate) {
    final startRate = this.widget.currentRate;
    final endRate = formatRate(rate);
    final duration = (((startRate - endRate) * 1000) / this.widget.speed).abs();

    void animate() {
      final rate =
          lerpDouble(0, endRate - startRate, _animationController.value) +
              startRate;

      this.widget.onChange(formatRate(rate).roundToDouble());

      if (endRate > startRate ? rate >= endRate : rate <= endRate) {
        this._animationController..removeListener(animate);
      }
    }

    if (this.widget.speed != null) {
      if (_animationController != null) {
        _animationController
          ..stop()
          ..reset();
      }

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
      textStyle: circleTextStyle,
      type: MaterialType.canvas,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              CustomPaint(
                key: ValueKey("layer"),
                size: Size.square(this.widget.size),
                painter: FlanDividerCirclePainter(
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
                painter: FlanDividerCirclePainter(
                  rate: this.widget.currentRate,
                  color: this.widget.color,
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
}

class FlanDividerCirclePainter extends CustomPainter {
  FlanDividerCirclePainter({
    this.rate,
    this.color,
    this.fill,
    this.strokeWidth,
    this.clockwise = true,
    this.strokeLineCap = StrokeCap.round,
  })  : _paint = Paint()
          ..strokeWidth = strokeWidth
          ..strokeCap = strokeLineCap
          ..style = PaintingStyle.stroke,
        super();

  final double rate;
  final dynamic color;
  final double strokeWidth;
  final Color fill;
  final bool clockwise;
  final StrokeCap strokeLineCap;

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
          ..color = this.fill,
      );
    }
    // draw line
    if (this.color is Gradient) {
      _paint.shader = this.color.createShader(rect);
    } else {
      _paint.color = this.color;
    }
    canvas.drawArc(
      rect,
      math.pi * -0.5,
      math.pi * 2 * this.rate / 100 * (this.clockwise ? 1 : -1),
      false,
      _paint..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
