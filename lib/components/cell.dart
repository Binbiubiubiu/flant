import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../mixins/route_mixins.dart';
import '../styles/var.dart';
import 'icon.dart';

/// ### FlanCell 单元格
/// 单元格为列表中的单个展示项。
class FlanCell extends RouteStatelessWidget {
  const FlanCell({
    Key? key,
    this.title,
    this.value,
    this.label,
    this.size = FlanCellSize.normal,
    this.iconName,
    this.iconUrl,
    this.iconPrefix = kFlanIconsFamily,
    this.border = false,
    this.clickable = false,
    this.isLink = false,
    this.isRequired = false,
    this.disabled = false,
    this.center = false,
    this.arrowDirection = FlanCellArrowDirection.right,
    this.titleStyle,
    this.valueStyle,
    this.labelStyle,
    this.onClick,
    this.child,
    this.titleSlot,
    this.labelSlot,
    this.iconSlot,
    this.rightIconSlot,
    this.extraSlots,
    String? toName,
    PageRoute<Object?>? toRoute,
    bool replace = false,
  }) : super(key: key, toName: toName, toRoute: toRoute, replace: replace);

  // ****************** Props ******************
  /// 左侧标题
  final String? title;

  /// 右侧内容
  final String? value;

  /// 标题下方的描述信息
  final String? label;

  /// 单元格大小，可选值为 `large`
  final FlanCellSize size;

  /// 左侧图标名称
  final int? iconName;

  /// 左侧图片链接
  final String? iconUrl;

  /// 图标类名前缀，同 Icon 组件的 class-prefix 属性
  final String iconPrefix;

  /// 是否显示内边框
  final bool border;

  /// 是否开启点击反馈
  final bool clickable;

  /// 是否展示右侧箭头并开启点击反馈
  final bool isLink;

  /// 是否显示表单必填星号
  final bool isRequired;

  /// 是否禁用
  final bool disabled;

  /// 是否使内容垂直居中
  final bool center;

  /// 箭头方向，可选值为 `left` `up` `down`
  final FlanCellArrowDirection arrowDirection;

  /// 左侧标题额外样式
  final TextStyle? titleStyle;

  /// 右侧内容额外类名
  final TextStyle? valueStyle;

  /// 描述信息额外类名
  final TextStyle? labelStyle;

  // ****************** Events ******************
  /// 点击单元格时触发
  final GestureTapCallback? onClick;

  // ****************** Slots ******************
  /// 自定义右侧 value 的内容
  final Widget? child;

  /// 自定义左侧 title 的内容
  final Widget? titleSlot;

  /// 自定义标题下方 label 的内容
  final Widget? labelSlot;

  /// 自定义左侧图标
  final Widget? iconSlot;

  /// 自定义右侧按钮，默认为 `arrow`
  final Widget? rightIconSlot;

  /// 自定义单元格最右侧的额外内容
  final Widget? extraSlots;

  @override
  Widget build(BuildContext context) {
    Widget cell = Container(
      margin: const EdgeInsets.symmetric(
        horizontal: ThemeVars.cellHorizontalPadding,
      ),
      padding: EdgeInsets.symmetric(
        vertical: _sizeStyle.paddingVertical,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: border
              ? const BorderSide(width: 0.5, color: ThemeVars.cellBorderColor)
              : BorderSide.none,
        ),
      ),
      child: Row(
        crossAxisAlignment:
            center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: <Widget>[
          _buildLeftIcon(context),
          _buildTitle(context),
          Expanded(child: _buildValue(context)),
          _buildRigthIcon(context),
          extraSlots ?? const SizedBox.shrink(),
        ],
      ),
    );

