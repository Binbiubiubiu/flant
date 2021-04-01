// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlanRadioGroup<T extends dynamic> extends StatelessWidget {
  const FlanRadioGroup({
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
  final T value;

  // ****************** Events ******************
  final ValueChanged<T>? onChange;

  // ****************** Slots ******************
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'radiogroup',
      child: Flex(
        direction: direction,
        children: children,
      ),
    );
  }

  void updateValue(T value) {
    if (onChange != null) {
      onChange!(value);
    }
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    // TODO: implement debugDescribeChildren
    return super.debugDescribeChildren();
  }
}
