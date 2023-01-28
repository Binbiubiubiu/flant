import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../components/checkbox_group.dart';
import '../styles/var.dart';
import 'icon.dart';

/// ### Checkbox 复选框
/// 用于在选中和非选中状态之间进行切换。
@optionalTypeArgs
class FlanCheckbox<T extends dynamic> extends StatelessWidget {
  const FlanCheckbox({
    Key? key,
    this.name,
    this.disabled = false,
    this.iconSize,
    this.value = false,
    this.checkedColor,
    this.labelPosition = FlanCheckerLabelPosition.right,
    this.labelDisabled = false,
    this.shape = FlanCheckerShape.round,
    this.bindGroup = true,
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
  final bool bindGroup;

  // ****************** Events ******************
  final ValueChanged<bool>? onChange;
  final VoidCallback? onClick;

  // ****************** Slots ******************
  final Widget Function(bool checked)? iconBuilder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final FlanCheckboxGroup<T>? parent =
        FlanCheckBoxScope.of(context)?.parent as FlanCheckboxGroup<T>?;
    if (parent != null && name == null) {
      throw 'use FlanCheckbox in the FlanCheckboxGroup,please set the name of FlanCheckbox';
    }

    void setParentValue(bool checked) {
      final int max = parent!.max;
      final List<T> value = parent.value.toList();

      if (checked) {
        final bool overlimit = max > 0 && value.length >= max;
        if (!overlimit && !value.contains(name)) {
          value.add(name!);
          if (bindGroup) {
            parent.updateValue(value);
          }
        }
      } else {
        if (value.remove(name!) && bindGroup) {
          parent.updateValue(value);
        }
      }
    }

    final bool checked =
        parent != null && bindGroup ? parent.value.contains(name) : value;

    void toggle({bool? newValue}) {
      newValue ??= !checked;
      if (parent != null && bindGroup) {
        setParentValue(newValue);
      } else {
        onChange?.call(newValue);
      }
    }

    return FlanChecker<T>(
      iconBuilder: iconBuilder,
      child: child,
      role: 'checkbox',
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
    properties
        .add(DiagnosticsProperty<bool>('value', value, defaultValue: false));
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
    properties.add(
        DiagnosticsProperty<bool>('bindGroup', bindGroup, defaultValue: true));
    super.debugFillProperties(properties);
  }
}

class FlanChecker<T> extends StatelessWidget {
  const FlanChecker({
    Key? key,
    this.name,
    this.disabled = false,
    this.iconSize,
    this.value = false,
    this.checkedColor,
    this.labelPosition = FlanCheckerLabelPosition.right,
    this.labelDisabled = false,
    this.shape = FlanCheckerShape.round,
    this.role,
    this.parent,
    this.checked = false,
    this.bindGroup = true,
    this.onClick,
    this.onToggle,
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
  final String? role;
  final FlanCheckerParentProps? parent;
  final bool checked;
  final bool bindGroup;

  // ****************** Events ******************
  final VoidCallback? onClick;
  final VoidCallback? onToggle;

  // ****************** Slots ******************
  final Widget Function(bool checked)? iconBuilder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[_buildIcon()];
    if (labelPosition == FlanCheckerLabelPosition.left) {
      children.insert(0, _buildLabel());
    } else {
      children.add(_buildLabel());
    }

    return Semantics(
      label: role,
      checked: checked,
      child: GestureDetector(
        onTap: _onClick,
        child: Wrap(
          spacing: ThemeVars.checkboxLabelMargin,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: children,
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final double? iconSize = this.iconSize ?? _parentProps?.iconSize;
    final double size = iconSize ?? ThemeVars.checkboxSize;

    final Color? bgColor = _disabled
        ? ThemeVars.checkboxDisabledBackgroundColor
        : checked
            ? iconColor ?? ThemeVars.checkboxCheckedIconColor
            : null;

    final Color? borderColor = _disabled
        ? ThemeVars.checkboxDisabledIconColor
        : checked
            ? iconColor ?? ThemeVars.checkboxCheckedIconColor
            : null;

    return MouseRegion(
      cursor:
          _disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      child: iconBuilder != null
          ? SizedBox(
              height: ThemeVars.checkboxSize,
              child: iconBuilder!(checked),
            )
          : Container(
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(
                  width: 1.0,
                  color: borderColor ?? ThemeVars.checkboxborderColor,
                ),
                shape: shape == FlanCheckerShape.round
                    ? BoxShape.circle
                    : BoxShape.rectangle,
              ),
              width: 1.2 * size,
              height: 1.2 * size,
              alignment: Alignment.center,
              child: FlanIcon(
                iconName: FlanIcons.success,
                color: checked
                    ? _disabled
                        ? ThemeVars.checkboxDisabledIconColor
                        : ThemeVars.white
                    : Colors.transparent,
                size: size * 0.8,
              ),
            ),
    );
  }

  Widget _buildLabel() {
    if (child != null) {
      return IgnorePointer(
        ignoring: labelDisabled,
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: ThemeVars.checkboxSize * 0.8,
            color: disabled
                ? ThemeVars.checkboxDisabledLabelColor
                : ThemeVars.checkboxLabelColor,
          ),
          child: child!,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  void _onClick() {
    if (!disabled) {
      onToggle?.call();
    }
    onClick?.call();
  }

  FlanCheckerParentProps? get _parentProps =>
      parent != null && bindGroup ? parent! : null;

  bool get _disabled => _parentProps?.disabled ?? disabled;

  Color? get iconColor {
    final Color? checkedColor = this.checkedColor ?? _parentProps?.checkedColor;
    if (checkedColor != null && checked && !_disabled) {
      return checkedColor;
    }
    return null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<T>('name', name));
    properties
        .add(DiagnosticsProperty<bool>('value', value, defaultValue: false));
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

    properties.add(DiagnosticsProperty<String>('role', role));
    properties
        .add(DiagnosticsProperty<FlanCheckerParentProps>('parent', parent));
    properties.add(
        DiagnosticsProperty<bool>('checked', checked, defaultValue: false));

    super.debugFillProperties(properties);
  }
}

enum FlanCheckerShape {
  square,
  round,
}

enum FlanCheckerLabelPosition {
  left,
  right,
}

class FlanCheckerParentProps {
  const FlanCheckerParentProps({
    this.disabled,
    this.iconSize,
    this.direction,
    this.checkedColor,
  });

  final bool? disabled;
  final double? iconSize;
  final Axis? direction;
  final Color? checkedColor;
}
