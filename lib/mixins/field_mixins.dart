import 'package:flant/components/field.dart';
import 'package:flutter/material.dart';

@optionalTypeArgs
mixin LinkFieldMixin<T extends StatefulWidget> on State<T> {
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
