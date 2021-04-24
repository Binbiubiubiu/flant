// 🐦 Flutter imports:
import 'package:flant/components/common/active_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/mouse_cursor.dart';

// 🌎 Project imports:
import '../mixins/route_mixins.dart';
import '../styles/button_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'icon.dart';
import 'loading.dart';

/// ### FlanButton 按钮
/// 用于触发一个操作，如提交表单
class FlanButton extends RouteStatelessWidget {
  const FlanButton({
    Key? key,
    this.type = FlanButtonType.normal,
    this.size = FlanButtonSize.normal,
    this.text = '',
    this.color,
    this.gradient,
    this.iconName,
    this.iconUrl,
    this.iconPosition = FlanButtonIconPosition.left,
    this.block = false,
    this.plain = false,
    this.round = false,
    this.square = false,
    this.hairline = false,
    this.disabled = false,
    this.loading = false,
    this.border = true,
    this.textColor,
    this.loadingText = '',
    this.loadingType = FlanLoadingType.circular,
    this.loadingSize,
    this.radius,
    this.onClick,
    this.child,
    this.loadingSlot,
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
  /// 类型，可选值为 `primary` `info` `warning` `danger`
  final FlanButtonType type;

  // 尺寸，可选值为 `large` `small` `mini`
  final FlanButtonSize size;

  /// 按钮文字
  final String text;

  /// 按钮颜色，
  final Color? color;

  /// 按钮颜色(支持传入 linear-gradient 渐变色)
  final Gradient? gradient;

  /// 左侧图标名称
  final IconData? iconName;

  /// 左侧图片链接
  final String? iconUrl;

  /// 图标展示位置，可选值为 `right`
  final FlanButtonIconPosition iconPosition;

  /// 是否为块级元素
  final bool block;

  /// 是否为朴素按钮
  final bool plain;

  /// 是否为圆形按钮
  final bool round;

  /// 是否为方形按钮
  final bool square;

  /// 是否使用 0.5px 边框
  final bool hairline;

  /// 是否禁用按钮
  final bool disabled;

  /// 是否显示为加载状态
  final bool loading;

  /// 是否有边框
  final bool border;

  /// 加载状态提示文字
  final String loadingText;

  /// 加载图标类型，可选值为 `spinner`
  final FlanLoadingType loadingType;

  /// 加载图标大小
  final double? loadingSize;

  /// 圆角大小
  final BorderRadius? radius;

  /// 文字颜色
  final Color? textColor;

  // ****************** Events ******************
  /// 点击按钮，且按钮状态不为加载或禁用时触发
  final GestureTapCallback? onClick;

  // ****************** Slots ******************
  /// 按钮内容
  final Widget? child;

  /// 自定义加载图标
  final Widget? loadingSlot;

  @override
  Widget build(BuildContext context) {
    final FlanButtonThemeData themeData = FlanTheme.of(context).buttonTheme;

    final _FlanButtonSize _btnSize = _getBtnSize(themeData);
    final _FlanButtonTheme _themeType = _getThemeType(themeData);

    final BorderRadius radius = this.radius ??
        (square
            ? BorderRadius.zero
            : BorderRadius.circular(
                round ? _btnSize.height / 2.0 : themeData.borderRadius,
              ));

    final TextStyle textStyle = TextStyle(
      fontSize: _btnSize.fontSize,
      // height: ThemeVars.buttonDefaultLineHeight /
      //     ThemeVars.buttonDefaultFontSize,
      color: textColor ?? _themeType.color,
    );

    final Color bgColor = (plain ? null : color) ?? _themeType.backgroundColor;

    final Widget? sideIcon = _buildIcon(themeData, _themeType);

    final Widget _btn = DefaultTextStyle(
      style: textStyle,
      child: FlanActiveResponse(
        disabled: disabled || loading,
        cursorBuilder: (SystemMouseCursor cursor) =>
            loading ? SystemMouseCursors.basic : cursor,
        onClick: () {
          if (onClick != null) {
            onClick!();
          }
          route(context);
        },
        builder: (BuildContext contenxt, bool active) {
          return Container(
            decoration: BoxDecoration(
              border: _themeType.border,
              borderRadius: radius,
              gradient: color != null ? null : gradient,
              color: bgColor,
            ),
            height: _btnSize.height,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: _btnSize.padding,
                  child: _buildContent(sideIcon),
                ),
                Positioned.fill(
                  child: RepaintBoundary(
                    child: IgnorePointer(
                      ignoring: true,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: radius,
                          color:
                              ThemeVars.black.withOpacity(active ? 0.1 : 0.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return Semantics(
      container: true,
      button: true,
      enabled: !disabled,
      child: Opacity(
        opacity: disabled ? 0.5 : 1.0,
        child: _btn,
      ),
    );
  }

  /// 构建图标
  Widget? _buildIcon(
    FlanButtonThemeData themeData,
    _FlanButtonTheme _themeType,
  ) {
    if (loading) {
      return loadingSlot ??
          FlanLoading(
            size: loadingSize ?? themeData.loadingIconSize,
            type: loadingType,
            color: textColor ?? _themeType.color,
          );
    }

    if (iconName != null || iconUrl != null) {
      return FlanIcon(
        iconName: iconName,
        iconUrl: iconUrl,
        color: _themeType.color,
        size: themeData.iconSize,
      );
    }
  }

  /// 构建内容
  Widget _buildContent(Widget? sideIcon) {
    final List<Widget> children = <Widget>[
      if (loading) Text(loadingText) else child ?? Text(text),
    ];

    if (sideIcon != null) {
      switch (iconPosition) {
        case FlanButtonIconPosition.left:
          if (_isHasText) {
            children.insert(0, SizedBox(width: 4.0.rpx));
          }
          children.insert(0, sideIcon);
          break;
        case FlanButtonIconPosition.right:
          if (_isHasText) {
            children.add(SizedBox(width: 4.0.rpx));
          }
          children.add(sideIcon);
          break;
      }
    }

    if (size == FlanButtonSize.large || block) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    }

    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );
  }

  /// 计算按钮样式
  _FlanButtonTheme _computedThemeType(
    FlanButtonThemeData themeData, {
    required Color backgroundColor,
    required Color color,
    required Color borderColor,
  }) {
    if (this.color != null) {
      borderColor = this.color!;
      color = Colors.white;
    }

    if (gradient != null) {
      borderColor = Colors.transparent;
      color = Colors.white;
    }

    BorderSide borderSide = BorderSide.none;
    if (border) {
      borderSide = BorderSide(
        width: hairline ? 0.5 : themeData.borderWidth,
        color: borderColor,
      );
    }

    return _FlanButtonTheme(
      backgroundColor: plain ? themeData.plainBackgroundColor : backgroundColor,
      color: plain ? borderColor : color,
      border: Border.fromBorderSide(borderSide),
    );
  }

  /// 按钮是否有内容
  bool get _isHasText => text.isNotEmpty || child != null;

  /// 按钮大小集合
  _FlanButtonSize _getBtnSize(FlanButtonThemeData themeData) {
    switch (size) {
      case FlanButtonSize.large:
        return _FlanButtonSize(
          fontSize: themeData.defaultFontSize,
          height: themeData.largeHeight,
          padding: EdgeInsets.zero, //themeData.normalPadding,
        );

      case FlanButtonSize.normal:
        return _FlanButtonSize(
          fontSize: themeData.normalFontSize,
          height: themeData.defaultHeight,
          padding: themeData.normalPadding,
        );

      case FlanButtonSize.small:
        return _FlanButtonSize(
          fontSize: themeData.smallFontSize,
          height: themeData.smallHeight,
          padding: themeData.smallPadding,
        );

      case FlanButtonSize.mini:
        return _FlanButtonSize(
          fontSize: themeData.miniFontSize,
          height: themeData.miniHeight,
          padding: themeData.miniPadding,
        );
    }
  }

  /// 按钮样式集合
  _FlanButtonTheme _getThemeType(FlanButtonThemeData themeData) {
    switch (type) {
      case FlanButtonType.primary:
        return _computedThemeType(
          themeData,
          backgroundColor: themeData.primaryBackgroundColor,
          color: themeData.primaryColor,
          borderColor: themeData.primaryBorderColor,
        );
      case FlanButtonType.success:
        return _computedThemeType(
          themeData,
          backgroundColor: themeData.successBackgroundColor,
          color: themeData.successColor,
          borderColor: themeData.successBorderColor,
        );
      case FlanButtonType.danger:
        return _computedThemeType(
          themeData,
          backgroundColor: themeData.dangerBackgroundColor,
          color: themeData.dangerColor,
          borderColor: themeData.dangerBorderColor,
        );
      case FlanButtonType.warning:
        return _computedThemeType(
          themeData,
          backgroundColor: themeData.warningBackgroundColor,
          color: themeData.warningColor,
          borderColor: themeData.warningBorderColor,
        );
      case FlanButtonType.normal:
        return _computedThemeType(
          themeData,
          backgroundColor: themeData.defaultBackgroundColor,
          color: themeData.defaultColor,
          borderColor: themeData.defaultBorderColor,
        );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('text', text, defaultValue: ''));
    properties.add(DiagnosticsProperty<IconData>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties
        .add(DiagnosticsProperty<bool>('block', block, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('plain', plain, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('round', round, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('square', square, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('loading', loading, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('hairline', hairline, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties.add(DiagnosticsProperty<FlanButtonType>('type', type,
        defaultValue: FlanButtonType.normal));
    properties.add(DiagnosticsProperty<FlanButtonSize>('size', size,
        defaultValue: FlanButtonSize.normal));
    properties.add(DiagnosticsProperty<double>('loadingSize', loadingSize));
    properties.add(DiagnosticsProperty<FlanButtonIconPosition>(
        'iconPosition', iconPosition,
        defaultValue: FlanButtonIconPosition.left));
    properties.add(DiagnosticsProperty<BorderRadius>('radius', radius));
    super.debugFillProperties(properties);
  }
}

/// 按钮主题样式类
class _FlanButtonTheme {
  _FlanButtonTheme({
    required this.color,
    required this.backgroundColor,
    this.border,
  }) : super();

  final Color backgroundColor;
  final Color color;
  final Border? border;
}

/// 按钮大小样式类
class _FlanButtonSize {
  _FlanButtonSize({
    required this.fontSize,
    required this.height,
    required this.padding,
  }) : super();

  final double fontSize;
  final double height;
  final EdgeInsets padding;
}

/// 按钮类型
enum FlanButtonType {
  normal,
  primary,
  success,
  warning,
  danger,
}

/// 按钮大小
enum FlanButtonSize {
  large,
  normal,
  small,
  mini,
}

/// 图标展示位置
enum FlanButtonIconPosition {
  left,
  right,
}
