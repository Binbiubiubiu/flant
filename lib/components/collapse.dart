// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'collapse_item.dart';
import 'style.dart';

/// ### FlanCollapse 折叠面板
/// 将一组内容放置在多个折叠面板中，点击面板的标题可以展开或收缩其内容。
class FlanCollapse extends StatelessWidget {
  const FlanCollapse({
    Key? key,
    required this.value,
    required this.onChange,
    this.accordion = false,
    this.border = true,
    required this.children,
  })  : assert(value is String || value is List<String>),
        super(key: key);

  // ****************** Props ******************
  /// 当前展开面板的 `name`
  final dynamic value;

  /// 是否开启手风琴模式
  final bool accordion;

  /// 是否显示外边框
  final bool border;

  // ****************** Events ******************

  final ValueChanged<dynamic> onChange;

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
      child: FlanCollapseScope(
        parent: this,
        child: Column(
          children: children,
        ),
      ),
    );
  }

  void updateName(dynamic name) {
    onChange(name);
  }

  void toggle(String name, bool expanded) {
    if (accordion) {
      updateName(value == name ? '' : name);
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

    if (!accordion && value is! List<String>) {
      throw 'FlanCollapse: value should be Array in non-accordion mode';
    }

    return accordion ? value == name : (value as List<String>).contains(name);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<dynamic>('value', value));
    properties.add(
        DiagnosticsProperty<bool>('accordion', accordion, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('border', border, defaultValue: true));
    super.debugFillProperties(properties);
  }
}

class FlanCollapseScope extends InheritedWidget {
  const FlanCollapseScope({
    Key? key,
    required this.parent,
    required Widget child,
  }) : super(key: key, child: child);

  final FlanCollapse parent;

  static FlanCollapseScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlanCollapseScope>();
  }

  @override
  bool updateShouldNotify(FlanCollapseScope oldWidget) {
    return parent != oldWidget.parent;
  }
}
