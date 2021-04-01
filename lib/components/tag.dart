// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
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
    if (closeable) {
      return AnimatedOpacity(
        opacity: show ? 1.0 : 0.0,
        duration: ThemeVars.animationDurationBase,
        curve: show
            ? ThemeVars.animationTimingFunctionLeave
            : ThemeVars.animationTimingFunctionEnter,
        child: _buildTag(),
      );
    }

    return _buildTag();
  }

  /// 计算标签不同size的padding
  EdgeInsets get _tagPadding {
    return <FlanTagSize, EdgeInsets>{
      FlanTagSize.normal: ThemeVars.tagPadding,
      FlanTagSize.medium: ThemeVars.tagMediumPadding,
      FlanTagSize.large: ThemeVars.tagLargePadding,
    }[size]!;
  }

  /// 计算标签不同type的主题色
  Color get _themeColor {
    return <FlanTagType, Color>{
      FlanTagType.normal: ThemeVars.tagDefaultColor,
      FlanTagType.danger: ThemeVars.tagDangerColor,
      FlanTagType.primary: ThemeVars.tagPrimaryColor,
      FlanTagType.success: ThemeVars.tagSuccessColor,
      FlanTagType.warning: ThemeVars.tagWarningColor
    }[type]!;
  }

  /// 计算标签文字颜色
  Color get _textColor {
    if (textColor != null) {
      return textColor!;
    }
    if (color != null && plain) {
      return color!;
    }

    return plain ? _themeColor : ThemeVars.tagTextColor;
  }

  /// 计算标签背景颜色
  Color get _backgroundColor =>
      plain ? ThemeVars.tagPlainBackgroundColor : (color ?? _themeColor);

  /// 计算标签字体大小
  double get _textSize => size == FlanTagSize.large
      ? ThemeVars.tagLargeFontSize
      : ThemeVars.tagFontSize;

  /// 计算标签圆角大小
  BorderRadius get _borderRadius {
    if (mark) {
      return const BorderRadius.only(
        topRight: Radius.circular(ThemeVars.tagRoundBorderRadius),
        bottomRight: Radius.circular(ThemeVars.tagRoundBorderRadius),
      );
    }

    if (round) {
      return BorderRadius.circular(ThemeVars.tagRoundBorderRadius);
    }

    if (size == FlanTagSize.large) {
      return BorderRadius.circular(ThemeVars.tagLargeBorderRadius);
    }

    return BorderRadius.circular(ThemeVars.tagBorderRadius);
  }

  /// 构建标签
  Widget _buildTag() {
    return Material(
      textStyle: TextStyle(
        color: _textColor,
        fontSize: _textSize,
        // height: ThemeVars.tagLineHeight / ThemeVars.tagFontSize,
      ),
      shape: RoundedRectangleBorder(
        side:
            plain ? BorderSide(width: 1.0, color: _textColor) : BorderSide.none,
        borderRadius: _borderRadius,
      ),
      color: _backgroundColor,
      child: Padding(
        padding: _tagPadding,
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            child ?? const SizedBox.shrink(),
            _buildCloseIcon(),
          ],
        ),
      ),
    );
  }

  ///构建关闭图标
  Widget _buildCloseIcon() {
    if (closeable) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final TextStyle tagStyle = DefaultTextStyle.of(context).style;
          return Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: FlanIcon.name(
              FlanIcons.cross,
              onClick: onClose,
              size: tagStyle.fontSize,
              color: tagStyle.color,
            ),
          );
        },
      );
    }

    return const SizedBox.shrink();
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
