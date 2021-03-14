import 'package:flant/components/cell.dart';
import 'package:flant/components/form.dart';
import 'package:flant/components/icon.dart';
import 'package:flant/styles/icons.dart';
import 'package:flant/styles/var.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

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
    this.leftIconName,
    this.leftIconUrl,
    this.rightIconName,
    this.rightIconUrl,
    this.iconPrefix = kFlanIconsFamily,
    this.rules = const <FlanFieldRule>[],
    required this.onInput,
    this.onFocus,
    this.onBlur,
    this.onClear,
    this.onKeypress,
    this.onClickInput,
    this.onClickLeftIcon,
    this.onClickRightIcon,
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
  final TextInputFormatter? formatter;

  /// 格式化函数触发的时机，可选值为 `onBlur` `onChange`
  final FlanFieldFormatTrigger formatTrigger;

  /// 箭头方向，可选值为 `left` `up` `down` `right`
  final FlanCellArrowDirection arrowDirection;

  /// 左侧文本额外类名
  final TextStyle? labelStyle;

  /// 左侧文本宽度
  final double? labelWidth;

  /// 左侧文本对齐方式，可选值为 `left` `center` `right`
  final FlanFieldTextAlign? labelAlign;

  /// 输入框对齐方式，可选值为 `left` `center` `right`
  final FlanFieldTextAlign? inputAlign;

  /// 错误提示文案对齐方式，可选值为 `left` `center` `right`
  final FlanFieldTextAlign? errMessageAlign;

  /// 是否自适应内容高度，只对 textarea 有效
  final BoxConstraints? autosize;

  /// 左侧图标名称
  final int? leftIconName;

  /// 左侧图片链接
  final String? leftIconUrl;

  /// 右侧图片链接
  final int? rightIconName;

  /// 右侧图片链接
  final String? rightIconUrl;

  /// 图标类名前缀，同 Icon 组件的 class-prefix 属性
  final String iconPrefix;

  /// 表单校验规则，详见 Form 组件
  final List<FlanFieldRule> rules;

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

  late final Future<FlanFieldValidateError?> Function(
      {List<FlanFieldRule>? rules}) validate;

  @override
  _FlanFieldState<T> createState() => _FlanFieldState<T>();
}

class _FlanFieldState<T extends dynamic> extends State<FlanField<T>> {
  bool focuesd = false;
  bool validateFailed = false;
  String validateMessage = '';

  late FocusNode focusNode;
  late TextEditingController editingController;

  ValueNotifier<String> childFieldValue = ValueNotifier<String>('');

