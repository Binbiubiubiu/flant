import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../styles/var.dart';

/// ### FlanEmpty 空状态
/// 空状态时的占位提示
class FlanProgress extends StatelessWidget {
  const FlanProgress({
    Key? key,
    this.color,
    this.gradient,
    this.inactive = false,
    this.pivotText,
    this.textColor,
    this.pivotColor,
    this.trackColor,
    this.strokeWidth,
    this.percentage = 0.0,
    this.showPivot = true,
    this.child,
  })  : assert(percentage >= 0 && percentage <= 100),
        super(key: key);

  // ****************** Props ******************

  /// 进度条颜色
  final Color? color;

  /// 进度条颜色，传入对象格式可以定义渐变色
  final Gradient? gradient;

  /// 是否置灰
  final bool inactive;

  /// 进度文字内容
  final String? pivotText;

  /// 进度文字颜色
  final Color? textColor;

  /// 进度文字背景色
  final Color? pivotColor;

  /// 轨道颜色
  final Color? trackColor;

  /// 进度条粗细
  final double? strokeWidth;

  /// 进度百分比
  final double percentage;

  /// 是否显示进度文字
  final bool showPivot;

  // ****************** Events ******************

  // ****************** Slots ******************
  /// 自定义底部内容
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: strokeWidth ?? ThemeVars.progressHeight,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double current = constraints.maxWidth * percentage / 100.0;
          return Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  color: trackColor ?? ThemeVars.progressBackgroundColor,
                  borderRadius: BorderRadius.circular(ThemeVars.progressHeight),
                ),
                width: constraints.maxWidth,
              ),
              Container(
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  gradient: gradient,
                  color: background ?? ThemeVars.progressColor,
                  borderRadius: BorderRadius.circular(ThemeVars.progressHeight),
                ),
                width: current,
              ),
              Positioned(
                top: constraints.maxHeight / 2,
                left: current,
                child: _buildPivot(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPivot(BuildContext context) {
    dynamic fomatNumber(double n) => n.toInt() == n ? n.toInt() : n;

    final String text = pivotText ?? '${fomatNumber(percentage)}%';
    final bool show = showPivot && text.isNotEmpty;

    if (show) {
      return FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: Container(
          height: ThemeVars.progressPivotLineHeight *
              ThemeVars.progressPivotFontSize,
          alignment: Alignment.center,
          constraints: const BoxConstraints(
            minWidth: 3 * ThemeVars.progressPivotFontSize,
          ),
          padding: ThemeVars.progressPivotPadding,
          decoration: BoxDecoration(
            color: pivotColor ??
                background ??
                ThemeVars.progressPivotBackgroundColor,
            borderRadius:
                BorderRadius.circular(ThemeVars.progressPivotFontSize),
          ),
          child: Text(
            text,
            style: TextStyle(
              // height: ThemeVars.progressPivotLineHeight,
              fontSize: ThemeVars.progressPivotFontSize,
              color: textColor ?? ThemeVars.progressPivotTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Color? get background => inactive ? const Color(0xffcacaca) : color;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties.add(
        DiagnosticsProperty<bool>('inactive', inactive, defaultValue: false));
    properties.add(
        DiagnosticsProperty<String>('pivotText', pivotText, defaultValue: ''));
    properties.add(DiagnosticsProperty<Color>('textColor', textColor));
    properties.add(DiagnosticsProperty<Color>('pivotColor', pivotColor));
    properties.add(DiagnosticsProperty<Color>('trackColor', trackColor));
    properties.add(DiagnosticsProperty<double>('strokeWidth', strokeWidth));
    properties.add(DiagnosticsProperty<double>('percentage', percentage,
        defaultValue: 0.0));
    properties.add(
        DiagnosticsProperty<bool>('showPivot', showPivot, defaultValue: true));
    super.debugFillProperties(properties);
  }
}
