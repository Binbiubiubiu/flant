// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import './col.dart';

/// ### FlanRow 行布局
class FlanRow extends StatelessWidget {
  const FlanRow({
    Key? key,
    this.wrap = true,
    this.gutter = 0.0,
    this.justify = FlanRowJustify.start,
    this.align = FlanRowAlign.top,
    this.children = const <Widget>[],
  }) : super(key: key);

  // ****************** Props ******************
  /// 列元素之间的间距
  final double gutter;

  /// Flex 主轴对齐方式，可选值为 `start` `end` `center` `spaceAround` `spaceBetween`
  final FlanRowJustify justify;

  /// Flex 交叉轴对齐方式，可选值为 `top` `bottom` `center`
  final FlanRowAlign align;

  /// 是否自动换行
  final bool wrap;

  // ****************** Events ******************

  // ****************** Slots ******************
  // 内容
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (wrap) {
      content = FractionallySizedBox(
        widthFactor: 1.0,
        child: Wrap(
          alignment: _wrapJustify,
          runAlignment: _wrapAlign,
          children: children,
        ),
      );
    } else {
      content = Row(
        mainAxisAlignment: _rowJustify,
        crossAxisAlignment: _rowAlign,
        children: children,
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return FlanRowProvider(
          maxWidth: constraints.maxWidth,
          child: content,
        );
      },
    );
  }

  MainAxisAlignment get _rowJustify {
    switch (justify) {
      case FlanRowJustify.start:
        return MainAxisAlignment.start;
      case FlanRowJustify.center:
        return MainAxisAlignment.center;
      case FlanRowJustify.end:
        return MainAxisAlignment.end;
      case FlanRowJustify.spaceAround:
        return MainAxisAlignment.spaceAround;
      case FlanRowJustify.spaceBetween:
        return MainAxisAlignment.spaceBetween;
    }
  }

  CrossAxisAlignment get _rowAlign {
    switch (align) {
      case FlanRowAlign.top:
        return CrossAxisAlignment.start;
      case FlanRowAlign.center:
        return CrossAxisAlignment.center;
      case FlanRowAlign.bottom:
        return CrossAxisAlignment.end;
    }
  }

  WrapAlignment get _wrapJustify {
    switch (justify) {
      case FlanRowJustify.start:
        return WrapAlignment.start;
      case FlanRowJustify.center:
        return WrapAlignment.center;
      case FlanRowJustify.end:
        return WrapAlignment.end;
      case FlanRowJustify.spaceAround:
        return WrapAlignment.spaceAround;
      case FlanRowJustify.spaceBetween:
        return WrapAlignment.spaceBetween;
    }
  }

  WrapAlignment get _wrapAlign {
    switch (align) {
      case FlanRowAlign.top:
        return WrapAlignment.start;
      case FlanRowAlign.center:
        return WrapAlignment.center;
      case FlanRowAlign.bottom:
        return WrapAlignment.end;
    }
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
    properties.add(DiagnosticsProperty<FlanRowJustify>(
        'MainAxisAlignment', justify,
        defaultValue: MainAxisAlignment.start));
    properties.add(DiagnosticsProperty<FlanRowAlign>(
        'CrossAxisAlignment', align,
        defaultValue: CrossAxisAlignment.start));
    super.debugFillProperties(properties);
  }
}

/// Flex 主轴对齐方式，可选值为 `start` `end` `center` `spaceAround` `spaceBetween`
class RowSpace {
  const RowSpace({
    this.left = 0.0,
    this.right = 0.0,
  });

  final double left;
  final double right;
}

/// Flex 交叉轴对齐方式，可选值为 `top` `bottom` `center`
enum FlanRowJustify {
  start,
  center,
  end,
  spaceAround,
  spaceBetween,
}

/// 垂直布局
enum FlanRowAlign {
  top,
  center,
  bottom,
}

class FlanRowProvider extends InheritedWidget {
  const FlanRowProvider({
    Key? key,
    required this.maxWidth,
    required Widget child,
  }) : super(key: key, child: child);

  final double maxWidth;

  static FlanRowProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlanRowProvider>();
  }

  @override
  bool updateShouldNotify(FlanRowProvider oldWidget) {
    return maxWidth != oldWidget.maxWidth;
  }
}
