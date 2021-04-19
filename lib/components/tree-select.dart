// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 🌎 Project imports:
import 'package:flant/components/icon.dart';
import 'package:flant/components/sidebar.dart';
import 'package:flant/components/sidebar_item.dart';
import '../styles/var.dart';

/// ### TreeSelect 分类选择
/// 用于从一组相关联的数据集合中进行选择。
class FlanTreeSelect extends StatelessWidget {
  const FlanTreeSelect({
    Key? key,
    this.max,
    this.items = const <FlanTreeSelectItem>[],
    this.height = 300.0,
    this.activeId = const <String>[],
    this.selectedIconName = FlanIcons.success,
    this.selectedIconUrl,
    this.mainActiveIndex = 0,
    this.isMulit = false,
    this.onClickNav,
    this.onClickItem,
    this.onActiveIdChange,
    this.onMainActiveIndexChange,
    this.child,
  })  : assert(max == null || (max >= 0)),
        super(key: key);

  // ****************** Props ******************
  /// 右侧项最大选中个数
  final int? max;

  /// 分类显示所需的数据
  final List<FlanTreeSelectItem> items;

  /// 高度
  final double height;

  /// 右侧选中项的 id
  final List<String> activeId;

  /// 自定义右侧栏选中状态的图标名字
  final IconData selectedIconName;

  /// 自定义右侧栏选中状态的图标访问地址
  final String? selectedIconUrl;

  /// 左侧选中项的索引
  final int mainActiveIndex;

  /// 是否多选
  final bool isMulit;

  // ****************** Events ******************
  /// 点击左侧导航时触发
  final void Function(int index)? onClickNav;

  /// 点击右侧选择项时触发
  final void Function(FlanTreeSelectChild data)? onClickItem;

  /// 右侧选中项的id变化回调
  final void Function(List<String> activeId)? onActiveIdChange;

  /// 左侧选中项的索引变化回调
  final void Function(int mainActiveIndex)? onMainActiveIndexChange;

  // ****************** Slots ******************
  /// 自定义右侧区域内容
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: ThemeVars.treeSelectFontSize,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _buildSidebar(),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: ThemeVars.treeSelectContentBackgroundColor,
                child: _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubItem(FlanTreeSelectChild item) {
    return _FlanTreeSelectSubItem(
      active: _isActiveItem(item.id),
      item: item,
      activeIcon: FlanIcon(
        color: ThemeVars.treeSelectItemActiveColor,
        size: ThemeVars.treeSelectItemSelectedSize,
        iconName: selectedIconName,
        iconUrl: selectedIconUrl,
      ),
      onClick: () {
        if (item.disabled) {
          return;
        }

        List<String> activeId;
        if (isMulit) {
          activeId = this.activeId.toList();
          final int index = activeId.indexOf(item.id);
          if (index != -1) {
            activeId.remove(item.id);
          } else if (max == null || (max != null && activeId.length < max!)) {
            activeId.add(item.id);
          }
        } else {
          activeId = <String>[item.id];
        }

        if (onActiveIdChange != null) {
          onActiveIdChange!(activeId);
        }
        if (onClickItem != null) {
          onClickItem!(item);
        }
      },
    );
  }

  void _onSidebarChange(int index) {
    if (onMainActiveIndexChange != null) {
      onMainActiveIndexChange!(index);
    }

    if (onClickNav != null) {
      onClickNav!(index);
    }
  }

  Widget _buildSidebar() {
    final List<FlanSidebarItem> items =
        this.items.map((FlanTreeSelectItem item) {
      return FlanSidebarItem(
        dot: item.dot,
        title: item.text,
        badge: item.badge,
        disabled: item.disabled,
        padding: ThemeVars.treeSelectNavItemPadding,
      );
    }).toList();
    return FlanSidebar(
      value: mainActiveIndex,
      onValueChange: onMainActiveIndexChange,
      onChange: _onSidebarChange,
      children: items,
      backgroundColor: ThemeVars.treeSelectNavBackgroundColor,
    );
  }

  Widget _buildContent() {
    if (child != null) {
      return child!;
    }
    final FlanTreeSelectItem? selected =
        items.isNotEmpty ? items[mainActiveIndex] : null;
    if (selected != null) {
      return ListView(
        children: selected.children.map(_buildSubItem).toList(),
      );
    }
    return const SizedBox.shrink();
  }

