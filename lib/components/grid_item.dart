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
    PageRoute<Object?>? toRoute,
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
    final FlanGridProvider? parent = FlanGridProvider.of(context);
    if (parent == null) {
      throw 'GridItem must be a child widget of Grid';
    }

    final int index = (parent.child as Wrap).children.indexOf(this);

    final double size = 1 / parent.grid.columnNum * parent.maxWidth;

    final bool surround = parent.grid.border && parent.grid.gutter > 0.0;
    final Border? border = parent.grid.border
        ? Border(
            right: const FlanHairLine(),
            bottom: const FlanHairLine(),
            left: surround ? const FlanHairLine() : BorderSide.none,
            top: surround ? const FlanHairLine() : BorderSide.none,
          )
        : null;

    return Container(
      width: size,
      height: parent.grid.square ? size : null,
      padding: EdgeInsets.only(right: parent.grid.gutter),
      margin: EdgeInsets.only(
        top: index >= parent.grid.columnNum ? parent.grid.gutter : 0,
      ),
      child: Semantics(
        button: parent.grid.clickable,
        sortKey: parent.grid.clickable ? const OrdinalSortKey(0.0) : null,
        child: Material(
          type:
              parent.grid.clickable ? MaterialType.button : MaterialType.canvas,
          color: ThemeVars.gridItemContentBackgroundColor,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: ThemeVars.gridItemContentActiveColor,
            onTap: parent.grid.clickable
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
                mainAxisAlignment: parent.grid.center
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: parent.grid.center
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                direction: parent.grid.direction,
                children: _buildContext(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final FlanGridProvider parent = FlanGridProvider.of(context)!;

    if (iconSlot != null) {
      return FlanBadge(dot: dot, content: badge, child: iconSlot);
    }

    if (iconName != null || iconUrl != null) {
      return FlanIcon(
        dot: dot,
        iconName: iconName,
        iconUrl: iconUrl,
        size: parent.grid.iconSize ?? ThemeVars.gridItemIconSize,
        badge: badge,
        classPrefix: iconPrefix,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildText(BuildContext context) {
    if (textSlot != null) {
      return textSlot!;
    }

    if (text != null) {
      return Text(text!);
    }

    return const SizedBox.shrink();
  }

  List<Widget> _buildContext(BuildContext context) {
    if (child != null) {
      return <Widget>[child!];
    }

    return <Widget>[
      _buildIcon(context),
      const SizedBox(width: ThemeVars.paddingXs, height: ThemeVars.paddingXs),
      DefaultTextStyle(
        style: const TextStyle(
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
    properties.add(DiagnosticsProperty<String>('text', text));
    properties.add(DiagnosticsProperty<int>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    properties.add(DiagnosticsProperty<String>('iconPrefix', iconPrefix));
    properties.add(DiagnosticsProperty<bool>('dot', dot, defaultValue: false));
    properties.add(DiagnosticsProperty<String>('badge', badge));
    super.debugFillProperties(properties);
  }
}
