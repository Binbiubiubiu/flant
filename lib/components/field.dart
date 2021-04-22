// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:flant/components/cell.dart';
import 'package:flant/components/form.dart';
import 'package:flant/components/icon.dart';
import 'package:flant/styles/icons.dart';
import 'package:flant/styles/var.dart';
import '../styles/var.dart';
import '../utils/format/number.dart';
import 'cell.dart';
import 'form.dart';
import 'icon.dart';

int uuid = 0;

/// ### FlanField
/// 表单中的输入框组件。
class FlanField<T extends dynamic> extends StatefulWidget {
  FlanField({
    Key? key,
    required this.value,
    this.label = '',
    String? name,
    this.type = FlanFieldType.text,
    this.size = FlanCellSize.normal,
    this.maxLength,
    this.placeholder = '',
    this.border = false,
    this.disabled = false,
    this.readonly = false,
    this.colon = false,
    this.isRequired = false,
    this.center = false,
    this.clearable = false,
    this.clearTrigger = FlanFieldClearTrigger.focus,
    this.clickable = false,
    this.isLink = false,
    this.autofocus = false,
    this.showWordLimit = false,
    this.error = false,
    this.errorMessage,
    this.formatter,
    this.formatTrigger = FlanFieldFormatTrigger.onChange,
    this.arrowDirection = FlanCellArrowDirection.right,
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
    this.rules = const <FlanFieldRule>[],
    this.padding,
    this.bgColor,
    required this.onInput,
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
        name = name ?? 'FlanField$uuid',
        super(key: key);

  // ****************** Props ******************
  /// 当前输入的值
  final T value;

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
  final bool error;

  /// 底部错误提示文案，为空时不展示
  final String? errorMessage;

  /// 输入内容格式化函数
  final String Function(String)? formatter;

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

  // ****************** Events ******************

  /// 输入框内容变化时触发
  final ValueChanged<T> onInput;

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
  final ValueChanged<T>? onSubmitted;

  // ****************** Slots ******************

  /// 自定义输入框 label 标签
  final Widget? labelSlot;

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

  FlanFieldState<T>? _state;

  void resetValidation() {
    _state?.resetValidation();
  }

  Future<FlanFieldValidateError?> validate() async {
    return _state?.validate();
  }

  void scrollToVisiable() {
    _state?._scrollToVisiable();
  }

  @override
  FlanFieldState<T> createState() => _state = FlanFieldState<T>();
}

class FlanFieldState<T extends dynamic> extends State<FlanField<T>> {
  bool focuesd = false;
  bool validateFailed = false;
  String validateMessage = '';

  late FocusNode focusNode;
  late TextEditingController editingController;

  late ValueNotifier<dynamic> childFieldValue;

  @override
  void initState() {
    childFieldValue = ValueNotifier<dynamic>(widget.value);
    // widget.validate = validate;
    editingController = TextEditingController(text: widget.value.toString())
      ..addListener(onInput);
    focusNode = FocusNode()..addListener(onFouse);
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
      updateValue(modelvalue, trigger: widget.formatTrigger);
      watchValue();
    });
  }

  void onInput() => updateValue(editingController.text);
  void onFouse() {
    focuesd = focusNode.hasFocus;
    if (focuesd) {
      if (widget.onFocus != null) {
        widget.onFocus!();
      }
    } else {
      if (widget.formatTrigger == FlanFieldFormatTrigger.onBlur) {
        updateValue(formatNumber(modelvalue));
      }
      if (widget.onBlur != null) {
        widget.onBlur!();
      }
      validateWithTrigger(FlanFieldValidateTrigger.onBlur);
    }
    setState(() {});
  }

  @override
  void dispose() {
    editingController
      ..removeListener(onInput)
      ..dispose();
    focusNode.removeListener(onFouse);
    super.dispose();
  }

  void watchValue() {
    updateValue(modelvalue);
    resetValidation();
    validateWithTrigger(FlanFieldValidateTrigger.onChange);
  }

