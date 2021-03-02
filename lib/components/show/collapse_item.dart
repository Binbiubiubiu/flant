import 'package:flant/components/base/style.dart';
import 'package:flant/styles/var.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';

import '../base/cell.dart';
import '../base/icon.dart';
import './collapse.dart';

/// ### FlanCollapseItem 折叠面板
class FlanCollapseItem extends StatefulWidget {
  const FlanCollapseItem({
    Key key,
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
  })  : assert(size != null && size is FlanCellSize),
        assert(iconPrefix != null),
        assert(border != null),
        assert(clickable != null),
        assert(isLink != null),
        assert(isRequired != null),
        assert(center != null),
        assert(
            arrowDirection != null && arrowDirection is FlanCellArrowDirection),
        assert(disabled != null),
        super(key: key);

  // ****************** Props ******************

  /// 左侧标题
  final String title;

  /// 右侧内容
  final String value;

  /// 标题下方的描述信息
  final String label;

  /// 单元格大小，可选值为 `large`
  final FlanCellSize size;

  /// 左侧图标名称
  final int iconName;

  /// 左侧图片链接
  final String iconUrl;

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
  final TextStyle titleStyle;

  /// 右侧内容额外类名
  final TextStyle valueStyle;

  /// 描述信息额外类名
  final TextStyle labelStyle;

  /// 唯一标识符，默认为索引值
  final String name;

  /// 是否禁用面板
  final bool disabled;

  // ****************** Event ******************

  // ****************** Slots ******************

  /// 面板内容
  final Widget child;

  /// 自定义显示内容
  final Widget valueSlot;

  /// 自定义 `icon`
  final Widget iconSlot;

  /// 自定义 `title`
  final Widget titleSlot;

  /// 自定义右侧按钮，默认是 `arrow`
  final Widget rightIconSlot;

  @override
  _FlanCollapseItemState createState() => _FlanCollapseItemState();
}

