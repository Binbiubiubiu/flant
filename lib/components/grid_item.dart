import 'package:flant/components/grid.dart';
import 'package:flant/components/icon.dart';
import 'package:flant/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';

import '../mixins/route_mixins.dart';
import '../styles/var.dart';
import 'badge.dart';

class FlanGridItem extends RouteStatelessWidget {
  const FlanGridItem({
    Key? key,
    this.text,
    this.iconName,
    this.iconUrl,
    this.iconPrefix = kFlanIconsFamily,
    this.dot = false,
    this.badge,
    this.onClick,
    this.child,
    this.iconSlot,
    this.textSlot,
    bool replace = false,
    String? toName,
    PageRoute? toRoute,
  }) : super(key: key, replace: replace, toName: toName, toRoute: toRoute);

  // ****************** Props ******************
  /// 列元素偏移距离
  final String? text;

  /// 列元素宽度
  final int? iconName;

  final String? iconUrl;

  final String iconPrefix;

  final bool dot;

  final String? badge;

  // ****************** Events ******************

  /// 	点击格子时触发
  final VoidCallback? onClick;

  // ****************** Slots ******************
  /// 自定义宫格的所有内容
  final Widget? child;

  /// 自定义图标
  final Widget? iconSlot;

  /// 自定义文字
  final Widget? textSlot;

  @override
  Widget build(BuildContext context) {
    final parent = FlanGridProvider.of(context);
    if (parent == null) {
      throw 'GridItem must be a child widget of Grid';
    }

    final index = parent.child.children.indexOf(this);

    final size = 1 / parent.columnNum * parent.maxWidth;

    final surround = parent.border && parent.gutter > 0.0;
    final border = parent.border
        ? Border(
            right: FlanHairLine(),
            bottom: FlanHairLine(),
            left: surround ? FlanHairLine() : BorderSide.none,
            top: surround ? FlanHairLine() : BorderSide.none,
          )
        : null;

    return Container(
      width: size,
      height: parent.square ? size : null,
      padding: EdgeInsets.only(right: parent.gutter),
      margin: EdgeInsets.only(
        top: index >= parent.columnNum ? parent.gutter : 0,
      ),
      child: Semantics(
        button: parent.clickable,
        sortKey: parent.clickable ? OrdinalSortKey(0.0) : null,
        child: Material(
          type: parent.clickable ? MaterialType.button : MaterialType.canvas,
          color: ThemeVars.gridItemContentBackgroundColor,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: ThemeVars.gridItemContentActiveColor,
            onTap: parent.clickable
                ? () {
                    route(context);
                    if (onClick != null) {
                      onClick!();
                    }
                  }
                : null,
            child: Container(
              padding: ThemeVars.gridItemContentPadding,
              decoration: BoxDecoration(border: border),
              child: Flex(
                mainAxisAlignment: parent.center
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: parent.center
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                direction: parent.direction,
                children: this._buildContext(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final parent = FlanGridProvider.of(context)!;

    if (this.iconSlot != null) {
      return FlanBadge(dot: dot, content: badge, child: iconSlot);
    }

    if (iconName != null || iconUrl != null) {
      return FlanIcon(
        dot: dot,
        iconName: iconName,
        iconUrl: iconUrl,
        size: parent.iconSize ?? ThemeVars.gridItemIconSize,
        badge: badge,
        classPrefix: iconPrefix,
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildText(BuildContext context) {
    if (textSlot != null) {
      return textSlot!;
    }

    if (text != null) {
      return Text(text!);
    }

    return SizedBox.shrink();
  }

  List<Widget> _buildContext(BuildContext context) {
    if (child != null) {
      return [child!];
    }

    return [
      _buildIcon(context),
      SizedBox(width: ThemeVars.paddingXs, height: ThemeVars.paddingXs),
      DefaultTextStyle(
        style: TextStyle(
          color: ThemeVars.gridItemTextColor,
          fontSize: ThemeVars.gridItemTextFontSize,
          height: 1.5,
        ),
        child: _buildText(context),
      ),
    ];
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>("text", text));
    properties.add(DiagnosticsProperty<int>("iconName", iconName));
    properties.add(DiagnosticsProperty<String>("iconUrl", iconUrl));
    properties.add(DiagnosticsProperty<String>("iconPrefix", iconPrefix));
    properties.add(DiagnosticsProperty<bool>("dot", dot, defaultValue: false));
    properties.add(DiagnosticsProperty<String>("badge", badge));
    super.debugFillProperties(properties);
  }
}
