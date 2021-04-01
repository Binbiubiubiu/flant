// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

// 🌎 Project imports:
import 'package:flant/components/badge.dart';
import 'package:flant/components/icon.dart';
import 'package:flant/mixins/route_mixins.dart';
import 'package:flant/styles/icons.dart';
import '../styles/var.dart';

/// ### ActionBarIcon 动作栏图标按钮
class FlanActionBarIcon extends RouteStatelessWidget {
  const FlanActionBarIcon({
    Key? key,
    this.text = '',
    this.iconName,
    this.iconUrl,
    this.color,
    this.dot = false,
    this.badge,
    this.onClick,
    this.child,
    this.iconSlot,
    String? toName,
    PageRoute<Object?>? toRoute,
    bool replace = false,
  }) : super(
          key: key,
          toName: toName,
          toRoute: toRoute,
          replace: replace,
        );

  // ****************** Props ******************
  /// 按钮文字
  final String text;

  /// 图标名称
  final int? iconName;

  /// 图标链接
  final String? iconUrl;

  /// 图标颜色
  final Color? color;

  /// 是否显示图标右上角小红点
  final bool dot;

  /// 图标右上角徽标的内容
  final String? badge;

  // ****************** Events ******************

  final VoidCallback? onClick;

  // ****************** Slots ******************
  /// 子元素
  final Widget? child;

  /// 图标插槽
  final Widget? iconSlot;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      sortKey: const OrdinalSortKey(0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: ThemeVars.actionBarIconWidth - 2.0,
        ),
        child: Material(
          color: ThemeVars.white,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: ThemeVars.black.withOpacity(0.1),
            onTap: () {
              route(context);
              if (onClick != null) {
                onClick!();
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildIcon(),
                const SizedBox(height: 5.0),
                DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ThemeVars.actionBarIconTextColor,
                    fontSize: ThemeVars.actionBarIconFontSize,
                    height: 1.0,
                  ),
                  child: child ?? Text(text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (iconSlot != null) {
      return FlanBadge(
        dot: dot,
        content: badge,
        child: iconSlot,
      );
    }

    return FlanIcon(
      dot: dot,
      badge: badge,
      iconName: iconName,
      iconUrl: iconUrl,
      color: color ?? ThemeVars.actionBarIconColor,
      size: ThemeVars.actionBarIconSize,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('text', text));
    properties.add(DiagnosticsProperty<int>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties.add(DiagnosticsProperty<bool>('dot', dot, defaultValue: false));
    properties.add(DiagnosticsProperty<String>('badge', badge));

    super.debugFillProperties(properties);
  }
}
