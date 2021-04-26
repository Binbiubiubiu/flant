// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/components/badge_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';

/// ### FlanImage 图片
/// 增强版的 img 标签，提供多种图片填充模式，支持图片懒加载、加载中提示、加载失败提示。
class FlanBadge extends StatelessWidget {
  const FlanBadge({
    Key? key,
    this.content = '',
    this.dot = false,
    this.max,
    this.color,
    this.offset = const <double>[0.0, 0.0],
    this.showZero = true,
    this.child,
    this.contentSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 徽标内容
  final String content;

  /// 徽标背景颜色
  final Color? color;

  /// 徽标背景颜色
  final bool dot;

  /// 最大值，超过最大值会显示 `{max}+`，仅当 content 为数字时有效
  final int? max;

  /// 设置徽标的偏移量，数组的两项分别对应水平和垂直方向的偏移量
  final List<double> offset;

  /// 当 content 为数字 0 时，是否展示徽标
  final bool showZero;

  // ****************** Events ******************

  // ****************** Slots ******************
  /// 徽标包裹的子元素
  final Widget? child;

  /// 自定义徽标内容
  final Widget? contentSlot;

  @override
  Widget build(BuildContext context) {
    final FlanBadgeThemeData themeData = FlanTheme.of(context).badgeTheme;

    if (child != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: <Widget?>[
          child,
          Positioned(
            top: offset[0],
            right: -offset[1],
            child: FractionalTranslation(
              translation: const Offset(0.5, -0.5),
              child: _buildBadge(themeData),
            ),
          ),
        ].noNull,
      );
    }

    return Transform.translate(
      offset: Offset(offset[0], offset[1]),
      child: _buildBadge(themeData) ?? const SizedBox.shrink(),
    );
  }

  /// 是否有内容
  bool get _hasContent {
    if (contentSlot != null) {
      return true;
    }
    return content.isNotEmpty && (showZero || content.trim() != '0');
  }

  /// 构建内容
  Widget? _buildContent(FlanBadgeThemeData themeData) {
    if (!dot && _hasContent) {
      if (contentSlot != null) {
        return IconTheme(
          data: IconThemeData(
            color: themeData.color,
            size: themeData.fontSize,
          ),
          child: contentSlot!,
        );
      }

      String text = content;
      final double? contentNumber = double.tryParse(text);
      if (max != null && contentNumber != null && contentNumber > max!) {
        text = '$max+';
      }

      return Text(
        text,
        textAlign: TextAlign.center,
      );
    }
  }

  /// 构建点样式徽标
  Widget _buildDotBadge(FlanBadgeThemeData themeData) {
    return Container(
      width: themeData.dotSize,
      height: themeData.dotSize,
      constraints: const BoxConstraints(minWidth: 0),
      padding: themeData.padding,
      decoration: BoxDecoration(
        color: color ?? themeData.dotColor,
        border: Border.all(
          color: FlanThemeVars.white,
          width: themeData.borderWidth,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(themeData.dotSize),
        ),
      ),
      child: _buildContent(themeData),
    );
  }

  /// 构建内容
  Widget _buildContentBadge(FlanBadgeThemeData themeData) {
    return Container(
      constraints: BoxConstraints(
        minWidth: themeData.size,
      ),
      alignment: Alignment.center,
      padding: themeData.padding,
      decoration: BoxDecoration(
        color: color ?? themeData.backgroundColor,
        border: Border.all(
          color: FlanThemeVars.white,
          width: themeData.borderWidth,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(FlanThemeVars.borderRadiusMax),
        ),
      ),
      child: _buildContent(themeData),
    );
  }

  /// 构建徽标
  Widget? _buildBadge(FlanBadgeThemeData themeData) {
    if (_hasContent || dot) {
      return DefaultTextStyle(
        style: TextStyle(
          height: 1.2,
          fontSize: themeData.fontSize,
          fontWeight: themeData.fontWeight,
          fontFamily: themeData.fontFamily,
          color: themeData.color,
        ),
        child: UnconstrainedBox(
          child:
              dot ? _buildDotBadge(themeData) : _buildContentBadge(themeData),
        ),
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<String>('content', content, defaultValue: ''));
    properties.add(DiagnosticsProperty<bool>('dot', dot, defaultValue: false));
    properties.add(DiagnosticsProperty<int>('max', max));
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties.add(DiagnosticsProperty<List<double>>('offset', offset,
        defaultValue: const <double>[0.0, 0.0]));
    properties.add(
        DiagnosticsProperty<bool>('showZero', showZero, defaultValue: true));
    super.debugFillProperties(properties);
  }
}
