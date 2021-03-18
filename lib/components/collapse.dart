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
        color: Colors.white,
        border: Border(
          bottom: border ? const FlanHairLine() : BorderSide.none,
        ),
      ),
      child: FlanCollapseProvider<String>(
        toggle: toggle,
        isExpanded: isExpanded,
        child: Column(
          children: children,
        ),
      ),
    );
  }

  void updateName(dynamic name) {
    onChange(name as T);
  }

  void toggle(String name, bool expanded) {
    if (accordion) {
      updateName(name == value ? '' : name);
    } else if (expanded) {
      updateName(<String>[...value as List<String>, name]);
    } else {
      updateName((value as List<String>)
          .where((String activeName) => activeName != name)
          .toList());
    }
  }

  bool isExpanded(String name) {
    if (accordion && value is List<String>) {
      throw 'FlanCollapse: value should not be Array in accordion mode';
    }

    // ignore: prefer_is_not_operator
    if (!accordion && !(value is List<String>)) {
      throw 'FlanCollapse: value should be Array in non-accordion mode';
    }

    return accordion ? value == name : (value as List<String>).contains(name);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<T>('value', value));
    properties.add(
        DiagnosticsProperty<bool>('accordion', accordion, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('border', border, defaultValue: true));
    super.debugFillProperties(properties);
  }
}

/// FlanRow 共享信息
class FlanCollapseProvider<T extends dynamic> extends InheritedWidget {
  const FlanCollapseProvider({
    required this.toggle,
    required this.isExpanded,
    required Column child,
  }) : super(child: child);

  final void Function(T name, bool expanded) toggle;
  final bool Function(T name) isExpanded;

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