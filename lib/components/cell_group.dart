// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/var.dart';
import 'cell.dart';

/// ### FlanCellGroup 单元格组
class FlanCellGroup extends StatelessWidget {
  const FlanCellGroup({
    Key? key,
    this.title,
    this.border = false,
    this.children = const <FlanCell>[],
    this.titleSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 分组标题
  final String? title;

  /// 是否显示外边框
  final bool border;

  // ****************** Events ******************

  // ****************** Slots ******************
  /// 默认插槽
  final List<FlanCell> children;

  /// 自定义分组标题
  final Widget? titleSlot;

  @override
  Widget build(BuildContext context) {
    final List<Widget> cells = <Widget>[];
    if (children.isNotEmpty) {
      const Divider line = Divider(
        height: 0.5,
        indent: ThemeVars.cellHorizontalPadding,
        endIndent: ThemeVars.cellHorizontalPadding,
      );
      for (int i = 0; i < children.length; i++) {
        if (i > 0) {
          cells.add(line);
        }
        cells.add(children[i]);
      }
    }

    Widget group = Container(
      decoration: const BoxDecoration(
        color: ThemeVars.cellGroupBackgroundColor,
        border: Border(
          bottom: BorderSide(width: 0.5, color: ThemeVars.cellBorderColor),
          top: BorderSide(width: 0.5, color: ThemeVars.cellBorderColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cells,
      ),
    );

    if (_hasTitle) {
      group = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(),
          group,
        ],
      );
    }

    return Semantics(
      container: true,
      child: Material(
        child: group,
      ),
    );
  }

  /// 是否有标题
  bool get _hasTitle => title != null || titleSlot != null;

  /// 构建标题
  Widget _buildTitle() {
    return Padding(
      padding: ThemeVars.cellGroupTitlePadding,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: ThemeVars.cellGroupTitleColor,
          fontSize: ThemeVars.cellGroupTitleFontSize,
          height: ThemeVars.cellGroupTitleLineHeight /
              ThemeVars.cellGroupTitleFontSize,
        ),
        child: titleSlot ?? Text(title ?? ''),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('title', title));
    properties
        .add(DiagnosticsProperty<bool>('border', border, defaultValue: false));
    super.debugFillProperties(properties);
  }
}
