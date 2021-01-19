import 'package:flant/styles/var.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    this.text,
    this.icon,
    this.color,
    this.block,
    this.plain,
    this.round,
    this.square,
    this.loading,
    this.hairline,
    this.disabled,
    this.iconPrefix,
    this.loadingText,
    this.type = ButtonType.normal,
    this.size = ButtonSize.normal,
    this.loadingSize = 20.0,
    this.iconPosition = ButtonIconPosition.left,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  final String text;
  final String icon;
  final String color;
  final bool block;
  final bool plain;
  final bool round;
  final bool square;
  final bool loading;
  final bool hairline;
  final bool disabled;
  final String iconPrefix;
  final String loadingText;

  final ButtonType type;
  final ButtonSize size;
  final double loadingSize;
  final ButtonIconPosition iconPosition;

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Map<ButtonType, BoxDecoration> typeMap = {
      ButtonType.normal: {
        color: ThemeVars.buttonDefaultBackgroundColor,
      },
    };

    final Widget result = Center(
      widthFactor: 1.0,
      heightFactor: 1.0,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: ThemeVars.buttonDefaultFontSize,
          height: ThemeVars.buttonDefaultLineHeight,
        ),
        child: this.child,
      ),
    );

    return Semantics(
      container: true,
      button: true,
      enabled: this.disabled,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(ThemeVars.buttonBorderRadius),
            ),
            child: Material(
              type: this.color == null
                  ? MaterialType.transparency
                  : MaterialType.button,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: this.onPressed,
                child: Container(
                  decoration: BoxDecoration(),
                  height: ThemeVars.buttonDefaultHeight,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: result,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
