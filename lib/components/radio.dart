import 'package:flant/components/radio_group.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'checkbox.dart';

class FlanRadio<T extends dynamic> extends StatelessWidget {
  const FlanRadio({
    Key? key,
    this.name,
    this.disabled = false,
    this.iconSize,
    this.value = false,
    this.checkedColor,
    this.labelPosition = FlanCheckerLabelPosition.right,
    this.labelDisabled = false,
    this.shape = FlanCheckerShape.round,
    this.onChange,
    this.onClick,
    this.iconBuilder,
    this.child,
  }) : super(key: key);

  // ****************** Props ******************
  final T? name;
  final bool disabled;
  final double? iconSize;
  final bool value;
  final Color? checkedColor;
  final FlanCheckerLabelPosition labelPosition;
  final bool labelDisabled;
  final FlanCheckerShape shape;

  // ****************** Events ******************
  final ValueChanged<bool>? onChange;
  final VoidCallback? onClick;

  // ****************** Slots ******************
  final Widget Function(bool checked)? iconBuilder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final FlanRadioGroup<T>? parent =
        context.findAncestorWidgetOfExactType<FlanRadioGroup<T>>();
    if (parent != null && name == null) {
      throw 'use FlanRadio in the FlanRadioGroup,please set the name of FlanRadio';
    }

    final bool checked = (parent != null ? parent.value : value) == name;

    void toggle({bool? newValue}) {
      newValue ??= !checked;
      if (parent != null) {
        parent.updateValue(name!);
      } else {
        if (onChange != null) {
          onChange!(newValue);
        }
      }
    }

    return FlanChecker<T>(
      iconBuilder: iconBuilder,
      child: child,
      role: 'radio',
      value: value,
      checked: checked,
      parent: FlanCheckerParentProps(
        checkedColor: parent?.checkedColor,
        direction: parent?.direction,
        disabled: parent?.disabled,
        iconSize: parent?.iconSize,
      ),
      onToggle: toggle,
      onClick: onClick,
      disabled: disabled,
      iconSize: iconSize,
      checkedColor: checkedColor,
      name: name,
      labelPosition: labelPosition,
      labelDisabled: labelDisabled,
      shape: shape,
    );
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    // TODO: implement debugDescribeChildren
    return super.debugDescribeChildren();
  }
}
