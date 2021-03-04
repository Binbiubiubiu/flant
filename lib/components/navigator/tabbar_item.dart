import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../styles/var.dart';
import '../base/style.dart';
import '../base/icon.dart';
import '../show/badge.dart';
import './tabbar.dart';

typedef FlanTabbarItemSlotBuilder = Widget Function(
    BuildContext context, bool active);

class FlanTabbarItem<T extends dynamic> extends StatelessWidget {
  const FlanTabbarItem({
    Key key,
    this.name,
    this.iconName,
    this.iconUrl,
    this.iconPrefix = kFlanIconsFamily,
    this.dot = false,
    this.badge,
    this.url,
    this.textBuilder,
    this.iconBuilder,
    this.onClick,
    String toName,
    bool replace,
  })  : assert(iconPrefix != null),
        assert(dot != null),
        super(key: key);

  // ****************** Props ******************
  /// 标签名称，作为匹配的标识符
  final T name;

  /// 图标名称
  final int iconName;

  /// 图片链接
  final String iconUrl;

  /// 图标类名前缀
  final String iconPrefix;

  /// 是否显示图标右上角小红点
  final bool dot;

  /// 图标右上角徽标的内容
  final String badge;

  /// 点击后跳转的链接地址
  final String url;

  // ****************** Events ******************

  final VoidCallback onClick;

  // ****************** Slots ******************

  /// 默认内容
  final FlanTabbarItemSlotBuilder textBuilder;

  /// 自定义图标
  final FlanTabbarItemSlotBuilder iconBuilder;

  @override
  Widget build(BuildContext context) {
    final parent = FlanTabbarProvider.of(context);

    if (parent == null) {
      throw 'TabbarItem must be a child component of Tabbar.';
    }
    final index = parent.child.children
        .indexWhere((element) => (element as Expanded).child == this);

    final active = (this.name ?? index) == parent.value;

    final color = active
        ? (parent.activeColor ?? ThemeVars.tabbarItemActiveColor)
        : (parent.inactiveColor ?? ThemeVars.tabbarItemTextColor);

    Widget customIcon =
        (this.iconBuilder != null ? this.iconBuilder(context, active) : null);
    if (customIcon != null && !(customIcon is FlanIcons)) {
      customIcon = SizedBox(height: 20.0, child: customIcon);
    }

    final iconWidget = IconTheme(
      data: IconThemeData(
        color: color,
        size: ThemeVars.tabbarItemIconSize,
      ),
      child: customIcon ??
          FlanIcon(
            iconName: this.iconName,
            iconUrl: this.iconUrl,
            classPrefix: this.iconPrefix,
          ),
    );

    return GestureDetector(
      onTap: () {
        parent.setActive(name ?? index);
        if (this.onClick != null) {
          this.onClick();
        }
      },
      child: Material(
        textStyle: TextStyle(
          color: color,
          fontSize: ThemeVars.tabbarItemFontSize,
          height: ThemeVars.tabbarItemLineHeight,
        ),
        color: Colors.transparent,
        child: Ink(
          height: ThemeVars.tabbarHeight,
          decoration: BoxDecoration(border: Border(top: FlanHairLine())),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ThemeVars.paddingBase),
              FlanBadge(
                dot: this.dot,
                content: this.badge,
                child: iconWidget,
              ),
              SizedBox(height: ThemeVars.tabbarItemMarginBottom),
              this.textBuilder != null
                  ? this.textBuilder(context, active)
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement debugFillProperties
    super.debugFillProperties(properties);
  }
}
