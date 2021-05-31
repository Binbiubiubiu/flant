// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 🌎 Project imports:
import '../styles/components/swipe_theme.dart';
import '../styles/var.dart';

typedef FlanSwipeIndicatorBuilder = Widget Function(int active);

/// ### Swipe 轮播
class FlanSwipe extends StatefulWidget {
  const FlanSwipe({
    Key? key,
    this.autoplay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
    this.controller,
    this.width,
    this.height,
    this.showIndicators = true,
    this.vertical = false,
    this.touchable = true,
    this.stopPropagation = true,
    this.indicatorColor,
    this.onChange,
    required this.itemCount,
    required this.itemBuilder,
    this.indicatorBuilder,
  }) : super(key: key);

  // ****************** Props ******************
  /// 自动轮播间隔，单位为 ms
  final Duration autoplay;

  /// 动画时长，单位为 ms
  final Duration duration;

  /// 控制器
  final FlanSwipeController? controller;

  /// 滑块宽度
  final double? width;

  /// 滑块高度
  final double? height;

  /// 是否显示指示器
  final bool showIndicators;

  /// 是否为纵向滚动
  final bool vertical;

  /// 是否可以通过手势滑动
  final bool touchable;

  /// 是否阻止滑动事件冒泡
  final bool stopPropagation;

  /// 指示器颜色
  final Color? indicatorColor;

  /// 数量
  final int itemCount;

  // ****************** Events ******************

  /// 每一页轮播结束后触发
  final ValueChanged<int>? onChange;

  // ****************** Slots ******************

  /// 轮播内容
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// 自定义指示器
  final FlanSwipeIndicatorBuilder? indicatorBuilder;

  @override
  _FlanSwipeState createState() => _FlanSwipeState();
}

class _FlanSwipeState extends State<FlanSwipe> {
  late FlanSwipeController _controller;
  late ValueNotifier<int> current;

  Timer? _loopTimer;

  @override
  void initState() {
    _controller = widget.controller ?? FlanSwipeController(itemCount: count);
    current = ValueNotifier<int>(_controller.initialPage % count);
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    current.dispose();
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FlanSwipeThemeData themeData = FlanSwipeTheme.of(context);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification is UserScrollNotification &&
                  notification.direction == ScrollDirection.forward) {
                _stopTimer();
              }

