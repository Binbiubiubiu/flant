import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../mixins/route_mixins.dart';
import '../styles/components/action_bar_theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'action_bar.dart';
import 'button.dart';

/// ### ActionBarButton 动作栏按钮
class FlanActionBarButton extends FlanRouteStatelessWidget {
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
    final FlanActionBar? parent = FlanActionBarScope.of(context)?.parent;
    if (parent == null) {
      throw 'ActionButton must be a child component of FlanActionBar';
    }
    final int index = parent.children.indexOf(this);
    final bool isFirst = !(index > 0 &&
        parent.children.elementAt(index - 1) is FlanActionBarButton);
    final bool isLast = !(index < parent.children.length - 1 &&
        parent.children.elementAt(index + 1) is FlanActionBarButton);

    final FlanActionBarThemeData themeData = FlanActionBarTheme.of(context);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: isFirst ? 5.0 : 0.0,
          right: isLast ? 5.0 : 0.0,
        ),
        child: SizedBox(
          height: height ?? themeData.buttonHeight,
          child: FlanButton(
            radius: BorderRadius.horizontal(
              left: isFirst
                  ? Radius.circular(FlanThemeVars.borderRadiusMax.rpx)
                  : Radius.zero,
              right: isLast
                  ? Radius.circular(FlanThemeVars.borderRadiusMax.rpx)
                  : Radius.zero,
            ),
            size: FlanButtonSize.large,
            type: type,
            iconName: iconName,
            iconUrl: iconUrl,
            color: color,
            gradient: gradient ??
                <FlanButtonType, Gradient>{
                  FlanButtonType.danger: themeData.buttonDangerColor,
                  FlanButtonType.warning: themeData.buttonWarningColor,
                }[type],
            loading: loading,
            disabled: disabled,
            onClick: () {
              route(context);
              onClick?.call();
            },
            child: DefaultTextStyle.merge(
              style: TextStyle(
                fontSize: FlanThemeVars.fontSizeMd.rpx,
                fontWeight: FlanThemeVars.fontWeightBold,
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
