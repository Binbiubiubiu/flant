import 'package:flant/flant.dart';
import 'package:flant/utils/widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef FlanTabsBeforeChange = Future<bool> Function(String name);

typedef FlanTabsValueCallback = void Function(String name, String title);

typedef FlanTabsScrollCallback = void Function(FlanTabScrollDetail detail);

class FlanTabs extends StatefulWidget {
  const FlanTabs({
    Key? key,
    this.color,
    this.border = false,
    this.sticky = false,
    this.animated = false,
    this.ellipsis = true,
    this.swipeable = false,
    this.scrollspy = false,
    this.background,
    this.lazyRender = true,
    this.lineWidth,
    this.lineHeight,
    this.beforeChange,
    this.titleActiveColor,
    this.titleInactiveColor,
    this.type = FlanTabsType.line,
    this.active = '0',
    this.duration = const Duration(milliseconds: 300),
    this.offsetTop = 0.0,
    this.swipeThreshold = 5,
    this.onClick,
    this.onChange,
    this.onDisabled,
    this.onRendered,
    this.onScroll,
    this.children = const <FlanTab>[],
    this.titleSlot,
    this.navLeftSlot,
    this.navRightSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 标签主题色
  final Color? color;

  /// 是否显示标签栏外边框，仅在 `type="line"` 时有效
  final bool border;

  /// 是否使用粘性定位布局
  final bool sticky;

  /// 是否开启切换标签内容时的转场动画
  final bool animated;

  /// 是否省略过长的标题文字
  final bool ellipsis;

  /// 是否开启手势左右滑动切换
  final bool swipeable;

  /// 是否开启滚动导航
  final bool scrollspy;

  /// 标签栏背景色
  final Color? background;

  /// 是否开启延迟渲染（首次切换到标签时才触发内容渲染）
  final bool lazyRender;

  /// 底部条宽度
  final double? lineWidth;

  /// 底部条高度
  final double? lineHeight;

  /// 切换标签前的回调函数，返回 `false` 可阻止切换，支持返回 Future
  final FlanTabsBeforeChange? beforeChange;

  /// 标题选中态颜色
  final Color? titleActiveColor;

  /// 标题默认态颜色
  final Color? titleInactiveColor;

  /// 样式风格类型，可选值为 `card`
  final FlanTabsType type;

  /// 绑定当前选中标签的标识符
  final String active;

  /// 动画时间
  final Duration duration;

  /// 粘性定位布局下与顶部的最小距离
  final double offsetTop;

  /// 滚动阈值，标签数量超过阈值且总宽度超过标签栏宽度时开始横向滚动
  final int swipeThreshold;

  // ****************** Events ******************

  /// 点击标签时触发
  final FlanTabsValueCallback? onClick;

  /// 当前激活的标签改变时触发
  final FlanTabsValueCallback? onChange;

  /// 点击被禁用的标签时触发
  final FlanTabsValueCallback? onDisabled;

  /// 标签内容首次渲染时触发（仅在开启延迟渲染后触发）
  final FlanTabsValueCallback? onRendered;

  /// 滚动时触发，仅在 sticky 模式下生效
  final FlanTabsScrollCallback? onScroll;

  // ****************** Slots ******************
  /// 标签页内容
  final List<FlanTab> children;

  /// 自定义标题
  final Widget? titleSlot;

  /// 标题左侧内容
  final Widget? navLeftSlot;

  /// 标题右侧内容
  final Widget? navRightSlot;

  static FlanTabsState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_FlanTabsScope>()?.state;
  }

  @override
  FlanTabsState createState() => FlanTabsState();
}

class FlanTabsState extends State<FlanTabs> {
  bool inited = false;
  int currentIndex = -1;

  List<double> titleWidth = <double>[];

  ValueNotifier<double> titleLineOffsetLeft = ValueNotifier<double>(0.0);
  late ScrollController titleHeaderScrollController;
  late PageController pageController;

  void registeTitle(BuildContext context, int index) {
    final double width = context.size?.width ?? 0.0;
    titleWidth[index] = width;
  }

