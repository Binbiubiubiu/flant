import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../styles/var.dart';
import './tabbar_item.dart';

class FlanTabbar<T extends dynamic> extends StatelessWidget {
  FlanTabbar({
    Key key,
    T value,
    // this.route = false,
    // this.placeholder = false,
    this.activeColor,
    this.beforeChange,
    this.inactiveColor,
    this.border = true,
    this.safeAreaInsetBottom = false,
    this.onChange,
    this.children,
  })  :
        // assert(route != null),
        // assert(placeholder != null),
        assert(value != null),
        assert(border != null),
        assert(safeAreaInsetBottom != null),
        value = value ?? 0,
        super(key: key);

  // ****************** Props ******************
  /// 当前展开面板的 `name`
  // final bool route;

  /// 固定在底部时，是否在标签位置生成一个等高的占位元素
  // final bool placeholder;

  /// 选中标签的颜色
  final Color activeColor;

  final bool Function(T name) beforeChange;

  /// 未选中标签的颜色
  final Color inactiveColor;

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
  final List<FlanTabbarItem> children;

  @override
  Widget build(BuildContext context) {
    final tabbar = Container(
      width: double.infinity,
      height: ThemeVars.tabbarHeight,
      decoration: BoxDecoration(
        color: ThemeVars.tabbarBackgroundColor,
      ),
      child: FlanTabbarProvider(
        value: this.value,
        activeColor: this.activeColor,
        inactiveColor: this.inactiveColor,
        setActive: (dynamic value) {
          if (value != this.value) {
            if (this.beforeChange != null) {
              this.beforeChange(value);
            }
            if (this.onChange != null) {
              this.onChange(value);
            }
          }
        },
        child: Row(
          children:
              (this.children ?? []).map((e) => Expanded(child: e)).toList(),
        ),
      ),
    );

    return SafeArea(bottom: this.safeAreaInsetBottom, child: tabbar);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement debugFillProperties
    super.debugFillProperties(properties);
  }
}

class FlanTabbarProvider extends InheritedWidget {
  FlanTabbarProvider({
    Key key,
    this.value,
    this.activeColor,
    this.inactiveColor,
    this.setActive,
    this.child,
  }) : super(key: key, child: child);

  final dynamic value;

  final Color activeColor;
  final Color inactiveColor;

  final ValueChanged<dynamic> setActive;

  final Row child;

  static FlanTabbarProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlanTabbarProvider>();
  }

  @override
  bool updateShouldNotify(FlanTabbarProvider oldWidget) {
    return value != oldWidget.value ||
        activeColor != oldWidget.activeColor ||
        inactiveColor != oldWidget.inactiveColor;
  }
}
