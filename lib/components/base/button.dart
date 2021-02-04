import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flant/styles/var.dart';

enum FlanButtonType {
  normal,
  primary,
  success,
  warning,
  danger,
}

enum FlanButtonSize {
  large,
  normal,
  small,
  mini,
}

enum FlanButtonIconPosition {
  left,
  right,
}

class FlanButton extends StatelessWidget {
  FlanButton({
    Key key,
    @required this.onPressed,
    this.text = "",
    this.icon,
    this.color,
    // this.gradient,
    this.block = false,
    this.plain = false,
    this.round = false,
    this.square = false,
    this.loading = false,
    this.hairline = false,
    this.disabled = false,
    // this.iconPrefix,
    // this.loadingText,
    this.type = FlanButtonType.normal,
    this.size = FlanButtonSize.normal,
    this.loadingSize = 10.0,
    this.iconPosition = FlanButtonIconPosition.left,
    this.child,
  })  : assert(text != null),
        assert(block != null),
        assert(plain != null),
        assert(round != null),
        assert(square != null),
        assert(loading != null),
        assert(hairline != null),
        assert(disabled != null),
        assert(type != null && FlanButtonType.values.contains(type)),
        assert(size != null && FlanButtonSize.values.contains(size)),
        assert(loadingSize != null),
        assert(onPressed != null),
        assert(iconPosition != null &&
            FlanButtonIconPosition.values.contains(iconPosition)),
        super(key: key);

  final String text;
  final IconData icon;
  final dynamic color;
  // final Gradient gradient;
  final bool block;
  final bool plain;
  final bool round;
  final bool square;
  final bool loading;
  final bool hairline;
  final bool disabled;

  // TODO: 支持iconfont
  // final String iconPrefix;
  // final String loadingText;

  final FlanButtonType type;
  final FlanButtonSize size;
  final double loadingSize;
  final FlanButtonIconPosition iconPosition;

  final VoidCallback onPressed;
  final Widget child;

  Widget renderText() {
    return child ?? Text(text);
  }

  Widget renderIcon() {
    return loading
        ? Icon(
            Icons.run_circle,
            color: this.themeType.color,
          )
        : Icon(
            icon,
            color: this.themeType.color,
          );
  }

