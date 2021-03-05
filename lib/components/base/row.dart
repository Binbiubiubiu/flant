import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './col.dart';

/// ### FlanRow 行布局
class FlanRow extends StatefulWidget {
  const FlanRow({
    Key? key,
    this.gutter = 0.0,
    this.justify = WrapAlignment.start,
    this.align = WrapAlignment.start,
    this.children = const <Widget>[],
  }) : super(key: key);

  // ****************** Props ******************
  /// 列元素之间的间距
  final double gutter;

  /// Flex 主轴对齐方式，可选值为 `start` `bottom` `center` `spaceAround` `spaceBetween` `spaceEvenly`
  final WrapAlignment justify;

  /// Flex 交叉轴对齐方式，可选值为 `start` `bottom` `center` `spaceAround` `spaceBetween` `spaceEvenly`
  final WrapAlignment align;

  // ****************** Events ******************

  // ****************** Slots ******************
  // 内容
  final List<Widget> children;

  @override
  _FlanRowState createState() => _FlanRowState();
}

class _FlanRowState extends State<FlanRow> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return FlanRowProvider(
            spaces: this.spaces,
            maxWidth: constraints.maxWidth,
            child: Wrap(
              alignment: this.widget.justify,
              runAlignment: this.widget.align,
              children: this.widget.children,
            ),
          );
        },
      ),
    );
  }

  /// 获取组信息
  List<List<int>> get groups {
    final List<List<int>> groups = [[]];
    double totalSpan = 0;
    for (int i = 0; i < this.widget.children.length; i++) {
      final child = this.widget.children[i];
      totalSpan += (child is FlanCol ? child.span : 0.0);

      if (totalSpan > 24.0) {
        groups.add([i]);
        totalSpan -= 24;
      } else {
        groups[groups.length - 1].add(i);
      }
    }

    return groups;
  }

  /// 获取空间信息
  List<RowSpace> get spaces {
    final List<RowSpace> spaces = [];

    if (this.widget.gutter == null) {
      return spaces;
    }

    this.groups.forEach((group) {
      final double averagePadding =
          (this.widget.gutter * (group.length - 1)) / group.length;

      for (int index = 0; index < group.length; index++) {
        if (index == 0) {
          spaces.add(RowSpace(right: averagePadding));
        } else {
          final item = group[index];
          final double left = this.widget.gutter - spaces[item - 1].right;
          final double right = averagePadding - left;
          spaces.add(RowSpace(left: left, right: right));
        }
      }
    });

    return spaces;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<double>("gutter", widget.gutter,
        defaultValue: 0.0));
    properties.add(DiagnosticsProperty<WrapAlignment>(
        "MainAxisAlignment", widget.justify,
        defaultValue: MainAxisAlignment.start));
    properties.add(DiagnosticsProperty<WrapAlignment>(
        "CrossAxisAlignment", widget.align,
        defaultValue: CrossAxisAlignment.start));
    super.debugFillProperties(properties);
  }
}

/// FlanRow 共享信息
class FlanRowProvider extends InheritedWidget {
  const FlanRowProvider({
    required this.spaces,
    required this.maxWidth,
    required this.child,
  }) : super(child: child);

  final List<RowSpace> spaces;
  final double maxWidth;
  final Wrap child;

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static FlanRowProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlanRowProvider>();
  }

  @override
  bool updateShouldNotify(covariant FlanRowProvider oldWidget) {
    return oldWidget.spaces != spaces;
  }
}

/// 水平间隔
class RowSpace {
  const RowSpace({
    this.left = 0.0,
    this.right = 0.0,
  });

  final double left;
  final double right;
}
