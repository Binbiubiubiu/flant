// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// 🌎 Project imports:
import 'package:flant/components/radio.dart';
import 'package:flant/flant.dart';
import '../styles/var.dart';

/// ### ContactList 联系人列表
/// 展示联系人列表。
class FlanContactList extends StatelessWidget {
  const FlanContactList({
    Key? key,
    this.list = const <FlanContactListItem>[],
    this.addText,
    required this.value,
    this.defaultTagText = '',
    this.onAdd,
    this.onEdit,
    this.onSelect,
    required this.onValueChange,
  }) : super(key: key);

  // ****************** Props ******************
  final List<FlanContactListItem> list;

  final String? addText;
  final String value;
  final String defaultTagText;

  // ****************** Events ******************

  /// 点击新增按钮时触发
  final VoidCallback? onAdd;

  /// 当前选中联系人的 id 回调
  final ValueChanged<String> onValueChange;

  /// 点击编辑按钮时触发
  final void Function(FlanContactListItem item, int index)? onEdit;

  /// 切换选中的联系人时触发
  final void Function(FlanContactListItem item, int index)? onSelect;

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: FlanRadioGroup<String>(
        value: value,
        children: List<Widget>.generate(
          list.length,
          (int index) => _buildItem(list[index], index),
        ),
      ),
    );
  }

  Widget bottonButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: ThemeVars.paddingMd,
      ),
      color: ThemeVars.white,
      child: SafeArea(
        child: SizedBox(
          height: 40.0,
          child: FlanButton(
            round: true,
            block: true,
            type: FlanButtonType.danger,
            text: addText ?? FlanS.of(context).ContactList_addText,
            onClick: () {
              if (onAdd != null) {
                onAdd!();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildItem(FlanContactListItem item, int index) {
    void onClick() {
      onValueChange(item.id);
      if (onSelect != null) {
        onSelect!(item, index);
      }
    }

    return FlanCell(
      key: ValueKey<String>(item.id),
      iconSlot: FlanIcon(
        size: ThemeVars.contactListEditIconSize,
        iconName: FlanIcons.edit,
        onClick: () {
          if (onEdit != null) {
            onEdit!(item, index);
          }
        },
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          right: ThemeVars.paddingXl,
          left: ThemeVars.paddingXs,
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text(item.name),
            Text(item.tel),
            if (item.isDefault && defaultTagText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: ThemeVars.paddingXs),
                child: FlanTag(
                  round: true,
                  type: FlanTagType.danger,
                  child: Text(defaultTagText),
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
      rightIconSlot: FlanRadio<String>(
        name: item.id,
        iconSize: 16.0,
        onClick: onClick,
        checkedColor: ThemeVars.contactListItemRadioIconColor,
      ),
      isLink: true,
      center: true,
      padding: const EdgeInsets.all(ThemeVars.contactListItemPadding),
      onClick: onClick,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<List<FlanContactListItem>>('list', list,
        defaultValue: const <FlanContactListItem>[]));
    properties.add(DiagnosticsProperty<String>('addText', addText));
    properties.add(DiagnosticsProperty<String>('value', value));
    properties.add(DiagnosticsProperty<String>('defaultTagText', defaultTagText,
        defaultValue: ''));

    super.debugFillProperties(properties);
  }
}

/// 联系人
class FlanContactListItem {
  const FlanContactListItem({
    required this.id,
    required this.tel,
    required this.name,
    this.isDefault = false,
  });

  factory FlanContactListItem.fromJson(Map<String, dynamic> json) {
    return FlanContactListItem(
      id: json['id'].toString(),
      name: json['name'].toString(),
      tel: json['tel'].toString(),
      isDefault: json['isDefault'] is bool && json['isDefault'] as bool,
    );
  }

  /// 每位联系人的唯一标识
  final String id;

  /// 联系人姓名
  final String tel;

  /// 联系人手机号
  final String name;

  /// 是否为默认联系人
  final bool isDefault;
}
