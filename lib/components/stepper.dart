// 🎯 Dart imports:
import 'dart:async';
import 'dart:math' as math;

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import '../styles/var.dart';
import '../utils/format/number.dart';
import 'icon.dart';

const Duration LONG_PRESS_INTERVAL = Duration(milliseconds: 200);

/// ### Stepper 步进器
/// 步进器由增加按钮、减少按钮和输入框组成，用于在一定范围内输入、调整数字。
class FlanStepper extends StatefulWidget {
  const FlanStepper({
    Key? key,
    required this.value,
    this.min = 1,
    this.max = double.infinity,
    this.defaultValue = 1,
    this.step = 1,
    this.name = '',
    this.inputWidth,
    this.buttonSize,
    this.decimalLength,
    this.theme = FlanStepperTheme.normal,
    this.placeholder,
    this.integer = false,
    this.disabled = false,
    this.disablePlus = false,
    this.disableMinus = false,
    this.disableInput = false,
    this.beforeChange,
    this.showPlus = true,
    this.showMinus = true,
    this.longPress = true,
    this.allowEmpty = false,
    required this.onChange,
    this.onOverlimit,
    this.onPlus,
    this.onMinus,
    this.onFocus,
    this.onBlur,
  }) : super(key: key);

  // ****************** Props ******************
  /// 当前输入的值
  final dynamic value;

  /// 最小值
  final num min;

  /// 最大值
  final num max;

  /// 初始值，当 `value` 为空时生效
  final num defaultValue;

  /// 步长，每次点击时改变的值
  final num step;

  /// 标识符，可以在 `change` 事件回调参数中获取
  final String name;

  /// 输入框宽度
  final double? inputWidth;

  /// 按钮大小以及输入框高度
  final double? buttonSize;

  /// 固定显示的小数位数
  final int? decimalLength;

  /// 样式风格，可选值为 `round`
  final FlanStepperTheme theme;

  /// 输入框占位提示文字
  final String? placeholder;

  /// 是否只允许输入整数
  final bool integer;

  /// 是否禁用步进器
  final bool disabled;

  /// 是否禁用增加按钮
  final bool disablePlus;

  /// 是否禁用减少按钮
  final bool disableMinus;

  /// 	是否禁用输入框
  final bool disableInput;

  /// 输入值变化前的回调函数，返回 false 可阻止输入
  final bool Function(dynamic)? beforeChange;

  /// 是否显示增加按钮
  final bool showPlus;

  /// 是否显示减少按钮
  final bool showMinus;

  /// 是否开启长按手势
  final bool longPress;

  /// 是否允许输入的值为空
  final bool allowEmpty;

  // ****************** Events ******************
  /// 当绑定值变化时触发的事件
  final Function(dynamic, FlanStepperDetails) onChange;

  /// 点击不可用的按钮时触发
  final VoidCallback? onOverlimit;

  /// 点击增加按钮时触发
  final VoidCallback? onPlus;

  /// 点击减少按钮时触发
  final VoidCallback? onMinus;

  /// 输入框聚焦时触发
  final VoidCallback? onFocus;

  /// 输入框失焦时触发
  final VoidCallback? onBlur;

  @override
  _FlanStepperState createState() => _FlanStepperState();
}

class _FlanStepperState extends State<FlanStepper> {
  late final TextEditingController textEditingController;
  late final FocusNode focusNode;
  late final ValueNotifier<dynamic> current;
  FlanStepperActionType? actionType;

  Timer? longPressTimer;

