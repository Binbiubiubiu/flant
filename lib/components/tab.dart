// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 🌎 Project imports:
import '../mixins/route_mixins.dart';
import 'tabs.dart';

class FlanTab extends FlanRouteStatelessWidget {
  const FlanTab({
    Key? key,
    this.dot = false,
    this.name,
    this.badge = '',
    this.title = '',
    this.disabled = false,
    this.titleStyle,
    this.child,
    this.titleSlot,
    String? toName,
    PageRoute<Object?>? toRoute,
    bool replace = false,
  }) : super(key: key, toName: toName, toRoute: toRoute, replace: replace);

  // ****************** Props ******************
  /// 是否在标题右上角显示小红点
  final bool dot;

  /// 标签名称，作为匹配的标识符
  final String? name;

  /// 图标右上角徽标的内容
  final String badge;

  /// 标题
  final String title;

  /// 是否禁用标签
  final bool disabled;

  /// 自定义标题样式
  final BoxDecoration? titleStyle;

  // ****************** Events ******************

  // ****************** Slots ******************

  /// 标签页内容
  final Widget? child;

  /// 自定义标题
  final Widget? titleSlot;

  @override
  Widget build(BuildContext context) {
    final FlanTabsState? parent = FlanTabs.of(context);
    if (parent == null) {
      throw '[Flant]] FlanTab must be a child component of FlanTabs.';
    }
    // final int index = parent.widget.children.indexOf(this);
    // String getName() => name ?? '$index';

    return child ?? const SizedBox.shrink();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<bool>('dot', dot, defaultValue: false));
    properties.add(DiagnosticsProperty<String>('name', name));
    properties.add(DiagnosticsProperty<String>('badge', badge));
    properties.add(DiagnosticsProperty<String>('title', title));
    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties
        .add(DiagnosticsProperty<BoxDecoration>('titleStyle', titleStyle));

    super.debugFillProperties(properties);
  }
}