    if (isRequired) {
      cell = Stack(
        children: <Widget>[
          Positioned(
            top: _sizeStyle.paddingVertical,
            left: ThemeVars.paddingXs,
            child: const Text(
              '*',
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

    if (_isClickable) {
      cell = InkWell(
        splashColor: Colors.transparent,
        highlightColor:
            disabled ? Colors.white : ThemeVars.black.withOpacity(0.1),
        // enableFeedback: false,
        onTap: () {
          if (disabled) {
            return;
          }
          if (onClick != null) {
            onClick!();
          }
          route(context);
        },
        child: cell,
      );
    }

    return Semantics(
      container: true,
      button: _isClickable,
      child: Material(
        type: _isClickable ? MaterialType.button : MaterialType.canvas,
        textStyle: _cellTextStyle,
        color: ThemeVars.cellBackgroundColor,
        child: cell,
      ),
    );
  }

  /// 是否有左侧标题
  bool get _hasTitle =>
      titleSlot != null || (title != null && title!.isNotEmpty);

  /// 是否有右侧内容
  bool get _hasValue => child != null || (value != null && value!.isNotEmpty);

  /// 是否有标题下方的描述信息
  bool get _hasLabel =>
      labelSlot != null || (label != null && label!.isNotEmpty);

  /// 默认字体样式
  TextStyle get _cellTextStyle {
    return TextStyle(
      color: ThemeVars.cellTextColor,
      fontSize: _sizeStyle.titleFontSize,
      // height: ThemeVars.cellLineHeight / this._sizeStyle.titleFontSize,
    );
  }

  /// 是否可以点击
  bool get _isClickable => isLink || clickable;

  double get _iconLineHeight => _sizeStyle.titleFontSize * 1.36;

  /// 单元格大小样式
  _FlanCellSizeStyle get _sizeStyle {
    return <FlanCellSize, _FlanCellSizeStyle>{
      FlanCellSize.normal: const _FlanCellSizeStyle(
        paddingVertical: ThemeVars.cellVerticalPadding,
        titleFontSize: ThemeVars.cellFontSize,
        labelFontSize: ThemeVars.cellLabelFontSize,
      ),
      FlanCellSize.large: const _FlanCellSizeStyle(
        paddingVertical: ThemeVars.cellLargeVerticalPadding,
        titleFontSize: ThemeVars.cellLargeTitleFontSize,
        labelFontSize: ThemeVars.cellLargeLabelFontSize,
      ),
    }[size]!;
  }

  /// 构建标题
  Widget _buildTitle(BuildContext context) {
    if (_hasTitle) {
      final Widget title = titleSlot ?? Text(this.title ?? '');
      TextStyle tStyle = _cellTextStyle;

      if (titleStyle != null) {
        tStyle = tStyle.merge(titleStyle);
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DefaultTextStyle(
            style: tStyle.copyWith(
              color: disabled ? ThemeVars.collapseItemTitleDisabledColor : null,
              // height: ThemeVars.cellLineHeight / ThemeVars.cellFontSize,
            ),
            child: title,
          ),
          _buildLabel(context),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  /// 构建标题下方的描述信息
  Widget _buildLabel(BuildContext context) {
    if (_hasLabel) {
      final Padding label = Padding(
        padding: const EdgeInsets.only(top: ThemeVars.cellLabelMarginTop),
        child: labelSlot ?? Text(this.label ?? ''),
      );

      TextStyle lstyle = _cellTextStyle.copyWith(
        color: disabled
            ? ThemeVars.collapseItemTitleDisabledColor
            : ThemeVars.cellLabelColor,
        fontSize: _sizeStyle.labelFontSize,
        // height: ThemeVars.cellLineHeight / this._sizeStyle.labelFontSize,
      );
      if (labelStyle != null) {
        lstyle = lstyle.merge(labelStyle);
      }
      return DefaultTextStyle(
        style: lstyle,
        child: label,
      );
    }
    return const SizedBox.shrink();
  }

  /// 构建右侧内容
  Widget _buildValue(BuildContext context) {
    if (_hasValue) {
      final Widget value =
          child ?? Text(this.value ?? '', textAlign: TextAlign.right);

      final TextStyle vStyle = _cellTextStyle.copyWith(
        color: disabled
            ? ThemeVars.collapseItemTitleDisabledColor
            : !_hasTitle
                ? ThemeVars.textColor
                : ThemeVars.cellValueColor,
      );
      if (valueStyle != null) {
        vStyle.merge(valueStyle);
      }
      return DefaultTextStyle(
        style: vStyle,
        child: value,
      );
    }

    return const SizedBox.shrink();
  }

  /// 构建左侧图标
  Widget _buildLeftIcon(BuildContext context) {
    if (iconSlot != null) {
      return IconTheme.merge(
        data: IconThemeData(
          color: disabled ? ThemeVars.collapseItemTitleDisabledColor : null,
          size: ThemeVars.cellIconSize,
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: _iconLineHeight,
          ),
          padding: const EdgeInsets.only(right: ThemeVars.paddingBase),
          alignment: Alignment.center,
          child: iconSlot,
        ),
      );
    }

    if (iconName != null || iconUrl != null) {
      return Container(
        constraints: BoxConstraints(
          minWidth: ThemeVars.cellFontSize,
          minHeight: _iconLineHeight,
        ),
        padding: const EdgeInsets.only(right: ThemeVars.paddingBase),
        alignment: Alignment.center,
        child: FlanIcon(
          iconName: iconName,
          iconUrl: iconUrl,
          size: ThemeVars.cellIconSize,
          color: disabled ? ThemeVars.collapseItemTitleDisabledColor : null,
          classPrefix: iconPrefix,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  /// 构建右侧图标
  Widget _buildRigthIcon(BuildContext context) {
    if (rightIconSlot != null) {
      return IconTheme.merge(
        data: IconThemeData(
          size: ThemeVars.cellIconSize,
          color: disabled
              ? ThemeVars.collapseItemTitleDisabledColor
              : ThemeVars.cellRightIconColor,
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: _iconLineHeight,
          ),
          padding: const EdgeInsets.only(left: ThemeVars.paddingBase),
          alignment: Alignment.center,
          child: rightIconSlot,
        ),
      );
    }

    if (isLink) {
      final int iconName = <FlanCellArrowDirection, int>{
        FlanCellArrowDirection.down: FlanIcons.arrow_down,
        FlanCellArrowDirection.up: FlanIcons.arrow_up,
        FlanCellArrowDirection.left: FlanIcons.arrow_left,
        FlanCellArrowDirection.right: FlanIcons.arrow,
      }[arrowDirection]!;

      return Container(
        constraints: BoxConstraints(
          minWidth: ThemeVars.cellFontSize,
          minHeight: _iconLineHeight,
        ),
        padding: const EdgeInsets.only(left: ThemeVars.paddingBase),
        alignment: Alignment.center,
        child: FlanIcon(
          iconName: iconName,
          size: ThemeVars.cellIconSize,
          color: disabled
              ? ThemeVars.collapseItemTitleDisabledColor
              : ThemeVars.cellRightIconColor,
          classPrefix: iconPrefix,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('title', title));
    properties.add(DiagnosticsProperty<String>('value', value));
    properties.add(DiagnosticsProperty<FlanCellSize>('size', size,
        defaultValue: FlanCellSize.normal));
    properties.add(DiagnosticsProperty<int>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    properties.add(DiagnosticsProperty<String>('iconPrefix', iconPrefix));
    properties
        .add(DiagnosticsProperty<bool>('border', border, defaultValue: true));
    properties.add(
        DiagnosticsProperty<bool>('clickable', clickable, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('isLink', isLink, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('isRequired', isRequired,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('center', center, defaultValue: false));
    properties.add(DiagnosticsProperty<FlanCellArrowDirection>(
        'arrowDirection', arrowDirection,
        defaultValue: FlanCellArrowDirection.right));
    properties.add(DiagnosticsProperty<TextStyle>('titleStyle', titleStyle));
    properties.add(DiagnosticsProperty<TextStyle>('valueStyle', valueStyle));
    properties.add(DiagnosticsProperty<TextStyle>('labelStyle', labelStyle));
    properties.add(DiagnosticsProperty<FlanCellSize>('size', size,
        defaultValue: FlanCellSize.normal));
    super.debugFillProperties(properties);
  }
}

/// 单元格大小
enum FlanCellSize {
  large,
  normal,
}

/// 箭头方向
enum FlanCellArrowDirection {
  up,
  down,
  left,
  right,
}

/// 单元格样式类
class _FlanCellSizeStyle {
  const _FlanCellSizeStyle({
    required this.paddingVertical,
    required this.titleFontSize,
    required this.labelFontSize,
  });

  final double paddingVertical;
  final double titleFontSize;
  final double labelFontSize;
}
