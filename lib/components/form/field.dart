import 'package:flant/components/alert/loading.dart';
import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
import '../../styles/var.dart';

/// ### FlanField
/// 表单中的输入框组件。
class FlanField extends StatelessWidget {
  const FlanField({
    Key key,
  }) : super(key: key);

  // ****************** Props ******************

  // ****************** Events ******************

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
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
