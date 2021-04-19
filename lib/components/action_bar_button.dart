// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../mixins/route_mixins.dart';
import '../styles/var.dart';
import 'action_bar.dart';
import 'button.dart';

/// ### ActionBarButton 动作栏按钮
class FlanActionBarButton extends RouteStatelessWidget {
  const FlanActionBarButton({
    Key? key,
    this.text = '',
    this.color,
    this.gradient,
    this.type = FlanButtonType.normal,
    this.iconName,
    this.iconUrl,
    this.disabled = false,
    this.loading = false,
    this.height,
    this.onClick,
    this.child,
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

  /// 按钮颜色
  final Color? color;

  /// 渐变色
  final Gradient? gradient;

  /// 图标名称
  final FlanButtonType type;

  /// 图标名称
  final IconData? iconName;

  /// 图标访问链接
  final String? iconUrl;

  /// 是否禁用按钮
  final bool disabled;

  /// 是否显示为加载状态
  final bool loading;

  /// 高度
  final double? height;

  // ****************** Events ******************

  /// 点击事件
  final VoidCallback? onClick;

  // ****************** Slots ******************
  /// 子元素
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final FlanActionBar? parent =
        context.findAncestorWidgetOfExactType<FlanActionBar>();

    if (parent == null) {
      throw 'ActionButton must be a child component of FlanActionBar';
    }
    final int index = parent.children.indexOf(this);
    final bool isFirst = !(index != 0 &&
        parent.children.elementAt(index - 1) is FlanActionBarButton);
    final bool isLast = !(index != parent.children.length - 1 &&
        parent.children.elementAt(index + 1) is FlanActionBarButton);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: isFirst ? 5.0 : 0.0,
          right: isLast ? 5.0 : 0.0,
        ),
        child: SizedBox(
          height: height ?? ThemeVars.actionBarButtonHeight,
          child: FlanButton(
            radius: BorderRadius.horizontal(
              left: isFirst
                  ? const Radius.circular(ThemeVars.borderRadiusMax)
                  : Radius.zero,
              right: isLast
                  ? const Radius.circular(ThemeVars.borderRadiusMax)
                  : Radius.zero,
            ),
            size: FlanButtonSize.large,
            type: type,
            iconName: iconName,
            iconUrl: iconUrl,
            color: color,
            gradient: gradient ??
                (type == FlanButtonType.danger
                    ? ThemeVars.actionBarButtonDangerColor
                    : type == FlanButtonType.warning
                        ? ThemeVars.actionBarButtonWarningColor
                        : null),
            loading: loading,
            disabled: disabled,
            onClick: () {
              route(context);
              if (onClick != null) {
                onClick!();
              }
            },
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: ThemeVars.fontSizeMd,
                fontWeight: ThemeVars.fontWeightBold,
              ),
              child: child ?? Text(text),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('text', text));
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties.add(DiagnosticsProperty<Gradient>('gradient', gradient));
    properties.add(DiagnosticsProperty<FlanButtonType>('type', type,
        defaultValue: FlanButtonType.normal));
    properties.add(DiagnosticsProperty<IconData>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('loading', loading, defaultValue: false));

    super.debugFillProperties(properties);
  }
}
