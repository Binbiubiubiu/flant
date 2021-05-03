// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 🌎 Project imports:
import 'package:flant/components/radio_group.dart';
import 'checkbox.dart';

/// ### Radio 单选框
/// 用于在多个选项中选择单个结果。
@optionalTypeArgs
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
  /// 标识符
  final T? name;

  /// 是否为禁用状态
  final bool disabled;

  /// 图标大小
  final double? iconSize;

  /// 是否选中
  final bool value;

  /// 选中状态颜色
  final Color? checkedColor;

  /// 标识符
  final FlanCheckerLabelPosition labelPosition;

  /// 文本位置，可选值为 `left` `right`
  final bool labelDisabled;

  /// 形状，可选值为 `square` `round`
  final FlanCheckerShape shape;

  // ****************** Events ******************
  /// 选中变化时触发
  final ValueChanged<bool>? onChange;

  /// 点击单选框时触发
  final VoidCallback? onClick;

  // ****************** Slots ******************
  /// 自定义图标
  final Widget Function(bool checked)? iconBuilder;

  /// 自定义内容
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final FlanRadioGroup<T>? parent =
        FlanRadioScope.of(context)?.parent as FlanRadioGroup<T>?;
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
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<T>('name', name));
    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties.add(DiagnosticsProperty<double>('iconSize', iconSize));
    properties
        .add(DiagnosticsProperty<bool>('value', value, defaultValue: false));
    properties.add(DiagnosticsProperty<Color>('checkedColor', checkedColor));
    properties.add(DiagnosticsProperty<FlanCheckerLabelPosition>(
        'labelPosition', labelPosition,
        defaultValue: FlanCheckerLabelPosition.right));
    properties.add(DiagnosticsProperty<bool>('labelDisabled', labelDisabled,
        defaultValue: false));
    properties.add(DiagnosticsProperty<FlanCheckerShape>('shape', shape,
        defaultValue: FlanCheckerShape.round));

    super.debugFillProperties(properties);
  }
}
