import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../styles/components/tabbar_theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'badge.dart';
import 'icon.dart';
import 'style.dart';
import 'tabbar.dart';

typedef FlanTabbarItemSlotBuilder = Widget Function(
    BuildContext context, bool active);

class FlanTabbarItem extends StatelessWidget {
  const FlanTabbarItem({
    Key? key,
    this.name,
    this.iconName,
    this.iconUrl,
    this.dot = false,
    this.badge = '',
    this.textBuilder,
    this.iconBuilder,
    this.onClick,
  }) : super(key: key);

  // ****************** Props ******************
  /// 标签名称，作为匹配的标识符
  final String? name;

  /// 图标名称
  final IconData? iconName;

  /// 图片链接
  final String? iconUrl;

  /// 是否显示图标右上角小红点
  final bool dot;

  /// 图标右上角徽标的内容
  final String badge;

  // ****************** Events ******************

  final VoidCallback? onClick;

  // ****************** Slots ******************

  /// 默认内容
  final FlanTabbarItemSlotBuilder? textBuilder;

  /// 自定义图标
  final FlanTabbarItemSlotBuilder? iconBuilder;

  @override
  Widget build(BuildContext context) {
    final FlanTabbarThemeData themeData = FlanTabbarTheme.of(context);
    final FlanTabbar? parent = FlanTabbarScope.of(context)?.parent;

    if (parent == null) {
      throw 'TabbarItem must be a child component of Tabbar.';
    }
    final int index =
        parent.children.indexWhere((Widget element) => element == this);

    final bool active = (name ?? index.toString()) == parent.value;

    final Color color = active
        ? (parent.activeColor ?? themeData.itemActiveColor)
        : (parent.inactiveColor ?? themeData.itemTextColor);

    Widget? customIcon;
    if (iconBuilder != null) {
      customIcon = iconBuilder!(context, active);
    }
    if (iconName != null || iconUrl != null) {
      customIcon = FlanIcon(
        iconName: iconName,
        iconUrl: iconUrl,
      );
    }

    final IconTheme iconWidget = IconTheme(
      data: IconThemeData(
        color: color,
        size: themeData.itemIconSize,
      ),
      child: Container(
        height: 20.0.rpx,
        constraints: BoxConstraints.tightFor(width: 20.0.rpx),
        child: customIcon,
      ),
    );

    return Expanded(
      child: GestureDetector(
        onTap: () {
          parent.setActive(name ?? index.toString());

          onClick?.call();
        },
        child: DefaultTextStyle(
          style: TextStyle(
            color: color,
            fontSize: themeData.itemFontSize,
            height: themeData.itemLineHeight,
          ),
          child: Container(
            height: themeData.height,
            decoration: const BoxDecoration(
              border: Border(top: FlanHairLine()),
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: FlanThemeVars.paddingBase.rpx),
                FlanBadge(
                  dot: dot,
                  content: badge,
                  child: iconWidget,
                ),
                SizedBox(height: themeData.itemMarginBottom),
                if (textBuilder != null) textBuilder!(context, active),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('name', name));
    properties.add(DiagnosticsProperty<IconData>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    properties.add(DiagnosticsProperty<bool>('dot', dot, defaultValue: false));
    properties.add(DiagnosticsProperty<String>('badge', badge));
    super.debugFillProperties(properties);
  }
}
