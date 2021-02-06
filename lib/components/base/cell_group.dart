import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
import 'package:flant/styles/var.dart';

import './cell.dart';

class FlanCellGroup extends StatelessWidget {
  const FlanCellGroup({
    Key key,
    this.title,
    this.border = false,
    this.children = const [],
    this.titleSlot,
  }) : super(key: key);

  final String title;
  final bool border;
  final List<Widget> children;

  // slot

  final Widget titleSlot;

  bool get hasTitle => this.title != null || this.titleSlot != null;

  @override
  Widget build(BuildContext context) {
    final noBottonBorder = this.children.last is FlanCell;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.children,
      ),
    );

    if (this.hasTitle) {
      group = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          this.buildTitle(),
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

  Widget buildTitle() {
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
}
