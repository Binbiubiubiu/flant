// 🐦 Flutter imports:

import 'package:flant/styles/components/cell_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import '../styles/components/field_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import '../utils/format/number.dart' show customFormat, formatNumber;
import '../utils/widget.dart';
import 'cell.dart';
import 'form.dart';
import 'icon.dart';

int uuid = 0;

typedef FlanFieldFormatter = String Function(String value);

/// ### FlanField
/// 表单中的输入框组件。
@optionalTypeArgs
class FlanField extends StatefulWidget {
  factory FlanField({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? name,
    FlanFieldType? type,
    FlanCellSize? size,
    int? maxLength,
    String? placeholder,
    bool? border,
    bool? disabled,
    bool? readonly,
    bool? colon,
    bool? isRequired,
    bool? center,
    bool? clearable,
    IconData? clearIconName,
    String? clearIconUrl,
    FlanFieldClearTrigger? clearTrigger,
    bool? clickable,
    bool? isLink = false,
    bool? autofocus = false,
    bool? showWordLimit = false,
    bool? error = false,
    String? errorMessage,
    FlanFieldFormatter? formatter,
    FlanFieldFormatTrigger? formatTrigger,
    FlanCellArrowDirection? arrowDirection,
    TextStyle? labelStyle,
    double? labelWidth,
    TextAlign? labelAlign,
    TextAlign? inputAlign,
    TextAlign? errMessageAlign,
    BoxConstraints? autosize,
    int? rows,
    IconData? leftIconName,
    String? leftIconUrl,
    IconData? rightIconName,
    String? rightIconUrl,
    List<FlanFieldRule>? rules,
    bool? autocomplete,
    EdgeInsets? padding,
    Color? bgColor,
    ValueChanged<String>? onInput,
    VoidCallback? onFocus,
    VoidCallback? onBlur,
    VoidCallback? onClear,
    VoidCallback? onKeypress,
    VoidCallback? onClickInput,
    VoidCallback? onClickLeftIcon,
    VoidCallback? onClickRightIcon,
    ValueChanged<String>? onSubmitted,
    InlineSpan? labelSlot,
    Widget? inputSlot,
    Widget? leftIconSlot,
    Widget? rightIconSlot,
    Widget? buttonSlot,
    Widget? extraSlot,
  }) {
    return FlanField.raw(
      key: key,
      controller: controller,
      label: label ?? '',
      name: name ?? 'FlanField$uuid',
      type: type ?? FlanFieldType.text,
      size: size ?? FlanCellSize.normal,
      maxLength: maxLength,
      placeholder: placeholder ?? '',
      border: border ?? false,
      disabled: disabled ?? false,
      readonly: readonly ?? false,
      colon: colon ?? false,
      isRequired: isRequired ?? false,
      center: center ?? false,
      clearable: clearable ?? false,
      clearIconName: clearIconName,
      clearIconUrl: clearIconUrl,
      clearTrigger: clearTrigger ?? FlanFieldClearTrigger.focus,
      clickable: clickable ?? false,
      isLink: isLink ?? false,
      autofocus: autofocus ?? false,
      showWordLimit: showWordLimit ?? false,
      error: error,
      errorMessage: errorMessage,
      formatter: formatter,
      formatTrigger: formatTrigger ?? FlanFieldFormatTrigger.onChange,
      arrowDirection: arrowDirection ?? FlanCellArrowDirection.right,
      labelStyle: labelStyle,
      labelWidth: labelWidth,
      labelAlign: labelAlign,
      inputAlign: inputAlign,
      errMessageAlign: errMessageAlign,
      autosize: autosize,
      rows: rows,
      leftIconName: leftIconName,
      leftIconUrl: leftIconUrl,
      rightIconName: rightIconName,
      rightIconUrl: rightIconUrl,
      rules: rules ?? const <FlanFieldRule>[],
      autocomplete: autocomplete ?? false,
      padding: padding,
      bgColor: bgColor,
      onInput: onInput,
      onFocus: onFocus,
      onBlur: onBlur,
      onClear: onClear,
      onKeypress: onKeypress,
      onClickInput: onClickInput,
      onClickLeftIcon: onClickLeftIcon,
      onClickRightIcon: onClickRightIcon,
      onSubmitted: onSubmitted,
      labelSlot: labelSlot,
      inputSlot: inputSlot,
      leftIconSlot: leftIconSlot,
      rightIconSlot: rightIconSlot,
      buttonSlot: buttonSlot,
      extraSlot: extraSlot,
    );
  }

