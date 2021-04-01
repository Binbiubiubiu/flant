import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../styles/var.dart';

/// ### List 列表
/// 瀑布流滚动加载，用于展示长列表，当列表即将滚动到底部时，会触发事件并加载更多列表项。
class FlanList extends StatelessWidget {
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
    this.onLoad,
    this.children,
    this.loadingSlot,
    this.finishedSlot,
    this.errorSlot,
  }) : super(key: key);

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

  // ****************** Events ******************
  /// 滚动条与底部距离小于 offset 时触发
  final VoidCallback? onLoad;

  // ****************** Slots ******************
  /// 列表内容
  final List<Widget>? children;

  /// 自定义底部加载中提示
  final Widget? loadingSlot;

  /// 自定义加载完成后的提示文案
  final Widget? finishedSlot;

  /// 自定义加载失败后的提示文案
  final Widget? errorSlot;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<bool>('loading', loading, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('error', error, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('finished', finished, defaultValue: false));
    properties.add(
        DiagnosticsProperty<double>('offset', offset, defaultValue: 300.0));
    properties.add(DiagnosticsProperty<String>('loadingText', loadingText));
    properties.add(DiagnosticsProperty<String>('finishedText', finishedText));
    properties.add(DiagnosticsProperty<String>('errorText', errorText));
    properties.add(DiagnosticsProperty<bool>('immediateCheck', immediateCheck,
        defaultValue: true));
    properties.add(DiagnosticsProperty<FlanListDirection>(
        'direction', direction,
        defaultValue: FlanListDirection.down));

    super.debugFillProperties(properties);
  }
}

/// 滚动触发加载的方向
enum FlanListDirection {
  up,
  down,
}