  @override
  void didUpdateWidget(covariant FlanField<T> oldWidget) {
    if (widget.value != oldWidget.value) {
      watchValue();
    }
    super.didUpdateWidget(oldWidget);
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
    final Widget label = _buildLabel();
    final Widget leftIcon = _buildLeftIcon();

    return FlanCell(
      iconSlot: leftIcon,
      titleSlot: label,
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
      // titleStyle: TextStyle(),
      // valueStyle: ,
      // titleStyle: ,
      arrowDirection: widget.arrowDirection,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: _buildInput()),
              if (showClear)
                Padding(
                  padding: const EdgeInsets.only(left: ThemeVars.paddingXs),
                  child: FlanIcon.name(
                    FlanIcons.clear,
                    color: ThemeVars.fieldClearIconColor,
                    size: ThemeVars.fieldClearIconSize,
                    onClick: () {
                      widget.onInput('' as T);
                      if (widget.onClear != null) {
                        widget.onClear!();
                      }
                    },
                  ),
                )
              else
                const SizedBox.shrink(),
              _buildRightIcon(),
              widget.buttonSlot ??
                  Padding(
                    padding: const EdgeInsets.only(left: ThemeVars.paddingXs),
                    child: widget.buttonSlot,
                  )
            ],
          ),
          _buildWordLimt(),
          _buildMessage(),
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

  void updateValue(String value, {FlanFieldFormatTrigger? trigger}) {
    trigger ??= FlanFieldFormatTrigger.onChange;
    value = limitValueLength(value);
    // if (widget.type == FlanFieldType.number ||
    //     widget.type == FlanFieldType.digit) {
    //   final bool isNumber = widget.type == FlanFieldType.number;
    //   value = formatNumber(value, allowDot: isNumber, allowMinus: isNumber);
    // }

    // if (widget.formatter != null && trigger == widget.formatTrigger) {
    //   value = widget.formatter!(value);
    // }

    if (editingController.text != value) {
      editingController.text = value;
    }

    if (value != widget.value) {
      widget.onInput(value as T);
    }
  }

  bool get disabled => widget.disabled || (form != null && form!.disabled);

  FlanForm? get form => context.findAncestorWidgetOfExactType<FlanForm>();
  String get modelvalue => "${widget.value ?? ''}";
  bool get showClear {
    final bool readonly = widget.readonly || (form != null && form!.readonly);
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

  T get formValue {
    if (childFieldValue.value != null && widget.inputSlot != null) {
      return childFieldValue.value as T;
    }
    return widget.value;
  }

  bool get showError {
    return widget.error || (form != null && form!.showError && validateFailed);
  }

  void onKeypress() {
    if (widget.onKeypress != null) {
      widget.onKeypress!();
    }
  }

  void onClickInput() {
    if (widget.onClickInput != null) {
      widget.onClickInput!();
    }
  }

  Widget _buildInput() {
    final TextAlign inputAlign =
        widget.inputAlign ?? form?.inputAlign ?? TextAlign.left;
    if (widget.inputSlot != null) {
      return GestureDetector(
        onTap: onClickInput,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: ThemeVars.cellLineHeight,
          ),
          alignment: <TextAlign, Alignment>{
            TextAlign.left: Alignment.centerLeft,
            TextAlign.center: Alignment.center,
            TextAlign.right: Alignment.centerRight,
          }[inputAlign],
          child: DefaultTextStyle(
            style: TextStyle(
              color: showError
                  ? ThemeVars.fieldInputErrorTextColor
                  : ThemeVars.fieldInputTextColor,
            ),
            child: widget.inputSlot!,
          ),
        ),
      );
    }

    return Container(
      constraints: widget.autosize ??
          (widget.type == FlanFieldType.textarea
              ? const BoxConstraints(
                  minHeight: ThemeVars.fieldTextAreaMinHeight)
              : widget.autosize),
      child: TextField(
        textAlign: inputAlign,
        onTap: onClickInput,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: widget.placeholder,
          hintStyle:
              const TextStyle(color: ThemeVars.fieldPlaceholderTextColor),

          counterText: '',
          // errorStyle: TextStyle(),
          isDense: true,
        ),
        textInputAction: <FlanFieldType, TextInputAction>{
          FlanFieldType.search: TextInputAction.search,
        }[widget.type],
        scrollPadding: EdgeInsets.zero,
        mouseCursor: disabled ? SystemMouseCursors.forbidden : null,
        enabled: !disabled,
        onSubmitted: (String value) {
          if (widget.onSubmitted != null) {
            widget.onSubmitted!(value as T);
          }
        },
        readOnly: widget.readonly,
        controller: editingController,
        focusNode: focusNode,
        keyboardType: <FlanFieldType, TextInputType>{
          FlanFieldType.digit: TextInputType.number,
          FlanFieldType.number: TextInputType.number,
        }[widget.type],
        cursorWidth: 1.0,
        obscureText: widget.type == FlanFieldType.password,
        obscuringCharacter: '●',
        inputFormatters: formatters,
        style: TextStyle(
          color: disabled
              ? ThemeVars.fieldDisabledTextColor
              : ThemeVars.fieldInputTextColor,
          fontSize: ThemeVars.cellFontSize,
        ),
        cursorColor: showError
            ? ThemeVars.fieldInputErrorTextColor
            : ThemeVars.fieldInputTextColor,
        maxLength: widget.maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        maxLines: widget.type == FlanFieldType.textarea ? null : 1,
        minLines: widget.rows,
      ),
    );
  }

  Widget _buildLeftIcon() {
    if (widget.leftIconName != null ||
        widget.leftIconUrl != null ||
        widget.leftIconSlot != null) {
      return GestureDetector(
        onTap: () {
          if (widget.onClickLeftIcon != null) {
            widget.onClickLeftIcon!();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(right: ThemeVars.paddingBase),
          child: IconTheme.merge(
            data: const IconThemeData(
              size: ThemeVars.fieldIconSize,
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

  Widget _buildRightIcon() {
    if (widget.rightIconName != null ||
        widget.rightIconUrl != null ||
        widget.rightIconSlot != null) {
      return GestureDetector(
        onTap: () {
          if (widget.onClickRightIcon != null) {
            widget.onClickRightIcon!();
          }
        },
        child: IconTheme.merge(
          data: const IconThemeData(
            size: ThemeVars.fieldIconSize,
            color: ThemeVars.fieldRightIconColor,
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

  Widget _buildWordLimt() {
    if (widget.showWordLimit && widget.maxLength != null) {
      final int count = modelvalue.runes.length;
      return Container(
        padding: const EdgeInsets.only(top: ThemeVars.paddingBase),
        alignment: Alignment.centerRight,
        child: Text(
          '$count/${widget.maxLength}',
          style: const TextStyle(
            color: ThemeVars.fieldWordLimitColor,
            fontSize: ThemeVars.fieldWordLimitFontSize,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildMessage() {
    if (form != null && form!.showErrorMessage == false) {
      return const SizedBox.shrink();
    }

    final String message = widget.errorMessage ?? validateMessage;
    if (message.isNotEmpty) {
      final TextAlign errorMessageAlign =
          widget.errMessageAlign ?? form?.errMessageAlign ?? TextAlign.left;

      return Container(
        alignment: <TextAlign, Alignment>{
          TextAlign.left: Alignment.centerLeft,
          TextAlign.center: Alignment.center,
          TextAlign.right: Alignment.centerRight,
        }[errorMessageAlign],
        child: Text(
          message,
          style: const TextStyle(
            color: ThemeVars.fieldErrorMessageColor,
            fontSize: ThemeVars.fieldErrorMessageTextColor,
          ),
          textAlign: errorMessageAlign,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildLabel() {
    final String colon =
        widget.colon || (form != null && form!.colon) ? ':' : '';
    return Builder(builder: (BuildContext context) {
      final TextStyle textStyle = DefaultTextStyle.of(context).style;
      final double labelWidth = ThemeVars.fieldLabelWidth *
          (textStyle.fontSize ?? ThemeVars.cellLabelFontSize);
      const EdgeInsets labelMargin = EdgeInsets.only(
        right: ThemeVars.fieldLabelMarginRight,
      );

      final TextAlign labelAlign =
          widget.labelAlign ?? form?.labelAlign ?? TextAlign.left;

      Widget? labelContent;

      if (widget.labelSlot != null) {
        labelContent = Wrap(
          children: <Widget>[
            widget.labelSlot!,
            Text(colon),
          ],
        );
      }
      if (widget.label.isNotEmpty) {
        labelContent = Text('${widget.label}$colon');
      }

      if (labelContent != null) {
        return DefaultTextStyle(
          style: TextStyle(
            color: disabled
                ? ThemeVars.fieldDisabledTextColor
                : ThemeVars.fieldLabelColor,
          ),
          child: Container(
            width: labelWidth,
            padding: labelMargin,
            alignment: <TextAlign, Alignment>{
              TextAlign.left: Alignment.centerLeft,
              TextAlign.center: Alignment.center,
              TextAlign.right: Alignment.centerRight,
            }[labelAlign],
            child: labelContent,
          ),
        );
      }

      return const SizedBox.shrink();
    });
  }

  void _scrollToVisiable() {
    Scrollable.ensureVisible(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<T>('value', widget.value));
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
    properties.add(DiagnosticsProperty<String Function(String)>(
        'formatter', widget.formatter));
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

    super.debugFillProperties(properties);
  }
}

class FlanFieldProvider extends InheritedWidget {
  const FlanFieldProvider({
    Key? key,
    required this.childFieldValue,
    required this.resetValidation,
    required this.validateWithTrigger,
    required Widget child,
  }) : super(key: key, child: child);

  final ValueNotifier<dynamic> childFieldValue;
  final VoidCallback resetValidation;
  final void Function(FlanFieldValidateTrigger trigger) validateWithTrigger;

  static FlanFieldProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlanFieldProvider>();
  }

  @override
  bool updateShouldNotify(FlanFieldProvider oldWidget) {
    return childFieldValue != oldWidget.childFieldValue ||
        resetValidation != oldWidget.resetValidation ||
        validateWithTrigger != oldWidget.validateWithTrigger;
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
