// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

// 🌎 Project imports:
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
    this.iconPrefix = kFlanIconsFamily,
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

  GlobalKey wrapKey = GlobalKey();

  @override
  void initState() {
    collapseAnimationController = AnimationController(
      duration: ThemeVars.collapseItemTransitionDuration,
      vsync: this,
    )..addListener(_handleAnimationChange);
    collapseIconAnimation = collapseAnimationController
        .drive(CurveTween(curve: Curves.linear))
        .drive(Tween<double>(begin: 0.0, end: -0.5));
    collapseWrapperAnimation = collapseAnimationController;

    WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
      final double? height = wrapKey.currentContext?.size?.height;
      collapseWrapperAnimation = Tween<double>(begin: 0.0, end: height)
          .animate(collapseWrapperAnimation);

      collapseAnimationController.value = expanded ? 1.0 : 0.0;
    });

    super.initState();
  }

  @override
  void didUpdateWidget(FlanCollapseItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (expanded) {
      collapseAnimationController.forward();
    } else {
      collapseAnimationController.reverse();
    }
  }

  void _handleAnimationChange() => setState(() {});

  @override
  void dispose() {
    collapseAnimationController
      ..removeListener(_handleAnimationChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Semantics title = Semantics(
      button: true,
      sortKey: OrdinalSortKey(widget.disabled ? -1 : 0),
      excludeSemantics: true,
      toggled: expanded,
      child: FlanCell(
        disabled: widget.disabled,
        rightIconSlot: RotationTransition(
          turns: collapseIconAnimation,
          child:
              widget.rightIconSlot ?? const FlanIcon.name(FlanIcons.arrow_down),
        ), // this.widget.rightIconSlot,
        onClick: () {
          if (expanded) {
            collapseAnimationController.reverse();
          } else {
            collapseAnimationController.forward();
          }

          parent.toggle(currentName, !expanded);
        },
        iconSlot: widget.iconSlot,
        titleSlot: widget.titleSlot,
        child: widget.valueSlot,
        border: expanded && widget.border,
        title: widget.title,
        value: widget.value,
        label: widget.label,
        size: widget.size,
        iconName: widget.iconName,
        iconUrl: widget.iconUrl,
        iconPrefix: widget.iconPrefix,
        clickable: widget.clickable,
        isLink: widget.isLink,
        isRequired: widget.isRequired,
        center: widget.center,
        arrowDirection: widget.arrowDirection,
        titleStyle: widget.titleStyle,
        valueStyle: widget.valueStyle,
        labelStyle: widget.labelStyle,
      ),
    );

    final SizedBox content = SizedBox(
      width: double.infinity,
      height: collapseWrapperAnimation.value,
      child: SingleChildScrollView(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        child: UnconstrainedBox(
          alignment: Alignment.topCenter,
          constrainedAxis: Axis.horizontal,
          child: Container(
            key: wrapKey,
            color: ThemeVars.collapseItemContentBackgroundColor,
            padding: ThemeVars.collapseItemContentPadding,
            child: DefaultTextStyle(
              style: const TextStyle(
                color: ThemeVars.collapseItemContentTextColor,
                fontSize: ThemeVars.collapseItemContentFontSize,
                height: ThemeVars.collapseItemContentLineHeight,
              ),
              child: widget.child ?? const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );

    return Column(
      children: <Widget>[
        Visibility(
          visible: index > 0 && widget.border,
          child: Divider(
            height: 0.5,
            indent: ThemeVars.collapseItemContentPadding.left,
            endIndent: ThemeVars.collapseItemContentPadding.right,
            color: ThemeVars.cellBorderColor,
          ),
        ),
        title,
        content
      ],
    );
  }

  FlanCollapse get parent {
    final FlanCollapse? parent =
        context.findAncestorWidgetOfExactType<FlanCollapse>();

    if (parent == null) {
      throw 'FlanCollapseItem must be a child component of FlanCollapse';
    }

    return parent;
  }

  int get index => parent.children.indexOf(widget);

  String get currentName => widget.name ?? '$index';

  bool get expanded => parent.isExpanded(currentName);

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
    properties
        .add(DiagnosticsProperty<String>('iconPrefix', widget.iconPrefix));
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

class _FlanCollapseContent extends StatefulWidget {
  const _FlanCollapseContent({Key? key}) : super(key: key);

  @override
  __FlanCollapseContentState createState() => __FlanCollapseContentState();
}

class __FlanCollapseContentState extends State<_FlanCollapseContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const SizedBox(),
    );
  }
}
