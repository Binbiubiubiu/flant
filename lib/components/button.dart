import 'package:flant/styles/var.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  normal,
  primary,
  success,
  warning,
  danger,
}

enum ButtonSize { large, normal, small, mini }

enum ButtonIconPosition {
  left,
  right,
}

class Button extends StatelessWidget {
  Button({
    Key key,
    this.text = "",
    this.icon,
    this.color,
    this.block = false,
    this.plain = false,
    this.round = false,
    this.square = false,
    this.loading = false,
    this.hairline = false,
    this.disabled = false,
    // this.iconPrefix,
    // this.loadingText,
    this.type = ButtonType.normal,
    this.size = ButtonSize.normal,
    this.loadingSize = 10.0,
    this.iconPosition = ButtonIconPosition.left,
    this.onPressed,
    this.child,
  })  : assert(text != null),
        assert(block != null),
        assert(plain != null),
        assert(round != null),
        assert(square != null),
        assert(loading != null),
        assert(hairline != null),
        assert(disabled != null),
        assert(type != null && ButtonType.values.contains(type)),
        assert(size != null && ButtonSize.values.contains(type)),
        assert(loadingSize != null),
        assert(
            iconPosition != null && ButtonIconPosition.values.contains(type)),
        super(key: key);

  final String text;
  final IconData icon;
  final Color color;
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

  final ButtonType type;
  final ButtonSize size;
  final double loadingSize;
  final ButtonIconPosition iconPosition;

  final VoidCallback onPressed;
  final Widget child;

  Widget renderText() {
    return child ?? Text(text);
  }

  Widget renderIcon() {
    return loading
        ? Icon(
            Icons.run_circle,
            color: themeType["color"],
          )
        : Icon(
            icon,
            color: themeType["color"],
          );
  }

  Widget renderContent() {
    var children = [
      renderText(),
    ];

    var icon = this.loading || this.icon != null ? renderIcon() : null;

    if (icon == null) {
      return children[0];
    }
    switch (iconPosition) {
      case ButtonIconPosition.left:
        if (isHasText) {
          children.insert(0, SizedBox(width: 4.0));
        }
        children.insert(0, icon);
        break;
      case ButtonIconPosition.right:
        children.add(icon);
        if (isHasText) {
          children.add(SizedBox(width: 4.0));
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
            this.round ? btnSize["height"] / 2.0 : ThemeVars.buttonBorderRadius,
          );

    Widget _btn = Material(
      textStyle: TextStyle(
        fontSize: btnSize["fontSize"],
        // height: ThemeVars.buttonDefaultLineHeight /
        //     ThemeVars.buttonDefaultFontSize,
        color: themeType["color"],
      ),
      type: MaterialType.button,
      color: (this.plain ? null : this.color) ?? themeType["backgroundColor"],
      borderRadius: radius,
      child: Ink(
        decoration: BoxDecoration(
          border: themeType["border"],
          borderRadius: radius,
        ),
        height: btnSize["height"],
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: ThemeVars.black.withOpacity(0.1),
          onTap: disabled ? null : onPressed,
          child: Padding(
            padding: btnSize["padding"],
            child: Center(
              child: renderContent(),
            ),
          ),
        ),
      ),
    );

    if (!isBtnEnable) {
      _btn = Opacity(
        opacity: .5,
        child: _btn,
      );
    }

    if (size != ButtonSize.large && !this.block) {
      _btn = Row(
        mainAxisSize: MainAxisSize.min,
        children: [_btn],
      );
    }

    return Semantics(
      container: true,
      button: true,
      enabled: isBtnEnable,
      child: _btn,
    );
  }

  Map<String, dynamic> computedThemeType(
    plain,
    hairline, {
    Color backgroundColor,
    Color color,
    Color borderColor,
  }) {
    if (this.color != null) {
      borderColor = this.color;
      color = Colors.white;
    }
    return {
      "backgroundColor":
          plain ? ThemeVars.buttonPlainBackgroundColor : backgroundColor,
      "color": plain ? borderColor : color,
      "border": Border.all(
        width: hairline ? 0.5 : ThemeVars.buttonBorderWidth,
        color: borderColor,
      ),
    };
  }

  get isBtnEnable => !this.disabled && this.onPressed != null;
  get isHasText => this.text.isNotEmpty || this.child != null;

  get btnSize {
    return {
      ButtonSize.large: {
        "fontSize": ThemeVars.buttonDefaultFontSize,
        "height": ThemeVars.buttonLargeHeight,
        "padding": const EdgeInsets.symmetric(horizontal: 15.0),
      },
      ButtonSize.normal: {
        "fontSize": ThemeVars.buttonNormalFontSize,
        "height": ThemeVars.buttonDefaultHeight,
        "padding": const EdgeInsets.symmetric(horizontal: 15.0),
      },
      ButtonSize.small: {
        "fontSize": ThemeVars.buttonSmallFontSize,
        "height": ThemeVars.buttonSmallHeight,
        "padding": EdgeInsets.symmetric(horizontal: ThemeVars.paddingSm),
      },
      ButtonSize.mini: {
        "fontSize": ThemeVars.buttonMiniFontSize,
        "height": ThemeVars.buttonMiniHeight,
        "padding": EdgeInsets.symmetric(horizontal: ThemeVars.paddingBase),
      },
    }[size];
  }

  get themeType {
    return {
      ButtonType.normal: computedThemeType(
        this.plain,
        this.hairline,
        backgroundColor: ThemeVars.buttonDefaultBackgroundColor,
        color: ThemeVars.buttonDefaultColor,
        borderColor: ThemeVars.buttonDefaultBorderColor,
      ),
      ButtonType.primary: computedThemeType(
        this.plain,
        this.hairline,
        backgroundColor: ThemeVars.buttonPrimaryBackgroundColor,
        color: ThemeVars.buttonPrimaryColor,
        borderColor: ThemeVars.buttonPrimaryBorderColor,
      ),
      ButtonType.success: computedThemeType(
        this.plain,
        this.hairline,
        backgroundColor: ThemeVars.buttonSuccessBackgroundColor,
        color: ThemeVars.buttonSuccessColor,
        borderColor: ThemeVars.buttonSuccessBorderColor,
      ),
      ButtonType.danger: computedThemeType(
        this.plain,
        this.hairline,
        backgroundColor: ThemeVars.buttonDangerBackgroundColor,
        color: ThemeVars.buttonDangerColor,
        borderColor: ThemeVars.buttonDangerBorderColor,
      ),
      ButtonType.warning: computedThemeType(
        this.plain,
        this.hairline,
        backgroundColor: ThemeVars.buttonWarningBackgroundColor,
        color: ThemeVars.buttonWarningColor,
        borderColor: ThemeVars.buttonWarningBorderColor,
      ),
    }[type];
  }
}
