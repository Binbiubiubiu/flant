import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './col.dart';

/// ### FlanRow 行布局
class FlanRow extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Wrap(
        alignment: justify,
        runAlignment: align,
        children: children,
      ),
    );
  }

  /// 获取组信息
  List<List<int>> get groups {
    final List<List<int>> groups = <List<int>>[<int>[]];
    double totalSpan = 0;
    for (int i = 0; i < children.length; i++) {
      final Widget child = children[i];
      totalSpan += child is FlanCol ? child.span : 0.0;

      if (totalSpan > 24.0) {
        groups.add(<int>[i]);
        totalSpan -= 24;
      } else {
        groups[groups.length - 1].add(i);
      }
    }

    return groups;
  }

  /// 获取空间信息
  List<RowSpace> get spaces {
    final List<RowSpace> spaces = <RowSpace>[];

    for (final List<int> group in groups) {
      final double averagePadding =
          (gutter * (group.length - 1)) / group.length;

      for (int index = 0; index < group.length; index++) {
        if (index == 0) {
          spaces.add(RowSpace(right: averagePadding));
        } else {
          final int item = group[index];
          final double left = gutter - spaces[item - 1].right;
          final double right = averagePadding - left;
          spaces.add(RowSpace(left: left, right: right));
        }
      }
    }

    return spaces;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('gutter', gutter, defaultValue: 0.0));
    properties.add(DiagnosticsProperty<WrapAlignment>(
        'MainAxisAlignment', justify,
        defaultValue: MainAxisAlignment.start));
    properties.add(DiagnosticsProperty<WrapAlignment>(
        'CrossAxisAlignment', align,
        defaultValue: CrossAxisAlignment.start));
    super.debugFillProperties(properties);
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
