// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 🌎 Project imports:
import '../styles/components/sidebar_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import 'badge.dart';
import 'common/active_response.dart';
import 'sidebar.dart';

class FlanSidebarItem extends StatelessWidget {
  const FlanSidebarItem({
    Key? key,
    this.title = '',
    this.dot = false,
    this.badge = '',
    this.disabled = false,
    this.padding,
    this.onClick,
    this.titleSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 内容
  final String title;

  /// 是否显示右上角小红点
  final bool dot;

  /// 图标右上角徽标的内容
  final String badge;

  /// 是否禁用该项
  final bool disabled;

  /// 内边距
  final EdgeInsets? padding;

  // ****************** Events ******************
  /// 点击时触发
  final ValueChanged<int>? onClick;

  // ****************** Slots ******************
  /// 自定义标题
  final Widget? titleSlot;

  @override
  Widget build(BuildContext context) {
    final FlanSidebar? parent = FlanSidebarScope.of(context)?.parent;
    if (parent == null) {
      throw 'FlanSidebarItem must be a child Widget of FlanSidebar';
    }

    final int index = parent.children.indexOf(this);
    final bool selected = index == parent.getActive();

    final FlanSidebarThemeData themeData = FlanTheme.of(context).sidebarTheme;

    final Widget borderRight = Positioned.fill(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Visibility(
          visible: selected,
          child: Container(
            width: themeData.selectedBorderWidth,
            height: themeData.selectedBorderHeight,
            color: themeData.selectedBorderColor,
          ),
        ),
      ),
    );

    void _onClick() {
      if (disabled) {
        return;
      }

      onClick?.call(index);

      parent.setActive(index);
    }

    return Stack(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: FlanActiveResponse(
            disabled: disabled,
            builder: (BuildContext contenxt, bool active, Widget? child) {
              final Color bgColor = selected
                  ? themeData.selectedBackgroundColor
                  : active
                      ? themeData.activeColor
                      : themeData.backgroundColor;

              final Color textColor = disabled
                  ? themeData.disabledTextColor
                  : selected
                      ? themeData.selectedTextColor
                      : themeData.textColor;
              return DefaultTextStyle(
                style: TextStyle(
                  fontSize: themeData.fontSize,
                  height: themeData.lineHeight,
                  color: textColor,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: padding ?? themeData.padding,
                  color: bgColor,
                  child: child,
                ),
              );
            },
            onClick: _onClick,
            child: FlanBadge(
              dot: dot,
              content: badge,
              child: titleSlot ??
                  Text(title,
                      textHeightBehavior: FlanThemeVars.textHeightBehavior),
            ),
          ),
        ),
        borderRight,
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<String>('title', title, defaultValue: ''));
    properties.add(DiagnosticsProperty<bool>('dot', dot, defaultValue: false));
    properties
        .add(DiagnosticsProperty<String>('badge', badge, defaultValue: ''));
    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding));
    super.debugFillProperties(properties);
  }
}