  Widget renderContent() {
    var children = [
      this.renderText(),
    ];

    var icon = this.loading || this.icon != null ? this.renderIcon() : null;

    if (icon == null) {
      return children[0];
    }
    switch (iconPosition) {
      case FlanButtonIconPosition.left:
        if (this.isHasText) {
          children.insert(0, const SizedBox(width: 4.0));
        }
        children.insert(0, icon);
        break;
      case FlanButtonIconPosition.right:
        children.add(icon);
        if (this.isHasText) {
          children.add(const SizedBox(width: 4.0));
        }
        break;
      default:
        break;
    }
    return Row(
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final radius = this.square
        ? BorderRadius.zero
        : BorderRadius.circular(
            this.round ? btnSize.height / 2.0 : ThemeVars.buttonBorderRadius,
          );

    final textStyle = TextStyle(
      fontSize: this.btnSize.fontSize,
      // height: ThemeVars.buttonDefaultLineHeight /
      //     ThemeVars.buttonDefaultFontSize,
      color: this.themeType.color,
    );

    final bgColor =
        (this.plain ? null : (this.color is Gradient ? null : this.color)) ??
            this.themeType.backgroundColor;

    Widget _btn = Material(
      type: MaterialType.button,
      textStyle: textStyle,
      color: bgColor,
      borderRadius: radius,
      child: Ink(
        decoration: BoxDecoration(
          border: this.themeType.border,
          borderRadius: radius,
          gradient: this.color is Gradient ? this.color : null,
        ),
        height: this.btnSize.height,
        child: InkWell(
          borderRadius: radius,
          splashColor: Colors.transparent,
          highlightColor: ThemeVars.black.withOpacity(0.1),
          onTap: this.disabled ? null : this.onPressed,
          child: Padding(
            padding: this.btnSize.padding,
            child: Center(
              child: this.renderContent(),
            ),
          ),
        ),
      ),
    );

    if (!this.isBtnEnable) {
      _btn = Opacity(
        opacity: .5,
        child: _btn,
      );
    }

    if (this.size != FlanButtonSize.large && !this.block) {
      _btn = Row(
        mainAxisSize: MainAxisSize.min,
        children: [_btn],
      );
    }

    return Semantics(
      container: true,
      button: true,
      enabled: this.isBtnEnable,
      child: _btn,
    );
  }

  _FlanButtonTheme computedThemeType(
    plain,
    hairline, {
    Color backgroundColor,
    Color color,
    Color borderColor,
  }) {
    if (this.color != null) {
      borderColor = this.color is Gradient ? Colors.transparent : this.color;
      color = Colors.white;
    }
    return _FlanButtonTheme(
      backgroundColor:
          plain ? ThemeVars.buttonPlainBackgroundColor : backgroundColor,
      color: plain ? borderColor : color,
      border: Border.all(
        width: hairline ? 0.5 : ThemeVars.buttonBorderWidth,
        color: borderColor,
      ),
    );
  }

  bool get isBtnEnable => !this.disabled && this.onPressed != null;
  bool get isHasText => this.text.isNotEmpty || this.child != null;

  _FlanButtonSize get btnSize {
    return {
      FlanButtonSize.large: _FlanButtonSize(
        fontSize: ThemeVars.buttonDefaultFontSize,
        height: ThemeVars.buttonLargeHeight,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
      ),
      FlanButtonSize.normal: _FlanButtonSize(
        fontSize: ThemeVars.buttonNormalFontSize,
        height: ThemeVars.buttonDefaultHeight,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
      ),
      FlanButtonSize.small: _FlanButtonSize(
        fontSize: ThemeVars.buttonSmallFontSize,
        height: ThemeVars.buttonSmallHeight,
        padding: EdgeInsets.symmetric(horizontal: ThemeVars.paddingSm),
      ),
      FlanButtonSize.mini: _FlanButtonSize(
        fontSize: ThemeVars.buttonMiniFontSize,
        height: ThemeVars.buttonMiniHeight,
        padding: EdgeInsets.symmetric(horizontal: ThemeVars.paddingBase),
      ),
    }[size];
  }

  _FlanButtonTheme get themeType {
    return {
      FlanButtonType.normal: computedThemeType(
        this.plain,
        this.hairline,
        backgroundColor: ThemeVars.buttonDefaultBackgroundColor,
        color: ThemeVars.buttonDefaultColor,
        borderColor: ThemeVars.buttonDefaultBorderColor,
      ),
      FlanButtonType.primary: computedThemeType(
        this.plain,
        this.hairline,
        backgroundColor: ThemeVars.buttonPrimaryBackgroundColor,
        color: ThemeVars.buttonPrimaryColor,
        borderColor: ThemeVars.buttonPrimaryBorderColor,
      ),
      FlanButtonType.success: computedThemeType(
        this.plain,
        this.hairline,
        backgroundColor: ThemeVars.buttonSuccessBackgroundColor,
        color: ThemeVars.buttonSuccessColor,
        borderColor: ThemeVars.buttonSuccessBorderColor,
      ),
      FlanButtonType.danger: computedThemeType(
        this.plain,
        this.hairline,
        backgroundColor: ThemeVars.buttonDangerBackgroundColor,
        color: ThemeVars.buttonDangerColor,
        borderColor: ThemeVars.buttonDangerBorderColor,
      ),
      FlanButtonType.warning: computedThemeType(
        this.plain,
        this.hairline,
        backgroundColor: ThemeVars.buttonWarningBackgroundColor,
        color: ThemeVars.buttonWarningColor,
        borderColor: ThemeVars.buttonWarningBorderColor,
      ),
    }[type];
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>("text", text, defaultValue: ""));
    properties.add(DiagnosticsProperty<IconData>("icon", icon));
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
