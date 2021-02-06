import 'package:flant/mixins/route_mixins.dart';
import 'package:flant/styles/icons.dart';
import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
import 'package:flant/styles/var.dart';

import './icon.dart';

enum FlanCellSize {
  large,
  normal,
}

enum FlanCellArrowDirection {
  up,
  down,
  left,
  right,
}

class FlanCellSizeStyle {
  const FlanCellSizeStyle({
    this.paddingVertical,
    this.titleFontSize,
    this.labelFontSize,
  });

  final double paddingVertical;
  final double titleFontSize;
  final double labelFontSize;
}

class FlanCell extends RouteStatelessWidget {
  const FlanCell({
    Key key,
    this.icon,
    this.size = FlanCellSize.normal,
    this.title,
    this.value,
    this.label,
    this.center = false,
    this.isLink = false,
    this.isRequired = false,
    this.clickable = false,
    this.iconPrefix,
    this.titleStyle,
    this.valueStyle,
    this.labelStyle,
    this.arrowDirection = FlanCellArrowDirection.right,
    this.border = true,
    this.child,
    this.iconSlot,
    this.titleSlot,
    this.labelSlot,
    this.rightIconSlot,
    dynamic to,
    bool replace = false,
  }) : super(key: key, to: to, replace: replace);

  final IconData icon;
  final FlanCellSize size;
  final String title;
  final String value;
  final String label;
  final bool center;
  final bool isLink;
  final bool isRequired;
  final bool clickable;
  final String iconPrefix;
  final TextStyle titleStyle;
  final TextStyle valueStyle;
  final TextStyle labelStyle;
  final FlanCellArrowDirection arrowDirection;
  final bool border;

  // slots
  final Widget child;
  final Widget iconSlot;
  final Widget titleSlot;
  final Widget labelSlot;
  final Widget rightIconSlot;

  bool get hasTitle =>
      this.titleSlot != null || (this.title != null && this.title.isNotEmpty);

  bool get hasValue =>
      this.child != null || (this.value != null && this.value.isNotEmpty);

  bool get hasLabel =>
      this.labelSlot != null || (this.label != null && this.label.isNotEmpty);

  double get lineHeight => ThemeVars.cellLineHeight / ThemeVars.cellFontSize;

  bool get isClickable => this.isLink || this.clickable;

  FlanCellSizeStyle get sizeStyle {
    return {
      FlanCellSize.normal: FlanCellSizeStyle(
        paddingVertical: ThemeVars.cellVerticalPadding,
        titleFontSize: ThemeVars.cellFontSize,
        labelFontSize: ThemeVars.cellLabelFontSize,
      ),
      FlanCellSize.large: FlanCellSizeStyle(
        paddingVertical: ThemeVars.cellLargeVerticalPadding,
        titleFontSize: ThemeVars.cellLargeTitleFontSize,
        labelFontSize: ThemeVars.cellLargeLabelFontSize,
      ),
    }[this.size];
  }

  @override
  Widget build(BuildContext context) {
    Widget cell = Padding(
      padding: EdgeInsets.symmetric(
        vertical: this.sizeStyle.paddingVertical,
        horizontal: ThemeVars.cellHorizontalPadding,
      ),
      child: Row(
        crossAxisAlignment:
            this.center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          this.buildLeftIcon(context),
          this.buildTitle(context),
          this.buildValue(context),
          this.buildRigthIcon(context),
        ].where((element) => element != null).toList(),
      ),
    );

    if (this.isRequired) {
      cell = Stack(
        children: [
          Positioned(
            top: this.sizeStyle.paddingVertical,
            left: ThemeVars.paddingXs,
            child: Text(
              "*",
              style: TextStyle(
                color: ThemeVars.cellRequiredColor,
                fontSize: ThemeVars.cellFontSize,
                height: 1.4,
              ),
            ),
          ),
          cell,
        ],
      );
    }

    if (this.isClickable) {
      cell = InkWell(
        splashColor: Colors.transparent,
        highlightColor: ThemeVars.black.withOpacity(0.1),
        enableFeedback: false,
        onTap: () {
          this.route(context);
        },
        child: cell,
      );
    }

