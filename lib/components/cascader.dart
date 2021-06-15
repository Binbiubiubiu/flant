// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'icon.dart';

/// ### Cascader 级联选择
/// 级联选择框，用于多层级数据的选择，典型场景为省市区选择。
class FlanCascader extends StatelessWidget {
  const FlanCascader({
    Key? key,
    this.title,
    this.closeable = true,
    this.swipeable = true,
    this.value,
    this.fieldNames,
    this.placeholder,
    this.activeColor,
    this.options = const <FlanCascaderOption>[],
    this.closeIconName = FlanIcons.cross,
    this.closeIconUrl,
    this.onClose,
    this.onChange,
    this.onFinish,
    this.onClickTab,
    this.titleSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 顶部标题
  final String? title;

  /// 	是否显示关闭图标
  final bool closeable;

  /// 是否开启手势左右滑动切换
  final bool swipeable;

  /// 选中项的值
  final String? value;

  final FlanCascaderFieldNames? fieldNames;

  /// 未选中时的提示文案
  final String? placeholder;

  /// 选中状态的高亮颜色
  final Color? activeColor;

  /// 可选项数据源
  final List<FlanCascaderOption> options;

  /// 关闭图标名称
  final IconData closeIconName;

  /// 关闭图片链接
  final String? closeIconUrl;

  // ****************** Events ******************

  /// 点击关闭图标时触发
  final VoidCallback? onClose;

  /// 选中项变化时触发
  final ValueChanged<FlanCascaderEvent>? onChange;

  /// 全部选项选择完成后触发
  final ValueChanged<FlanCascaderEvent>? onFinish;

  /// 点击标签时触发
  final void Function(int tabIndex, String title)? onClickTab;

  // ****************** Slots ******************
  /// 自定义顶部标题
  final Widget? titleSlot;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('title', title));
    properties.add(
        DiagnosticsProperty<bool>('closeable', closeable, defaultValue: true));
    properties.add(
        DiagnosticsProperty<bool>('swipeable', swipeable, defaultValue: true));
    properties.add(DiagnosticsProperty<String>('value', value));
    properties.add(
        DiagnosticsProperty<FlanCascaderFieldNames>('fieldNames', fieldNames));
    properties.add(DiagnosticsProperty<String>('placeholder', placeholder));
    properties.add(DiagnosticsProperty<Color>('activeColor', activeColor));
    properties.add(DiagnosticsProperty<List<FlanCascaderOption>>(
        'options', options,
        defaultValue: const <FlanCascaderOption>[]));
    properties.add(DiagnosticsProperty<IconData>('closeIconName', closeIconName,
        defaultValue: FlanIcons.cross));
    properties.add(DiagnosticsProperty<String>('closeIconUrl', closeIconUrl));

    super.debugFillProperties(properties);
  }
}

class FlanCascaderOption {
  const FlanCascaderOption({
    this.text,
    this.value,
    this.children,
  });

  final String? text;
  final String? value;
  final List<FlanCascaderOption>? children;
}

class FlanCascaderTab {
  const FlanCascaderTab({
    this.options = const <FlanCascaderOption>[],
    this.selectedOption,
  });

  final List<FlanCascaderOption> options;
  final FlanCascaderOption? selectedOption;
}

class FlanCascaderFieldNames {
  const FlanCascaderFieldNames({
    this.text,
    this.value,
    this.children,
  });

  final String? text;
  final String? value;
  final String? children;
}

class FlanCascaderEvent {
  const FlanCascaderEvent({
    required this.value,
    required this.tabIndex,
    required this.selectedOptions,
  });

  final FlanCascaderOption value;
  final int tabIndex;
  final List<FlanCascaderOption> selectedOptions;
}
