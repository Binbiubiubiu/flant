import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// ### IndexBar 索引栏
class FlanIndexBar extends StatelessWidget {
  const FlanIndexBar({
    Key? key,
    this.highlightColor,
    this.sticky = true,
    this.stickyOffsetTop = 0.0,
    this.indexList = kDefaultIndexList,
    this.onSelect,
    this.onChange,
    this.children = const <Widget>[],
  }) : super(key: key);

  // ****************** Props ******************
  /// 索引字符高亮颜色
  final Color? highlightColor;

  /// 是否开启锚点自动吸顶
  final bool sticky;

  /// 锚点自动吸顶时与顶部的距离
  final double stickyOffsetTop;

  /// 索引字符列表
  final List<String> indexList;

  // ****************** Events ******************
  /// 点击索引栏的字符时触发
  final ValueChanged<String>? onSelect;

  /// 当前高亮的索引字符变化时触发
  final ValueChanged<String>? onChange;

  // ****************** Slots ******************
  /// 内容
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: children,
        )
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<Color>('highlightColor', highlightColor));
    properties
        .add(DiagnosticsProperty<bool>('sticky', sticky, defaultValue: true));

    properties.add(DiagnosticsProperty<double>(
        'stickyOffsetTop', stickyOffsetTop,
        defaultValue: kDefaultIndexList));

    properties.add(DiagnosticsProperty<List<String>>('indexList', indexList,
        defaultValue: 0.0));

    super.debugFillProperties(properties);
  }
}

const List<String> kDefaultIndexList = <String>[
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
