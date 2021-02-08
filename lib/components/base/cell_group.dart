import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
import '../../styles/var.dart';
import './cell.dart';

/// ### FlanCellGroup 单元格组
class FlanCellGroup extends StatelessWidget {
  const FlanCellGroup({
    Key key,
    this.title,
    this.border = false,
    this.children,
    this.titleSlot,
  })  : assert(border != null),
        super(key: key);

  // ****************** Props ******************
  /// 分组标题
  final String title;

  /// 是否显示外边框
  final bool border;

  // ****************** Events ******************

  // ****************** Slots ******************
  /// 默认插槽
  final List<Widget> children;

  /// 自定义分组标题
  final Widget titleSlot;

  @override
  Widget build(BuildContext context) {
    final noBottonBorder = this.children?.last is FlanCell;

    Widget group = Container(
      decoration: BoxDecoration(
        color: ThemeVars.cellGroupBackgroundColor,
        border: Border(
          bottom: noBottonBorder
              ? BorderSide.none
              : BorderSide(width: 0.5, color: ThemeVars.cellBorderColor),
          top: BorderSide(width: 0.5, color: ThemeVars.cellBorderColor),
        ),
      ),
      child: this.children != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: this.children,
            )
          : null,
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
        child: this.titleSlot ?? Text(this.title),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>("title", title));
    properties.add(DiagnosticsProperty<bool>("border", border));
    super.debugFillProperties(properties);
  }
}
