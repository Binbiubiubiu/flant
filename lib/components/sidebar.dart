// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/components/sidebar_theme.dart';

/// ### Sidebar 侧边导航
/// 垂直展示的导航栏，用于在不同的内容区域之间进行切换。
class FlanSidebar extends StatelessWidget {
  const FlanSidebar({
    Key? key,
    this.value = 0,
    this.backgroundColor,
    this.onValueChange,
    this.onChange,
    this.children = const <Widget>[],
  }) : super(key: key);

  // ****************** Props ******************
  /// 当前导航项的索引
  final int value;

  /// 背景色
  final Color? backgroundColor;

  // ****************** Events ******************
  /// 导航值变化监听
  final ValueChanged<int>? onValueChange;

  /// 导航值变化监听
  final ValueChanged<int>? onChange;

  // ****************** Slots ******************
  /// 内容
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final FlanSidebarThemeData themeData = FlanSidebarTheme.of(context);
    return Container(
      width: themeData.width,
      color: backgroundColor,
      child: FlanSidebarScope(
        parent: this,
        child: ListView(
          shrinkWrap: true,
          children: children,
        ),
      ),
    );
  }

  int getActive() => value;

  void setActive(int value) {
    if (getActive() != value) {
      onValueChange?.call(value);
      onChange?.call(value);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<int>('value', value, defaultValue: 0));
    properties
        .add(DiagnosticsProperty<Color>('backgroundColor', backgroundColor));
    super.debugFillProperties(properties);
  }
}

class FlanSidebarScope extends InheritedWidget {
  const FlanSidebarScope({
    Key? key,
    required this.parent,
    required Widget child,
  }) : super(key: key, child: child);

  final FlanSidebar parent;

  static FlanSidebarScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlanSidebarScope>();
  }

  @override
  bool updateShouldNotify(FlanSidebarScope oldWidget) {
    return parent != oldWidget.parent;
  }
}