  @override
  void initState() {
    current = ValueNotifier<dynamic>(getInitialValue())
      ..addListener(() {
        widget.onChange(current.value, FlanStepperDetails(name: widget.name));
      });
    textEditingController =
        TextEditingController(text: current.value.toString())
          ..addListener(onInput);
    focusNode = FocusNode()
      ..addListener(() {
        if (focusNode.hasFocus) {
          if (widget.onFocus != null) {
            widget.onFocus!();
          }
        } else {
          final dynamic value = format(textEditingController.text);
          textEditingController.text = value.toString();
          current.value = value;
          if (widget.onBlur != null) {
            widget.onBlur!();
          }
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    current.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanStepper oldWidget) {
    if (widget.max != oldWidget.max ||
        widget.min != oldWidget.min ||
        widget.integer != oldWidget.integer ||
        widget.decimalLength != oldWidget.decimalLength) {
      check();
    }
    if (widget.value != oldWidget.value) {
      if (widget.value.toString() != current.value.toString()) {
        current.value = format(widget.value);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0,
      children: <Widget>[
        _StepperButton.minus(
          onTap: () {
            actionType = FlanStepperActionType.minus;
            onChange();
          },
          onLongPressStart: () {
            actionType = FlanStepperActionType.plus;
            onTouchStart();
          },
          onLongPressEnd: onTouchEnd,
          size: widget.buttonSize,
          disabled: minusDisabled,
          theme: widget.theme,
        ),
        _buildInput(context),
        _StepperButton.plus(
          onTap: () {
            actionType = FlanStepperActionType.plus;
            onChange();
          },
          onLongPressStart: () {
            actionType = FlanStepperActionType.plus;
            onTouchStart();
          },
          onLongPressEnd: onTouchEnd,
          size: widget.buttonSize,
          disabled: plusDisabled,
          theme: widget.theme,
        ),
      ],
    );
  }

  Widget _buildInput(BuildContext context) {
    final Color color = widget.disabled
        ? ThemeVars.stepperInputDisabledTextColor
        : ThemeVars.stepperInputTextColor;

    final Color bgColor = widget.disabled
        ? ThemeVars.stepperInputDisabledBackgroundColor
        : ThemeVars.stepperBackgroundColor;

    final bool isRound = widget.theme == FlanStepperTheme.round;

    return Container(
      width: widget.inputWidth ?? ThemeVars.stepperInputWidth,
      height: widget.buttonSize ?? ThemeVars.stepperInputHeight,
      color: isRound ? Colors.transparent : bgColor,
      alignment: Alignment.center,
      child: Baseline(
        baseline: (widget.buttonSize ?? ThemeVars.stepperInputHeight) *
            (isRound ? 0.2 : 0.3),
        baselineType: TextBaseline.alphabetic,
        child: TextField(
          focusNode: focusNode,
          controller: textEditingController,
          enabled: !widget.disabled,
          readOnly: widget.disabled,
          keyboardType:
              TextInputType.numberWithOptions(decimal: !widget.integer),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(widget.integer
                ? RegExp(r'^-?[0-9]*')
                : RegExp(r'^-?[0-9]*(\.[0-9]*){0,1}')),
          ],
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
          ),
          cursorColor: ThemeVars.textColor,
          cursorWidth: 1.0,
          cursorHeight: ThemeVars.stepperInputFontSize,
          style: TextStyle(
            fontSize: ThemeVars.stepperInputFontSize,
            color: color,
          ),
        ),
      ),
    );
  }

  dynamic format(dynamic value) {
    if (widget.allowEmpty && value is String && value.isEmpty) {
      return value;
    }

    value = formatNumber('$value');
    value = value == '' ? 0 : num.tryParse(value);
    value = value ?? widget.min;
    value = math.max(math.min(widget.max, value as num), widget.min);

    if (widget.decimalLength != null) {
      value = value.toStringAsFixed(widget.decimalLength!);
    }
    return value;
  }

  dynamic getInitialValue() {
    final dynamic defaultValue = widget.value ?? widget.defaultValue;
    final dynamic value = format(defaultValue);

    // if (value.toString() == widget.value.toString()) {
    //   widget.onChange(value, FlanStepperDetails(name: widget.name));
    // }
    return value;
  }

  bool get minusDisabled {
    final num? c = num.tryParse(current.value.toString());
    return widget.disabled ||
        widget.disableMinus ||
        c != null && c <= widget.min;
  }

  bool get plusDisabled {
    final num? c = num.tryParse(current.value.toString());
    return widget.disabled ||
        widget.disablePlus ||
        c != null && c >= widget.max;
  }

  void check() {
    final dynamic value = format(current.value);
    if (value.toString() != current.value.toString()) {
      current.value = value;
    }
  }

  void setValue(dynamic value) {
    if (widget.beforeChange != null) {
      final bool flag = widget.beforeChange!(value);
      if (flag) {
        current.value = value.toString();
      }
    } else {
      current.value = value.toString();
    }
  }

  void onChange() {
    if ((actionType == FlanStepperActionType.plus && plusDisabled) ||
        (actionType == FlanStepperActionType.minus && minusDisabled)) {
      if (widget.onOverlimit != null) {
        widget.onOverlimit!();
        return;
      }
    }

    final num diff =
        actionType == FlanStepperActionType.minus ? -widget.step : widget.step;
    final dynamic value =
        format((num.tryParse(current.value.toString()) ?? 0) + diff);

    textEditingController.text = value.toString();
    setValue(value);
    FocusScope.of(context).unfocus();
    switch (actionType) {
      case FlanStepperActionType.plus:
        if (widget.onPlus != null) {
          widget.onPlus!();
        }
        break;
      case FlanStepperActionType.minus:
        if (widget.onMinus != null) {
          widget.onMinus!();
        }
        break;
      default:
        break;
    }
  }

  void onInput() {
    final String value = textEditingController.text;

    String formatted = formatNumber(value);
    if (widget.decimalLength != null && formatted.contains('.')) {
      final List<String> pair = formatted.split('.');
      formatted = '${pair[0]}.${pair[1].substring(0, widget.decimalLength)}';
    }
    if (widget.beforeChange != null) {
      textEditingController.text = current.value.toString();
    } else if (value != formatted) {
      textEditingController.text = formatted;
    }
    setValue(formatted);
  }

  void longPressStep() {
    longPressTimer = Timer(LONG_PRESS_INTERVAL, () {
      onChange();
      longPressStep();
    });
  }

  void onTouchStart() {
    if (widget.longPress) {
      longPressTimer?.cancel();
      onChange();
      longPressStep();
    }
  }

  void onTouchEnd() {
    if (widget.longPress) {
      longPressTimer?.cancel();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<dynamic>('value', widget.value));
    properties
        .add(DiagnosticsProperty<num>('min', widget.min, defaultValue: 1.0));
    properties.add(DiagnosticsProperty<num>('max', widget.max,
        defaultValue: double.infinity));
    properties.add(DiagnosticsProperty<num>('defaultValue', widget.defaultValue,
        defaultValue: 1.0));

    properties
        .add(DiagnosticsProperty<num>('step', widget.step, defaultValue: 1.0));
    properties.add(
        DiagnosticsProperty<String>('name', widget.name, defaultValue: ''));
    properties
        .add(DiagnosticsProperty<double>('inputWidth', widget.inputWidth));
    properties
        .add(DiagnosticsProperty<double>('buttonSize', widget.buttonSize));
    properties
        .add(DiagnosticsProperty<int>('decimalLength', widget.decimalLength));
    properties.add(DiagnosticsProperty<FlanStepperTheme>('theme', widget.theme,
        defaultValue: FlanStepperTheme.normal));
    properties
        .add(DiagnosticsProperty<String>('placeholder', widget.placeholder));
    properties.add(DiagnosticsProperty<bool>('integer', widget.integer,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('disabled', widget.disabled,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'disableMinus', widget.disableMinus,
        defaultValue: false));

    properties.add(DiagnosticsProperty<bool>(
        'disableInput', widget.disableInput,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool Function(double)>(
        'beforeChange', widget.beforeChange));
    properties.add(DiagnosticsProperty<bool>('showPlus', widget.showPlus,
        defaultValue: true));

    properties.add(DiagnosticsProperty<bool>('showMinus', widget.showMinus,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('longPress', widget.longPress,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('allowEmpty', widget.allowEmpty,
        defaultValue: false));

    super.debugFillProperties(properties);
  }
}

enum FlanStepperTheme {
  normal,
  round,
}

class _StepperButton extends StatefulWidget {
  const _StepperButton({
    Key? key,
    this.disabled = false,
    this.size,
    this.theme = FlanStepperTheme.normal,
    required this.onTap,
    required this.iconName,
    required this.borderRadius,
    required this.onLongPressStart,
    required this.onLongPressEnd,
  }) : super(key: key);

  factory _StepperButton.minus({
    required VoidCallback onTap,
    required VoidCallback onLongPressStart,
    required VoidCallback onLongPressEnd,
    FlanStepperTheme theme = FlanStepperTheme.normal,
    bool disabled = false,
    double? size,
  }) {
    return _StepperButton(
      onTap: onTap,
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      disabled: disabled,
      size: size,
      theme: theme,
      iconName: FlanIcons.minus,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(ThemeVars.stepperBorderRadius),
        bottomLeft: Radius.circular(ThemeVars.stepperBorderRadius),
      ),
    );
  }

  factory _StepperButton.plus({
    required VoidCallback onTap,
    required VoidCallback onLongPressStart,
    required VoidCallback onLongPressEnd,
    FlanStepperTheme theme = FlanStepperTheme.normal,
    bool disabled = false,
    double? size,
  }) {
    return _StepperButton(
      onTap: onTap,
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      disabled: disabled,
      theme: theme,
      size: size,
      iconName: FlanIcons.plus,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(ThemeVars.stepperBorderRadius),
        bottomRight: Radius.circular(ThemeVars.stepperBorderRadius),
      ),
    );
  }

  final bool disabled;
  final FlanStepperTheme theme;
  final double? size;
  final VoidCallback onTap;
  final VoidCallback onLongPressStart;
  final VoidCallback onLongPressEnd;
  final IconData iconName;
  final BorderRadius borderRadius;

  @override
  __StepperButtonState createState() => __StepperButtonState();
}

class __StepperButtonState extends State<_StepperButton> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.disabled,
      child: MouseRegion(
        cursor: widget.disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: (TapDownDetails details) {
            setState(() => active = true);
          },
          onTapUp: (TapUpDetails details) {
            setState(() => active = false);
          },
          onTapCancel: () {
            setState(() => active = false);
          },
          onLongPressStart: (LongPressStartDetails details) {
            widget.onLongPressStart();
          },
          onLongPressEnd: (LongPressEndDetails details) {
            widget.onLongPressEnd();
          },
          onLongPressUp: () {
            widget.onLongPressEnd();
          },
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: isRound ? null : widget.borderRadius,
                shape: isRound ? BoxShape.circle : BoxShape.rectangle,
                color: bgColor,
                border: border,
              ),
              child: FlanIcon(
                iconName: widget.iconName,
                color: color,
                size: size * 0.6,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double get size => widget.size ?? ThemeVars.stepperInputHeight;

  double get opacity {
    if (isRound) {
      if (widget.disabled) {
        return 0.3;
      }

      if (active) {
        return ThemeVars.activeOpacity;
      }
    }

    return 1.0;
  }

  Border? get border {
    if (isRound) {
      return Border.all(
        width: 1.0,
        color: ThemeVars.stepperButtonRoundThemeColor,
      );
    }

    return null;
  }

  Color get bgColor {
    if (isRound) {
      return widget.iconName == FlanIcons.plus
          ? ThemeVars.stepperButtonRoundThemeColor
          : ThemeVars.white;
    }

    if (widget.disabled) {
      return ThemeVars.stepperButtonDisabledColor;
    }

    if (active) {
      return ThemeVars.stepperActiveColor;
    }
    return ThemeVars.stepperBackgroundColor;
  }

  Color get color {
    if (isRound) {
      return widget.iconName == FlanIcons.plus
          ? ThemeVars.white
          : ThemeVars.stepperButtonRoundThemeColor;
    }
    if (widget.disabled) {
      return ThemeVars.stepperButtonDisabledIconColor;
    }
    return ThemeVars.stepperButtonIconColor;
  }

  bool get isRound => widget.theme == FlanStepperTheme.round;
}

enum FlanStepperActionType {
  plus,
  minus,
}

class FlanStepperDetails {
  const FlanStepperDetails({
    required this.name,
  });

  final String name;
}
