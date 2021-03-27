import 'package:flant/components/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
    this.children = const <FlanField<dynamic>>[],
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

  final List<FlanField<dynamic>> children;

  @override
  FlanFormState createState() => FlanFormState();
}

class FlanFormState extends State<FlanForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.children,
    );
  }

  List<FlanField<dynamic>> _getFieldsByNames({List<String>? names}) {
    if (names != null) {
      return widget.children
          .where((FlanField<dynamic> element) => names.contains(element.name))
          .toList();
    }
    return widget.children;
  }

  Future<void> _validateSeq({List<String>? names}) async {
    final List<FlanFieldValidateError> errors = <FlanFieldValidateError>[];
    final List<FlanField<dynamic>> fields = _getFieldsByNames(names: names);

    for (final FlanField<dynamic> field in fields) {
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

  Future<void> _validateAll({List<String>? names}) async {
    final List<FlanFieldValidateError> errors = <FlanFieldValidateError>[];
    final List<FlanField<dynamic>> fields = _getFieldsByNames(names: names);

    for (final FlanField<dynamic> field in fields) {
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
    final int index = widget.children.indexWhere(
      (FlanField<dynamic> item) => item.name == name,
    );
    if (index != -1) {
      final FlanField<dynamic> matched = widget.children.elementAt(index);
      final FlanFieldValidateError? error = await matched.validate();

      if (error != null) {
        throw error;
      }
    }
  }

  Future<void> _validate<T>({T? name}) {
    if (name is String) {
      return _validateField(name as String);
    }

    return widget.validateFirst
        ? _validateSeq(names: name as List<String>)
        : _validateAll(names: name as List<String>);
  }

  void _resetValidation<T>({T? name}) {
    final fields = _getFieldsByNames(
      names: name is String ? <String>[name as String] : name as List<String>,
    );

    for (final FlanField<dynamic> field in fields) {
      // field.resetValidation();
    }
  }

  Map<String, dynamic> _getValues() => widget.children.fold(<String, dynamic>{},
          (Map<String, dynamic> form, FlanField<dynamic> field) {
        form[field.name] = field.value;
        return form;
      });

  void _submit() {
    final Map<String, dynamic> values = _getValues();
    _validate<String>().then((_) {
      if (widget.onSubmit != null) {
        widget.onSubmit!(values);
      }
    }).catchError((List<FlanFieldValidateError> errors) {
      if (widget.onFailed != null) {
        widget.onFailed!(FlanFormFailDetail(values: values, errors: errors));
        if (widget.scrollToError && errors[0].name != null) {
          // TODO: scrollToField
        }
      }
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<bool>('colon', widget.colon, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('disabled', widget.disabled,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('readonly', widget.readonly,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('showError', widget.showError,
        defaultValue: true));
    properties
        .add(DiagnosticsProperty<double>('labelWidth', widget.labelWidth));
    properties.add(DiagnosticsProperty<TextAlign>(
        'labelAlign', widget.labelAlign,
        defaultValue: TextAlign.left));
    properties.add(DiagnosticsProperty<TextAlign>(
        'inputAlign', widget.inputAlign,
        defaultValue: TextAlign.left));
    properties.add(DiagnosticsProperty<bool>(
        'scrollToError', widget.scrollToError,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'validateFirst', widget.validateFirst,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'submitOnEnter', widget.submitOnEnter,
        defaultValue: true));
    properties.add(DiagnosticsProperty<TextAlign>(
        'errMessageAlign', widget.errMessageAlign,
        defaultValue: TextAlign.left));
    properties.add(DiagnosticsProperty<FlanFieldValidateTrigger>(
        'validateTrigger', widget.validateTrigger,
        defaultValue: FlanFieldValidateTrigger.onBlur));
    properties.add(DiagnosticsProperty<bool>(
        'showErrorMessage', widget.showErrorMessage,
        defaultValue: false));
    super.debugFillProperties(properties);
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
