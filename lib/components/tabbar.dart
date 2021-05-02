// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/components/tabbar_theme.dart';
import '../styles/theme.dart';
import 'tabbar_item.dart';

/// ### Tabbar 标签栏
/// 底部导航栏，用于在不同页面之间进行切换。
class FlanTabbar extends StatelessWidget {
  const FlanTabbar({
    Key? key,
    this.value = '0',
    this.activeColor,
    this.beforeChange,
    this.inactiveColor,
    this.border = true,
    this.safeAreaInsetBottom = false,
    this.onChange,
    required this.children,
  }) : super(key: key);

  // ****************** Props ******************

  /// 选中标签的颜色
  final Color? activeColor;

  /// 切换标签前的回调函数，返回 `false` 可阻止切换
  final bool Function(String name)? beforeChange;

  /// 未选中标签的颜色
  final Color? inactiveColor;

  /// 当前选中标签的名称或索引值
  final String value;

  /// 是否显示外边框
  final bool border;

  /// 是否开启底部安全区适配
  final bool safeAreaInsetBottom;

  // ****************** Events ******************

  final ValueChanged<String>? onChange;

  // ****************** Slots ******************
  // 内容
  final List<FlanTabbarItem> children;

  @override
  Widget build(BuildContext context) {
    final FlanTabbarThemeData themeData = FlanTheme.of(context).tabbarTheme;
    final Container tabbar = Container(
      width: double.infinity,
      height: themeData.height,
      decoration: BoxDecoration(
        color: themeData.backgroundColor,
      ),
      child: Row(
        children: children,
      ),
    );

    return SafeArea(
      bottom: safeAreaInsetBottom,
      child: tabbar,
    );
  }

  void setActive(String value) {
    if (value != this.value) {
      bool canChange = true;
      if (beforeChange != null) {
        canChange = beforeChange!(value);
      }

      if (canChange && onChange != null) {
        onChange!(value);
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Color>('activeColor', activeColor));
    properties.add(DiagnosticsProperty<Function(String name)>(
        'beforeChange', beforeChange));
    properties.add(DiagnosticsProperty<Color>('inactiveColor', inactiveColor));
    properties.add(DiagnosticsProperty<String>('value', value));
    properties
        .add(DiagnosticsProperty<bool>('border', border, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'safeAreaInsetBottom', safeAreaInsetBottom,
        defaultValue: false));
    super.debugFillProperties(properties);
  }
}
