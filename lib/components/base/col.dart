import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../styles/var.dart';

class FlanCol extends StatelessWidget {
  const FlanCol({
    Key key,
    this.offset,
    this.span,
    this.onClick,
    this.children,
  }) : super(key: key);

  // ****************** Props ******************
  /// 列元素偏移距离
  final double offset;

  /// 列元素宽度
  final double span;

  // ****************** Events ******************
  /// 点击单元格时触发
  final GestureTapCallback onClick;

  // ****************** Slots ******************
  // 内容
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement debugFillProperties
    super.debugFillProperties(properties);
  }
}
