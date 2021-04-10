// 🐦 Flutter imports:
import 'package:flant/components/sidebar.dart';
import 'package:flant/mixins/route_mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/components/button.dart';
import 'package:flant/flant.dart';
import 'package:flutter/rendering.dart';
import '../styles/var.dart';

class FlanSidebarItem extends RouteStatelessWidget {
  const FlanSidebarItem({
    Key? key,
    this.title = '',
    this.dot = false,
    this.badge,
    this.disabled = false,
    this.onClick,
    this.titleSlot,
    String? toName,
    PageRoute<Object?>? toRoute,
    bool replace = false,
  }) : super(key: key, toName: toName, toRoute: toRoute, replace: replace);

  // ****************** Props ******************
  /// 内容
  final String title;

  /// 是否显示右上角小红点
  final bool dot;

  /// 图标右上角徽标的内容
  final String? badge;

  /// 是否禁用该项
  final bool disabled;

  // ****************** Events ******************
  /// 点击时触发
  final ValueChanged<int>? onClick;

  // ****************** Slots ******************
  /// 自定义标题
  final Widget? titleSlot;

  @override
  Widget build(BuildContext context) {
    final FlanSidebar? parent =
        context.findAncestorWidgetOfExactType<FlanSidebar>();
    if (parent == null) {
      throw 'FlanSidebarItem must be a child Widget of FlanSidebar';
    }

    final int index = parent.children.indexOf(this);
    final bool selected = index == parent.getActive();

    return _SideBarItemButton(
      selected: selected,
      disabled: disabled,
      onClick: () {
        if (disabled) {
          return;
        }

        if (onClick != null) {
          onClick!(index);
        }
        parent.setActive(index);
        route(context);
      },
      child: FlanBadge(
        dot: dot,
        content: badge,
        child: titleSlot ?? Text(title),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}

class _SideBarItemButton extends StatefulWidget {
  const _SideBarItemButton({
    Key? key,
    this.selected = false,
    this.disabled = false,
    this.onClick,
    required this.child,
  }) : super(key: key);

  final bool selected;
  final bool disabled;

  final VoidCallback? onClick;

  final Widget child;

  @override
  _SideBarItemButtonState createState() => _SideBarItemButtonState();
}

class _SideBarItemButtonState extends State<_SideBarItemButton> {
  bool isPressed = false;

  void doActive() {
    setState(() => isPressed = true);
  }

  void doDisActive() {
    setState(() => isPressed = false);
  }

  Color get bgColor => widget.disabled
      ? ThemeVars.sidebarBackgroundColor
      : widget.selected
          ? ThemeVars.sidebarSelectedBackgroundColor
          : isPressed
              ? ThemeVars.sidebarActiveColor
              : ThemeVars.sidebarBackgroundColor;

  Color get textColor => widget.disabled
      ? ThemeVars.sidebarDisabledTextColor
      : widget.selected
          ? ThemeVars.sidebarSelectedTextColor
          : ThemeVars.sidebarTextColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.disabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.forbidden,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: ThemeVars.sidebarFontSize,
          height: ThemeVars.sidebarLineHeight / ThemeVars.sidebarFontSize,
          color: textColor,
        ),
        child: GestureDetector(
          onTapDown: (TapDownDetails e) => doActive(),
          onTapCancel: () => doDisActive(),
          onTapUp: (TapUpDetails e) => doDisActive(),
          onTap: widget.onClick,
          child: Stack(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Container(
                  color: bgColor,
                  alignment: Alignment.centerLeft,
                  padding: ThemeVars.sidebarPadding,
                  child: widget.child,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Visibility(
                    visible: widget.selected,
                    child: Container(
                      width: ThemeVars.sidebarSelectedBorderWidth,
                      height: ThemeVars.sidebarSelectedBorderHeight,
                      color: ThemeVars.sidebarSelectedBorderColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
