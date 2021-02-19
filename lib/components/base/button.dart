import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../styles/var.dart';
import './icon.dart';
import '../../mixins/route_mixins.dart';

/// ### FlanButton 按钮
/// 用于触发一个操作，如提交表单
class FlanButton extends RouteStatelessWidget {
  const FlanButton({
    Key key,
    this.type = FlanButtonType.normal,
    this.size = FlanButtonSize.normal,
    this.text,
    this.color,
    this.gradient,
    this.iconName,
    this.iconUrl,
    this.iconPrefix = kFlanIconsFamily,
    this.iconPosition = FlanButtonIconPosition.left,
    this.block = false,
    this.plain = false,
    this.round = false,
    this.square = false,
    this.hairline = false,
    this.disabled = false,
    this.loading = false,
    this.loadingText,
    this.loadingType,
    this.loadingSize = 20.0,
    this.onClick,
    this.onTouchStart,
    this.child,
    this.loadingSlot,
    String toName,
    PageRoute toRoute,
    bool replace = false,
  })  : assert(type != null && type is FlanButtonType),
        assert(size != null && size is FlanButtonSize),
        assert(iconPrefix != null),
        assert(iconPosition != null && iconPosition is FlanButtonIconPosition),
        assert(block != null),
        assert(plain != null),
        assert(round != null),
        assert(square != null),
        assert(hairline != null),
        assert(disabled != null),
        assert(loading != null),
        assert(loadingSize != null && loadingSize > 0.0),
        super(
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
  final Color color;

  /// 按钮颜色(支持传入 linear-gradient 渐变色)
  final Gradient gradient;

  /// 左侧图标名称
  final int iconName;

  /// 左侧图片链接
  final String iconUrl;

  /// 图标类名前缀，同 Icon 组件的 class-prefix 属性
  final String iconPrefix;

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

  /// 加载状态提示文字
  final String loadingText;

  /// 加载图标类型，可选值为 `spinner`
  final double loadingType;

  /// 加载图标大小
  final double loadingSize;

  // ****************** Events ******************
  /// 点击按钮，且按钮状态不为加载或禁用时触发
  final GestureTapCallback onClick;

  /// 开始触摸按钮时触发
  final GestureTapDownCallback onTouchStart;

  // ****************** Slots ******************
  /// 按钮内容
  final Widget child;

  /// 自定义加载图标
  final Widget loadingSlot;

  @override
  Widget build(BuildContext context) {
    final radius = this.square
        ? BorderRadius.zero
        : BorderRadius.circular(
            this.round ? _btnSize.height / 2.0 : ThemeVars.buttonBorderRadius,
          );

    final textStyle = TextStyle(
      fontSize: this._btnSize.fontSize,
      // height: ThemeVars.buttonDefaultLineHeight /
      //     ThemeVars.buttonDefaultFontSize,
      color: this._themeType.color,
    );

    final bgColor =
        (this.plain ? null : this.color) ?? this._themeType.backgroundColor;

    Widget _btn = Material(
      type: MaterialType.button,
      textStyle: textStyle,
      color: bgColor,
      borderRadius: radius,
      child: Ink(
        decoration: BoxDecoration(
          border: this._themeType.border,
          borderRadius: radius,
          gradient: this.gradient,
        ),
        height: this._btnSize.height,
        child: InkWell(
          borderRadius: radius,
          splashColor: Colors.transparent,
          highlightColor: ThemeVars.black.withOpacity(0.1),
          onTapDown: this.onTouchStart,
          onTap: this.disabled
              ? null
              : () {
                  if (this.onClick != null) {
                    this.onClick();
                  }
                  this.route(context);
                },
          child: Padding(
            padding: this._btnSize.padding,
            child: this._buildContent(),
          ),
        ),
      ),
    );

    if (this.disabled) {
      _btn = Opacity(
        opacity: .5,
        child: _btn,
      );
    }

    return Semantics(
      container: true,
      button: true,
      enabled: !this.disabled,
      child: _btn,
    );
  }

  // 构建按钮文本
  Widget _buildText() {
    if (this.loading && this.loadingText != null) {
      return Text(this.loadingText);
    }

    if (this.child != null) {
      return this.child;
    }

    return Text(this.text ?? "");
  }

  /// 构建图标
  Widget _buildIcon() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final iSize = DefaultTextStyle.of(context).style.fontSize * 1.2;

      if (this.loading) {
        return FlanIcon.name(
          FlanIcons.circle,
          color: this._themeType.color,
          size: iSize,
        );
      }

      if (this.iconName != null || this.iconUrl != null) {
        return FlanIcon(
          iconName: this.iconName,
          iconUrl: this.iconUrl,
          color: this._themeType.color,
          size: 18.0,
          classPrefix: this.iconPrefix,
        );
      }

      return SizedBox();
    });
  }

  /// 构建内容
  Widget _buildContent() {
    var children = [
      this._buildText(),
    ];

    var sideIcon = this._buildIcon();

    switch (this.iconPosition) {
      case FlanButtonIconPosition.left:
        if (this._isHasText) {
          children.insert(0, const SizedBox(width: 4.0));
        }
        children.insert(0, sideIcon);
        break;
      case FlanButtonIconPosition.right:
        children.add(sideIcon);
        if (this._isHasText) {
          children.add(const SizedBox(width: 4.0));
        }
        break;
      default:
        break;
    }

    if (this.size == FlanButtonSize.large || this.block) {
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
  _FlanButtonTheme _computedThemeType({
    Color backgroundColor,
    Color color,
    Color borderColor,
  }) {
    if (this.color != null) {
      borderColor = this.color;
      color = Colors.white;
    }

    if (this.gradient != null) {
      borderColor = Colors.transparent;
      color = Colors.white;
    }
    return _FlanButtonTheme(
      backgroundColor:
          this.plain ? ThemeVars.buttonPlainBackgroundColor : backgroundColor,
      color: this.plain ? borderColor : color,
      border: Border.all(
        width: this.hairline ? 0.5 : ThemeVars.buttonBorderWidth,
        color: borderColor,
      ),
    );
  }

  // bool get isBtnEnable => !this.disabled && this.onPressed != null;
  /// 按钮是否有内容
  bool get _isHasText =>
      (this.text != null && this.text.isNotEmpty) || this.child != null;

  /// 按钮大小集合
  _FlanButtonSize get _btnSize {
    switch (this.size) {
      case FlanButtonSize.large:
        return _FlanButtonSize(
          fontSize: ThemeVars.buttonDefaultFontSize,
          height: ThemeVars.buttonLargeHeight,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
        );

      case FlanButtonSize.normal:
        return _FlanButtonSize(
          fontSize: ThemeVars.buttonNormalFontSize,
          height: ThemeVars.buttonDefaultHeight,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
        );

      case FlanButtonSize.small:
        return _FlanButtonSize(
          fontSize: ThemeVars.buttonSmallFontSize,
          height: ThemeVars.buttonSmallHeight,
          padding: EdgeInsets.symmetric(horizontal: ThemeVars.paddingSm),
        );

      case FlanButtonSize.mini:
        return _FlanButtonSize(
          fontSize: ThemeVars.buttonMiniFontSize,
          height: ThemeVars.buttonMiniHeight,
          padding: EdgeInsets.symmetric(horizontal: ThemeVars.paddingBase),
        );
    }
  }

  /// 按钮样式集合
  _FlanButtonTheme get _themeType {
    switch (this.type) {
      case FlanButtonType.primary:
        return this._computedThemeType(
          backgroundColor: ThemeVars.buttonPrimaryBackgroundColor,
          color: ThemeVars.buttonPrimaryColor,
          borderColor: ThemeVars.buttonPrimaryBorderColor,
        );
      case FlanButtonType.success:
        return this._computedThemeType(
          backgroundColor: ThemeVars.buttonSuccessBackgroundColor,
          color: ThemeVars.buttonSuccessColor,
          borderColor: ThemeVars.buttonSuccessBorderColor,
        );
      case FlanButtonType.danger:
        return this._computedThemeType(
          backgroundColor: ThemeVars.buttonDangerBackgroundColor,
          color: ThemeVars.buttonDangerColor,
          borderColor: ThemeVars.buttonDangerBorderColor,
        );
      case FlanButtonType.warning:
        return this._computedThemeType(
          backgroundColor: ThemeVars.buttonWarningBackgroundColor,
          color: ThemeVars.buttonWarningColor,
          borderColor: ThemeVars.buttonWarningBorderColor,
        );
      case FlanButtonType.normal:
        return this._computedThemeType(
          backgroundColor: ThemeVars.buttonDefaultBackgroundColor,
          color: ThemeVars.buttonDefaultColor,
          borderColor: ThemeVars.buttonDefaultBorderColor,
        );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>("text", text, defaultValue: ""));
    properties.add(DiagnosticsProperty<int>("iconName", iconName));
    properties.add(DiagnosticsProperty<String>("iconUrl", iconUrl));
    properties.add(DiagnosticsProperty<Color>("color", color));
    properties
        .add(DiagnosticsProperty<bool>("block", block, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>("plain", plain, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>("round", round, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>("square", square, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>("loading", loading, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>("hairline", hairline, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>("disabled", disabled, defaultValue: false));
    properties.add(DiagnosticsProperty<FlanButtonType>("type", type,
        defaultValue: FlanButtonType.normal));
    properties.add(DiagnosticsProperty<FlanButtonSize>("size", size,
        defaultValue: FlanButtonSize.normal));
    properties.add(DiagnosticsProperty<double>("loadingSize", loadingSize,
        defaultValue: 10.0));
    properties.add(DiagnosticsProperty<FlanButtonIconPosition>(
        "iconPosition", iconPosition,
        defaultValue: FlanButtonIconPosition.left));
    super.debugFillProperties(properties);
  }
}

/// 按钮主题样式类
class _FlanButtonTheme {
  _FlanButtonTheme({
    this.color,
    this.backgroundColor,
    this.border,
  }) : super();

  final Color backgroundColor;
  final Color color;
  final Border border;
}

/// 按钮大小样式类
class _FlanButtonSize {
  _FlanButtonSize({
    this.fontSize,
    this.height,
    this.padding,
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