              if (notification is ScrollEndNotification) {
                _startTimer();
              }
              return widget.stopPropagation;
            },
            child: IgnorePointer(
              ignoring: !widget.touchable,
              child: _PageView.builder(
                controller: _controller,
                physics: const ClampingScrollPhysics(),
                scrollDirection:
                    widget.vertical ? Axis.vertical : Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return widget.itemBuilder(context, index % count);
                },
                itemCount: _controller.loop ? null : count,
                onPageChanged: (int value) {
                  final int _current = value % count;
                  current.value = _current;
                  widget.onChange?.call(_current);
                },
              ),
            ),
          ),
          _buildIndicator(themeData),
        ],
      ),
    );
  }

  void _startTimer() {
    if (widget.autoplay != Duration.zero && count > 0) {
      if (!_controller.loop && current.value == count - 1) {
        return;
      }
      _loopTimer?.cancel();
      _loopTimer = Timer(widget.autoplay, () {
        _controller.nextPage(duration: widget.duration, curve: Curves.linear);
      });
    }
  }

  void _stopTimer() {
    if (_loopTimer != null) {
      _loopTimer?.cancel();
      _loopTimer = null;
    }
  }

  int get count => widget.itemCount;

  Widget _buildIndicator(FlanSwipeThemeData themeData) {
    if (widget.indicatorBuilder != null) {
      return ValueListenableBuilder<int>(
        valueListenable: current,
        builder: (BuildContext context, int value, Widget? child) {
          return widget.indicatorBuilder!(current.value);
        },
      );
    }

    if (widget.indicatorBuilder != null || widget.showIndicators && count > 1) {
      return Positioned(
        bottom: widget.vertical ? 0.0 : themeData.indicatorMargin,
        left: widget.vertical ? themeData.indicatorMargin : 0.0,
        right: widget.vertical ? null : 0.0,
        top: widget.vertical ? 0.0 : null,
        child: IgnorePointer(
          child: _FlanSwipeIndicator(
            current: current,
            itemCount: count,
            vertical: widget.vertical,
            activeColor: widget.indicatorColor,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Duration>('autoplay', widget.autoplay,
        defaultValue: Duration.zero));
    properties.add(DiagnosticsProperty<Duration>('duration', widget.duration,
        defaultValue: const Duration(milliseconds: 500)));
    properties.add(
        DiagnosticsProperty<PageController>('controller', widget.controller));
    properties.add(DiagnosticsProperty<double>('height', widget.height));
    properties.add(DiagnosticsProperty<bool>(
        'showIndicators', widget.showIndicators,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>('vertical', widget.vertical,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('touchable', widget.touchable,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>(
        'stopPropagation', widget.stopPropagation,
        defaultValue: true));
    properties.add(
        DiagnosticsProperty<Color>('indicatorColor', widget.indicatorColor));

    super.debugFillProperties(properties);
  }
}

class FlanSwipeController extends PageController {
  FlanSwipeController({
    int initialPage = 0,
    required this.itemCount,
    this.loop = true,
    bool keepPage = true,
    double viewportFraction = 1.0,
  })  : assert(initialPage >= 0),
        assert(viewportFraction >= .7),
        super(
          initialPage: initialPage + (loop ? itemCount * 500 : 0),
          keepPage: keepPage,
          viewportFraction: viewportFraction,
        );
  final bool loop;
  final int itemCount;
}

class _FlanSwipeIndicator extends StatelessWidget {
  const _FlanSwipeIndicator({
    Key? key,
    required this.current,
    required this.itemCount,
    required this.vertical,
    this.activeColor,
  }) : super(key: key);

  final ValueNotifier<int> current;

  final int itemCount;

  final bool vertical;

  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final FlanSwipeThemeData themeData = FlanSwipeTheme.of(context);

    return ValueListenableBuilder<int>(
      valueListenable: current,
      builder: (BuildContext context, Object? value, Widget? child) {
        return Wrap(
          direction: vertical ? Axis.vertical : Axis.horizontal,
          alignment: WrapAlignment.center,
          runSpacing: vertical ? themeData.indicatorSize : 0.0,
          spacing: themeData.indicatorSize,
          children: List<Widget>.generate(
            itemCount,
            (int index) => _buildDot(
              themeData,
              active: index == value,
              key: ValueKey<int>(index),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDot(
    FlanSwipeThemeData themeData, {
    bool active = false,
    required Key key,
  }) {
    final Color activeColor = this.activeColor ??
        themeData.indicatorActiveBackgroundColor
            .withOpacity(themeData.indicatorActiveOpacity);
    final Color inActiveColor = themeData.indicatorInactiveBackgroundColor
        .withOpacity(themeData.indicatorInactiveOpacity);

    return AnimatedContainer(
      key: key,
      width: themeData.indicatorSize,
      height: themeData.indicatorSize,
      decoration: BoxDecoration(
        color: active ? activeColor : inActiveColor,
        shape: BoxShape.circle,
      ),
      duration: FlanThemeVars.animationDurationFast,
    );
  }
}

// Having this global (mutable) page controller is a bit of a hack. We need it
// to plumb in the factory for _PagePosition, but it will end up accumulating
// a large list of scroll positions. As long as you don't try to actually
// control the scroll positions, everything should be fine.
final PageController _defaultPageController = PageController();
const PageScrollPhysics _kPagePhysics = PageScrollPhysics();

/// A scrollable list that works page by page.
///
/// Each child of a page view is forced to be the same size as the viewport.
///
/// You can use a [PageController] to control which page is visible in the view.
/// In addition to being able to control the pixel offset of the content inside
/// the [PageView], a [PageController] also lets you control the offset in terms
/// of pages, which are increments of the viewport size.
///
/// The [PageController] can also be used to control the
/// [PageController.initialPage], which determines which page is shown when the
/// [PageView] is first constructed, and the [PageController.viewportFraction],
/// which determines the size of the pages as a fraction of the viewport size.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=J1gE9xvph-A}
///
/// {@tool dartpad --template=stateless_widget_scaffold}
///
/// Here is an example of [PageView]. It creates a centered [Text] in each of the three pages
/// which scroll horizontally.
///
/// ```dart
///  Widget build(BuildContext context) {
///    final controller = PageController(initialPage: 0);
///    return PageView(
///      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
///      /// Use [Axis.vertical] to scroll vertically.
///      scrollDirection: Axis.horizontal,
///      controller: controller,
///      children: [
///        Center(
///          child: Text("First Page"),
///        ),
///        Center(
///          child: Text("Second Page"),
///        ),
///        Center(
///          child: Text("Third Page"),
///        )
///      ],
///    );
///  }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [PageController], which controls which page is visible in the view.
///  * [SingleChildScrollView], when you need to make a single child scrollable.
///  * [ListView], for a scrollable list of boxes.
///  * [GridView], for a scrollable grid of boxes.
///  * [ScrollNotification] and [NotificationListener], which can be used to watch
///    the scroll position without using a [ScrollController].
class _PageView extends StatefulWidget {
  /// Creates a scrollable list that works page by page from an explicit [List]
  /// of widgets.
  ///
  /// This constructor is appropriate for page views with a small number of
  /// children because constructing the [List] requires doing work for every
  /// child that could possibly be displayed in the page view, instead of just
  /// those children that are actually visible.
  ///
  /// Like other widgets in the framework, this widget expects that
  /// the [children] list will not be mutated after it has been passed in here.
  /// See the documentation at [SliverChildListDelegate.children] for more details.
  ///
  /// {@template flutter.widgets.PageView.allowImplicitScrolling}
  /// The [allowImplicitScrolling] parameter must not be null. If true, the
  /// [PageView] will participate in accessibility scrolling more like a
  /// [ListView], where implicit scroll actions will move to the next page
  /// rather than into the contents of the [PageView].
  /// {@endtemplate}
  _PageView({
    Key? key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController? controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    List<Widget> children = const <Widget>[],
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  })  : controller = controller ?? _defaultPageController,
        childrenDelegate = SliverChildListDelegate(children),
        super(key: key);

  /// Creates a scrollable list that works page by page using widgets that are
  /// created on demand.
  ///
  /// This constructor is appropriate for page views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// Providing a non-null [itemCount] lets the [PageView] compute the maximum
  /// scroll extent.
  ///
  /// [itemBuilder] will be called only with indices greater than or equal to
  /// zero and less than [itemCount].
  ///
  /// [PageView.builder] by default does not support child reordering. If
  /// you are planning to change child order at a later time, consider using
  /// [PageView] or [PageView.custom].
  ///
  /// {@macro flutter.widgets.PageView.allowImplicitScrolling}
  _PageView.builder({
    Key? key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController? controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  })  : controller = controller ?? _defaultPageController,
        childrenDelegate =
            SliverChildBuilderDelegate(itemBuilder, childCount: itemCount),
        super(key: key);

  /// Creates a scrollable list that works page by page with a custom child
  /// model.
  ///
  /// {@tool snippet}
  ///
  /// This [PageView] uses a custom [SliverChildBuilderDelegate] to support child
  /// reordering.
  ///
  /// ```dart
  /// class MyPageView extends StatefulWidget {
  ///   @override
  ///   _MyPageViewState createState() => _MyPageViewState();
  /// }
  ///
  /// class _MyPageViewState extends State<MyPageView> {
  ///   List<String> items = <String>['1', '2', '3', '4', '5'];
  ///
  ///   void _reverse() {
  ///     setState(() {
  ///       items = items.reversed.toList();
  ///     });
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       body: SafeArea(
  ///         child: PageView.custom(
  ///           childrenDelegate: SliverChildBuilderDelegate(
  ///             (BuildContext context, int index) {
  ///               return KeepAlive(
  ///                 data: items[index],
  ///                 key: ValueKey<String>(items[index]),
  ///               );
  ///             },
  ///             childCount: items.length,
  ///             findChildIndexCallback: (Key key) {
  ///               final ValueKey<String> valueKey = key as ValueKey<String>;
  ///               final String data = valueKey.value;
  ///               return items.indexOf(data);
  ///             }
  ///           ),
  ///         ),
  ///       ),
  ///       bottomNavigationBar: BottomAppBar(
  ///         child: Row(
  ///           mainAxisAlignment: MainAxisAlignment.center,
  ///           children: <Widget>[
  ///             TextButton(
  ///               onPressed: () => _reverse(),
  ///               child: Text('Reverse items'),
  ///             ),
  ///           ],
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  ///
  /// class KeepAlive extends StatefulWidget {
  ///   const KeepAlive({Key? key, required this.data}) : super(key: key);
  ///
  ///   final String data;
  ///
  ///   @override
  ///   _KeepAliveState createState() => _KeepAliveState();
  /// }
  ///
  /// class _KeepAliveState extends State<KeepAlive> with AutomaticKeepAliveClientMixin{
  ///   @override
  ///   bool get wantKeepAlive => true;
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     super.build(context);
  ///     return Text(widget.data);
  ///   }
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// {@macro flutter.widgets.PageView.allowImplicitScrolling}
  // ignore: unused_element
  _PageView.custom({
    Key? key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController? controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    required this.childrenDelegate,
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  })  : controller = controller ?? _defaultPageController,
        super(key: key);

  /// Controls whether the widget's pages will respond to
  /// [RenderObject.showOnScreen], which will allow for implicit accessibility
  /// scrolling.
  ///
  /// With this flag set to false, when accessibility focus reaches the end of
  /// the current page and the user attempts to move it to the next element, the
  /// focus will traverse to the next widget outside of the page view.
  ///
  /// With this flag set to true, when accessibility focus reaches the end of
  /// the current page and user attempts to move it to the next element, focus
  /// will traverse to the next page in the page view.
  final bool allowImplicitScrolling;

  /// {@macro flutter.widgets.scrollable.restorationId}
  final String? restorationId;

  /// The axis along which the page view scrolls.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis scrollDirection;

  /// Whether the page view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the page view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the page view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// An object that can be used to control the position to which this page
  /// view is scrolled.
  final PageController controller;

  /// How the page view should respond to user input.
  ///
  /// For example, determines how the page view continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// Set to false to disable page snapping, useful for custom scroll behavior.
  final bool pageSnapping;

  /// Called whenever the page in the center of the viewport changes.
  final ValueChanged<int>? onPageChanged;

  /// A delegate that provides the children for the [PageView].
  ///
  /// The [PageView.custom] constructor lets you specify this delegate
  /// explicitly. The [PageView] and [PageView.builder] constructors create a
  /// [childrenDelegate] that wraps the given [List] and [IndexedWidgetBuilder],
  /// respectively.
  final SliverChildDelegate childrenDelegate;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  @override
  _PageViewState createState() => _PageViewState();
}

class _PageViewState extends State<_PageView> {
  int _lastReportedPage = 0;

  @override
  void initState() {
    super.initState();
    _lastReportedPage = widget.controller.initialPage;
  }

  AxisDirection _getDirection(BuildContext context) {
    switch (widget.scrollDirection) {
      case Axis.horizontal:
        assert(debugCheckHasDirectionality(context));
        final TextDirection textDirection = Directionality.of(context);
        final AxisDirection axisDirection =
            textDirectionToAxisDirection(textDirection);
        return widget.reverse
            ? flipAxisDirection(axisDirection)
            : axisDirection;
      case Axis.vertical:
        return widget.reverse ? AxisDirection.up : AxisDirection.down;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AxisDirection axisDirection = _getDirection(context);
    final ScrollPhysics physics = _ForceImplicitScrollPhysics(
      allowImplicitScrolling: widget.allowImplicitScrolling,
    ).applyTo(widget.pageSnapping
        ? _kPagePhysics.applyTo(widget.physics)
        : widget.physics);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0 &&
            widget.onPageChanged != null &&
            notification is ScrollUpdateNotification) {
          final PageMetrics metrics = notification.metrics as PageMetrics;
          final int currentPage = metrics.page!.round();
          if (currentPage != _lastReportedPage) {
            _lastReportedPage = currentPage;
            widget.onPageChanged!(currentPage);
          }
        }
        return false;
      },
      child: Scrollable(
        dragStartBehavior: widget.dragStartBehavior,
        axisDirection: axisDirection,
        controller: widget.controller,
        physics: physics,
        restorationId: widget.restorationId,
        viewportBuilder: (BuildContext context, ViewportOffset position) {
          return Viewport(
            // TODO(dnfield): we should provide a way to set cacheExtent
            // independent of implicit scrolling:
            // https://github.com/flutter/flutter/issues/45632
            cacheExtent: widget.allowImplicitScrolling ? 1.0 : 0.0,
            cacheExtentStyle: CacheExtentStyle.viewport,
            axisDirection: axisDirection,
            offset: position,
            clipBehavior: widget.clipBehavior,
            slivers: <Widget>[
              SliverFillViewport(
                viewportFraction: widget.controller.viewportFraction,
                delegate: widget.childrenDelegate,
                padEnds: false,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description
        .add(EnumProperty<Axis>('scrollDirection', widget.scrollDirection));
    description.add(
        FlagProperty('reverse', value: widget.reverse, ifTrue: 'reversed'));
    description.add(DiagnosticsProperty<PageController>(
        'controller', widget.controller,
        showName: false));
    description.add(DiagnosticsProperty<ScrollPhysics>(
        'physics', widget.physics,
        showName: false));
    description.add(FlagProperty('pageSnapping',
        value: widget.pageSnapping, ifFalse: 'snapping disabled'));
    description.add(FlagProperty('allowImplicitScrolling',
        value: widget.allowImplicitScrolling,
        ifTrue: 'allow implicit scrolling'));
  }
}

class _ForceImplicitScrollPhysics extends ScrollPhysics {
  const _ForceImplicitScrollPhysics({
    required this.allowImplicitScrolling,
    ScrollPhysics? parent,
  }) : super(parent: parent);

  @override
  _ForceImplicitScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _ForceImplicitScrollPhysics(
      allowImplicitScrolling: allowImplicitScrolling,
      parent: buildParent(ancestor),
    );
  }

  @override
  final bool allowImplicitScrolling;
}
