// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../components/field.dart';

@optionalTypeArgs
mixin FlanLinkFieldMixin<T extends StatefulWidget> on State<T> {
  void linkField(ValueNotifier<dynamic> modalValue) {
    FlanField.of(context)?.childFieldValue = modalValue;
  }

  @override
  void deactivate() {
    FlanField.of(context)?.childFieldValue = null;
    super.deactivate();
  }

  void validateChangedValue() {
    FlanField.of(context)?.validWhereValueChange();
  }
}