class _FlanCollapseItemState extends State<FlanCollapseItem>
    with TickerProviderStateMixin {
  bool expanded;
  AnimationController collapseAnimationController;
  Animation collapseIconAnimation;
  Animation collapseWrapperAnimation;

  GlobalKey wrapKey = GlobalKey();

  @override
  void initState() {
    this.collapseAnimationController = AnimationController(
      duration: ThemeVars.collapseItemTransitionDuration,
      vsync: this,
    )..addListener(this._handleAnimationChange);
    this.collapseIconAnimation = Tween(begin: 0.0, end: -0.5).animate(
      CurvedAnimation(
        parent: this.collapseAnimationController,
        curve: Curves.linear,
      ),
    );
    this.collapseWrapperAnimation = CurvedAnimation(
      parent: this.collapseAnimationController,
      curve: Curves.easeInOut,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final height = wrapKey.currentContext.size.height;
      this.collapseWrapperAnimation =
          Tween(begin: 0.0, end: height).animate(collapseWrapperAnimation);

      this.setState(() {
        this.expanded = parent.isExpanded(currentName);
        this.collapseAnimationController.value = this.expanded ? 1.0 : 0.0;
      });
    });

    super.initState();
  }

  @override
  void didUpdateWidget(FlanCollapseItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    this.expanded = parent.isExpanded(currentName);
    if (this.expanded) {
      this.collapseAnimationController.forward();
    } else {
      this.collapseAnimationController.reverse();
    }
  }

  _handleAnimationChange() => this.setState(() {});

  @override
  void dispose() {
    if (this.collapseAnimationController != null) {
      this.collapseAnimationController
        ..removeListener(this._handleAnimationChange)
        ..dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = Semantics(
      button: true,
      sortKey: OrdinalSortKey(this.widget.disabled ? -1 : 0),
      excludeSemantics: true,
      toggled: this.expanded,
      child: FlanCell(
        disabled: this.widget.disabled,
        rightIconSlot: RotationTransition(
          turns: this.collapseIconAnimation,
          child:
              this.widget.rightIconSlot ?? FlanIcon.name(FlanIcons.arrow_down),
        ), // this.widget.rightIconSlot,
        onClick: () {
          this.expanded = parent.isExpanded(currentName);

          if (this.expanded) {
            this.collapseAnimationController.reverse();
          } else {
            this.collapseAnimationController.forward();
          }

          parent.toggle(currentName, !this.expanded);
        },
        iconSlot: this.widget.iconSlot,
        titleSlot: this.widget.titleSlot,
        child: this.widget.valueSlot,
        border: this.widget.border,
        title: this.widget.title,
        value: this.widget.value,
        label: this.widget.label,
        size: this.widget.size,
        iconName: this.widget.iconName,
        iconUrl: this.widget.iconUrl,
        iconPrefix: this.widget.iconPrefix,
        clickable: this.widget.clickable,
        isLink: this.widget.isLink,
        isRequired: this.widget.isRequired,
        center: this.widget.center,
        arrowDirection: this.widget.arrowDirection,
        titleStyle: this.widget.titleStyle,
        valueStyle: this.widget.valueStyle,
        labelStyle: this.widget.labelStyle,
      ),
    );

    final content = SizedBox(
      width: double.infinity,
      height: this.collapseWrapperAnimation.value,
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
              style: TextStyle(
                color: ThemeVars.collapseItemContentTextColor,
                fontSize: ThemeVars.collapseItemContentFontSize,
                height: ThemeVars.collapseItemContentLineHeight,
              ),
              child: this.widget.child,
            ),
          ),
        ),
      ),
    );

    return Column(
      children: [
        Visibility(
          visible: index > 0 && this.widget.border,
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

  FlanCollapseProvider<String> get parent {
    final parent = FlanCollapseProvider.of<String>(context);
    if (parent == null) {
      throw "FlanCollapseItem must be a child component of FlanCollapse";
    }

    return parent;
  }

  int get index => parent.child.children.indexOf(this.widget);

  String get currentName => widget.name ?? "$index";

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>("value", this.widget.value));
    properties.add(DiagnosticsProperty<String>("value", this.widget.value));
    properties.add(DiagnosticsProperty<String>("title", this.widget.title));
    properties.add(DiagnosticsProperty<String>("value", this.widget.value));
    properties.add(DiagnosticsProperty<FlanCellSize>("size", this.widget.size,
        defaultValue: FlanCellSize.normal));
    properties.add(DiagnosticsProperty<int>("iconName", this.widget.iconName));
    properties.add(DiagnosticsProperty<String>("iconUrl", this.widget.iconUrl));
    properties
        .add(DiagnosticsProperty<String>("iconPrefix", this.widget.iconPrefix));
    properties.add(DiagnosticsProperty<bool>("border", this.widget.border,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>("clickable", this.widget.clickable,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>("isLink", this.widget.isLink,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        "isRequired", this.widget.isRequired,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>("disabled", this.widget.disabled,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>("center", this.widget.center,
        defaultValue: false));
    properties.add(DiagnosticsProperty<FlanCellArrowDirection>(
        "arrowDirection", this.widget.arrowDirection,
        defaultValue: FlanCellArrowDirection.right));
    properties.add(
        DiagnosticsProperty<TextStyle>("titleStyle", this.widget.titleStyle));
    properties.add(
        DiagnosticsProperty<TextStyle>("valueStyle", this.widget.valueStyle));
    properties.add(
        DiagnosticsProperty<TextStyle>("labelStyle", this.widget.labelStyle));
    properties.add(DiagnosticsProperty<FlanCellSize>("size", this.widget.size,
        defaultValue: FlanCellSize.normal));
    super.debugFillProperties(properties);
  }
}

class _FlanCollapseContent extends StatefulWidget {
  _FlanCollapseContent({Key key}) : super(key: key);

  @override
  __FlanCollapseContentState createState() => __FlanCollapseContentState();
}

class __FlanCollapseContentState extends State<_FlanCollapseContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(),
    );
  }
}
