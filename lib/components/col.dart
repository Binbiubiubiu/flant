import 'package:flant/components/row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './row.dart' show FlanRowProvider;

/// ### FlanCol 列布局
class FlanCol extends StatelessWidget {
  const FlanCol({
    Key? key,
    this.offset,
    this.span = 0.0,
    this.children = const <Widget>[],
  }) : super(key: key);

  // ****************** Props ******************
  /// 列元素偏移距离
  final double? offset;

  /// 列元素宽度
  final double span;

  // ****************** Events ******************

  // ****************** Slots ******************
  // 内容
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final FlanRowProvider? parent = FlanRowProvider.of(context);

    BoxConstraints? colSpan;
    EdgeInsets? colOffset;
    EdgeInsets colPadding = EdgeInsets.zero;
    if (parent != null) {
      final List<RowSpace> spaces = parent.spaces;
      final int index = (parent.child as Wrap).children.indexOf(this);

      colPadding = EdgeInsets.only(
        left: spaces[index].left,
        right: spaces[index].right,
      );

      colSpan = BoxConstraints.tightFor(
        width: parent.maxWidth * (span / 24),
      );

      if (offset != null) {
        colOffset = EdgeInsets.only(left: parent.maxWidth * (offset! / 24));
      }
    }

    return Container(
      constraints: colSpan,
      margin: colOffset,
      padding: colPadding,
      child: Wrap(
        children: children,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<double>('offset', offset));
    properties
        .add(DiagnosticsProperty<double>('span', span, defaultValue: 0.0));
    super.debugFillProperties(properties);
  }
}
