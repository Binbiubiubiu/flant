import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;
import '../../styles/var.dart';

/// ### FlanImage 加载
/// 加载图标，用于表示加载中的过渡状态。
class FlanLoading extends StatelessWidget {
  FlanLoading({
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
    final icon = SizedBox(
      width: this.size ?? ThemeVars.loadingSpinnerSize,
      height: this.size ?? ThemeVars.loadingSpinnerSize,
      child: this.type == FlanLoadingType.spinner
          ? _FlanLoadingSpinner(
              color: this.color ?? ThemeVars.loadingSpinnerColor)
          : _FlanLoadingCirclar(
              color: this.color ?? ThemeVars.loadingSpinnerColor),
    );

    if (this.vertical) {
      return Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        // runSpacing: ThemeVars.paddingXs,
        children: [
          icon,
          this.buildText(context),
        ],
      );
    }

    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      // spacing: ThemeVars.paddingXs,
      children: [
        icon,
        this.buildText(context),
      ],
    );
  }

  Widget buildText(BuildContext context) {
    if (this.child != null) {
      return Padding(
        padding: EdgeInsets.only(
          left: this.vertical ? 0.0 : 8.0,
          top: this.vertical ? 8.0 : 0.0,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: this.textSize ?? ThemeVars.loadingTextFontSize,
            color: this.textColor ?? this.color ?? ThemeVars.loadingTextColor,
          ),
          child: this.child ?? SizedBox.shrink(),
        ),
      );
    }
    return SizedBox.shrink();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Color>("color", color,
        defaultValue: ThemeVars.loadingSpinnerColor));
    properties.add(DiagnosticsProperty<FlanLoadingType>("type", type,
        defaultValue: FlanLoadingType.circular));
    properties
        .add(DiagnosticsProperty<double>("size", size, defaultValue: 30.0));
    properties.add(
        DiagnosticsProperty<double>("textSize", textSize, defaultValue: 14.0));
    properties.add(DiagnosticsProperty<Color>("textColor", textColor,
        defaultValue: ThemeVars.loadingTextColor));
    properties.add(
        DiagnosticsProperty<bool>("vertical", vertical, defaultValue: false));
    super.debugFillProperties(properties);
  }
}

class _FlanLoadingCirclar extends StatefulWidget {
  _FlanLoadingCirclar({
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
    this.controller = AnimationController(
      value: 0.0,
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    final curveAnimation = CurvedAnimation(
      parent: this.controller,
      curve: Curves.easeInOut,
    );

    this.lengthAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 90.0), weight: .5),
      TweenSequenceItem(tween: Tween(begin: 90.0, end: 90.0), weight: .5),
    ]).animate(curveAnimation)
      ..addListener(this._handleChange);

    this.offsetAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -40.0), weight: .5),
      TweenSequenceItem(tween: Tween(begin: -40.0, end: -120.0), weight: .5),
    ]).animate(curveAnimation);

    this.controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    this.lengthAnimation.removeListener(this._handleChange);
    this.controller.dispose();

    super.dispose();
  }

  _handleChange() => this.setState(() {});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _FlanLoadingCirclarPainter(
        length: this.lengthAnimation.value,
        offset: this.offsetAnimation.value,
        color: this.widget.color ?? ThemeVars.loadingSpinnerColor,
      ),
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
    final r = 20.0;
    final num1 = this.length / r;
    final num3 = this.offset / r;

    canvas
      ..drawArc(
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
      this.length != oldDelegate.length || this.offset != oldDelegate.offset;

  @override
  bool shouldRebuildSemantics(_FlanLoadingCirclarPainter oldDelegate) => false;
}

class _FlanLoadingSpinner extends StatefulWidget {
  _FlanLoadingSpinner({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  __FlanLoadingSpinnerState createState() => __FlanLoadingSpinnerState();
}

class __FlanLoadingSpinnerState extends State<_FlanLoadingSpinner>
    with TickerProviderStateMixin {
  late Animation<int> animation;
  late AnimationController controller;

  @override
  void initState() {
    this.controller = AnimationController(
      value: 0.0,
      duration: ThemeVars.loadingSpinnerAnimationDuration,
      vsync: this,
    );

    this.animation = IntTween(begin: 0, end: 11).animate(this.controller)
      ..addListener(this._handleChange);

    this.controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    this.animation.removeListener(this._handleChange);
    this.controller.dispose();

    super.dispose();
  }

  _handleChange() => this.setState(() {});

  Matrix4 get transform =>
      Matrix4.rotationZ(this.animation.value * math.pi / 6);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: transform,
      alignment: Alignment.center,
      child: CustomPaint(
        size: Size.square(30.0),
        painter: _FlanLoadingSpinnerPainter(color: this.widget.color),
      ),
    );
  }
}

class _FlanLoadingSpinnerPainter extends CustomPainter {
  _FlanLoadingSpinnerPainter({
    this.color = ThemeVars.loadingSpinnerColor,
  })  : _paint = Paint()
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke,
        super();

  final Color color;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final canvasWidth = size.width;
    final canvasHeight = size.height;
    canvas.translate(canvasWidth / 2, canvasHeight / 2);
    for (int i = 0; i < 12; i++) {
      this._paint.color = this.color.withOpacity(1 - 0.75 / 12 * i);
      canvas
        ..rotate(math.pi / 6)
        ..drawLine(
          Offset(0, canvasHeight * .28),
          Offset(0, canvasHeight * .5),
          this._paint,
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
