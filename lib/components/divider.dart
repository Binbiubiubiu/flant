import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../styles/components/divider_theme.dart';
import '../styles/var.dart';

/// ### FlanImage 图片
/// 增强版的 img 标签，提供多种图片填充模式，支持图片懒加载、加载中提示、加载失败提示。
class FlanDivider extends StatelessWidget {
  const FlanDivider({
    Key? key,
    this.dashed = false,
    this.hairline = true,
    this.contentPosition = FlanDividerContentPosition.center,
    this.child,
    this.style,
  }) : super(key: key);

  // ****************** Props ******************
  /// 是否使用虚线
  final bool dashed;

  /// 是否使用 0.5px 线
  final bool hairline;

  /// 内容位置，可选值为 `left` `right`
  final FlanDividerContentPosition contentPosition;

  /// 分割线样式
  final FlanDividerStyle? style;
  // ****************** Events ******************

  // ****************** Slots ******************
  /// 内容
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final FlanDividerThemeData themeData = FlanDividerTheme.of(context);

    return Container(
      margin: themeData.margin,
      padding: style?.padding ?? EdgeInsets.zero,
      child: DefaultTextStyle(
        style: TextStyle(
          color: style?.color ?? themeData.textColor,
          fontSize: themeData.fontSize,
          height: themeData.lineHeight,
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildLine(
                  themeData,
                  constraints,
                  position: FlanDividerContentPosition.left,
                ),
                _buildContentSpace(themeData),
                child ?? const SizedBox.shrink(),
                _buildContentSpace(themeData),
                _buildLine(
                  themeData,
                  constraints,
                  position: FlanDividerContentPosition.right,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// 构建空白区域
  Widget _buildContentSpace(FlanDividerThemeData themeData) {
    return SizedBox(width: child != null ? themeData.contentPadding : 0.0);
  }

  /// 构建线条
  Widget _buildLine(
    FlanDividerThemeData themeData,
    BoxConstraints constraints, {
    required FlanDividerContentPosition position,
  }) {
    final CustomPaint line = CustomPaint(
      painter: _DividerPainter(
        dashed: dashed,
        color: style?.borderColor ?? themeData.borderColor,
        strokeWidth: FlanThemeVars.borderWidthBase * (hairline ? 0.5 : 1.0),
      ),
    );

    if (contentPosition != position) {
      return Expanded(child: line);
    }

    return SizedBox(
      width: constraints.maxWidth *
          (position == FlanDividerContentPosition.left
              ? themeData.contentLeftWidthPercent
              : themeData.contentRightWidthPercent),
      child: line,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<bool>('dashed', dashed, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('hairline', hairline, defaultValue: true));
    properties.add(DiagnosticsProperty<FlanDividerContentPosition>(
        'contentPosition', contentPosition,
        defaultValue: FlanDividerContentPosition.center));
    properties.add(DiagnosticsProperty<FlanDividerStyle>('style', style));
    super.debugFillProperties(properties);
  }
}

/// 分割线绘制工具类
class _DividerPainter extends CustomPainter {
  _DividerPainter({
    this.dashed = false,
    required this.color,
    this.strokeWidth = 1.0,
  })  : _paint = Paint()
          ..color = color
          ..strokeWidth = strokeWidth,
        super();

  /// 虚线样式
  final bool dashed;

  /// 线条颜色
  final Color color;

  /// 线条宽度
  final double strokeWidth;

  /// 分割线的画笔
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final double y = size.height * 0.5;
    if (!dashed) {
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), _paint);
      return;
    }

    const double dashWith = 3.0;
    final List<Offset> list =
        List<Offset>.filled((size.width / dashWith).floor(), Offset.zero)
            .asMap()
            .keys
            .map((int i) => Offset(i * dashWith, y))
            .toList();
    canvas.drawPoints(PointMode.lines, list, _paint);
  }

  @override
  bool shouldRepaint(_DividerPainter oldDelegate) =>
      dashed != oldDelegate.dashed ||
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth;
}

/// 分割线内容位置
enum FlanDividerContentPosition {
  left,
  center,
  right,
}

/// 分割线样式
class FlanDividerStyle {
  const FlanDividerStyle({
    required this.color,
    required this.borderColor,
    required this.padding,
  }) : super();

  final Color color;
  final Color borderColor;
  final EdgeInsets padding;
}
