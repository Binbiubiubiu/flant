import 'package:flant/flant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/widget.dart';

typedef FlanAddressChangeCallback = void Function(
    FlanAddressListAddress address, int index);

class FlanAddressList extends StatelessWidget {
  const FlanAddressList({
    Key? key,
    required this.value,
    this.disabledText = '',
    this.addButtonText = '',
    this.defaultTagText = '',
    this.list = const <FlanAddressListAddress>[],
    this.disabledList = const <FlanAddressListAddress>[],
    this.switchable = true,
    this.onAdd,
    this.onEdit,
    this.onSelect,
    this.onClickItem,
    this.onEditDisabled,
    this.onSelectDisabled,
    required this.onValueChange,
    this.child,
    this.topSlot,
    this.itemBottomBuilder,
    this.tagBuilder,
  }) : super(key: key);

  // ****************** Props ******************
  /// 内容
  final String value;

  /// 是否显示右上角小红点
  final String disabledText;

  /// 图标右上角徽标的内容
  final String addButtonText;

  /// 是否禁用该项
  final String defaultTagText;

  final List<FlanAddressListAddress> list;

  final List<FlanAddressListAddress> disabledList;

  final bool switchable;

  // ****************** Events ******************
  /// 点击时触发
  final VoidCallback? onAdd;

  final FlanAddressChangeCallback? onEdit;

  final FlanAddressChangeCallback? onSelect;

  final FlanAddressChangeCallback? onClickItem;

  final FlanAddressChangeCallback? onEditDisabled;

  final FlanAddressChangeCallback? onSelectDisabled;

  final void Function(String index) onValueChange;

  // ****************** Slots ******************

  /// 在列表下方插入内容
  final Widget? child;

  /// 在顶部插入内容
  final Widget? topSlot;

  /// 在列表项底部插入内容
  final Widget Function(FlanAddressListAddress item, bool disabled)?
      itemBottomBuilder;

