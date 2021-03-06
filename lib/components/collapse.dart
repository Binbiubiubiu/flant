import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'collapse_item.dart';
import 'style.dart';

/// ### FlanCollapse 折叠面板
/// 将一组内容放置在多个折叠面板中，点击面板的标题可以展开或收缩其内容。
class FlanCollapse<T extends dynamic> extends StatelessWidget {
  const FlanCollapse({
    Key? key,
    required this.value,
    required this.onChange,
    this.accordion = false,
    this.border = true,
    this.children = const <FlanCollapseItem>[],
  })  : assert(value is String || value is List<String>),
        super(key: key);

  // ****************** Props ******************
  /// 当前展开面板的 `name`
  final T value;

  /// 是否开启手风琴模式
  final bool accordion;

  /// 是否显示外边框
  final bool border;

  // ****************** Events ******************

  final ValueChanged<T> onChange;

  // ****************** Slots ******************
  // 内容
  final List<FlanCollapseItem> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: this.border ? FlanHairLine() : BorderSide.none,
        ),
      ),
      child: FlanCollapseProvider(
        toggle: this.toggle,
        isExpanded: this.isExpanded,
        child: Column(
          children: this.children,
        ),
      ),
    );
  }

  void updateName(dynamic name) {
    if (this.onChange != null) {
      this.onChange(name);
    }
  }

  void toggle(String name, bool expanded) {
    if (this.accordion) {
      this.updateName(name == this.value ? '' : name);
    } else if (expanded) {
      this.updateName([...(this.value as List<String>), name]);
    } else {
      this.updateName((this.value as List<String>)
          .where((activeName) => activeName != name)
          .toList());
    }
  }

  bool isExpanded(String name) {
    if (this.accordion && this.value is List<String>) {
      throw "FlanCollapse: value should not be Array in accordion mode";
    }

    if (!this.accordion && !(this.value is List<String>)) {
      throw "FlanCollapse: value should be Array in non-accordion mode";
    }

    return this.accordion
        ? this.value == name
        : (this.value as List<String>).contains(name);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<T>("value", value));
    properties.add(
        DiagnosticsProperty<bool>("accordion", accordion, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>("border", border, defaultValue: true));
    super.debugFillProperties(properties);
  }
}

/// FlanRow 共享信息
class FlanCollapseProvider<T extends dynamic> extends InheritedWidget {
  const FlanCollapseProvider({
    required this.toggle,
    required this.isExpanded,
    required this.child,
  }) : super(child: child);

  final void Function(T name, bool expanded) toggle;
  final bool Function(T name) isExpanded;
  final Column child;

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static FlanCollapseProvider<T>? of<T>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FlanCollapseProvider<T>>();
  }

  @override
  bool updateShouldNotify(covariant FlanCollapseProvider<T> oldWidget) {
    return true;
  }
}
