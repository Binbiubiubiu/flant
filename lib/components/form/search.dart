import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';

import '../../styles/var.dart';
import '../base/icon.dart';
import './field.dart';

/// ### FlanSearch
/// 用于搜索场景的输入框组件。
class FlanSearch extends StatelessWidget {
  const FlanSearch({
    Key? key,
    this.label,
    this.rightIconName,
    this.rightIconUrl,
    required this.value,
    this.actionText,
    this.background,
    this.maxLength,
    this.placeholder,
    this.autofocus = false,
    this.disabled = false,
    this.readonly = false,
    this.showAction = false,
    this.clearTrigger,
    this.shape = FlanSearchShape.square,
    this.clearable = true,
    this.leftIconName = FlanIcons.search,
    this.leftIconUrl,
    required this.onChange,
    this.onSearch,
    this.onInput,
    this.onFocus,
    this.onBlur,
    this.onClear,
    this.onCancel,
    this.leftSlot,
    this.actionSlot,
    this.labelSlot,
    this.leftIconSlot,
    this.rightIconSlot,
  }) : super(key: key);

  // ****************** Props ******************

  /// 关闭时对应的值
  final String? label;

  final int? rightIconName;

  final String? rightIconUrl;

  final String value;

  /// 取消按钮文字
  final String? actionText;

  /// 搜索框外部背景色
  final Color? background;

  /// 输入的最大字符数
  final int? maxLength;

  /// 占位提示文字
  final String? placeholder;

  /// 是否在搜索框右侧显示取消按钮
  final bool showAction;

  /// 显示清除图标的时机，`always` 表示输入框不为空时展示，`focus` 表示输入框聚焦且不为空时展示
  final FlanFieldClearTrigger? clearTrigger;

  /// 搜索框形状，可选值为 `round` `square`
  final FlanSearchShape shape;

  /// 是否启用清除图标，点击清除图标后会清空输入框
  final bool clearable;

  /// 是否禁用输入框
  final bool disabled;

  /// 是否将输入框设为只读
  final bool readonly;

  /// 是否自动聚焦
  final bool autofocus;

  final int? leftIconName;

  final String? leftIconUrl;

  // ****************** Events ******************

  /// 开关状态切换时触发
  final ValueChanged<String> onChange;

  final ValueChanged<String>? onSearch;

  final ValueChanged<String>? onInput;

  final VoidCallback? onFocus;

  final VoidCallback? onBlur;

  final VoidCallback? onClear;

  final VoidCallback? onCancel;

  // ****************** Slots ******************

  final Widget? leftSlot;

  final Widget? actionSlot;

  final Widget? labelSlot;

  final FlanIcon? leftIconSlot;

  final FlanIcon? rightIconSlot;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // properties.add(DiagnosticsProperty<dynamic>("value", widget.value,
    //     defaultValue: false));

    super.debugFillProperties(properties);
  }
}

enum FlanSearchShape {
  square,
  round,
}