  bool _isActiveItem(String id) => activeId.contains(id);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<int>('max', max));
    properties.add(DiagnosticsProperty<List<FlanTreeSelectItem>>('items', items,
        defaultValue: const <FlanTreeSelectItem>[]));
    properties.add(
        DiagnosticsProperty<double>('height', height, defaultValue: 300.0));
    properties.add(DiagnosticsProperty<List<String>>('activeId', activeId,
        defaultValue: const <String>[]));
    properties.add(DiagnosticsProperty<IconData>(
        'selectedIconName', selectedIconName,
        defaultValue: FlanIcons.success));
    properties
        .add(DiagnosticsProperty<String>('selectedIconUrl', selectedIconUrl));
    properties.add(DiagnosticsProperty<int>('mainActiveIndex', mainActiveIndex,
        defaultValue: 0));

    super.debugFillProperties(properties);
  }
}

class FlanTreeSelectChild {
  FlanTreeSelectChild({
    required this.id,
    required this.text,
    this.disabled = false,
  });

  factory FlanTreeSelectChild.fromJson(Map<String, dynamic> json) {
    return FlanTreeSelectChild(
      id: json['id'].toString(),
      text: json['text'].toString(),
      disabled: json['disabled'] == true,
    );
  }

  String id;
  String text;
  bool disabled;
}

class FlanTreeSelectItem {
  FlanTreeSelectItem({
    this.dot = false,
    required this.text,
    this.badge = '',
    this.children = const <FlanTreeSelectChild>[],
    this.disabled = false,
  });

  factory FlanTreeSelectItem.fromJson(Map<String, dynamic> json) {
    return FlanTreeSelectItem(
      dot: json['dot'] == true,
      badge: json['badge'] as String? ?? '',
      text: json['text'].toString(),
      disabled: json['disabled'] == true,
      children: json['children'] is List<Map<String, dynamic>>
          ? (json['children'] as List<Map<String, dynamic>>)
              .map((Map<String, dynamic> item) =>
                  FlanTreeSelectChild.fromJson(item))
              .toList()
          : <FlanTreeSelectChild>[],
    );
  }

  bool dot;
  String text;
  String badge;
  List<FlanTreeSelectChild> children;
  bool disabled;
}

class _FlanTreeSelectSubItem extends StatefulWidget {
  const _FlanTreeSelectSubItem({
    Key? key,
    this.active = false,
    required this.item,
    this.onClick,
    required this.activeIcon,
  }) : super(key: key);

  final bool active;
  final FlanTreeSelectChild item;

  final VoidCallback? onClick;

  final Widget activeIcon;

  @override
  __FlanTreeSelectSubItemState createState() => __FlanTreeSelectSubItemState();
}

class __FlanTreeSelectSubItemState extends State<_FlanTreeSelectSubItem> {
  bool isPressed = false;

  void doActive() {
    setState(() => isPressed = true);
  }

  void doDisActive() {
    setState(() => isPressed = false);
  }

  Color get bgColor => isPressed ? ThemeVars.activeColor : Colors.transparent;

  Color get textColor => widget.item.disabled
      ? ThemeVars.treeSelectItemDisabledColor
      : widget.active
          ? ThemeVars.treeSelectItemActiveColor
          : ThemeVars.textColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      key: ValueKey<String>(widget.item.id),
      cursor: widget.item.disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      child: IgnorePointer(
        ignoring: widget.item.disabled,
        child: GestureDetector(
          onTap: widget.onClick,
          onTapDown: (TapDownDetails e) => doActive(),
          onTapCancel: () => doDisActive(),
          onTapUp: (TapUpDetails e) => doDisActive(),
          child: Container(
            height: ThemeVars.treeSelectItemHeight,
            decoration: BoxDecoration(color: bgColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: ThemeVars.paddingMd),
                Expanded(
                  child: Text(
                    widget.item.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: ThemeVars.fontWeightBold,
                      // height: ThemeVars.treeSelectItemHeight /
                      //     ThemeVars.treeSelectFontSize,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.active,
                  child: Container(
                    width: 32.0,
                    padding: const EdgeInsets.only(right: ThemeVars.paddingMd),
                    child: widget.activeIcon,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
