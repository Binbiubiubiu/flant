// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';
import '../styles/var.dart';

class FlanStep extends StatefulWidget {
  const FlanStep({
    Key? key,
    this.child,
    this.activeIconSlot,
    this.inactiveIconSlot,
    this.finishIconSlot,
  }) : super(key: key);

  // ****************** Props ******************

  // ****************** Events ******************

  // ****************** Slots ******************
  /// 内容
  final Widget? child;

  // 自定义激活状态图标
  final Widget? activeIconSlot;

  /// 自定义未激活状态图标
  final Widget? inactiveIconSlot;

  /// 自定义已完成步骤对应的底部图标，优先级高于 `inactiveIcon`
  final Widget? finishIconSlot;

  @override
  _FlanStepState createState() => _FlanStepState();
}

class _FlanStepState extends State<FlanStep> {
  @override
  Widget build(BuildContext context) {
    final bool isRow = parentProps.direction == Axis.horizontal;
    return DefaultTextStyle(
      style: const TextStyle(
        color: ThemeVars.stepTextColor,
        fontSize: ThemeVars.stepFontSize,
      ),
      child: isRow ? buildRow() : buildColumn(),
    );
  }

  Widget buildColumn() {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: isLast ? BorderSide.none : const FlanHairLine(),
            ),
          ),
          // alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
          child: DefaultTextStyle(
            textAlign: TextAlign.left,
            style: TextStyle(
              color: titleStyle ??
                  (isFinished
                      ? ThemeVars.stepFinishTextColor
                      : isActive
                          ? ThemeVars.stepActiveColor
                          : ThemeVars.stepTextColor),
            ),
            child: widget.child ?? const SizedBox.shrink(),
          ),
        ),
        Positioned(
          top: 0.0,
          left: -15.0,
          bottom: 0.0,
          child: Transform.translate(
            offset: const Offset(0.0, 16.0),
            child: Container(
              width: isLast ? 0.0 : 0.5,
              color: lineStyle ??
                  (isFinished
                      ? ThemeVars.stepFinishLineColor
                      : ThemeVars.stepLineColor),
            ),
          ),
        ),
        Positioned(
          top: 19.0,
          left: -15.0,
          child: FractionalTranslation(
            translation: const Offset(-0.5, -0.5),
            child: buildCircle(),
          ),
        ),
      ],
    );
  }

  Widget buildRow() {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        FractionalTranslation(
          translation: Offset(isFirst || isLast ? 0.0 : -0.5, 0.0),
          child: DefaultTextStyle(
            style: TextStyle(
              color: titleStyle ??
                  (isFinished
                      ? ThemeVars.stepFinishTextColor
                      : isActive
                          ? ThemeVars.stepActiveColor
                          : ThemeVars.stepTextColor),
            ),
            child: widget.child ?? const SizedBox.shrink(),
          ),
        ),
        Positioned(
          top: 30.0,
          left: 0.0,
          right: 0.0,
          child: Divider(
            height: isLast ? 0.0 : 1.0,
            color: lineStyle ??
                (isFinished
                    ? ThemeVars.stepFinishLineColor
                    : ThemeVars.stepLineColor),
          ),
        ),
        Positioned(
          top: 30.0,
          right: isLast ? -ThemeVars.paddingXs : null,
          left: isLast ? null : -ThemeVars.paddingXs,
          child: Transform.translate(
            offset: Offset(isFirst || isLast ? 0.0 : -4.0, 0.0),
            child: FractionalTranslation(
              translation: const Offset(0.0, -0.5),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: ThemeVars.paddingXs,
                ),
                child: buildCircle(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCircle() {
    if (isActive) {
      if (widget.activeIconSlot != null) {
        return widget.activeIconSlot!;
      }

      final IconData? defaultIcon = parentProps.activeIconName == null &&
              parentProps.activeIconUrl == null
          ? FlanIcons.checked
          : null;

      return FlanIcon(
        iconName: parentProps.activeIconName ?? defaultIcon,
        iconUrl: parentProps.activeIconUrl,
        color: parentProps.activeColor ?? ThemeVars.stepActiveColor,
        size: ThemeVars.stepIconSize,
      );
    }

    if (getStatus == _FlanStepStatus.finish &&
        (parentProps.finishIconName != null ||
            parentProps.finishIconUrl != null ||
            widget.finishIconSlot != null)) {
      if (widget.finishIconSlot != null) {
        return widget.finishIconSlot!;
      }

      return FlanIcon(
        iconName: parentProps.finishIconName,
        iconUrl: parentProps.finishIconUrl,
        size: ThemeVars.stepIconSize,
        color: parentProps.activeColor ?? ThemeVars.stepActiveColor,
      );
    }

    if (widget.inactiveIconSlot != null) {
      return IconTheme(
        data: IconThemeData(
          color: isFinished
              ? ThemeVars.stepFinishTextColor
              : ThemeVars.stepCircleColor,
        ),
        child: widget.inactiveIconSlot!,
      );
    }

    if (parentProps.inactiveIconName != null ||
        parentProps.inactiveIconUrl != null) {
      return FlanIcon(
        iconName: parentProps.inactiveIconName,
        iconUrl: parentProps.inactiveIconUrl,
        color: isFinished
            ? ThemeVars.stepFinishTextColor
            : ThemeVars.stepCircleColor,
        size: ThemeVars.stepIconSize,
      );
    }

    return Container(
      width: ThemeVars.stepCircleSize,
      height: ThemeVars.stepCircleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: lineStyle ??
            (isFinished
                ? ThemeVars.stepFinishLineColor
                : ThemeVars.stepCircleColor),
      ),
    );
  }

  FlanSteps get parent {
    final FlanSteps? p = context.findAncestorWidgetOfExactType<FlanSteps>();
    if (p == null) {
      throw 'Step must be a child component of Steps';
    }
    return p;
  }

  List<Widget> get children => parent.children;
  int get index => children.indexOf(widget);
  bool get isFirst => index == 0;
  bool get isLast => index == children.length - 1;
  FlanSteps get parentProps => parent;

  _FlanStepStatus get getStatus {
    if (index < parentProps.active) {
      return _FlanStepStatus.finish;
    }
    return index == parentProps.active
        ? _FlanStepStatus.process
        : _FlanStepStatus.waiting;
  }

  bool get isActive => getStatus == _FlanStepStatus.process;

  bool get isFinished => getStatus == _FlanStepStatus.finish;

  Color? get lineStyle =>
      isFinished ? parentProps.activeColor : parentProps.inactiveColor;

  Color? get titleStyle =>
      isActive ? parentProps.activeColor : parentProps.inactiveColor;

  void onClickStep() => parent.onClickSubStep(index);
}

enum _FlanStepStatus {
  finish,
  process,
  waiting,
}
