import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// ### FlanField
/// 表单中的输入框组件。
class FlanField extends StatelessWidget {
  const FlanField({
    Key? key,
  }) : super(key: key);

  // ****************** Props ******************

  // ****************** Events ******************

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    return Container();
  }
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
