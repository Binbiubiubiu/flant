import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
    return Material(
      color: Colors.transparent,
      textStyle: TextStyle(
        color: style?.color ?? ThemeVars.dividerTextColor,
        fontSize: ThemeVars.dividerFontSize,
        height: ThemeVars.dividerLineHeight / ThemeVars.dividerFontSize,
      ),
      child: Container(
        margin: ThemeVars.dividerMargin,
        padding: style?.padding ?? EdgeInsets.zero,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildLine(
                  constraints,
                  position: FlanDividerContentPosition.left,
                ),
                _buildContentSpace(),
                child ?? const SizedBox.shrink(),
                _buildContentSpace(),
                _buildLine(
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
  Widget _buildContentSpace() {
    return SizedBox(
      width: child != null ? ThemeVars.dividerContentPadding : 0.0,
    );
  }

  /// 构建线条
  Widget _buildLine(
    BoxConstraints constraints, {
    required FlanDividerContentPosition position,
  }) {
    final CustomPaint line = CustomPaint(
      painter: _DividerPainter(
        dashed: dashed,
        color: style?.borderColor ?? ThemeVars.dividerBorderColor,
        strokeWidth: ThemeVars.borderWidthBase * (hairline ? 0.5 : 1.0),
      ),
    );

    if (contentPosition != position) {
      return Expanded(child: line);
    }

    return SizedBox(width: constraints.maxWidth * 0.1, child: line);
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