    return Semantics(
      container: true,
      button: this.isClickable,
      child: Material(
        type: this.isClickable ? MaterialType.button : MaterialType.canvas,
        textStyle: TextStyle(
          color: ThemeVars.cellTextColor,
          fontSize: this.sizeStyle.titleFontSize,
          height: this.lineHeight,
        ),
        color: ThemeVars.cellBackgroundColor,
        child: Ink(
          decoration: this.border
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: ThemeVars.cellBorderColor,
                    ),
                  ),
                )
              : null,
          child: cell,
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    if (this.hasTitle) {
      Widget title = this.titleSlot ?? Text(this.title);
      if (this.titleStyle != null) {
        title = DefaultTextStyle(
          style: TextStyle(inherit: true).merge(this.titleStyle),
          child: title,
        );
      }
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            this.buildLabel(context),
          ].where((element) => element != null).toList(),
        ),
      );
    }
    return null;
  }

  Widget buildLabel(BuildContext context) {
    if (this.hasLabel) {
      final label = Padding(
        padding: EdgeInsets.only(top: ThemeVars.cellLabelMarginTop),
        child: this.labelSlot ?? Text(this.label),
      );

      final lstyle = TextStyle(
        inherit: true,
        color: ThemeVars.cellLabelColor,
        fontSize: this.sizeStyle.labelFontSize,
      );
      if (this.labelStyle != null) {
        lstyle.merge(this.labelStyle);
      }
      return DefaultTextStyle(
        style: lstyle,
        child: label,
      );
    }
    return null;
  }

  Widget buildValue(BuildContext context) {
    if (hasValue) {
      final value = Expanded(
        child: Container(
          child: this.child ?? Text(this.value),
        ),
      );
      final vStyle = TextStyle(
        inherit: true,
        color: !this.hasTitle ? ThemeVars.textColor : ThemeVars.cellValueColor,
      );
      if (this.valueStyle != null) {
        vStyle..merge(this.valueStyle);
      }
      return DefaultTextStyle(
        style: vStyle,
        textAlign: !this.hasTitle ? TextAlign.left : TextAlign.right,
        child: value,
      );
    }

    return null;
  }

  Widget buildLeftIcon(BuildContext context) {
    if (this.iconSlot != null) {
      return IconTheme(
        data: IconThemeData(
          size: ThemeVars.cellIconSize,
        ),
        child: this.iconSlot,
      );
    }

    if (this.icon != null) {
      return Padding(
        padding: EdgeInsets.only(right: ThemeVars.paddingBase),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: ThemeVars.cellFontSize * 1.0),
          child: FlanIcon(
            name: this.icon,
            height: lineHeight * this.sizeStyle.titleFontSize,
            size: ThemeVars.cellIconSize,
            classPrefix: this.iconPrefix,
          ),
        ),
      );
    }
    return null;
  }

  Widget buildRigthIcon(BuildContext context) {
    if (this.rightIconSlot != null) {
      return IconTheme(
        data: IconThemeData(
          size: ThemeVars.cellIconSize,
        ),
        child: this.rightIconSlot,
      );
    }

    if (this.isLink) {
      final iconName = {
        FlanCellArrowDirection.down: FlanIcons.arrow_down,
        FlanCellArrowDirection.up: FlanIcons.arrow_up,
        FlanCellArrowDirection.left: FlanIcons.arrow_left,
        FlanCellArrowDirection.right: FlanIcons.arrow,
      }[this.arrowDirection];

      return Padding(
        padding: EdgeInsets.only(left: ThemeVars.paddingBase),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: ThemeVars.cellFontSize * 1.0),
          child: FlanIcon(
            name: iconName,
            color: ThemeVars.cellRightIconColor,
            height: ThemeVars.cellLineHeight,
            size: ThemeVars.cellIconSize,
            classPrefix: this.iconPrefix,
          ),
        ),
      );
    }

    return null;
  }
}
