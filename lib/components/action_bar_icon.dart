// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../mixins/route_mixins.dart';
import '../styles/components/action_bar_theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'badge.dart';
import 'common/active_response.dart';
import 'icon.dart';

/// ### ActionBarIcon 动作栏图标按钮
class FlanActionBarIcon extends FlanRouteStatelessWidget {
  const FlanActionBarIcon({
    Key? key,
    this.text = '',
    this.iconName,
    this.iconUrl,
    this.color,
    this.dot = false,
    this.badge = '',
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
  final IconData? iconName;

  /// 图标链接
  final String? iconUrl;

  /// 图标颜色
  final Color? color;

  /// 是否显示图标右上角小红点
  final bool dot;

  /// 图标右上角徽标的内容
  final String badge;

  // ****************** Events ******************

  final VoidCallback? onClick;

  // ****************** Slots ******************
  /// 子元素
  final Widget? child;

  /// 图标插槽
  final Widget? iconSlot;

  @override
  Widget build(BuildContext context) {
    final FlanActionBarThemeData themeData = FlanActionBarTheme.of(context);

    return Semantics(
      button: true,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: FlanActiveResponse(
                builder: (BuildContext contenxt, bool active, Widget? child) {
                  return Container(
                    height: themeData.iconHeight,
                    color:
                        active ? themeData.iconActiveColor : Colors.transparent,
                  );
                },
                onClick: () {
                  route(context);
                  onClick?.call();
                },
              ),
            ),
          ),
          IgnorePointer(
            child: Container(
              constraints: BoxConstraints(
                minWidth: themeData.iconWidth - 2.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildIcon(),
                  SizedBox(height: 5.0.rpx),
                  DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeData.iconTextColor,
                      fontSize: themeData.iconFontSize,
                      height: 1.0,
                    ),
                    child: child ?? Text(text),
                  ),
                ],
              ),
            ),
          ),
        ],
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
    properties.add(DiagnosticsProperty<IconData>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties.add(DiagnosticsProperty<bool>('dot', dot, defaultValue: false));
    properties.add(DiagnosticsProperty<String>('badge', badge));

    super.debugFillProperties(properties);
  }
}
