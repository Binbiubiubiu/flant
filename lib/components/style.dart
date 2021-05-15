// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/var.dart';

/// 1px 边框
class FlanHairLine extends BorderSide {
  const FlanHairLine({
    Color color = FlanThemeVars.borderColor,
  }) : super(color: color, width: 0.5);
}

/// 动画曲线构造器
typedef FlanCurveBuilder = Curve Function(bool show);

/// 默认动画曲线构造器
Curve kFlanCurveBuilder(bool show) => show
    ? FlanThemeVars.animationTimingFunctionEnter
    : FlanThemeVars.animationTimingFunctionLeave;

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
class FlanTransitionVisiable extends StatefulWidget {
  const FlanTransitionVisiable({
    Key? key,
    this.duration,
    this.reverseDuration,
    this.curve,
    this.reverseCurve,
    this.onCompleted,
    this.onDismissed,
    required this.transitionBuilder,
    this.replacement = const SizedBox.shrink(),
    this.appearAnimatable = false,
    this.visible = true,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
    required this.child,
  }) : super(key: key);

  /// 过渡动画`Fade`
  const FlanTransitionVisiable.fade({
    Key? key,
    this.duration,
    this.reverseDuration,
    this.curve,
    this.reverseCurve,
    this.onCompleted,
    this.onDismissed,
    this.transitionBuilder = kFlanFadeTransitionBuilder,
    this.replacement = const SizedBox.shrink(),
    this.appearAnimatable = false,
    this.visible = true,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
    required this.child,
  }) : super(key: key);

  /// 过渡动画`Slide Down`
  const FlanTransitionVisiable.slideDown({
    Key? key,
    this.duration,
    this.reverseDuration,
    this.curve,
    this.reverseCurve,
    this.onCompleted,
    this.onDismissed,
    this.transitionBuilder = kFlanSlideDownTransitionBuilder,
    this.replacement = const SizedBox.shrink(),
    this.appearAnimatable = false,
    this.visible = true,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
    required this.child,
  }) : super(key: key);

  /// 过渡动画`Slide Up`
  const FlanTransitionVisiable.slideUp({
    Key? key,
    this.duration,
    this.reverseDuration,
    this.curve,
    this.reverseCurve,
    this.onCompleted,
    this.onDismissed,
    this.transitionBuilder = kFlanSlideUpTransitionBuilder,
    this.replacement = const SizedBox.shrink(),
    this.appearAnimatable = false,
    this.visible = true,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
    required this.child,
  }) : super(key: key);

  /// 过渡动画`Slide Left`
  const FlanTransitionVisiable.slideLeft({
    Key? key,
    this.duration,
    this.reverseDuration,
    this.curve,
    this.reverseCurve,
    this.onCompleted,
    this.onDismissed,
    this.transitionBuilder = kFlanSlideLeftTransitionBuilder,
    this.appearAnimatable = false,
    this.replacement = const SizedBox.shrink(),
    this.visible = true,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
    required this.child,
  }) : super(key: key);

  /// 过渡动画`Slide Right`
  const FlanTransitionVisiable.slideRight({
    Key? key,
    this.duration,
    this.reverseDuration,
    this.curve,
    this.reverseCurve,
    this.onCompleted,
    this.onDismissed,
    this.transitionBuilder = kFlanSlideRightTransitionBuilder,
    this.replacement = const SizedBox.shrink(),
    this.appearAnimatable = false,
    this.visible = true,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
    required this.child,
  }) : super(key: key);

  /// 动画时间 in
  final Duration? duration;

  /// 动画时间 out
  final Duration? reverseDuration;

  /// 动画曲线 in
  final Curve? curve;

  /// 动画曲线 out
  final Curve? reverseCurve;

  final VoidCallback? onCompleted;

  final VoidCallback? onDismissed;

  /// 过渡动画构造器
  final FlanTransitionBuilder transitionBuilder;

  final bool appearAnimatable;
  final Widget replacement;
  final bool visible;
  final bool maintainState;
  final bool maintainAnimation;
  final bool maintainSize;
  final bool maintainSemantics;
  final bool maintainInteractivity;

  /// 子组件
  final Widget child;

  @override
  _FlanTransitionVisiableState createState() => _FlanTransitionVisiableState();
}

class _FlanTransitionVisiableState extends State<FlanTransitionVisiable>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late CurvedAnimation animation;

  late bool _visible;

  @override
  void initState() {
    _visible = widget.visible;
    List<double> initValue = _visible ? <double>[1.0, 0.0] : <double>[0.0, 1.0];
    if (widget.appearAnimatable) {
      initValue = initValue.reversed.toList();
    }
    animationController = AnimationController(
      vsync: this,
      value: initValue[0],
      duration: widget.duration ?? FlanThemeVars.animationDurationBase,
      reverseDuration: widget.reverseDuration,
    )..addStatusListener(_transitionStatusChange);

    animation = CurvedAnimation(
      parent: animationController,
      curve: widget.curve ?? FlanThemeVars.animationTimingFunctionEnter,
      reverseCurve:
          widget.reverseCurve ?? FlanThemeVars.animationTimingFunctionLeave,
    );

    if (widget.appearAnimatable) {
      if (_visible) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    animationController
      ..removeStatusListener(_transitionStatusChange)
      ..dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanTransitionVisiable oldWidget) {
    if (widget.duration != oldWidget.duration) {
      animationController.duration = widget.duration;
    }
    if (widget.visible) {
      setState(() {
        _visible = true;
      });
      animationController.forward();
    } else {
      animationController.reverse();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return widget.transitionBuilder(animation, child!);
      },
      child: Visibility(
        replacement: widget.replacement,
        visible: _visible,
        maintainState: widget.maintainState,
        maintainAnimation: widget.maintainAnimation,
        maintainSize: widget.maintainSize,
        maintainSemantics: widget.maintainSemantics,
        maintainInteractivity: widget.maintainInteractivity,
        child: widget.child,
      ),
    );
  }

  void _transitionStatusChange(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      if (widget.onDismissed != null) {
        widget.onDismissed!();
      }
      setState(() {
        _visible = false;
      });
    } else if (status == AnimationStatus.completed) {
      if (widget.onCompleted != null) {
        widget.onCompleted!();
      }
    }
  }
}
