// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/components/style.dart';
import 'grid_item.dart';

class FlanGrid extends StatelessWidget {
  const FlanGrid({
    Key? key,
    this.columnNum = 4,
    this.iconSize,
    this.gutter = 0.0,
    this.border = true,
    this.center = true,
    this.square = false,
    this.clickable = false,
    this.direction = Axis.vertical,
    this.children = const <FlanGridItem>[],
  }) : super(key: key);

  // ****************** Props ******************
  /// 列数
  final int columnNum;

  /// 图标大小
  final double? iconSize;

  /// 格子之间的间距
  final double gutter;

  /// 是否显示边框
  final bool border;

  /// 是否将格子内容居中显示
  final bool center;

  /// 是否将格子固定为正方形
  final bool square;

  /// 是否开启格子点击反馈
  final bool clickable;

  /// 格子内容排列的方向，可选值为 `horizontal` `vertical`
  final Axis direction;

  // ****************** Events ******************

  // ****************** Slots ******************
  // 内容
  final List<FlanGridItem> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: border && gutter == 0.0 ? const FlanHairLine() : BorderSide.none,
        ),
      ),
      padding: EdgeInsets.only(left: gutter),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: children,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<int>('columnNum', columnNum, defaultValue: 4));
    properties.add(
        DiagnosticsProperty<double>('iconSize', iconSize, defaultValue: 28.0));
    properties
        .add(DiagnosticsProperty<double>('gutter', gutter, defaultValue: 0.0));
    properties
        .add(DiagnosticsProperty<bool>('border', border, defaultValue: true));
    properties
        .add(DiagnosticsProperty<bool>('center', center, defaultValue: true));
    properties
        .add(DiagnosticsProperty<bool>('square', square, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('clickable', clickable, defaultValue: false));
    properties.add(DiagnosticsProperty<Axis>('direction', direction,
        defaultValue: Axis.vertical));
    super.debugFillProperties(properties);
  }
}
