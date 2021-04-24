// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/cell_group_theme.dart';
import '../styles/theme.dart';
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
    final FlanCellGroupThemeData themeData =
        FlanTheme.of(context).cellGroupTheme;

    Widget group = Container(
      decoration: BoxDecoration(
        color: themeData.backgroundColor,
        border: const Border(
          bottom: BorderSide(width: 0.5, color: FlanThemeVars.cellBorderColor),
          top: BorderSide(width: 0.5, color: FlanThemeVars.cellBorderColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );

    if (_hasTitle) {
      group = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(themeData),
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
  Widget _buildTitle(FlanCellGroupThemeData themeData) {
    return Padding(
      padding: themeData.titlePadding,
      child: DefaultTextStyle(
        style: TextStyle(
          color: themeData.titleColor,
          fontSize: themeData.titleFontSize,
          height: themeData.titleLineHeight / themeData.titleFontSize,
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
