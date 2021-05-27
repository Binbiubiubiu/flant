// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/components/loading.dart';
import 'package:flant/flant.dart';
import '../styles/var.dart';

/// ### List 列表
/// 瀑布流滚动加载，用于展示长列表，当列表即将滚动到底部时，会触发事件并加载更多列表项。
class FlanList extends StatefulWidget {
  const FlanList({
    Key? key,
    this.loading = false,
    this.error = false,
    this.finished = false,
    this.offset = 300.0,
    this.loadingText,
    this.finishedText,
    this.errorText,
    this.immediateCheck = true,
    this.direction = FlanListDirection.down,
    this.itemCount = 0,
    this.onLoad,
    this.onLoadingChange,
    this.onErrorChange,
    this.children = const <Widget>[],
    this.loadingSlot,
    this.finishedSlot,
    this.errorSlot,
  })  : assert(itemCount >= 0),
        super(key: key);

  // ****************** Props ******************
  /// 是否处于加载状态，加载过程中不触发 `load` 事件
  final bool loading;

  /// 是否加载失败，加载失败后点击错误提示可以重新触发 `load` 事件
  final bool error;

  /// 是否已加载完成，加载完成后不再触发 `load` 事件
  final bool finished;

  /// 滚动条与底部距离小于 `offset` 时触发 `load` 事件
  final double offset;

  /// 加载过程中的提示文案
  final String? loadingText;

  /// 加载完成后的提示文案
  final String? finishedText;

  /// 加载失败后的提示文案
  final String? errorText;

  /// 是否在初始化时立即执行滚动位置检查
  final bool immediateCheck;

  /// 滚动触发加载的方向，可选值为 `up` `down`
  final FlanListDirection direction;

  final int itemCount;

  // ****************** Events ******************
  /// 滚动条与底部距离小于 offset 时触发
  final VoidCallback? onLoad;

  /// loading 变化回调
  final ValueChanged<bool>? onLoadingChange;

  ///  error 变化回调
  final ValueChanged<bool>? onErrorChange;

  // ****************** Slots ******************
  /// 列表内容
  final List<Widget> children;

  /// 自定义底部加载中提示
  final Widget? loadingSlot;

  /// 自定义加载完成后的提示文案
  final Widget? finishedSlot;

  /// 自定义加载失败后的提示文案
  final Widget? errorSlot;

  @override
  _FlanListState createState() => _FlanListState();
}

class _FlanListState extends State<FlanList> {
  bool loading = false;
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    if (widget.immediateCheck) {
      emitCheck();
    }

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanList oldWidget) {
    loading = widget.loading;
    if (widget.loading != oldWidget.loading ||
        widget.error != oldWidget.error ||
        widget.finished != oldWidget.finished) {
      emitCheck();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final Widget list = SliverList(
      delegate: SliverChildListDelegate(widget.children),
    );

    final List<Widget> content = <Widget>[
      _bulidLoading(),
      _buildFinishedText(),
      _buildErrorText(),
    ];

    switch (widget.direction) {
      case FlanListDirection.up:
        content.add(list);
        break;
      case FlanListDirection.down:
        content.insert(0, list);
        break;
    }

    // RefreshIndicator

    return NotificationListener<ScrollUpdateNotification>(
      onNotification: check,
      child: CustomScrollView(
        controller: scrollController,
        slivers: content,
      ),
    );
  }

  bool check(ScrollUpdateNotification notification) {
    if (loading || widget.finished || widget.error) {
      return false;
    }

    bool isReachEdge = false;
    if (widget.direction == FlanListDirection.up) {
      isReachEdge =
          notification.metrics.pixels - notification.metrics.minScrollExtent <=
              widget.offset;
    } else {
      isReachEdge =
          notification.metrics.maxScrollExtent - notification.metrics.pixels <=
              widget.offset;
    }

    if (isReachEdge) {
      loading = true;
      widget.onLoadingChange?.call(true);

      widget.onLoad?.call();
    }
    return false;
  }

  void clickErrorText() {
    widget.onErrorChange?.call(false);

    emitCheck();
  }

  void emitCheck() {
    WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
      final double offset =
          widget.direction == FlanListDirection.up ? -1.0 : 1.0;
      scrollController.jumpTo(scrollController.offset.toDouble() + offset);
    });
  }

  Widget _buildFinishedText() {
    Widget? child;
    if (widget.finished) {
      final Widget? text = widget.finishedSlot ??
          (widget.finishedText != null ? Text(widget.finishedText!) : null);
      if (text != null) {
        child = Container(
          alignment: Alignment.center,
          height: ThemeVars.listTextLineHeight,
          child: DefaultTextStyle(
            style: const TextStyle(
              color: ThemeVars.listTextColor,
              fontSize: ThemeVars.listTextFontSize,
              height: 1.0,
            ),
            textAlign: TextAlign.center,
            child: text,
          ),
        );
      }
    }
    return SliverToBoxAdapter(
      child: child,
    );
  }

  Widget _buildErrorText() {
    Widget? child;

    if (widget.error) {
      final Widget? text = widget.errorSlot ??
          (widget.errorText != null ? Text(widget.errorText!) : null);
      if (text != null) {
        child = Container(
          alignment: Alignment.center,
          height: ThemeVars.listTextLineHeight,
          child: GestureDetector(
            onTap: clickErrorText,
            child: DefaultTextStyle(
              style: const TextStyle(
                color: ThemeVars.listTextColor,
                fontSize: ThemeVars.listTextFontSize,
                height: 1.0,
              ),
              textAlign: TextAlign.center,
              child: text,
            ),
          ),
        );
      }
    }
    return SliverToBoxAdapter(
      child: child,
    );
  }

  Widget _bulidLoading() {
    Widget? child;
    if (loading && !widget.finished) {
      child = Container(
        alignment: Alignment.center,
        height: ThemeVars.listTextLineHeight,
        child: DefaultTextStyle(
          style: const TextStyle(
            color: ThemeVars.listTextColor,
            fontSize: ThemeVars.listTextFontSize,
            height: 1.0,
          ),
          textAlign: TextAlign.center,
          child: widget.loadingSlot ??
              FlanLoading(
                size: ThemeVars.listLoadingIconSize,
                child: Text(widget.loadingText ?? FlanS.of(context).loading),
              ),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<bool>('loading', widget.loading,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('error', widget.error, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('finished', widget.finished,
        defaultValue: false));
    properties.add(DiagnosticsProperty<double>('offset', widget.offset,
        defaultValue: 300.0));
    properties
        .add(DiagnosticsProperty<String>('loadingText', widget.loadingText));
    properties
        .add(DiagnosticsProperty<String>('finishedText', widget.finishedText));
    properties.add(DiagnosticsProperty<String>('errorText', widget.errorText));
    properties.add(DiagnosticsProperty<bool>(
        'immediateCheck', widget.immediateCheck,
        defaultValue: true));
    properties.add(DiagnosticsProperty<FlanListDirection>(
        'direction', widget.direction,
        defaultValue: FlanListDirection.down));

    super.debugFillProperties(properties);
  }
}

/// 滚动触发加载的方向
enum FlanListDirection {
  up,
  down,
}
