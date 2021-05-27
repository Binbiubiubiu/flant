// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/components/field.dart';

class FlanForm extends StatefulWidget {
  const FlanForm({
    Key? key,
    this.colon = false,
    this.disabled = false,
    this.readonly = false,
    this.showError = true,
    this.labelWidth,
    this.labelAlign = TextAlign.left,
    this.inputAlign = TextAlign.left,
    this.scrollToError = false,
    this.validateFirst = false,
    this.errMessageAlign = TextAlign.left,
    this.submitOnEnter = true,
    this.validateTrigger = FlanFieldValidateTrigger.onBlur,
    this.showErrorMessage = true,
    this.onSubmit,
    this.onFailed,
    this.children = const <FlanField>[],
  }) : super(key: key);

  // ****************** Props ******************
  /// 是否在 label 后面添加冒号
  final bool colon;

  /// 是否禁用表单中的所有输入框
  final bool disabled;

  /// 是否将表单中的所有输入框设置为只读
  final bool readonly;

  /// 是否在校验不通过时标红输入框
  final bool showError;

  ///表单项 label 宽度
  final double? labelWidth;

  /// 表单项 label 对齐方式，可选值为 `left` `center` `right`
  final TextAlign labelAlign;

  /// 输入框对齐方式，可选值为 `left` `center` `right`
  final TextAlign inputAlign;

  /// 是否在提交表单且校验不通过时滚动至错误的表单项
  final bool scrollToError;

  /// 是否在某一项校验不通过时停止校验
  final bool validateFirst;

  /// 错误提示文案对齐方式，可选值为 `left` `center` `right`
  final TextAlign errMessageAlign;

  /// 是否在按下回车键时提交表单
  final bool submitOnEnter;

  /// 表单校验触发时机，可选值为 `onBlur` `onChange` `onSubmit`
  final FlanFieldValidateTrigger validateTrigger;

  /// 是否在校验不通过时在输入框下方展示错误提示
  final bool showErrorMessage;

  // ****************** Events ******************
  final ValueChanged<Map<String, dynamic>>? onSubmit;
  final ValueChanged<FlanFormFailDetail>? onFailed;

  // ****************** Slots ******************

  final List<FlanField> children;

  @override
  FlanFormState createState() => FlanFormState();

  static FlanFormState? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_FlanFormScope>()
        ?._formState;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<bool>('colon', colon, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('readonly', readonly, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('showError', showError, defaultValue: true));
    properties.add(DiagnosticsProperty<double>('labelWidth', labelWidth));
    properties.add(DiagnosticsProperty<TextAlign>('labelAlign', labelAlign,
        defaultValue: TextAlign.left));
    properties.add(DiagnosticsProperty<TextAlign>('inputAlign', inputAlign,
        defaultValue: TextAlign.left));
    properties.add(DiagnosticsProperty<bool>('scrollToError', scrollToError,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('validateFirst', validateFirst,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('submitOnEnter', submitOnEnter,
        defaultValue: true));
    properties.add(DiagnosticsProperty<TextAlign>(
        'errMessageAlign', errMessageAlign,
        defaultValue: TextAlign.left));
    properties.add(DiagnosticsProperty<FlanFieldValidateTrigger>(
        'validateTrigger', validateTrigger,
        defaultValue: FlanFieldValidateTrigger.onBlur));
    properties.add(DiagnosticsProperty<bool>(
        'showErrorMessage', showErrorMessage,
        defaultValue: false));
    super.debugFillProperties(properties);
  }
}

class FlanFormState extends State<FlanForm> {
  final Map<String, FlanFieldState> _fields = <String, FlanFieldState>{};

  void register(String name, FlanFieldState field) {
    _fields[name] = field;
  }

  void unregister(String name) {
    _fields.remove(name);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _FlanFormScope(
      formState: this,
      child: Column(
        children: widget.children,
      ),
    );
  }

  List<FlanFieldState> _getFieldsByNames({List<String>? names}) {
    if (names != null) {
      return _fields.keys
          .where((String key) => names.contains(key))
          .map((String key) => _fields[key]!)
          .toList();
    }
    return _fields.values.toList();
  }

  Future<void> _validateSeq({List<String>? names}) async {
    final List<FlanFieldValidateError> errors = <FlanFieldValidateError>[];
    final List<FlanFieldState> fields = _getFieldsByNames(names: names);

    for (final FlanFieldState field in fields) {
      if (errors.isEmpty) {
        final FlanFieldValidateError? error = await field.validate();
        if (error != null) {
          errors.add(error);
        }
      }
    }

    if (errors.isNotEmpty) {
      throw errors;
    }
  }

  Future<dynamic> _validateAll({List<String>? names}) async {
    final List<FlanFieldValidateError> errors = <FlanFieldValidateError>[];
    final List<FlanFieldState> fields = _getFieldsByNames(names: names);

    for (final FlanFieldState field in fields) {
      final FlanFieldValidateError? error = await field.validate();
      if (error != null) {
        errors.add(error);
      }
    }
    if (errors.isNotEmpty) {
      throw errors;
    }
  }

  Future<void> _validateField(String name) async {
    final FlanFieldState? matched = _fields[name];
    final FlanFieldValidateError? error = await matched?.validate();

    if (error != null) {
      throw error;
    }
  }

  Future<dynamic> validate<T>({T? name}) {
    if (name is String) {
      return _validateField(name as String);
    }
    return widget.validateFirst
        ? _validateSeq(names: name as List<String>?)
        : _validateAll(names: name as List<String>?);
  }

  void resetValidation<T>({T? name}) {
    final List<FlanFieldState> fields = _getFieldsByNames(
      names: name is String ? <String>[name as String] : name as List<String>,
    );

    for (final FlanFieldState field in fields) {
      field.resetValidation();
    }
  }

  Map<String, dynamic> _getValues() => _fields.values.fold(<String, dynamic>{},
          (Map<String, dynamic> form, FlanFieldState field) {
        form[field.widget.name] = field.modelvalue;
        return form;
      });

  Future<void> submit() async {
    final Map<String, dynamic> values = _getValues();

    try {
      await validate<dynamic>();
      widget.onSubmit?.call(values);
    } on List<FlanFieldValidateError> catch (errors) {
      widget.onFailed?.call(FlanFormFailDetail(values: values, errors: errors));

      if (widget.scrollToError && errors[0].name != null) {
        scrollToField(errors[0].name!);
      }
    }
  }

  void scrollToField(
    String name, {
    double alignment = 0.0,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
  }) {
    _fields[name]?.scrollToVisiable(
      alignment: alignment,
      duration: duration,
      curve: curve,
      alignmentPolicy: alignmentPolicy,
    );
  }
}

class FlanFormFailDetail {
  FlanFormFailDetail({
    required this.values,
    required this.errors,
  });
  final Map<String, dynamic> values;
  final List<FlanFieldValidateError> errors;
}

class _FlanFormScope extends InheritedWidget {
  const _FlanFormScope({
    Key? key,
    required FlanFormState formState,
    required Widget child,
  })  : _formState = formState,
        super(key: key, child: child);

  final FlanFormState _formState;

  FlanForm get form => _formState.widget;

  @override
  bool updateShouldNotify(_FlanFormScope oldWidget) {
    return _formState != oldWidget._formState;
  }
}