  const FlanField.raw({
    Key? key,
    required this.controller,
    required this.label,
    required this.name,
    required this.type,
    required this.size,
    this.maxLength,
    required this.placeholder,
    required this.border,
    required this.disabled,
    required this.readonly,
    required this.colon,
    required this.isRequired,
    required this.center,
    required this.clearable,
    this.clearIconName,
    this.clearIconUrl,
    required this.clearTrigger,
    required this.clickable,
    required this.isLink,
    required this.autofocus,
    required this.showWordLimit,
    this.error,
    this.errorMessage,
    this.formatter,
    required this.formatTrigger,
    required this.arrowDirection,
    this.labelStyle,
    this.labelWidth,
    this.labelAlign,
    this.inputAlign,
    this.errMessageAlign,
    this.autosize,
    this.rows,
    this.leftIconName,
    this.leftIconUrl,
    this.rightIconName,
    this.rightIconUrl,
    required this.rules,
    required this.autocomplete,
    this.padding,
    this.bgColor,
    this.onInput,
    this.onFocus,
    this.onBlur,
    this.onClear,
    this.onKeypress,
    this.onClickInput,
    this.onClickLeftIcon,
    this.onClickRightIcon,
    this.onSubmitted,
    this.labelSlot,
    this.inputSlot,
    this.leftIconSlot,
    this.rightIconSlot,
    this.buttonSlot,
    this.extraSlot,
  })  : assert(!showWordLimit || showWordLimit && maxLength != null),
        super(key: key);

  // ****************** Props ******************
  /// 当前输入的值
  final TextEditingController? controller;

  /// 输入框左侧文本
  final String label;

  /// 名称，提交表单的标识符
  final String name;

  /// 输入框类型
  /// - `text`
  /// - `tel`
  /// - `digit`
  /// - `number`
  /// - `textarea`
  /// - `password`
  final FlanFieldType type;

  /// 大小
  /// - `normal`
  /// - `large`
  final FlanCellSize size;

  /// 输入的最大字符数
  final int? maxLength;

  /// 输入框占位提示文字
  final String placeholder;

  /// 是否显示内边框
  final bool border;

  /// 是否禁用输入框
  final bool disabled;

  /// 是否只读
  final bool readonly;

  /// 是否在 label 后面添加冒号
  final bool colon;

  /// 是否显示表单必填星号
  final bool isRequired;

  /// 是否使内容垂直居中
  final bool center;

  /// 是否启用清除图标，点击清除图标后会清空输入框
  final bool clearable;

  /// 清除图标名称或图片链接
  final IconData? clearIconName;

  final String? clearIconUrl;

  /// 显示清除图标的时机，
  /// - `always` 表示输入框不为空时展示，
  /// - `focus` 表示输入框聚焦且不为空时展示
  final FlanFieldClearTrigger clearTrigger;

  /// 是否开启点击反馈
  final bool clickable;

  /// 是否展示右侧箭头并开启点击反馈
  final bool isLink;

  /// 是否自动聚焦
  final bool autofocus;

  /// 是否显示字数统计，需要设置`maxlength`属性
  final bool showWordLimit;

  /// 是否将输入内容标红
  final bool? error;

  /// 底部错误提示文案，为空时不展示
  final String? errorMessage;

  /// 输入内容格式化函数
  final FlanFieldFormatter? formatter;

  /// 格式化函数触发的时机，可选值为 `onBlur` `onChange`
  final FlanFieldFormatTrigger formatTrigger;

