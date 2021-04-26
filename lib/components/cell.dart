// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../mixins/route_mixins.dart';
import '../styles/components/cell_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'common/active_response.dart';
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
    this.border = true,
    this.clickable = false,
    this.isLink = false,
    this.isRequired = false,
    this.center = false,
    this.arrowDirection = FlanCellArrowDirection.right,
    this.titleStyle,
    this.valueStyle,
    this.labelStyle,
    this.padding,
    this.bgColor,
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
  final IconData? iconName;

  /// 左侧图片链接
  final String? iconUrl;

  /// 是否显示内边框
  final bool border;

  /// 是否开启点击反馈
  final bool clickable;

  /// 是否展示右侧箭头并开启点击反馈
  final bool isLink;

  /// 是否显示表单必填星号
  final bool isRequired;

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

  /// 内边距
  final EdgeInsets? padding;

  /// 背景颜色
  final Color? bgColor;

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
    final FlanCellThemeData themeData = FlanTheme.of(context).cellTheme;
    final double paddingVertical = _getPaddingVertical(themeData);

    final EdgeInsets cellPadding = padding ??
        EdgeInsets.symmetric(
          horizontal: themeData.horizontalPadding,
          vertical: paddingVertical,
        );
    final Color bgColor = this.bgColor ?? themeData.backgroundColor;

    final Widget requiredIcon = Positioned(
      top: paddingVertical,
      left: FlanThemeVars.paddingXs,
      child: Visibility(
        visible: isRequired,
        child: Text(
          '*',
          style: TextStyle(
            color: themeData.requiredColor,
            height: 1.2,
          ),
        ),
      ),
    );

    final Widget bottomBorder = Positioned(
      left: FlanThemeVars.paddingMd,
      right: FlanThemeVars.paddingMd,
      bottom: 0.0,
      child: Visibility(
        visible: border,
        child: Container(
          height: 0.5,
          color: themeData.borderColor,
        ),
      ),
    );

    final Widget content = Row(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: <Widget?>[
        _buildLeftIcon(themeData),
        _buildTitle(themeData),
        _buildValue(themeData),
        _buildRigthIcon(themeData),
        extraSlots,
      ].noNull,
    );

    Widget buildCell(Color bgColor) {
      return Stack(
        children: <Widget>[
          Container(
            color: bgColor,
            padding: cellPadding,
            child: content,
          ),
          bottomBorder,
          requiredIcon,
        ],
      );
    }

    Widget cell;
    if (_isClickable) {
      cell = FlanActiveResponse(
        builder: (BuildContext contenxt, bool active) {
          return buildCell(active ? themeData.activeColor : bgColor);
        },
        onClick: () {
          if (onClick != null) {
            onClick!();
          }
          route(context);
        },
      );
    } else {
      cell = buildCell(bgColor);
    }

    return Semantics(
      container: true,
      button: _isClickable,
      child: DefaultTextStyle(
        style: TextStyle(
          color: themeData.textColor,
          fontSize: themeData.fontSize,
          // height: themeData.lineHeight ,
        ),
        child: cell,
      ),
    );
  }

  /// 是否可以点击
  bool get _isClickable => isLink || clickable;

  /// 单元格内边距
  double _getPaddingVertical(FlanCellThemeData themeData) {
    switch (size) {
      case FlanCellSize.large:
        return themeData.largeVerticalPadding;
      case FlanCellSize.normal:
        return themeData.verticalPadding;
    }
  }

  double _getTitleFontSize(FlanCellThemeData themeData) {
    switch (size) {
      case FlanCellSize.large:
        return themeData.largeTitleFontSize;
      case FlanCellSize.normal:
        return themeData.fontSize;
    }
  }

  double _getLabelFontSize(FlanCellThemeData themeData) {
    switch (size) {
      case FlanCellSize.large:
        return themeData.largeLabelFontSize;
      case FlanCellSize.normal:
        return themeData.labelFontSize;
    }
  }

  /// 构建标题
  Widget? _buildTitle(FlanCellThemeData themeData) {
    if (titleSlot != null || title != null) {
      final Widget title = DefaultTextStyle.merge(
        style: TextStyle(
          fontSize: _getTitleFontSize(themeData),
        ).merge(titleStyle),
        child: titleSlot ?? Text(this.title!),
      );

      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget?>[
            title,
            _buildLabel(themeData),
          ].noNull,
        ),
      );
    }
  }

  /// 构建标题下方的描述信息
  Widget? _buildLabel(FlanCellThemeData themeData) {
    final bool showLabel = labelSlot != null || label != null;
    if (showLabel) {
      final double fontSize = _getLabelFontSize(themeData);
      return DefaultTextStyle.merge(
        style: TextStyle(
          color: themeData.labelColor,
          fontSize: fontSize,
          // height: themeData.labelLineHeight,
        ).merge(labelStyle),
        child: Padding(
          padding: EdgeInsets.only(top: themeData.labelMarginTop),
          child: labelSlot ?? Text(label!),
        ),
      );
    }
  }

  /// 构建右侧内容
  Widget? _buildValue(FlanCellThemeData themeData) {
    final bool hasValue = child != null || value != null;
    if (hasValue) {
      final bool hasTitle = titleSlot != null || title != null;
      final Widget value = Align(
        alignment: !hasTitle ? Alignment.centerLeft : Alignment.centerRight,
        child: child ?? Text(this.value!),
      );

      final TextStyle vStyle = TextStyle(
        color: hasTitle ? themeData.valueColor : null,
      ).merge(valueStyle);

      return Expanded(
        child: DefaultTextStyle.merge(
          style: vStyle,
          child: value,
        ),
      );
    }
  }

  /// 构建左侧图标
  Widget? _buildLeftIcon(FlanCellThemeData themeData) {
    if (iconSlot != null) {
      return iconSlot;
    }

    if (iconName != null || iconUrl != null) {
      return _buildIcon(
        themeData,
        padding: const EdgeInsets.only(right: FlanThemeVars.paddingBase),
        child: FlanIcon(
          iconName: iconName,
          iconUrl: iconUrl,
          size: themeData.iconSize,
        ),
      );
    }
  }

  /// 构建右侧图标
  Widget? _buildRigthIcon(FlanCellThemeData themeData) {
    if (rightIconSlot != null) {
      return rightIconSlot;
    }

    if (isLink) {
      return _buildIcon(
        themeData,
        padding: const EdgeInsets.only(left: FlanThemeVars.paddingBase),
        child: FlanIcon(
          iconName: _arrowIcon,
          size: themeData.iconSize,
          color: themeData.rightIconColor,
        ),
      );
    }
  }

  /// cell 图标布局hack
  Widget _buildIcon(
    FlanCellThemeData themeData, {
    Widget? child,
    EdgeInsets? padding,
  }) {
    return Container(
      constraints: BoxConstraints(
        minWidth: ThemeVars.cellFontSize,
        minHeight: themeData.fontSize * 1.34,
      ),
      padding: padding,
      alignment: Alignment.center,
      child: child,
    );
  }

  /// 箭头icon
  IconData get _arrowIcon {
    switch (arrowDirection) {
      case FlanCellArrowDirection.up:
        return FlanIcons.arrow_up;
      case FlanCellArrowDirection.down:
        return FlanIcons.arrow_down;
      case FlanCellArrowDirection.left:
        return FlanIcons.arrow_left;
      case FlanCellArrowDirection.right:
        return FlanIcons.arrow;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('title', title));
    properties.add(DiagnosticsProperty<String>('value', value));
    properties.add(DiagnosticsProperty<FlanCellSize>('size', size,
        defaultValue: FlanCellSize.normal));
    properties.add(DiagnosticsProperty<IconData>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    properties
        .add(DiagnosticsProperty<bool>('border', border, defaultValue: true));
    properties.add(
        DiagnosticsProperty<bool>('clickable', clickable, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('isLink', isLink, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('isRequired', isRequired,
        defaultValue: false));
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
