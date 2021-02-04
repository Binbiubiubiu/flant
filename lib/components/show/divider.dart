import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flant/styles/var.dart';

enum DividerContentPosition {
  left,
  center,
  right,
}

class DividerStyle {
  const DividerStyle({
    this.color,
    this.borderColor,
    this.padding,
  }) : super();

  final Color color;
  final Color borderColor;
  final EdgeInsets padding;
}

class Divider extends StatelessWidget {
  const Divider({
    Key key,
    this.dashed = false,
    this.hairline = true,
    this.contentPosition = DividerContentPosition.center,
    this.child,
    this.style,
  })  : assert(hairline != null),
        assert(contentPosition !=
            null), //&& DividerContentPosition.values.contains(contentPosition),
        super(key: key);

  final bool dashed;
  final bool hairline;
  final DividerContentPosition contentPosition;
  final Widget child;
  final DividerStyle style;

  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: TextStyle(
        color: this.style?.color ?? ThemeVars.dividerTextColor,
        fontSize: ThemeVars.dividerFontSize,
        height: ThemeVars.dividerLineHeight / ThemeVars.dividerFontSize,
      ),
      child: Container(
        margin: ThemeVars.dividerMargin,
        padding: this.style?.padding ?? EdgeInsets.zero,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                this.buildLine(
                  constraints,
                  position: DividerContentPosition.left,
                ),
                buildContentSpace(),
                child,
                buildContentSpace(),
                this.buildLine(
                  constraints,
                  position: DividerContentPosition.right,
                ),
              ].where((element) => element != null).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget buildContentSpace() {
    return this.child != null
        ? SizedBox(width: ThemeVars.dividerContentPadding)
        : null;
  }

  Widget buildLine(
    BoxConstraints constraints, {
    DividerContentPosition position,
  }) {
    final line = CustomPaint(
      painter: DividerPainter(
        dashed: this.dashed,
        color: this.style?.borderColor ?? ThemeVars.dividerBorderColor,
        strokeWidth: ThemeVars.borderWidthBase * (this.hairline ? 0.5 : 1.0),
      ),
    );

    if (this.contentPosition != position) {
      return Expanded(child: line);
    }

    return line;
  }
}

class DividerPainter extends CustomPainter {
  DividerPainter({
    this.dashed = false,
    this.color,
    this.strokeWidth = 1.0,
  })  : _paint = Paint()
          ..color = color
          ..strokeWidth = strokeWidth,
        super();

  final bool dashed;
  final Color color;
  final double strokeWidth;

  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height * 0.5;
    if (!this.dashed) {
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), _paint);
      return;
    }

    const dashWith = 3.0;
    var list = List.filled((size.width / dashWith).floor(), 0)
        .asMap()
        .keys
        .map((i) => Offset(i * dashWith, y))
        .toList();
    canvas.drawPoints(PointMode.lines, list, _paint);
  }

  @override
  bool shouldRepaint(DividerPainter oldDelegate) => this != oldDelegate;
}