  /// 箭头方向，可选值为 `left` `up` `down` `right`
  final FlanCellArrowDirection arrowDirection;

  /// 左侧文本额外类名
  final TextStyle? labelStyle;

  /// 左侧文本宽度
  final double? labelWidth;

  /// 左侧文本对齐方式，可选值为 `left` `center` `right`
  final TextAlign? labelAlign;

  /// 输入框对齐方式，可选值为 `left` `center` `right`
  final TextAlign? inputAlign;

  /// 错误提示文案对齐方式，可选值为 `left` `center` `right`
  final TextAlign? errMessageAlign;

  /// 是否自适应内容高度，只对 textarea 有效
  final BoxConstraints? autosize;

  /// 是否自适应内容高度，只对 textarea 有效
  final int? rows;

  /// 左侧图标名称
  final IconData? leftIconName;

  /// 左侧图片链接
  final String? leftIconUrl;

  /// 右侧图片链接
  final IconData? rightIconName;

  /// 右侧图片链接
  final String? rightIconUrl;

  /// 表单校验规则，详见 Form 组件
  final List<FlanFieldRule> rules;

  /// 内边距
  final EdgeInsets? padding;

  /// 背景色
  final Color? bgColor;

  /// 自动补全
  final bool autocomplete;

  // ****************** Events ******************

  /// 输入框内容变化时触发
  final ValueChanged<String>? onInput;

  /// 输入框获得焦点时触发
  final VoidCallback? onFocus;

  /// 输入框失去焦点时触发
  final VoidCallback? onBlur;

  /// 点击清除按钮时触发
  final VoidCallback? onClear;

  /// 点击 Field 时触发
  final VoidCallback? onKeypress;

  /// 点击输入区域时触发
  final VoidCallback? onClickInput;

  /// 点击左侧图标时触发
  final VoidCallback? onClickLeftIcon;

  /// 点击右侧图标时触发
  final VoidCallback? onClickRightIcon;

  /// 键盘回车键
  final ValueChanged<String>? onSubmitted;

  // ****************** Slots ******************

  /// 自定义输入框 label 标签
  final InlineSpan? labelSlot;

  /// 自定义输入框，使用此插槽后，与输入框相关的属性和事件将失效
  final Widget? inputSlot;

  /// 自定义输入框头部图标
  final Widget? leftIconSlot;

  /// 自定义输入框尾部图标
  final Widget? rightIconSlot;

  /// 自定义输入框尾部按钮
  final Widget? buttonSlot;

  /// 自定义输入框最右侧的额外内容
  final Widget? extraSlot;

  // late final Future<FlanFieldValidateError?> Function(
  //     {List<FlanFieldRule>? rules}) validate;

  @override
  FlanFieldState createState() => FlanFieldState();

  static FlanFieldState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlanFieldScope>()?._state;
  }
}

@optionalTypeArgs
class FlanFieldState extends State<FlanField> {
  bool focuesd = false;
  bool validateFailed = false;
  String validateMessage = '';

  late FocusNode focusNode;
  late TextEditingController editingController;

  FlanForm? form;
  ValueNotifier<dynamic>? childFieldValue;

  @override
  void initState() {
    editingController = widget.controller ?? TextEditingController();
    focusNode = FocusNode()..addListener(onFouse);
    nextTick(() {
      updateValueCorrect(modelvalue, widget.formatTrigger);
      validWhereValueChange();
    });
    super.initState();
  }

  void onFouse() {
    focuesd = focusNode.hasFocus;
    if (focuesd) {
      widget.onFocus?.call();
    } else {
      if (widget.formatTrigger == FlanFieldFormatTrigger.onBlur) {
        updateValueCorrect(modelvalue, FlanFieldFormatTrigger.onBlur);
      }
      widget.onBlur?.call();

      validateWithTrigger(FlanFieldValidateTrigger.onBlur);
    }
    setState(() {});
  }

