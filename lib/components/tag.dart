// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/components/tag_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import 'icon.dart';

/// ### FlanCircle 环形进度条
/// 圆环形的进度条组件，支持进度渐变动画。
class FlanTag extends StatelessWidget {
  const FlanTag({
    Key? key,
    this.type = FlanTagType.normal,
    this.size = FlanTagSize.normal,
    this.color,
    this.plain = false,
    this.round = false,
    this.mark = false,
    this.textColor,
    this.closeable = false,
    this.show = true,
    this.onClose,
    this.child,
  }) : super(key: key);

  // ****************** Props ******************
  /// 类型，可选值为 `normal` `primary` `success` `danger` `warning`
  final FlanTagType type;

  /// 大小, 可选值为 `large` `medium`
  final FlanTagSize size;

  /// 标签颜色
  final Color? color;

  /// 是否为空心样式
  final bool plain;

  /// 是否为圆角样式
  final bool round;

  /// 是否为标记样式
  final bool mark;

  /// 文本颜色，优先级高于`color`属性
  final Color? textColor;

  /// 是否为可关闭标签
  final bool closeable;

  /// 是否显示
  final bool show;

  // ****************** Events ******************

  /// 标签关闭的回调事件
  final VoidCallback? onClose;

  // ****************** Slots ******************

  /// 标签显示内容
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final FlanTagThemeData themeData = FlanTheme.of(context).tagTheme;

    return AnimatedOpacity(
      opacity: show ? 1.0 : 0.0,
      duration: FlanThemeVars.animationDurationBase,
      curve: show
          ? FlanThemeVars.animationTimingFunctionLeave
          : FlanThemeVars.animationTimingFunctionEnter,
      child: _buildTag(themeData),
    );
  }

  /// 计算标签不同size的padding
  EdgeInsets _getTagPadding(FlanTagThemeData themeData) {
    switch (size) {
      case FlanTagSize.normal:
        return themeData.padding;
      case FlanTagSize.medium:
        return themeData.mediumPadding;
      case FlanTagSize.large:
        return themeData.largePadding;
    }
  }

  /// 计算标签不同type的主题色
  Color _getThemeColor(FlanTagThemeData themeData) {
    switch (type) {
      case FlanTagType.normal:
        return themeData.defaultColor;
      case FlanTagType.primary:
        return themeData.primaryColor;
      case FlanTagType.success:
        return themeData.successColor;
      case FlanTagType.warning:
        return themeData.warningColor;
      case FlanTagType.danger:
        return themeData.dangerColor;
    }
  }

  /// 计算标签文字颜色
  Color _getTextColor(FlanTagThemeData themeData) {
    if (textColor != null) {
      return textColor!;
    }
    if (color != null && plain) {
      return color!;
    }

    return plain ? _getThemeColor(themeData) : themeData.textColor;
  }

  /// 计算标签背景颜色
  Color _getBackgroundColor(FlanTagThemeData themeData) => plain
      ? themeData.plainBackgroundColor
      : (color ?? _getThemeColor(themeData));

  /// 计算标签字体大小
  double _getTextSize(FlanTagThemeData themeData) =>
      size == FlanTagSize.large ? themeData.largeFontSize : themeData.fontSize;

  /// 计算标签圆角大小
  BorderRadius _getBorderRadius(FlanTagThemeData themeData) {
    if (mark) {
      return BorderRadius.only(
        topRight: Radius.circular(themeData.roundBorderRadius),
        bottomRight: Radius.circular(themeData.roundBorderRadius),
      );
    }

    if (round) {
      return BorderRadius.circular(themeData.roundBorderRadius);
    }

    if (size == FlanTagSize.large) {
      return BorderRadius.circular(themeData.largeBorderRadius);
    }

    return BorderRadius.circular(themeData.borderRadius);
  }

  /// 构建标签
  Widget _buildTag(FlanTagThemeData themeData) {
    final Color textColor = _getTextColor(themeData);
    final Color bgColor = _getBackgroundColor(themeData);
    final double fontSize = _getTextSize(themeData);

    return Container(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(plain
            ? BorderSide(width: 1.0, color: _getTextColor(themeData))
            : BorderSide.none),
        color: bgColor,
        borderRadius: _getBorderRadius(themeData),
      ),
      padding: _getTagPadding(themeData),
      child: DefaultTextStyle(
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          height: themeData.lineHeight ,
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            child ?? const SizedBox.shrink(),
            if (closeable)
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: FlanIcon.name(
                  FlanIcons.cross,
                  onClick: onClose,
                  size: fontSize,
                  color: textColor,
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<FlanTagType>('type', type,
        defaultValue: FlanTagType.normal));
    properties.add(DiagnosticsProperty<FlanTagSize>('size', size,
        defaultValue: FlanTagSize.normal));
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties
        .add(DiagnosticsProperty<bool>('plain', plain, defaultValue: false));

    properties
        .add(DiagnosticsProperty<bool>('round', round, defaultValue: false));

    properties
        .add(DiagnosticsProperty<bool>('mark', mark, defaultValue: false));
    properties.add(DiagnosticsProperty<Color>('textColor', textColor));
    properties.add(
        DiagnosticsProperty<bool>('closeable', closeable, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('show', show, defaultValue: true));

    super.debugFillProperties(properties);
  }
}

/// 标签类型集合
enum FlanTagType {
  normal,
  primary,
  success,
  warning,
  danger,
}

/// 标签大小集合
enum FlanTagSize {
  normal,
  medium,
  large,
}
