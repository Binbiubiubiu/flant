// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/utils/widget.dart';
import '../styles/components/cell_theme.dart';
import '../styles/components/collapse_theme.dart';
import '../styles/theme.dart';
import '../styles/var.dart';
import 'cell.dart';
import 'collapse.dart';
import 'icon.dart';

/// ### FlanCollapseItem 折叠面板
class FlanCollapseItem extends StatefulWidget {
  factory FlanCollapseItem({
    Key? key,
    String? title,
    String? value,
    String? label,
    FlanCellSize? size,
    IconData? iconName,
    String? iconUrl,
    bool? border,
    bool? clickable,
    bool? isLink,
    bool? isRequired,
    bool? center,
    FlanCellArrowDirection? arrowDirection,
    TextStyle? titleStyle,
    TextStyle? valueStyle,
    TextStyle? labelStyle,
    String? name,
    bool? disabled,
    bool? readonly,
    Widget? child,
    Widget? valueSlot,
    Widget? iconSlot,
    Widget? titleSlot,
    Widget? rightIconSlot,
  }) {
    return FlanCollapseItem.raw(
      key: key,
      title: title,
      value: value,
      label: label,
      size: size ?? FlanCellSize.normal,
      iconName: iconName,
      iconUrl: iconUrl,
      border: border ?? true,
      clickable: clickable ?? true,
      isLink: isLink ?? true,
      isRequired: isRequired ?? false,
      center: center ?? false,
      arrowDirection: arrowDirection ?? FlanCellArrowDirection.right,
      titleStyle: titleStyle,
      valueStyle: valueStyle,
      labelStyle: labelStyle,
      name: name,
      disabled: disabled ?? false,
      readonly: readonly ?? false,
      child: child,
      valueSlot: valueSlot,
      iconSlot: iconSlot,
      titleSlot: titleSlot,
      rightIconSlot: rightIconSlot,
    );
  }

  const FlanCollapseItem.raw({
    Key? key,
    this.title,
    this.value,
    this.label,
    required this.size,
    this.iconName,
    this.iconUrl,
    required this.border,
    required this.clickable,
    required this.isLink,
    required this.isRequired,
    required this.center,
    required this.arrowDirection,
    this.titleStyle,
    this.valueStyle,
    this.labelStyle,
    this.name,
    required this.disabled,
    required this.readonly,
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
  FlanCollapseItemState createState() => FlanCollapseItemState();
}

class FlanCollapseItemState extends State<FlanCollapseItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final FlanCollapseThemeData themeData = FlanTheme.of(context).collapseTheme;
    final Color? iconColor =
        widget.disabled ? themeData.itemTitleDisabledColor : null;
    final bool _expanded = this._expanded;

    final Widget title = Semantics(
      button: true,
      excludeSemantics: true,
      toggled: _expanded,
      child: FlanCell(
        rightIconSlot: Padding(
          padding: EdgeInsets.only(left: FlanThemeVars.paddingBase.rpx),
          child: widget.rightIconSlot ??
              _CollapseRightIcon(
                expanded: _expanded,
                duration: themeData.itemTransitionDuration,
                color: iconColor,
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

    final Widget content = _AnimatedContent(
      expanded: _expanded,
      duration: themeData.itemTransitionDuration,
      child: DefaultTextStyle(
        style: TextStyle(
          color: themeData.itemContentTextColor,
          fontSize: themeData.itemContentFontSize,
          height: themeData.itemContentLineHeight,
        ),
        child: Container(
          color: themeData.itemContentBackgroundColor,
          padding: themeData.itemContentPadding,
          child: widget.child,
        ),
      ),
    );

    return Column(
      children: <Widget>[
        Visibility(
          visible: _index > 0 && widget.border,
          child: Divider(
            height: 0.5,
            indent: FlanThemeVars.paddingMd.rpx,
            endIndent: FlanThemeVars.paddingMd.rpx,
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
    _parent.toggle(_currentName, !_expanded);
  }

  void toggle([bool? newValue]) {
    _parent.toggle(_currentName, newValue ?? !_expanded);
  }

  bool get _expanded => _parent.isExpanded(_currentName);
  String get _currentName => widget.name ?? '$_index';
  int get _index => _parent.children.indexOf(widget);

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

// 折叠动画组件
class _AnimatiedSize extends AnimatedWidget {
  const _AnimatiedSize({
    Key? key,
    required Animation<double> listenable,
    this.child,
  }) : super(key: key, listenable: listenable);

  final Widget? child;

  double get height => (listenable as Animation<double>).value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: child,
    );
  }
}

// 折叠内容组件
class _AnimatedContent extends StatefulWidget {
  const _AnimatedContent({
    Key? key,
    required this.duration,
    this.expanded = false,
    this.child,
  }) : super(key: key);

  final Duration duration;

  final bool expanded;

  final Widget? child;

  @override
  __AnimatedContentState createState() => __AnimatedContentState();
}

class __AnimatedContentState extends State<_AnimatedContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  GlobalKey wrapKey = GlobalKey();
  double? maxHeight = 0.0;

  @override
  void initState() {
    _animation = _controller = AnimationController(
      value: widget.expanded ? 1.0 : 0.0,
      duration: widget.duration,
      vsync: this,
    );

    _calcMaxHeight();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _AnimatedContent oldWidget) {
    _calcMaxHeight();

    // 重新计算高度后再动画
    nextTick(() {
      if (widget.expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  void _calcMaxHeight() {
    nextTick(() {
      final double? currentMaxHeight = wrapKey.currentContext?.size?.height;
      if (maxHeight != currentMaxHeight) {
        maxHeight = wrapKey.currentContext?.size?.height;
        _animation =
            _controller.drive(Tween<double>(begin: 0.0, end: maxHeight));
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AnimatiedSize(
      listenable: _animation,
      child: SingleChildScrollView(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        child: UnconstrainedBox(
          key: wrapKey,
          alignment: Alignment.topCenter,
          constrainedAxis: Axis.horizontal,
          child: widget.child,
        ),
      ),
    );
  }
}

// 旋转图标组件
class _CollapseRightIcon extends StatefulWidget {
  const _CollapseRightIcon({
    Key? key,
    this.color,
    required this.duration,
    this.expanded = false,
  }) : super(key: key);

  final Color? color;

  final Duration duration;

  final bool expanded;

  @override
  __CollapseRightIconState createState() => __CollapseRightIconState();
}

class __CollapseRightIconState extends State<_CollapseRightIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      value: widget.expanded ? 1.0 : 0.0,
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.5).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _CollapseRightIcon oldWidget) {
    if (widget.expanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final FlanCellThemeData themeData = FlanTheme.of(context).cellTheme;

    return RotationTransition(
      turns: _animation,
      child: Container(
        constraints: BoxConstraints(
          minWidth: themeData.fontSize,
          minHeight: themeData.fontSize * 1.34,
        ),
        alignment: Alignment.center,
        child: FlanIcon(
          iconName: FlanIcons.arrow_down,
          size: themeData.iconSize,
          color: widget.color,
        ),
      ),
    );
  }
}
