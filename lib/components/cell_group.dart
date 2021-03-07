import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
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
    List<Widget> cells = [];
    if (this.children.length > 0) {
      final line = Divider(
        height: 0.5,
        indent: ThemeVars.cellHorizontalPadding,
        endIndent: ThemeVars.cellHorizontalPadding,
      );
      for (var i = 0; i < this.children.length; i++) {
        if (i > 0) {
          cells.add(line);
        }
        cells.add(this.children[i]);
      }
    }

    Widget group = Container(
      decoration: BoxDecoration(
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

    if (this._hasTitle) {
      group = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          this._buildTitle(),
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
  bool get _hasTitle => this.title != null || this.titleSlot != null;

  /// 构建标题
  Widget _buildTitle() {
    return Padding(
      padding: ThemeVars.cellGroupTitlePadding,
      child: DefaultTextStyle(
        style: TextStyle(
          color: ThemeVars.cellGroupTitleColor,
          fontSize: ThemeVars.cellGroupTitleFontSize,
          height: ThemeVars.cellGroupTitleLineHeight /
              ThemeVars.cellGroupTitleFontSize,
        ),
        child: this.titleSlot ?? Text(this.title ?? ""),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>("title", title));
    properties
        .add(DiagnosticsProperty<bool>("border", border, defaultValue: false));
    super.debugFillProperties(properties);
  }
}
