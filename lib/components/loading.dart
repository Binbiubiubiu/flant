// 🎯 Dart imports:
import 'dart:math' as math;

// 🐦 Flutter imports:
import 'package:flant/styles/components/loading_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/components/loading_theme.dart';
import '../styles/theme.dart';
// import '../styles/var.dart';
import '../utils/widget.dart';

/// ### FlanImage 加载
/// 加载图标，用于表示加载中的过渡状态。
class FlanLoading extends StatelessWidget {
  const FlanLoading({
    Key? key,
    this.color,
    this.type = FlanLoadingType.circular,
    this.size,
    this.textSize,
    this.textColor,
    this.vertical = false,
    this.child,
  }) : super(key: key);

  // ****************** Props ******************
  /// 颜色
  final Color? color;

  /// 类型，可选值为 `spinner`
  final FlanLoadingType type;

  /// 加载图标大小
  final double? size;

  /// 文字大小
  final double? textSize;

  /// 文字颜色
  final Color? textColor;

  /// 是否垂直排列图标和文字内容
  final bool vertical;

  // ****************** Events ******************

  // ****************** Slots ******************
  /// 加载文案
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final FlanLoadingThemeData themeData = FlanTheme.of(context).loadingTheme;

    final Widget icon = RepaintBoundary(
      child: SizedBox(
        width: size ?? themeData.spinnerSize,
        height: size ?? themeData.spinnerSize,
        child: type == FlanLoadingType.spinner
            ? _FlanLoadingSpinner(
                color: color ?? themeData.spinnerColor,
                duration: themeData.spinnerAnimationDuration,
              )
            : _FlanLoadingCirclar(color: color ?? themeData.spinnerColor),
      ),
    );

    if (vertical) {
      return Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        // runSpacing: FlanThemeVars.paddingXs.rpx,
        children: <Widget?>[
          icon,
          buildText(themeData),
        ].noNull,
      );
    }

    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      // spacing: FlanThemeVars.paddingXs.rpx,
      children: <Widget?>[
        icon,
        buildText(themeData),
      ].noNull,
    );
  }

  Widget? buildText(FlanLoadingThemeData themeData) {
    if (child != null) {
      return Padding(
        padding: EdgeInsets.only(
          left: vertical ? 0.0 : 8.0.rpx,
          top: vertical ? 8.0.rpx : 0.0,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: textSize ?? themeData.textFontSize,
            color: textColor ?? color ?? themeData.textColor,
          ),
          child: child!,
        ),
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties.add(DiagnosticsProperty<FlanLoadingType>('type', type,
        defaultValue: FlanLoadingType.circular));
    properties.add(DiagnosticsProperty<double>('size', size));
    properties.add(DiagnosticsProperty<double>('textSize', textSize));
    properties.add(DiagnosticsProperty<Color>('textColor', textColor));
    properties.add(
        DiagnosticsProperty<bool>('vertical', vertical, defaultValue: false));
    super.debugFillProperties(properties);
  }
}

class _FlanLoadingCirclar extends StatefulWidget {
  const _FlanLoadingCirclar({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  __FlanLoadingCirclarState createState() => __FlanLoadingCirclarState();
}

class __FlanLoadingCirclarState extends State<_FlanLoadingCirclar>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> lengthAnimation;
  late Animation<double> offsetAnimation;

  @override
  void initState() {
    controller = AnimationController(
      value: 0.0,
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    final CurvedAnimation curveAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    lengthAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 90.0),
        weight: .5,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 90.0, end: 90.0),
        weight: .5,
      ),
    ]).animate(curveAnimation);

    offsetAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: -40.0),
        weight: .5,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -40.0, end: -120.0),
        weight: .5,
      ),
    ]).animate(curveAnimation);

    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FlanLoadingThemeData themeData = FlanTheme.of(context).loadingTheme;

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: _FlanLoadingCirclarPainter(
            length: lengthAnimation.value,
            offset: offsetAnimation.value,
            color: widget.color ?? themeData.spinnerColor,
          ),
        );
      },
    );
  }
}

class _FlanLoadingCirclarPainter extends CustomPainter {
  _FlanLoadingCirclarPainter({
    required this.color,
    required this.length,
    required this.offset,
  })   : _paint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.round,
        super();

  final double length;
  final double offset;
  final Color color;

  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    const double r = 20.0;
    final double num1 = length / r;
    final double num3 = offset / r;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2 - 2.0,
      ),
      -num3,
      (-num3 + num1 > 2 * math.pi) ? 2 * math.pi + num3 : num1,
      false,
      _paint,
    );
  }

  @override
  bool shouldRepaint(_FlanLoadingCirclarPainter oldDelegate) =>
      length != oldDelegate.length || offset != oldDelegate.offset;

  @override
  bool shouldRebuildSemantics(_FlanLoadingCirclarPainter oldDelegate) => false;
}

class _FlanLoadingSpinner extends StatefulWidget {
  const _FlanLoadingSpinner({
    Key? key,
    required this.color,
    required this.duration,
  }) : super(key: key);

  final Color color;
  final Duration duration;

  @override
  __FlanLoadingSpinnerState createState() => __FlanLoadingSpinnerState();
}

class __FlanLoadingSpinnerState extends State<_FlanLoadingSpinner>
    with TickerProviderStateMixin {
  late Animation<int> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      value: 0.0,
      duration: widget.duration,
      vsync: this,
    );

    animation = IntTween(begin: 0, end: 11).animate(controller);

    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final Matrix4 transform =
            Matrix4.rotationZ(animation.value * math.pi / 6);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: CustomPaint(
        size: const Size.square(30.0),
        painter: _FlanLoadingSpinnerPainter(color: widget.color),
      ),
    );
  }
}

class _FlanLoadingSpinnerPainter extends CustomPainter {
  _FlanLoadingSpinnerPainter({
    required this.color,
  })   : _paint = Paint()
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke,
        super();

  final Color color;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final double canvasWidth = size.width;
    final double canvasHeight = size.height;
    canvas.translate(canvasWidth / 2, canvasHeight / 2);
    for (int i = 0; i < 12; i++) {
      _paint.color = color.withOpacity(1 - 0.75 / 12 * i);
      canvas
        ..rotate(math.pi / 6)
        ..drawLine(
          Offset(0, canvasHeight * .28),
          Offset(0, canvasHeight * .5),
          _paint,
        );
    }
  }

  @override
  bool shouldRepaint(_FlanLoadingSpinnerPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_FlanLoadingSpinnerPainter oldDelegate) => false;
}

/// 类型
enum FlanLoadingType {
  circular,
  spinner,
}
