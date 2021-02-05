import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flant/styles/var.dart';

const badgeTextStyle = TextStyle(
  height: 1.2,
  fontSize: ThemeVars.badgeFontSize,
  fontWeight: ThemeVars.badgeFontWeight,
  color: ThemeVars.badgeColor,
);

class FlanBadge extends StatelessWidget {
  const FlanBadge({
    Key key,
    this.child,
    this.content,
    this.dot = false,
    this.max,
    this.color,
    this.contentSlot,
  }) : super(key: key);

  final Widget child;
  final Widget contentSlot;
  final String content;
  final bool dot;
  final int max;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (this.child != null) {
      return Stack(
        fit: StackFit.loose,
        overflow: Overflow.visible,
        children: [
          this.child,
          Positioned(
            top: 0.0,
            right: 0.0,
            child: SizedOverflowBox(
              size: const Size(0.0, 0.0),
              child: this.buildBadge(),
            ),
          ),
        ],
      );
    }

    return this.buildBadge();
  }

  bool get hasContent {
    return this.contentSlot != null ||
        (this.content != null && this.content.isNotEmpty);
  }

  Widget buildContent() {
    if (!this.dot && hasContent) {
      if (this.contentSlot != null) {
        return IconTheme(
          data: IconThemeData(
            color: badgeTextStyle.color,
            size: badgeTextStyle.fontSize,
          ),
          child: this.contentSlot,
        );
      }

      var text = this.content;
      var contentNumber = double.tryParse(this.content);
      if (this.max != null &&
          contentNumber != null &&
          contentNumber > this.max) {
        text = "$max+";
      }

      return Text(
        text,
        textAlign: TextAlign.center,
      );
    }

    return null;
  }

  Widget buildDotBadge() {
    return Container(
      width: ThemeVars.badgeDotSize,
      height: ThemeVars.badgeDotSize,
      constraints: BoxConstraints(
        minWidth: 0,
      ),
      padding: ThemeVars.badgePadding,
      decoration: BoxDecoration(
        color: this.color ?? ThemeVars.badgeDotColor,
        border: Border.all(
          color: ThemeVars.white,
          width: ThemeVars.badgeBorderWidth,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeVars.badgeDotSize),
        ),
      ),
      child: this.buildContent(),
    );
  }

  Widget buildContentBadge() {
    return Container(
      constraints: BoxConstraints(
        minWidth: ThemeVars.badgeSize,
      ),
      alignment: Alignment.center,
      padding: ThemeVars.badgePadding,
      decoration: BoxDecoration(
        color: this.color ?? ThemeVars.badgeBackgroundColor,
        border: Border.all(
          color: ThemeVars.white,
          width: ThemeVars.badgeBorderWidth,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeVars.borderRadiusMax),
        ),
      ),
      child: this.buildContent(),
    );
  }

  Widget buildBadge() {
    if (hasContent || this.dot) {
      return Material(
        textStyle: badgeTextStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            this.dot ? this.buildDotBadge() : this.buildContentBadge(),
          ],
        ),
      );
    }

    return null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>("content", content));
    properties.add(DiagnosticsProperty<bool>("dot", dot, defaultValue: false));
    properties.add(DiagnosticsProperty<int>("max", max));
    properties.add(DiagnosticsProperty<Color>("color", color));
    super.debugFillProperties(properties);
  }
}
