// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/flant.dart';
import '../styles/var.dart';

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
    return Container(
      width: ThemeVars.sidebarWidth,
      color: backgroundColor,
      child: ListView(
        shrinkWrap: true,
        children: children,
      ),
    );
  }

  int getActive() => value;

  void setActive(int value) {
    if (getActive() != value) {
      if (onValueChange != null) {
        onValueChange!(value);
      }

      if (onChange != null) {
        onChange!(value);
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
