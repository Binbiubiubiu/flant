// 🐦 Flutter imports:

import 'package:flant/utils/widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/components/cell_theme.dart';
import '../styles/components/collapse_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import 'cell.dart';
import 'collapse.dart';
import 'icon.dart';

/// ### FlanCollapseItem 折叠面板
class FlanCollapseItem extends StatefulWidget {
  const FlanCollapseItem({
    Key? key,
    this.title,
    this.value,
    this.label,
    this.size = FlanCellSize.normal,
    this.iconName,
    this.iconUrl,
    this.border = true,
    this.clickable = false,
    this.isLink = true,
    this.isRequired = false,
    this.center = false,
    this.arrowDirection = FlanCellArrowDirection.right,
    this.titleStyle,
    this.valueStyle,
    this.labelStyle,
    this.name,
    this.disabled = false,
    this.readonly = false,
    this.child,
    this.valueSlot,
    this.iconSlot,
    this.titleSlot,
    this.rightIconSlot,
  }) : super(key: key);

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

  /// 唯一标识符，默认为索引值
  final String? name;

  /// 是否禁用面板
  final bool disabled;

  /// 是否为只读状态，只读状态下无法操作面板
  final bool readonly;

  // ****************** Event ******************

  // ****************** Slots ******************

  /// 面板内容
  final Widget? child;

  /// 自定义显示内容
  final Widget? valueSlot;

  /// 自定义 `icon`
  final Widget? iconSlot;

  /// 自定义 `title`
  final Widget? titleSlot;

  /// 自定义右侧按钮，默认是 `arrow`
  final Widget? rightIconSlot;

  @override
  _FlanCollapseItemState<String> createState() =>
      _FlanCollapseItemState<String>();
}

