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
  /// 是否选中
  final int max;

  /// 是否禁用所有单选框
  final bool disabled;

  /// 排列方向，可选值为 `horizontal` `vertical`
  final Axis direction;

  /// 所有单选框的图标大小
  final double? iconSize;

  /// 所有单选框的选中状态颜色
  final Color? checkedColor;

  /// 当前选中项的标识符
  final T value;

  // ****************** Events ******************
  /// 选中变化时触发
  final ValueChanged<T>? onChange;

  // ****************** Slots ******************
  /// 自定义内容
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
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<int>('max', max, defaultValue: 5));
    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties.add(DiagnosticsProperty<Axis>('direction', direction,
        defaultValue: Axis.vertical));
    properties.add(DiagnosticsProperty<double>('iconSize', iconSize));
    properties.add(DiagnosticsProperty<T>('value', value));

    super.debugFillProperties(properties);
  }
}