  /// 自定义列表项标签内容
  final Widget Function(FlanAddressListAddress item)? tagBuilder;

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = _buildList(this.list);
    final List<Widget> disabledList =
        _buildList(this.disabledList, disabled: true);
    final Widget disabledText = Visibility(
      visible: this.disabledText.isNotEmpty,
      child: Padding(
        padding: ThemeVars.addressListDisabledTextPadding,
        child: Text(
          this.disabledText,
          style: const TextStyle(
            fontSize: ThemeVars.addressListDisabledTextFontSize,
            color: ThemeVars.addressListDisabledTextColor,
            height: ThemeVars.addressListDisabledTextLineHeight /
                ThemeVars.addressListDisabledTextFontSize,
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        topSlot ?? const SizedBox.shrink(),
        FlanRadioGroup<String>(
          value: value,
          onChange: onValueChange,
          children: list,
        ),
        disabledText,
        Column(children: disabledList),
        child ?? const SizedBox.shrink(),
      ],
    );
  }

  FlanAddressListItem _buildItem(FlanAddressListAddress item, int index,
      {bool disabled = false}) {
    return FlanAddressListItem(
      bottomBuilder: itemBottomBuilder,
      tagBuilder: tagBuilder,
      key: ValueKey<String>(item.id),
      address: item,
      disabled: disabled,
      switchable: switchable,
      defaultTagText: defaultTagText,
      onEdit: () {
        (disabled ? onEditDisabled : onEdit)?.call(item, index);
      },
      onClick: () {
        onClickItem?.call(item, index);
      },
      onSelect: () {
        (disabled ? onSelectDisabled : onSelect)?.call(item, index);

        if (!disabled) {
          onValueChange(item.id);
        }
      },
    );
  }

  List<Widget> _buildList(List<FlanAddressListAddress> list,
      {bool disabled = false}) {
    final List<Widget> content = <Widget>[];
    for (int i = 0; i < list.length; i++) {
      if (i > 0) {
        content.add(const SizedBox(height: ThemeVars.paddingSm));
      }
      content.add(_buildItem(list[i], i, disabled: disabled));
    }
    return content;
  }

  Widget buildBottom(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ThemeVars.white,
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: ThemeVars.paddingMd,
      ),
      child: SafeArea(
        child: SizedBox(
          height: 40.0,
          child: FlanButton(
            round: true,
            block: true,
            type: FlanButtonType.danger,
            text: addButtonText.isNotEmpty
                ? addButtonText
                : FlanS.of(context).AddressList_add,
            onClick: () {
              onAdd?.call();
            },
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('value', value));
    properties.add(DiagnosticsProperty<String>('disabledText', disabledText,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('addButtonText', addButtonText,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<String>('defaultTagText', defaultTagText,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<List<FlanAddressListAddress>>(
        'list', list,
        defaultValue: const <FlanAddressListAddress>[]));
    properties.add(DiagnosticsProperty<List<FlanAddressListAddress>>(
        'disabledList', disabledList,
        defaultValue: const <FlanAddressListAddress>[]));
    properties.add(DiagnosticsProperty<bool>('switchable', switchable,
        defaultValue: true));

    super.debugFillProperties(properties);
  }
}

class FlanAddressListItem extends StatelessWidget {
  const FlanAddressListItem({
    Key? key,
    this.disabled = false,
    this.switchable = false,
    this.defaultTagText = '',
    required this.address,
    this.onEdit,
    this.onClick,
    this.onSelect,
    this.tagBuilder,
    this.bottomBuilder,
  }) : super(key: key);

  // ****************** Props ******************
  /// 禁用
  final bool disabled;

  /// 是否允许切换地址
  final bool switchable;

  /// 默认地址标签文字
  final String defaultTagText;

  /// 地址
  final FlanAddressListAddress address;

  // ****************** Events ******************
  /// 编辑按钮点击事件
  final VoidCallback? onEdit;

  /// 点击事件
  final VoidCallback? onClick;

  /// 选中事件
  final VoidCallback? onSelect;

  // ****************** Slots ******************

  /// 标签插槽
  final Widget Function(FlanAddressListAddress address)? tagBuilder;

  /// 底部插槽
  final Widget Function(FlanAddressListAddress address, bool disabled)?
      bottomBuilder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onClick,
      child: Container(
        padding: const EdgeInsets.all(ThemeVars.addressListItemPadding),
        decoration: const BoxDecoration(
          color: ThemeVars.white,
          borderRadius: BorderRadius.all(
            Radius.circular(ThemeVars.borderRadiusLg),
          ),
        ),
        child: Column(
          children: <Widget>[
            FlanCell(
              center: true,
              border: false,
              padding: EdgeInsets.zero,
              child: _buildContent(),
              rightIconSlot: _buildRightIcon(),
            ),
            bottomBuilder?.call(address, disabled) ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  void _onClick() {
    if (switchable) {
      onSelect?.call();
    }

    onClick?.call();
  }

  Widget _buildRightIcon() {
    return Container(
      width: 44.0,
      alignment: Alignment.center,
      child: FlanIcon(
        iconName: FlanIcons.edit,
        color: ThemeVars.gray6,
        size: ThemeVars.addressListEditIconSize,
        onClick: () {
          onEdit?.call();
          onClick?.call();
        },
      ),
    );
  }

  Widget _buildTag() {
    return tagBuilder?.call(address) ??
        Visibility(
          visible: address.isDefault && defaultTagText.isNotEmpty,
          child: Padding(
            padding: EdgeInsets.only(left: FlanThemeVars.paddingXs.rpx),
            child: FlanTag(
              type: FlanTagType.danger,
              round: true,
              child: Text(defaultTagText),
            ),
          ),
        );
  }

  Widget _buildContent() {
    final Widget info = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text.rich(
          TextSpan(
            text: '${address.name} ${address.tel}',
            children: <InlineSpan>[
              WidgetSpan(child: _buildTag()),
            ],
            style: TextStyle(
              fontSize: ThemeVars.fontSizeLg,
              color:
                  disabled ? ThemeVars.addressListItemDisabledTextColor : null,
              // height: ThemeVars.fontSizeLg / ThemeVars.lineHeightLg,
            ),
          ),
        ),
        const SizedBox(height: ThemeVars.paddingXs),
        Text(
          address.address,
          style: TextStyle(
            color: disabled
                ? ThemeVars.addressListItemDisabledTextColor
                : ThemeVars.addressListItemTextColor,
            fontSize: ThemeVars.addressListItemFontSize,
            // height: ThemeVars.addressListItemFontSize /
            //     ThemeVars.addressListItemLineHeight,
          ),
        ),
      ],
    );

    if (switchable && !disabled) {
      return Row(
        children: <Widget>[
          FlanRadio<String>(
            name: address.id,
            iconSize: 18.0,
            checkedColor: ThemeVars.addressListItemRadioIconColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: info,
            ),
          ),
        ],
      );
    }

    return info;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('switchable', switchable,
        defaultValue: false));
    properties.add(DiagnosticsProperty<String>('defaultTagText', defaultTagText,
        defaultValue: ''));
    properties
        .add(DiagnosticsProperty<FlanAddressListAddress>('address', address));

    super.debugFillProperties(properties);
  }
}

/// 地址
class FlanAddressListAddress {
  const FlanAddressListAddress({
    required this.id,
    required this.tel,
    required this.name,
    required this.address,
    this.isDefault = false,
  });

  factory FlanAddressListAddress.fromJson(Map<String, dynamic> json) {
    return FlanAddressListAddress(
      id: json['id'].toString(),
      name: json['name'].toString(),
      tel: json['tel'].toString(),
      address: json['address'].toString(),
      isDefault: json['isDefault'] is bool && json['isDefault'] as bool,
    );
  }

  /// 每条地址的唯一标识
  final String id;

  /// 收货人姓名
  final String tel;

  /// 收货人手机号
  final String name;

  /// 收货地址
  final String address;

  /// 是否为默认地址
  final bool isDefault;

  @override
  String toString() {
    return 'FlanAddressListAddress{ id:$id,name:$name,tel:$tel,address:$address,isDefault:$isDefault}';
  }
}
