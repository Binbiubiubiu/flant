// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/var.dart';

/// 1px 边框
class FlanHairLine extends BorderSide {
  const FlanHairLine({
    Color color = ThemeVars.borderColor,
  }) : super(color: color, width: 0.5);
}

/// 动画曲线构造器
typedef FlanCurveBuilder = Curve Function(bool show);

/// 默认动画曲线构造器
Curve kFlanCurveBuilder(bool show) => show
    ? ThemeVars.animationTimingFunctionEnter
    : ThemeVars.animationTimingFunctionLeave;

/// 过渡动画构造器
typedef FlanTransitionBuilder = Widget Function(
    Animation<double> animation, Widget child);

/// 过渡动画`Fade` 构造器
Widget kFlanFadeTransitionBuilder(Animation<double> animation, Widget child) {
  return Opacity(
    opacity: animation.value,
    child: child,
  );
}

/// 过渡动画`Slide Up` 构造器
Widget kFlanSlideUpTransitionBuilder(
    Animation<double> animation, Widget child) {
  return FractionalTranslation(
    translation: Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).evaluate(animation),
    child: child,
  );
}

/// 过渡动画`Slide Down` 构造器
Widget kFlanSlideDownTransitionBuilder(
    Animation<double> animation, Widget child) {
  return FractionalTranslation(
    translation: Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).evaluate(animation),
    child: child,
  );
}

/// 过渡动画`Slide Left` 构造器
Widget kFlanSlideLeftTransitionBuilder(
    Animation<double> animation, Widget child) {
  return FractionalTranslation(
    translation: Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).evaluate(animation),
    child: child,
  );
}

/// 过渡动画`Slide Right` 构造器
Widget kFlanSlideRightTransitionBuilder(
    Animation<double> animation, Widget child) {
  return FractionalTranslation(
    translation: Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).evaluate(animation),
    child: child,
  );
}

/// ### 过渡动画
///
/// - `curveBuilder` 动画曲线构造器,通过`show` 判断是进场动画还是离场动画
/// - `transitionBuilder` 过渡动画构造器
/// - 通过类型`Visibility`的子组件`child`的`visible` 控制展示和隐藏
class FlanTransition extends StatefulWidget {
  const FlanTransition({
    Key? key,
    this.duration,
    this.curveBuilder = kFlanCurveBuilder,
    this.onCompleted,
    this.onDismissed,
    required this.transitionBuilder,
    required this.child,
  }) : super(key: key);

  /// 过渡动画`Fade`
  const FlanTransition.fade({
    Key? key,
    this.duration,
    this.curveBuilder = kFlanCurveBuilder,
    this.onCompleted,
    this.onDismissed,
    this.transitionBuilder = kFlanFadeTransitionBuilder,
    required this.child,
  }) : super(key: key);

  /// 过渡动画`Slide Down`
  const FlanTransition.slideDown({
    Key? key,
    this.duration,
    this.curveBuilder = kFlanCurveBuilder,
    this.onCompleted,
    this.onDismissed,
    this.transitionBuilder = kFlanSlideDownTransitionBuilder,
    required this.child,
  }) : super(key: key);

  /// 过渡动画`Slide Up`
  const FlanTransition.slideUp({
    Key? key,
    this.duration,
    this.curveBuilder = kFlanCurveBuilder,
    this.onCompleted,
    this.onDismissed,
    this.transitionBuilder = kFlanSlideUpTransitionBuilder,
    required this.child,
  }) : super(key: key);

  /// 过渡动画`Slide Left`
  const FlanTransition.slideLeft({
    Key? key,
    this.duration,
    this.curveBuilder = kFlanCurveBuilder,
    this.onCompleted,
    this.onDismissed,
    this.transitionBuilder = kFlanSlideLeftTransitionBuilder,
    required this.child,
  }) : super(key: key);

  /// 过渡动画`Slide Right`
  const FlanTransition.slideRight({
    Key? key,
    this.duration,
    this.curveBuilder = kFlanCurveBuilder,
    this.onCompleted,
    this.onDismissed,
    this.transitionBuilder = kFlanSlideRightTransitionBuilder,
    required this.child,
  }) : super(key: key);

  /// 动画时间
  final Duration? duration;

  /// 动画曲线构造器
  final FlanCurveBuilder curveBuilder;

  final VoidCallback? onCompleted;

  final VoidCallback? onDismissed;

  /// 过渡动画构造器
  final FlanTransitionBuilder transitionBuilder;

  /// 子组件
  final Visibility child;

  @override
  _FlanTransitionState createState() => _FlanTransitionState();
}

class _FlanTransitionState extends State<FlanTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Visibility content;

  bool get show {
    return widget.child.visible;
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? ThemeVars.animationDurationBase,
    )
      ..addStatusListener(_transitionStatusChange)
      ..addListener(_handleChange);
    content = widget.child;
    if (show) {
      animationController.forward();
    }

    super.initState();
  }

  void _handleChange() => setState(() {});

  @override
  void dispose() {
    animationController
      ..removeStatusListener(_transitionStatusChange)
      ..removeListener(_handleChange)
      ..dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanTransition oldWidget) {
    final bool preShow = oldWidget.child.visible;
    if (show && !preShow) {
      setState(() {
        content = widget.child;
        animationController.forward();
      });
    }

    if (!show && preShow) {
      animationController.reverse();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: widget.curveBuilder(show),
    );
    return widget.transitionBuilder(curvedAnimation, content);
  }

  void _transitionStatusChange(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      setState(() {
        content = widget.child;

        if (widget.onDismissed != null) {
          widget.onDismissed!();
        }
      });
    } else if (status == AnimationStatus.completed) {
      if (widget.onCompleted != null) {
        widget.onCompleted!();
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<FlanCurveBuilder>(
        'curveBuilder', widget.curveBuilder,
        defaultValue: kFlanCurveBuilder));
    properties.add(DiagnosticsProperty<FlanTransitionBuilder>(
        'transitionBuilder', widget.transitionBuilder));
    super.debugFillProperties(properties);
  }
}
