// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/var.dart';

/// ### FlanImage 图片
/// 增强版的 img 标签，提供多种图片填充模式，支持图片懒加载、加载中提示、加载失败提示。
class FlanBadge extends StatelessWidget {
  const FlanBadge({
    Key? key,
    this.content,
    this.dot = false,
    this.max,
    this.color,
    this.child,
    this.contentSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 徽标内容
  final String? content;

  /// 徽标背景颜色
  final Color? color;

  /// 徽标背景颜色
  final bool dot;

  /// 最大值，超过最大值会显示 `{max}+`，仅当 content 为数字时有效
  final int? max;

  // ****************** Events ******************

  // ****************** Slots ******************
  /// 徽标包裹的子元素
  final Widget? child;

  /// 自定义徽标内容
  final Widget? contentSlot;

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: <Widget>[
          child ?? const SizedBox.shrink(),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: SizedOverflowBox(
              size: const Size(0.0, 0.0),
              child: _buildBadge(),
            ),
          ),
        ],
      );
    }

    return _buildBadge();
  }

  /// 是否有内容
  bool get _hasContent {
    return contentSlot != null || (content != null && content!.isNotEmpty);
  }

  /// 构建内容
  Widget _buildContent() {
    if (!dot && _hasContent) {
      if (contentSlot != null) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final TextStyle style = DefaultTextStyle.of(context).style;

            return IconTheme(
              data: IconThemeData(
                color: style.color,
                size: style.fontSize,
              ),
              child: contentSlot ?? const SizedBox.shrink(),
            );
          },
        );
      }

      String text = content!;
      final double? contentNumber = double.tryParse(text);
      if (max != null && contentNumber != null && contentNumber > max!) {
        text = '$max+';
      }

      return Text(
        text,
        textAlign: TextAlign.center,
      );
    }

    return const SizedBox.shrink();
  }

  /// 构建点样式徽标
  Widget _buildDotBadge() {
    return Container(
      width: ThemeVars.badgeDotSize,
      height: ThemeVars.badgeDotSize,
      constraints: const BoxConstraints(
        minWidth: 0,
      ),
      padding: ThemeVars.badgePadding,
      decoration: BoxDecoration(
        color: color ?? ThemeVars.badgeDotColor,
        border: Border.all(
          color: ThemeVars.white,
          width: ThemeVars.badgeBorderWidth,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(ThemeVars.badgeDotSize),
        ),
      ),
      child: _buildContent(),
    );
  }

  /// 构建内容
  Widget _buildContentBadge() {
    return Container(
      constraints: const BoxConstraints(
        minWidth: ThemeVars.badgeSize,
      ),
      alignment: Alignment.center,
      padding: ThemeVars.badgePadding,
      decoration: BoxDecoration(
        color: color ?? ThemeVars.badgeBackgroundColor,
        border: Border.all(
          color: ThemeVars.white,
          width: ThemeVars.badgeBorderWidth,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(ThemeVars.borderRadiusMax),
        ),
      ),
      child: _buildContent(),
    );
  }

  /// 构建徽标
  Widget _buildBadge() {
    if (_hasContent || dot) {
      return Material(
        color: Colors.transparent,
        textStyle: const TextStyle(
          height: 1.2,
          fontSize: ThemeVars.badgeFontSize,
          fontWeight: ThemeVars.badgeFontWeight,
          color: ThemeVars.badgeColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (dot) _buildDotBadge() else _buildContentBadge(),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('content', content));
    properties.add(DiagnosticsProperty<bool>('dot', dot, defaultValue: false));
    properties.add(DiagnosticsProperty<int>('max', max));
    properties.add(DiagnosticsProperty<Color>('color', color));
    super.debugFillProperties(properties);
  }
}