  @override
  void initState() {
    widget.validate = validate;
    editingController = TextEditingController(text: widget.value.toString())
      ..addListener(onInput);
    focusNode = FocusNode()..addListener(onFouse);
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
      updateValue(modelvalue, trigger: widget.formatTrigger);
      adjustTextareaSize();
      watchValue();
    });
  }

  void onInput() => updateValue(editingController.text);
  void onFouse() => setState(() => focuesd = focusNode.hasFocus);

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
    _resetValidation();
    _validateWithTrigger(FlanFieldValidateTrigger.onChange);
    adjustTextareaSize();
  }

  @override
  void didUpdateWidget(covariant FlanField<T> oldWidget) {
    if (widget.value != oldWidget.value) {
      watchValue();
    }
    super.didUpdateWidget(oldWidget);
  }

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
                  padding: EdgeInsets.only(left: ThemeVars.paddingXs),
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
              widget.buttonSlot ?? Container(child: widget.buttonSlot)
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
        });
      }
    }
  }

  void _resetValidation() {
    if (validateFailed) {
      setState(() {
        validateFailed = false;
        validateMessage = '';
      });
    }
  }

  Future<FlanFieldValidateError?> validate({List<FlanFieldRule>? rules}) async {
    rules ??= widget.rules;
    _resetValidation();
    if (rules.isNotEmpty) {
      await _runRules(rules);
      if (validateFailed) {
        return FlanFieldValidateError(validateMessage, name: widget.name);
      }
    }
  }

  void _validateWithTrigger(FlanFieldValidateTrigger trigger) {
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

  FlanForm? get form => FlanFormProvider.of(context)?.form;
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
      result.add(
        FilteringTextInputFormatter.allow(RegExp(r'^-?([0-9]+\.)?[0-9]*$')),
      );
    }

    if (widget.type == FlanFieldType.digit) {
      result.add(
        FilteringTextInputFormatter.digitsOnly,
      );
    }

    if (widget.formatter != null &&
        widget.formatTrigger == FlanFieldFormatTrigger.onChange) {
      result.add(widget.formatter!);
    }

    return result;
  }

  T get formValue {
    // TODO: childFieldvalue
    return widget.value;
  }

  bool showError() {
    return widget.error || (form != null && form!.showError && validateFailed);
  }

  void onKeypress() {
    if (widget.onKeypress != null) {
      widget.onKeypress!();
    }
  }

  void adjustTextareaSize() {
    // final String input = inputValue;
    // if(widget.type == FlanFieldType.textarea && widget.autosize!=null && input.isNotEmpty){
    //   resizeText
    // }
  }

  Widget _buildInput() {
    final FlanFieldTextAlign? inputAlign =
        widget.inputAlign ?? form?.inputAlign;
    if (widget.inputSlot != null) {
      return Container(
        child: widget.inputSlot,
      );
    }
    // if (editingController.text.isEmpty) {
    //   return Text(widget.placeholder);
    // }

    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: widget.placeholder,
        hintStyle: const TextStyle(color: ThemeVars.fieldPlaceholderTextColor),
        isDense: true,
      ),
      scrollPadding: EdgeInsets.zero,
      mouseCursor: disabled ? SystemMouseCursors.forbidden : null,
      enabled: !disabled,
      readOnly: widget.readonly,
      controller: editingController,
      focusNode: focusNode,
      keyboardType: <TextInputType, TextInputType>{}[widget.type],
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
      cursorColor: ThemeVars.fieldInputTextColor,
    );
  }

  Widget _buildLeftIcon() {
    if (widget.leftIconName != null ||
        widget.leftIconUrl != null ||
        widget.leftIconSlot != null) {
      return Padding(
        padding: const EdgeInsets.only(right: ThemeVars.paddingBase),
        child: IconTheme.merge(
          data: const IconThemeData(
            size: ThemeVars.fieldIconSize,
          ),
          child: widget.leftIconSlot ??
              FlanIcon(
                iconName: widget.leftIconName,
                iconUrl: widget.leftIconUrl,
                classPrefix: widget.iconPrefix,
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
      return IconTheme.merge(
        data: const IconThemeData(
          size: ThemeVars.fieldIconSize,
          color: ThemeVars.fieldRightIconColor,
        ),
        child: widget.rightIconSlot ??
            FlanIcon(
              iconName: widget.rightIconName,
              iconUrl: widget.rightIconUrl,
              classPrefix: widget.iconPrefix,
            ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildWordLimt() {
    if (widget.showWordLimit && widget.maxLength != null) {
      final int count = modelvalue.length;
      return Container(
        child: Text('$count/${widget.maxLength}'),
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
      final FlanFieldTextAlign? errorMessageAlign =
          widget.errMessageAlign ?? form?.errMessageAlign;

      return Text(
        message,
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

      final FlanFieldTextAlign labelAlign =
          widget.labelAlign ?? form?.labelAlign ?? FlanFieldTextAlign.left;

      Widget? labelContent;

      if (widget.labelSlot != null) {
        labelContent = Wrap(
          // alignment: <FlanFieldTextAlign, WrapAlignment>{
          //   FlanFieldTextAlign.left: WrapAlignment.start,
          //   FlanFieldTextAlign.center: WrapAlignment.center,
          //   FlanFieldTextAlign.right: WrapAlignment.end,
          // }[labelAlign]!,
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
            alignment: <FlanFieldTextAlign, Alignment>{
              FlanFieldTextAlign.left: Alignment.centerLeft,
              FlanFieldTextAlign.center: Alignment.center,
              FlanFieldTextAlign.right: Alignment.centerRight,
            }[labelAlign],
            child: labelContent,
          ),
        );
      }

      return const SizedBox.shrink();
    });
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
    properties.add(
        DiagnosticsProperty<TextInputFormatter>('formatter', widget.formatter));
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
    properties.add(DiagnosticsProperty<FlanFieldTextAlign>(
        'labelAlign', widget.labelAlign,
        defaultValue: FlanFieldTextAlign.left));
    properties.add(DiagnosticsProperty<FlanFieldTextAlign>(
        'inputAlign', widget.inputAlign,
        defaultValue: FlanFieldTextAlign.left));

    properties.add(DiagnosticsProperty<FlanFieldTextAlign>(
        'errMessageAlign', widget.errMessageAlign,
        defaultValue: FlanFieldTextAlign.left));

    properties
        .add(DiagnosticsProperty<BoxConstraints>('autosize', widget.autosize));
    properties
        .add(DiagnosticsProperty<int>('leftIconName', widget.leftIconName));
    properties
        .add(DiagnosticsProperty<String>('leftIconUrl', widget.leftIconUrl));

    properties
        .add(DiagnosticsProperty<int>('rightIconName', widget.rightIconName));
    properties
        .add(DiagnosticsProperty<String>('rightIconUrl', widget.rightIconUrl));
    properties.add(DiagnosticsProperty<String>('iconPrefix', widget.iconPrefix,
        defaultValue: kFlanIconsFamily));
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

  final ValueNotifier<String> childFieldValue;
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
  final R Function<R, T extends dynamic>(T, FlanFieldRule)? validator;
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

enum FlanFieldTextAlign {
  left,
  center,
  right,
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
  final dynamic returnVal = rule.validator!<dynamic, dynamic>(value, rule);
  return returnVal;
}
