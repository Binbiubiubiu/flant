import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../styles/components/tree_select_theme.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'common/active_response.dart';
import 'icon.dart';
import 'sidebar.dart';
import 'sidebar_item.dart';

/// ### TreeSelect 分类选择
/// 用于从一组相关联的数据集合中进行选择。
class FlanTreeSelect extends StatelessWidget {
  const FlanTreeSelect({
    Key? key,
    this.max,
    this.items = const <FlanTreeSelectItem>[],
    this.height,
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
  final double? height;

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
    final FlanTreeSelectThemeData themeData = FlanTreeSelectTheme.of(context);

    return SizedBox(
      height: height ?? 300.0.rpx,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: themeData.fontSize,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _buildSidebar(themeData),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: themeData.contentBackgroundColor,
                child: _buildContent(themeData),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSidebarChange(int index) {
    onMainActiveIndexChange?.call(index);

    onClickNav?.call(index);
  }

  Widget _buildSidebar(FlanTreeSelectThemeData themeData) {
    final List<FlanSidebarItem> items =
        this.items.map((FlanTreeSelectItem item) {
      return FlanSidebarItem(
        dot: item.dot,
        title: item.text,
        badge: item.badge,
        disabled: item.disabled,
        padding: themeData.navItemPadding,
      );
    }).toList();
    return FlanSidebar(
      value: mainActiveIndex,
      onChange: _onSidebarChange,
      children: items,
      backgroundColor: themeData.navBackgroundColor,
    );
  }

  Widget? _buildContent(FlanTreeSelectThemeData themeData) {
    if (child != null) {
      return child!;
    }
    final FlanTreeSelectItem? selected =
        items.isNotEmpty ? items[mainActiveIndex] : null;
    if (selected != null) {
      return ListView(
        children: selected.children.map((FlanTreeSelectChild item) {
          void _onClick() {
            if (item.disabled) {
              return;
            }

            List<String> _activeId;
            if (isMulit) {
              _activeId = <String>[...activeId];
              if (_activeId.contains(item.id)) {
                _activeId.remove(item.id);
              } else if (max == null ||
                  (max != null && activeId.length < max!)) {
                _activeId.add(item.id);
              }
            } else {
              _activeId = <String>[item.id];
            }

            onActiveIdChange?.call(_activeId);

            onClickItem?.call(item);
          }

          final bool active = _isActiveItem(item.id);

          final Widget rightIcon = Visibility(
            visible: active,
            child: Container(
              width: 32.0.rpx,
              padding: EdgeInsets.only(
                right: FlanThemeVars.paddingMd.rpx,
              ),
              child: FlanIcon(
                color: themeData.itemActiveColor,
                size: themeData.itemSelectedSize,
                iconName: selectedIconName,
                iconUrl: selectedIconUrl,
              ),
            ),
          );

          return FlanActiveResponse(
            disabled: item.disabled,
            builder: (BuildContext contenxt, bool isPressed, Widget? child) {
              final Color bgColor =
                  isPressed ? FlanThemeVars.activeColor : Colors.transparent;

              final Color textColor = item.disabled
                  ? themeData.itemDisabledColor
                  : active
                      ? themeData.itemActiveColor
                      : FlanThemeVars.textColor;

              return DefaultTextStyle(
                style: TextStyle(
                  color: textColor,
                ),
                child: Container(
                  height: themeData.itemHeight,
                  color: bgColor,
                  child: child,
                ),
              );
            },
            onClick: _onClick,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: FlanThemeVars.paddingMd.rpx),
                Expanded(
                  child: Text(
                    item.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FlanThemeVars.fontWeightBold,
                      // height: FlanThemeVars.itemHeight
                    ),
                  ),
                ),
                rightIcon,
              ],
            ),
          );
        }).toList(),
      );
    }
    return null;
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
