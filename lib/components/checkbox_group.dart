import 'package:flant/components/checkbox.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'checkbox.dart';

@optionalTypeArgs
class FlanCheckboxGroup<T extends dynamic> extends StatelessWidget {
  const FlanCheckboxGroup({
    Key? key,
    this.max = 5,
    this.disabled = false,
    this.direction = Axis.vertical,
    this.iconSize,
    this.checkedColor,
    required this.value,
    this.onChange,
    required this.children,
  }) : super(key: key);

  // ****************** Props ******************
  final int max;
  final bool disabled;
  final Axis direction;
  final double? iconSize;
  final Color? checkedColor;
  final List<T> value;

  // ****************** Events ******************
  final ValueChanged<List<T>>? onChange;

  // ****************** Slots ******************
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return FlanCheckBoxScope(
      parent: this,
      child: Flex(
        direction: direction,
        children: children,
      ),
    );
  }

  void toggleAll({
    bool? checked,
    bool skipDisabled = false,
  }) {
    final List<FlanCheckbox<T>> checkedChildren = children
        .whereType<FlanCheckbox<T>>()
        .toList()
        .where((FlanCheckbox<T> item) {
      // ignore: unnecessary_type_check
      if (item is! FlanCheckbox<T>) {
        return false;
      }

      if (!item.bindGroup) {
        return false;
      }
      if (item.disabled && skipDisabled) {
        return value.contains(item.name);
      }

      return checked ?? !value.contains(item.name);
    }).toList();
    final List<T> names =
        checkedChildren.map((FlanCheckbox<T> e) => e.name!).toList();
    updateValue(names);
  }

  void updateValue(List<T> value) {
    onChange?.call(value);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<int>('max', max, defaultValue: 5));
    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties.add(DiagnosticsProperty<Axis>('direction', direction,
        defaultValue: Axis.vertical));
    properties.add(DiagnosticsProperty<double>('iconSize', iconSize));
    properties.add(DiagnosticsProperty<List<T>>('value', value));

    super.debugFillProperties(properties);
  }
}

class FlanCheckBoxScope extends InheritedWidget {
  const FlanCheckBoxScope({
    Key? key,
    required this.parent,
    required Widget child,
  }) : super(key: key, child: child);

  final FlanCheckboxGroup parent;

  static FlanCheckBoxScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlanCheckBoxScope>();
  }

  @override
  bool updateShouldNotify(FlanCheckBoxScope oldWidget) {
    return parent != oldWidget.parent;
  }
}