class _FlanCollapseItemState<T> extends State<FlanCollapseItem>
    with TickerProviderStateMixin {
  late AnimationController collapseAnimationController;
  late Animation<double> collapseIconAnimation;
  late Animation<double> collapseWrapperAnimation;

  FlanCollapseThemeData? _themeData;
  double? maxHeight = 0.0;
  late int _index;

  GlobalKey wrapKey = GlobalKey();

  @override
  void initState() {
    _index = _parent.children.indexOf(widget);

    nextTick(() {
      maxHeight = wrapKey.currentContext?.size?.height;
      collapseWrapperAnimation = collapseAnimationController
          .drive(Tween<double>(begin: 0.0, end: maxHeight));
      setState(() {});
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final FlanCollapseThemeData ctd = FlanTheme.of(context).collapseTheme;
    if (ctd != _themeData) {
      _themeData = ctd;
      collapseAnimationController = AnimationController(
        value: _expanded ? 1.0 : 0.0,
        duration: _themeData?.itemTransitionDuration,
        vsync: this,
      );
      collapseIconAnimation = collapseAnimationController
          .drive(Tween<double>(begin: 0.0, end: -0.5));

      collapseWrapperAnimation = collapseAnimationController
          .drive(Tween<double>(begin: 0.0, end: maxHeight));
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(FlanCollapseItem oldWidget) {
    if (_expanded) {
      collapseAnimationController.forward();
    } else {
      collapseAnimationController.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    collapseAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget title = Semantics(
      button: true,
      excludeSemantics: true,
      toggled: _expanded,
      child: FlanCell(
        rightIconSlot: Padding(
          padding: const EdgeInsets.only(left: FlanThemeVars.paddingBase),
          child: widget.rightIconSlot ??
              RotationTransition(
                turns: collapseIconAnimation,
                child: _CollapseRightIcon(
                  color: widget.disabled
                      ? _themeData?.itemTitleDisabledColor
                      : null,
                ),
              ),
        ),
        onClick: _onClick,
        iconSlot: widget.iconSlot,
        titleSlot: widget.titleSlot,
        child: widget.valueSlot,
        border: _expanded && widget.border,
        title: widget.title,
        value: widget.value,
        label: widget.label,
        size: widget.size,
        iconName: widget.iconName,
        iconUrl: widget.iconUrl,
        disabled: widget.disabled,
        clickable: widget.clickable && !widget.readonly,
        isLink: widget.isLink && !widget.readonly,
        isRequired: widget.isRequired,
        center: widget.center,
        arrowDirection: widget.arrowDirection,
        titleStyle: widget.titleStyle,
        valueStyle: widget.valueStyle,
        labelStyle: widget.labelStyle,
      ),
    );

    final Widget content = _AnimatedContentSize(
      maxHeight: maxHeight!,
      listenable: collapseAnimationController,
      child: DefaultTextStyle(
        style: TextStyle(
          color: _themeData?.itemContentTextColor,
          fontSize: _themeData?.itemContentFontSize,
          height: _themeData?.itemContentLineHeight,
        ),
        child: Container(
          key: wrapKey,
          color: _themeData?.itemContentBackgroundColor,
          padding: _themeData?.itemContentPadding,
          child: widget.child,
        ),
      ),
    );

    return Column(
      children: <Widget>[
        Visibility(
          visible: _index > 0 && widget.border,
          child: const Divider(
            height: 0.5,
            indent: FlanThemeVars.paddingMd,
            endIndent: FlanThemeVars.paddingMd,
            color: FlanThemeVars.borderColor,
          ),
        ),
        title,
        content
      ],
    );
  }

  void _onClick() {
    if (widget.disabled || widget.readonly) {
      return;
    }

    if (_expanded) {
      collapseAnimationController.reverse();
    } else {
      collapseAnimationController.forward();
    }
    _parent.toggle(_currentName, !_expanded);
  }

  void toggle([bool? newValue]) {
    _parent.toggle(_currentName, newValue ?? !_expanded);
  }

  bool get _expanded => _parent.isExpanded(_currentName);
  String get _currentName => widget.name ?? '$_index';

  FlanCollapse get _parent {
    final FlanCollapse? parent =
        context.findAncestorWidgetOfExactType<FlanCollapse>();

    if (parent == null) {
      throw 'FlanCollapseItem must be a child component of FlanCollapse';
    }
    return parent;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('value', widget.value));
    properties.add(DiagnosticsProperty<String>('value', widget.value));
    properties.add(DiagnosticsProperty<String>('title', widget.title));
    properties.add(DiagnosticsProperty<String>('value', widget.value));
    properties.add(DiagnosticsProperty<FlanCellSize>('size', widget.size,
        defaultValue: FlanCellSize.normal));
    properties.add(DiagnosticsProperty<IconData>('iconName', widget.iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', widget.iconUrl));
    properties.add(
        DiagnosticsProperty<bool>('border', widget.border, defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('clickable', widget.clickable,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('isLink', widget.isLink,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('isRequired', widget.isRequired,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('disabled', widget.disabled,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('readonly', widget.readonly,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('center', widget.center,
        defaultValue: false));
    properties.add(DiagnosticsProperty<FlanCellArrowDirection>(
        'arrowDirection', widget.arrowDirection,
        defaultValue: FlanCellArrowDirection.right));
    properties
        .add(DiagnosticsProperty<TextStyle>('titleStyle', widget.titleStyle));
    properties
        .add(DiagnosticsProperty<TextStyle>('valueStyle', widget.valueStyle));
    properties
        .add(DiagnosticsProperty<TextStyle>('labelStyle', widget.labelStyle));
    properties.add(DiagnosticsProperty<FlanCellSize>('size', widget.size,
        defaultValue: FlanCellSize.normal));
    super.debugFillProperties(properties);
  }
}

class _AnimatedContentSize extends AnimatedWidget {
  const _AnimatedContentSize({
    Key? key,
    required Animation<double> listenable,
    required this.maxHeight,
    this.child,
  }) : super(key: key, listenable: listenable);

  final double maxHeight;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Tween<double>(begin: 0.0, end: maxHeight)
          .evaluate(listenable as Animation<double>),
      child: SingleChildScrollView(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        child: UnconstrainedBox(
          alignment: Alignment.topCenter,
          constrainedAxis: Axis.horizontal,
          child: child,
        ),
      ),
    );
  }
}

class _CollapseRightIcon extends StatelessWidget {
  const _CollapseRightIcon({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final FlanCellThemeData themeData = FlanTheme.of(context).cellTheme;

    return Container(
      constraints: BoxConstraints(
        minWidth: themeData.fontSize,
        minHeight: themeData.fontSize * 1.34,
      ),
      alignment: Alignment.center,
      child: FlanIcon(
        iconName: FlanIcons.arrow_down,
        size: themeData.iconSize,
        color: color,
      ),
    );
  }
}