  @override
  void deactivate() {
    FlanForm.of(context)?.unregister(widget.name);
    super.deactivate();
  }

  @override
  void dispose() {
    // 如果是自带controller 需要销毁
    if (widget.controller == null) {
      editingController.dispose();
    }
    focusNode.removeListener(onFouse);

    super.dispose();
  }

  void validWhereValueChange() {
    validateWithTrigger(FlanFieldValidateTrigger.onChange);
  }

  Future<FlanFieldValidateError?> validate({List<FlanFieldRule>? rules}) async {
    rules ??= widget.rules;
    resetValidation();
    if (rules.isNotEmpty) {
      await _runRules(rules);
      if (validateFailed) {
        return FlanFieldValidateError(validateMessage, name: widget.name);
      }
    }
  }

  void focus() => focusNode.requestFocus();
  void blur() => focusNode.unfocus();

  @override
  Widget build(BuildContext context) {
    final FlanFieldThemeData themeData = FlanTheme.of(context).fieldTheme;

    final FlanFormState? formState = FlanForm.of(context);
    form = formState?.widget;
    final Widget? label = _buildLabel(themeData);
    final Widget? leftIcon = _buildLeftIcon(themeData);

    formState?.register(widget.name, this);

    return FlanCell(
      iconSlot: leftIcon,
      titleSlot: label,
      titleWidth: widget.labelWidth ?? themeData.labelWidth,
      extraSlots: widget.extraSlot,
      size: widget.size,
      iconName: widget.leftIconName,
      iconUrl: widget.leftIconUrl,
      center: widget.center,
      border: widget.border,
      isLink: widget.isLink,
      isRequired: widget.isRequired,
      clickable: widget.clickable,
      padding: widget.padding,
      bgColor: widget.bgColor,
      arrowDirection: widget.arrowDirection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: _buildInput(context, themeData)),
              _buildClearIcon(themeData),
              _buildRightIcon(themeData),
              widget.buttonSlot ??
                  Padding(
                    padding: EdgeInsets.only(
                      left: FlanThemeVars.paddingXs.rpx,
                    ),
                    child: widget.buttonSlot,
                  )
            ],
          ),
          _buildWordLimt(themeData),
          _buildMessage(themeData),
        ],
      ),
    );
  }

  Future<void> _runRules(List<FlanFieldRule> rules) async {
    for (final FlanFieldRule rule in rules) {
      if (validateFailed) {
        continue;
      }

      dynamic value = formValue;
      if (rule.formatter != null) {
        value = rule.formatter!(value, rule);
      }

      if (!runSyncRule(value, rule)) {
        setState(() {
          validateFailed = true;
          validateMessage = getRuleMessage(value, rule);
        });
        return;
      }

      if (rule.validator != null) {
        return runRuleValidator(value, rule).then((dynamic result) {
          if (result != null && result is String) {
            setState(() {
              validateFailed = true;
              validateMessage = result;
            });
          } else if (result == false) {
            validateFailed = true;
            validateMessage = getRuleMessage(value, rule);
          }
          setState(() {});
        });
      }
    }
  }

  void resetValidation() {
    if (validateFailed) {
      setState(() {
        validateFailed = false;
        validateMessage = '';
      });
    }
  }

  Widget _buildClearIcon(FlanFieldThemeData themeData) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: editingController,
      builder: (BuildContext context, TextEditingValue value, Widget? child) {
        return Visibility(
          visible: showClear,
          child: child!,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: FlanThemeVars.paddingXs.rpx),
        child: FlanIcon(
          iconName: widget.clearIconName ??
              (widget.clearIconUrl == null ? FlanIcons.clear : null),
          iconUrl: widget.clearIconUrl,
          color: themeData.clearIconColor,
          size: themeData.clearIconSize,
          onClick: () {
            editingController.clear();

            widget.onClear?.call();
          },
        ),
      ),
    );
  }

  void validateWithTrigger(FlanFieldValidateTrigger trigger) {
    if (form != null && widget.rules.isNotEmpty) {
      final bool defaultTrigger = form!.validateTrigger == trigger;
      final List<FlanFieldRule> rules =
          widget.rules.where((FlanFieldRule rule) {
        if (rule.trigger != null) {
          return rule.trigger == trigger;
        }
        return defaultTrigger;
      }).toList();
      validate(rules: rules);
    }
    // else {
    //   resetValidation();
    // }
  }

  String limitValueLength(String value) {
    if (widget.maxLength != null && widget.maxLength! < value.length) {
      if (modelvalue.isNotEmpty && modelvalue.length == widget.maxLength) {
        return modelvalue;
      }
      return value.substring(0, widget.maxLength);
    }
    return value;
  }

  void updateValueCorrect(String value, [FlanFieldFormatTrigger? trigger]) {
    trigger ??= FlanFieldFormatTrigger.onChange;
    value = limitValueLength(value);
    if (widget.type == FlanFieldType.number ||
        widget.type == FlanFieldType.digit) {
      final bool isNumber = widget.type == FlanFieldType.number;
      value = formatNumber(value, allowDot: isNumber, allowMinus: isNumber);
    }

    if (widget.formatter != null && trigger == widget.formatTrigger) {
      value = widget.formatter!(value);
    }

    editingController.text = value;
  }

  void updateValue(String value, [FlanFieldFormatTrigger? trigger]) {
    trigger ??= FlanFieldFormatTrigger.onChange;
    // value = limitValueLength(value);
    // if (widget.type == FlanFieldType.number ||
    //     widget.type == FlanFieldType.digit) {
    //   final bool isNumber = widget.type == FlanFieldType.number;
    //   value = formatNumber(value, allowDot: isNumber, allowMinus: isNumber);
    // }

    // if (widget.formatter != null && trigger == widget.formatTrigger) {
    //   value = widget.formatter!(value);
    // }

    editingController.text = value;
  }

  bool get disabled => widget.disabled || form?.disabled == true;

  String get modelvalue => editingController.text;
  bool get showClear {
    final bool readonly = widget.readonly || form?.readonly == true;
    if (widget.clearable && !readonly) {
      final bool hasValue = modelvalue.isNotEmpty;
      final bool trigger =
          widget.clearTrigger == FlanFieldClearTrigger.always ||
              (widget.clearTrigger == FlanFieldClearTrigger.focus && focuesd);

      return hasValue && trigger;
    }
    return false;
  }

  List<TextInputFormatter> get formatters {
    final List<TextInputFormatter> result = <TextInputFormatter>[];
    if (widget.type == FlanFieldType.number) {
      result.add(TextInputFormatter.withFunction(customFormat(formatNumber)));
    }

    if (widget.type == FlanFieldType.digit) {
      result.add(FilteringTextInputFormatter.digitsOnly);
    }

    if (widget.formatter != null &&
        widget.formatTrigger == FlanFieldFormatTrigger.onChange) {
      result.add(
          TextInputFormatter.withFunction(customFormat(widget.formatter!)));
    }

    return result;
  }

  dynamic get formValue {
    if (childFieldValue?.value != null && widget.inputSlot != null) {
      return childFieldValue?.value;
    }
    return editingController.text;
  }

  bool get showError {
    if (widget.error != null) {
      return widget.error!;
    }

    return form != null && form!.showError && validateFailed;
  }

  void onClickInput() {
    widget.onClickInput?.call();
  }

  Widget _buildInput(BuildContext context, FlanFieldThemeData themeData) {
    final FlanCellThemeData cellThemeData = FlanTheme.of(context).cellTheme;
    final TextAlign inputAlign =
        widget.inputAlign ?? form?.inputAlign ?? TextAlign.left;
    if (widget.inputSlot != null) {
      return GestureDetector(
        onTap: onClickInput,
        child: Container(
          constraints: BoxConstraints(
            minHeight: cellThemeData.lineHeight,
          ),
          alignment: <TextAlign, Alignment>{
            TextAlign.left: Alignment.centerLeft,
            TextAlign.center: Alignment.center,
            TextAlign.right: Alignment.centerRight,
          }[inputAlign],
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: showError
                  ? themeData.inputErrorTextColor
                  : themeData.inputTextColor,
            ),
            child: FlanFieldScope(
              fieldState: this,
              child: widget.inputSlot!,
            ),
          ),
        ),
      );
    }

    return Container(
      constraints: widget.autosize ??
          (widget.type == FlanFieldType.textarea
              ? BoxConstraints(
                  minHeight: themeData.textAreaMinHeight,
                )
              : null),
      child: TextField(
        textAlign: inputAlign,
        onTap: onClickInput,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: widget.placeholder,
          hintStyle: TextStyle(
            color: showError
                ? themeData.inputErrorTextColor
                : themeData.placeholderTextColor,
          ),
          counterText: '',
          isDense: true,
        ),
        textInputAction: <FlanFieldType, TextInputAction>{
          FlanFieldType.search: TextInputAction.search,
        }[widget.type],
        scrollPadding: EdgeInsets.zero,
        mouseCursor: disabled ? SystemMouseCursors.forbidden : null,
        enabled: !disabled,
        onSubmitted: (String value) {
          widget.onSubmitted?.call(value);
        },
        autofocus: widget.autofocus,
        autocorrect: widget.autocomplete,
        onChanged: (String value) {
          validWhereValueChange();
          widget.onKeypress?.call();

          widget.onInput?.call(value);
        },
        readOnly: widget.readonly,
        controller: editingController,
        focusNode: focusNode,
        keyboardType: <FlanFieldType, TextInputType>{
          FlanFieldType.digit: TextInputType.number,
          FlanFieldType.number: TextInputType.number,
          FlanFieldType.tel: TextInputType.phone,
        }[widget.type],
        cursorWidth: 1.0,
        obscureText: widget.type == FlanFieldType.password,
        obscuringCharacter: '●',
        inputFormatters: formatters,
        style: TextStyle(
          color:
              disabled ? themeData.disabledTextColor : themeData.inputTextColor,
          fontSize: cellThemeData.fontSize,
        ),
        cursorColor: showError
            ? themeData.inputErrorTextColor
            : themeData.inputTextColor,
        textAlignVertical: TextAlignVertical.center,
        maxLength: widget.maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        maxLines: widget.type == FlanFieldType.textarea ? null : 1,
        minLines: widget.rows,
      ),
    );
  }

  Widget _buildLeftIcon(FlanFieldThemeData themeData) {
    if (widget.leftIconName != null ||
        widget.leftIconUrl != null ||
        widget.leftIconSlot != null) {
      return GestureDetector(
        onTap: () {
          widget.onClickLeftIcon?.call();
        },
        child: Padding(
          padding: EdgeInsets.only(right: FlanThemeVars.paddingBase.rpx),
          child: IconTheme.merge(
            data: IconThemeData(
              size: themeData.iconSize,
            ),
            child: widget.leftIconSlot ??
                FlanIcon(
                  iconName: widget.leftIconName,
                  iconUrl: widget.leftIconUrl,
                ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildRightIcon(FlanFieldThemeData themeData) {
    if (widget.rightIconName != null ||
        widget.rightIconUrl != null ||
        widget.rightIconSlot != null) {
      return GestureDetector(
        onTap: () {
          widget.onClickRightIcon?.call();
        },
        child: IconTheme.merge(
          data: IconThemeData(
            size: themeData.iconSize,
            color: themeData.rightIconColor,
          ),
          child: widget.rightIconSlot ??
              FlanIcon(
                iconName: widget.rightIconName,
                iconUrl: widget.rightIconUrl,
              ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildWordLimt(FlanFieldThemeData themeData) {
    if (widget.showWordLimit && widget.maxLength != null) {
      final TextStyle textStyle = TextStyle(
        color: themeData.wordLimitColor,
        fontSize: themeData.wordLimitFontSize,
      );
      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: FlanThemeVars.paddingBase.rpx),
        child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: editingController,
          builder:
              (BuildContext context, TextEditingValue value, Widget? child) {
            final int count = value.text.runes.length;
            return Text(
              '$count/${widget.maxLength}',
              style: textStyle,
              textAlign: TextAlign.right,
            );
          },
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildMessage(FlanFieldThemeData themeData) {
    if (form?.showErrorMessage == false) {
      return const SizedBox.shrink();
    }

    final String message = widget.errorMessage ?? validateMessage;
    if (message.isNotEmpty) {
      final TextAlign errorMessageAlign =
          widget.errMessageAlign ?? form?.errMessageAlign ?? TextAlign.left;

      return SizedBox(
        width: double.infinity,
        child: Text(
          message,
          style: TextStyle(
            color: themeData.errorMessageColor,
            fontSize: themeData.errorMessageTextColor,
          ),
          textAlign: errorMessageAlign,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget? _buildLabel(FlanFieldThemeData themeData) {
    if (widget.label.isNotEmpty || widget.labelSlot != null) {
      final String colon = widget.colon || (form?.colon == true) ? ':' : '';

      final TextAlign labelAlign =
          widget.labelAlign ?? form?.labelAlign ?? TextAlign.left;

      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          right: themeData.labelMarginRight,
        ),
        child: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              widget.labelSlot ?? TextSpan(text: widget.label),
              TextSpan(text: colon),
            ],
          ),
          textAlign: labelAlign,
          style: TextStyle(
            color:
                disabled ? themeData.disabledTextColor : themeData.labelColor,
          ),
        ),
      );
    }
  }

  void scrollToVisiable({
    double alignment = 0.0,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
  }) {
    Scrollable.ensureVisible(
      context,
      alignment: alignment,
      duration: duration,
      curve: curve,
      alignmentPolicy: alignmentPolicy,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<TextEditingController>(
        'controller', widget.controller));
    properties.add(DiagnosticsProperty<String>('name', widget.name));
    properties.add(DiagnosticsProperty<FlanFieldType>('type', widget.type,
        defaultValue: FlanFieldType.text));
    properties.add(DiagnosticsProperty<FlanCellSize>('size', widget.size,
        defaultValue: FlanCellSize.normal));
    properties.add(DiagnosticsProperty<int>('maxLength', widget.maxLength));
    properties.add(DiagnosticsProperty<String>(
        'placeholder', widget.placeholder,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<bool>('border', widget.border,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('disabled', widget.disabled,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('readonly', widget.readonly,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('colon', widget.colon, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('isRequired', widget.isRequired,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('center', widget.center,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('clearable', widget.clearable,
        defaultValue: false));
    properties.add(DiagnosticsProperty<IconData>(
      'clearIconName',
      widget.clearIconName,
    ));
    properties.add(DiagnosticsProperty<String>(
      'clearIconUrl',
      widget.clearIconUrl,
    ));
    properties.add(DiagnosticsProperty<FlanFieldClearTrigger>(
        'clearTrigger', widget.clearTrigger,
        defaultValue: FlanFieldClearTrigger.focus));
    properties.add(DiagnosticsProperty<bool>('clickable', widget.clickable,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('isLink', widget.isLink,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('autofocus', widget.autofocus,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'showWordLimit', widget.showWordLimit,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('error', widget.error, defaultValue: false));
    properties.add(DiagnosticsProperty<String>(
        'errorMessage', widget.errorMessage,
        defaultValue: ''));
    properties.add(
        DiagnosticsProperty<FlanFieldFormatter>('formatter', widget.formatter));
    properties.add(DiagnosticsProperty<FlanFieldFormatTrigger>(
        'formatTrigger', widget.formatTrigger,
        defaultValue: FlanFieldFormatTrigger.onChange));
    properties.add(DiagnosticsProperty<FlanCellArrowDirection>(
        'arrowDirection', widget.arrowDirection,
        defaultValue: FlanCellArrowDirection.right));
    properties
        .add(DiagnosticsProperty<TextStyle>('labelStyle', widget.labelStyle));
    properties.add(DiagnosticsProperty<double>('labelWidth', widget.labelWidth,
        defaultValue: 0.0));
    properties.add(DiagnosticsProperty<TextAlign>(
        'labelAlign', widget.labelAlign,
        defaultValue: TextAlign.left));
    properties.add(DiagnosticsProperty<TextAlign>(
        'inputAlign', widget.inputAlign,
        defaultValue: TextAlign.left));

    properties.add(DiagnosticsProperty<TextAlign>(
        'errMessageAlign', widget.errMessageAlign,
        defaultValue: TextAlign.left));

    properties
        .add(DiagnosticsProperty<BoxConstraints>('autosize', widget.autosize));
    properties.add(
        DiagnosticsProperty<IconData>('leftIconName', widget.leftIconName));
    properties
        .add(DiagnosticsProperty<String>('leftIconUrl', widget.leftIconUrl));

    properties.add(
        DiagnosticsProperty<IconData>('rightIconName', widget.rightIconName));
    properties
        .add(DiagnosticsProperty<String>('rightIconUrl', widget.rightIconUrl));
    properties
        .add(DiagnosticsProperty<List<FlanFieldRule>>('rules', widget.rules));
    properties.add(DiagnosticsProperty<bool>(
        'autocomplete', widget.autocomplete,
        defaultValue: false));
    super.debugFillProperties(properties);
  }
}

@optionalTypeArgs
class FlanFieldScope extends InheritedWidget {
  const FlanFieldScope({
    Key? key,
    required FlanFieldState fieldState,
    required Widget child,
  })  : _state = fieldState,
        super(key: key, child: child);

  final FlanFieldState _state;

  FlanField get field => _state.widget;

  @override
  bool updateShouldNotify(FlanFieldScope oldWidget) {
    return false;
  }
}

typedef FlanFieldValidator<T extends dynamic, R extends dynamic> = R Function(
    T value, FlanFieldRule rule);

class FlanFieldRule {
  FlanFieldRule({
    this.pattern,
    this.trigger,
    this.message,
    this.messageBuilder,
    this.required = false,
    this.validator,
    this.formatter,
  });

  final RegExp? pattern;
  final FlanFieldValidateTrigger? trigger;
  final String? message;
  final String Function(dynamic, FlanFieldRule)? messageBuilder;
  final bool required;
  final FlanFieldValidator? validator;
  final String Function(dynamic, FlanFieldRule)? formatter;
}

class FlanFieldValidateError {
  FlanFieldValidateError(
    this.message, {
    this.name,
  });

  final String? name;
  final String message;
}

enum FlanFieldType {
  tel,
  text,
  digit,
  number,
  search,
  password,
  textarea,
}

enum FlanFieldClearTrigger {
  always,
  focus,
}

enum FlanFieldFormatTrigger {
  onBlur,
  onChange,
}

enum FlanFieldValidateTrigger {
  onBlur,
  onChange,
  onSubmit,
}

bool isEmptyValue(dynamic value) {
  if (value is List) {
    return value.isEmpty;
  }

  if (value is String) {
    return value.isEmpty;
  }

  if (value == 0) {
    return false;
  }
  return true;
}

bool runSyncRule(dynamic value, FlanFieldRule rule) {
  if (rule.required && isEmptyValue(value)) {
    return false;
  }
  if (rule.pattern != null && !rule.pattern!.hasMatch(value.toString())) {
    return false;
  }
  return true;
}

String getRuleMessage(dynamic value, FlanFieldRule rule) {
  if (rule.messageBuilder != null) {
    return rule.messageBuilder!(value, rule);
  }
  return rule.message ?? '';
}

Future<dynamic> runRuleValidator(dynamic value, FlanFieldRule rule) async {
  final dynamic returnVal = rule.validator!(value, rule);
  return returnVal;
}