  @override
  void initState() {
    titleWidth =
        List<double>.generate(widget.children.length, (int index) => 0.0);
    titleHeaderScrollController = ScrollController();
    pageController = PageController(initialPage: currentIndex);
    Future<void>.delayed(Duration.zero, () {
      // titleLineOffsetLeft.value = titleWidth[0] / 2;
      print(titleWidth);
    });
    super.initState();
  }

  @override
  void dispose() {
    titleHeaderScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _FlanTabsScope(
      state: this,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildHeader(),
          SizedBox(
            width: 500.0,
            height: 500.0,
            child: PageView(
              controller: pageController,
              onPageChanged: setCurrentIndex,
              children: widget.children,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNav() {
    return List<Widget>.generate(widget.children.length, (int index) {
      final FlanTab item = widget.children[index];
      Widget title = FlanTabsTitle(
        index: index,
        dot: item.dot,
        type: widget.type,
        badge: item.badge,
        title: item.title,
        color: widget.color,
        // style:item.titleStyle
        isActive: index == currentIndex,
        disabled: item.disabled,
        scrollable: scrollable,
        titleSlot: item.titleSlot,
        activeColor: widget.titleActiveColor,
        inActiveColor: widget.titleInactiveColor,
        isLast: index == widget.children.length - 1,
        onClick: () {
          setLine(index);
          scrollIntoView(index);
          onClick.call(item, index);
        },
      );
      if (!scrollable) {
        title = Expanded(
          child: title,
        );
      }
      return title;
    });
  }

  void setLine(int index) {
    titleLineOffsetLeft.value = complateTitleOffsetLeft(titleWidth, index);
  }

  void scrollIntoView(int index) {
    if (!scrollable || navKey.currentContext != null) {
      return;
    }
    final double navWidth = navKey.currentContext?.size?.width ?? 0.0;
    titleHeaderScrollController.animateTo(
      titleLineOffsetLeft.value - (navWidth - titleWidth[index]) / 2,
      duration: widget.duration,
      curve: Curves.linear,
    );
  }

  GlobalKey navKey = GlobalKey();

  Widget _buildHeader() {
    final bool isLine = widget.type == FlanTabsType.line;
    final bool isCard = widget.type == FlanTabsType.card;
    final EdgeInsets linePadding =
        isLine ? const EdgeInsets.only(bottom: 15.0) : EdgeInsets.zero;
    final EdgeInsets complete = scrollable
        ? const EdgeInsets.only(
            left: ThemeVars.paddingXs, right: ThemeVars.paddingXs)
        : EdgeInsets.zero;

    final EdgeInsets cardMargin = isCard
        ? const EdgeInsets.symmetric(horizontal: ThemeVars.paddingMd)
        : EdgeInsets.zero;

    return Container(
      padding: linePadding,
      decoration: BoxDecoration(
        color: ThemeVars.tabsNavBackgroundColor,
        border: isLine && widget.border
            ? const Border(top: FlanHairLine(), bottom: FlanHairLine())
            : null,
      ),
      child: SingleChildScrollView(
        controller: titleHeaderScrollController,
        scrollDirection: Axis.horizontal,
        physics: scrollable
            ? const ClampingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: Container(
          key: navKey,
          height: isLine ? ThemeVars.tabsLineHeight : ThemeVars.tabsCardHeight,
          padding: complete,
          margin: cardMargin,
          decoration: isCard
              ? BoxDecoration(
                  border: const Border.fromBorderSide(
                    BorderSide(
                      color: ThemeVars.tabsDefaultColor,
                      width: ThemeVars.borderWidthBase,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(ThemeVars.borderRadiusSm),
                )
              : null,
          child: Stack(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  widget.navLeftSlot ?? const SizedBox.shrink(),
                  ..._buildNav(),
                  widget.navRightSlot ?? const SizedBox.shrink(),
                ],
              ),
              ValueListenableBuilder<double>(
                valueListenable: titleLineOffsetLeft,
                builder: (BuildContext context, double value, Widget? child) {
                  return AnimatedPositioned(
                    duration: widget.duration,
                    bottom: 0,
                    left: titleLineOffsetLeft.value,
                    child: child!,
                  );
                },
                child: FractionalTranslation(
                  translation: const Offset(-0.5, 0.0),
                  child: Container(
                    width: ThemeVars.tabsBottomBarWidth,
                    height: ThemeVars.tabsBottomBarHeight,
                    decoration: BoxDecoration(
                      color: ThemeVars.tabsBottomBarColor,
                      borderRadius:
                          BorderRadius.circular(ThemeVars.tabsBottomBarHeight),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onClick(FlanTab item, int index) {
    final String title = item.title;
    final bool disabled = item.disabled;
    final String name = getTabName(item, index);
    if (disabled) {
      widget.onDisabled?.call(name, title);
    } else {
      widget.beforeChange?.call(name).then((bool flag) {
        if (flag) {
          setCurrentIndex(index);
          scrollToCurrentContent();
        }
      });
      widget.onClick?.call(name, title);
    }
  }

  void scrollTo(String name) {
    nextTick(() {
      setCurrentIndexByName(name);
      scrollToCurrentContent(true);
    });
  }

  void setCurrentIndexByName(String name) {
    int index = 0;
    for (int i = 0; i < widget.children.length; i++) {
      final FlanTab tab = widget.children[i];
      if (getTabName(tab, i) == name) {
        index = i;
      }
    }

    setCurrentIndex(index);
  }

  void scrollToCurrentContent([bool immediate = false]) {
    if (immediate) {
      pageController.jumpToPage(currentIndex);
    } else {
      pageController.animateToPage(
        currentIndex,
        duration: widget.duration,
        curve: Curves.linear,
      );
    }
  }

  void setCurrentIndex(int currentIndex) {
    final int? newIndex = findAvailableTab(currentIndex);
    if (newIndex == null) {
      return;
    }

    final FlanTab newTab = widget.children[newIndex];
    final String newName = getTabName(newTab, newIndex);

    currentIndex = newIndex;
    if (newName != widget.active) {
      widget.onChange?.call(newName, newTab.title);
    }
  }

  int? findAvailableTab(int index) {
    final int diff = index < currentIndex ? -1 : 1;
    while (index > 0 && index < widget.children.length) {
      if (!widget.children[index].disabled) {
        return index;
      }
      index += diff;
    }
    return null;
  }

  bool get scrollable =>
      widget.children.length > widget.swipeThreshold || !widget.ellipsis;

  String getTabName(FlanTab tab, int index) => tab.name ?? '$index';

  String get currentName {
    final FlanTab activeTab = widget.children[currentIndex];
    return getTabName(activeTab, currentIndex);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Color>('color', widget.color));
    properties.add(DiagnosticsProperty<bool>('border', widget.border,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('sticky', widget.sticky,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('animated', widget.animated,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('ellipsis', widget.ellipsis,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('swipeable', widget.swipeable,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('scrollspy', widget.scrollspy,
        defaultValue: false));
    properties.add(DiagnosticsProperty<Color>('background', widget.background));
    properties.add(DiagnosticsProperty<bool>('lazyRender', widget.lazyRender,
        defaultValue: true));
    properties.add(DiagnosticsProperty<double>('lineWidth', widget.lineWidth));
    properties
        .add(DiagnosticsProperty<double>('lineHeight', widget.lineHeight));
    properties.add(DiagnosticsProperty<FlanTabsBeforeChange>(
        'beforeChange', widget.beforeChange));
    properties.add(DiagnosticsProperty<Color>(
        'titleActiveColor', widget.titleActiveColor));
    properties.add(DiagnosticsProperty<Color>(
        'titleInactiveColor', widget.titleInactiveColor));
    properties.add(DiagnosticsProperty<FlanTabsType>('type', widget.type,
        defaultValue: FlanTabsType.line));
    properties.add(DiagnosticsProperty<String>('active', widget.active,
        defaultValue: '0'));
    properties.add(DiagnosticsProperty<Duration>('duration', widget.duration,
        defaultValue: const Duration(milliseconds: 300)));
    properties.add(DiagnosticsProperty<double>('offsetTop', widget.offsetTop,
        defaultValue: 0.0));
    properties.add(DiagnosticsProperty<int>(
        'swipeThreshold', widget.swipeThreshold,
        defaultValue: 5));

    super.debugFillProperties(properties);
  }
}

class _FlanTabsScope extends InheritedWidget {
  const _FlanTabsScope({
    Key? key,
    required this.state,
    required Widget child,
  }) : super(key: key, child: child);

  final FlanTabsState state;

  // ignore: unused_element
  static _FlanTabsScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_FlanTabsScope>();
  }

  @override
  bool updateShouldNotify(_FlanTabsScope oldWidget) {
    return true;
  }
}

class FlanTabsTitle extends StatefulWidget {
  const FlanTabsTitle({
    Key? key,
    required this.index,
    required this.isLast,
    this.dot = false,
    required this.type,
    this.color,
    this.title = '',
    this.badge = '',
    this.isActive = false,
    this.disabled = false,
    this.scrollable = false,
    this.activeColor,
    this.titleSlot,
    this.inActiveColor,
    this.onClick,
  }) : super(key: key);

  // ****************** Props ******************
  final int index;
  final bool isLast;
  final bool dot;

  final FlanTabsType type;

  final Color? color;

  final String title;

  final String badge;

  final bool isActive;

  final bool disabled;

  final bool scrollable;

  final Color? activeColor;

  final Color? inActiveColor;

  // ****************** Events ******************
  final VoidCallback? onClick;

  // ****************** Slots ******************

  final Widget? titleSlot;

  @override
  _FlanTabsTitleState createState() => _FlanTabsTitleState();
}

class _FlanTabsTitleState extends State<FlanTabsTitle> {
  void syncTitle() {
    nextTick(() {
      FlanTabs.of(context)?.registeTitle(context, widget.index);
    });
  }

  @override
  void initState() {
    syncTitle();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FlanTabsTitle oldWidget) {
    syncTitle();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: widget.isActive,
      enabled: !widget.disabled,
      child: GestureDetector(
        onTap: () {
          widget.onClick?.call();
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: ThemeVars.paddingMd),
          decoration: BoxDecoration(
            border: isCard && !widget.isLast
                ? const Border(
                    right: BorderSide(
                      color: ThemeVars.tabsDefaultColor,
                      width: ThemeVars.borderWidthBase,
                    ),
                  )
                : null,
          ),
          child: _buildText(context),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    final Widget text = widget.titleSlot ??
        Text(
          widget.title,
          style: TextStyle(
            color: textColor,
            fontWeight: fontWeight,
          ),
          overflow: widget.scrollable ? TextOverflow.ellipsis : null,
        );

    if (widget.dot || widget.badge.isNotEmpty) {
      return FlanBadge(
        dot: widget.dot,
        content: widget.badge,
        child: text,
      );
    }
    return text;
  }

  bool get isCard => widget.type == FlanTabsType.card;

  Color? get backgroundColor {
    Color? _color;

    if (widget.color != null && isCard) {
      if (!widget.disabled) {
        if (widget.isActive) {
          _color = widget.color ?? ThemeVars.tabsDefaultColor;
        }
      }
    }
    return _color;
  }

  FontWeight? get fontWeight {
    if (widget.isActive) {
      return ThemeVars.fontWeightBold;
    }
    return null;
  }

  Color get textColor {
    Color _color = isCard ? ThemeVars.tabsDefaultColor : ThemeVars.tabTextColor;
    if (widget.isActive) {
      _color = isCard ? ThemeVars.white : ThemeVars.tabActiveTextColor;
    }

    if (widget.disabled) {
      _color = ThemeVars.tabDisabledTextColor;
    }

    if (widget.color != null && isCard) {
      if (!widget.disabled) {
        if (widget.isActive) {
        } else {
          _color = widget.color!;
        }
      }
    }

    final Color? titleColor =
        widget.isActive ? widget.activeColor : widget.inActiveColor;
    if (titleColor != null) {
      _color = titleColor;
    }
    return _color;
  }

  MouseCursor get cursor {
    if (widget.disabled) {
      return SystemMouseCursors.forbidden;
    }

    return SystemMouseCursors.click;
  }
}

enum FlanTabsType {
  line,
  card,
}

class FlanTabScrollDetail {
  const FlanTabScrollDetail({
    this.isFixed = false,
    required this.scrollTop,
  });

  final bool isFixed;
  final double scrollTop;
}

double complateTitleOffsetLeft(List<double> titleWidth, int index) {
  double total = 0.0;
  for (int i = 0; i < titleWidth.length; i++) {
    if (i == index) {
      total += titleWidth[i] / 2;
      break;
    }
    total += titleWidth[i];
  }

  return total;
}
