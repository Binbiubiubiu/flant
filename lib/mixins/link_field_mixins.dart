// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/components/field.dart';

@optionalTypeArgs
mixin FlanLinkFieldMixin<T extends StatefulWidget> on State<T> {
  FlanFieldState<T>? get field {
    return context.findAncestorStateOfType<FlanFieldState<T>>();
  }

  void useLinkField(dynamic widget, dynamic oldWidget) {
    if (field != null) {
      field!.childFieldValue.value = widget.value;
      if (widget.value != oldWidget.value) {
        field?.resetValidation();
        field?.validateWithTrigger(FlanFieldValidateTrigger.onChange);
      }
    }
  }
}
