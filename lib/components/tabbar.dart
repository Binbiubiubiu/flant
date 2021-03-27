import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../styles/var.dart';
import 'tabbar_item.dart';

class FlanTabbar<T> extends StatelessWidget {
  const FlanTabbar({
    Key? key,
    required T value,
    this.activeColor,
    this.beforeChange,
    this.inactiveColor,
    this.border = true,
    this.safeAreaInsetBottom = false,
    required this.onChange,
    required this.children,
  })   : value = value ?? 0 as T,
        super(key: key);

  // ****************** Props ******************

  /// 选中标签的颜色
  final Color? activeColor;

  /// 切换标签前的回调函数，返回 `false` 可阻止切换
  final bool Function(T name)? beforeChange;

  /// 未选中标签的颜色
  final Color? inactiveColor;

  /// 当前选中标签的名称或索引值
  final T value;

  /// 是否显示外边框
  final bool border;

  /// 是否开启底部安全区适配
  final bool safeAreaInsetBottom;

  // ****************** Events ******************

  final ValueChanged<T> onChange;

  // ****************** Slots ******************
  // 内容
  final List<FlanTabbarItem<T>> children;

  @override
  Widget build(BuildContext context) {
    final Container tabbar = Container(
      width: double.infinity,
      height: ThemeVars.tabbarHeight,
      decoration: const BoxDecoration(
        color: ThemeVars.tabbarBackgroundColor,
      ),
      child: Row(
        children: children,
      ),
    );

    return SafeArea(bottom: safeAreaInsetBottom, child: tabbar);
  }

  void setActive(T value) {
    if (value != this.value) {
      bool canChange = true;
      if (beforeChange != null) {
        canChange = beforeChange!(value);
      }

      if (canChange) {
        onChange(value);
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Color>('activeColor', activeColor));
    properties.add(
        DiagnosticsProperty<Function(T name)>('beforeChange', beforeChange));
    properties.add(DiagnosticsProperty<Color>('inactiveColor', inactiveColor));
    properties.add(DiagnosticsProperty<T>('value', value));
    properties
        .add(DiagnosticsProperty<bool>('border', border, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'safeAreaInsetBottom', safeAreaInsetBottom,
        defaultValue: false));
    super.debugFillProperties(properties);
  }
}
