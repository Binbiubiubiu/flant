// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 🌎 Project imports:
import '../locale/l10n.dart';
import '../styles/var.dart';
import 'field.dart';
import 'icon.dart';

/// ### FlanSearch
/// 用于搜索场景的输入框组件。
class FlanSearch extends StatefulWidget {
  const FlanSearch({
    Key? key,
    this.label,
    this.rightIconName,
    this.rightIconUrl,
    required this.value,
    this.actionText,
    this.background,
    this.maxLength,
    this.placeholder = '',
    this.autofocus = false,
    this.disabled = false,
    this.readonly = false,
    this.showAction = false,
    this.error = false,
    this.clearTrigger = FlanFieldClearTrigger.focus,
    this.shape = FlanSearchShape.square,
    this.clearable = true,
    this.inputAlign = TextAlign.left,
    this.leftIconName = FlanIcons.search,
    this.leftIconUrl,
    this.onSearch,
    required this.onInput,
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

  /// 右侧图标名称
  final IconData? rightIconName;

  /// 右侧图标链接
  final String? rightIconUrl;

  /// 搜索框值
  final String value;

  /// 取消按钮文字
  final String? actionText;

  /// 搜索框外部背景色
  final Color? background;

  /// 输入的最大字符数
  final int? maxLength;

  /// 占位提示文字
  final String placeholder;

  /// 是否在搜索框右侧显示取消按钮
  final bool showAction;

  /// 显示清除图标的时机，`always` 表示输入框不为空时展示，`focus` 表示输入框聚焦且不为空时展示
  final FlanFieldClearTrigger clearTrigger;

  /// 搜索框形状，可选值为 `round` `square`
  final FlanSearchShape shape;

  /// 是否启用清除图标，点击清除图标后会清空输入框
  final bool clearable;

  /// 是否禁用输入框
  final bool disabled;

  /// 是否将输入框设为只读
  final bool readonly;

  /// 是否将输入内容标红
  final bool error;

  /// 是否自动聚焦
  final bool autofocus;

  final TextAlign inputAlign;

  /// 左侧图标名称
  final IconData leftIconName;

  /// 左侧图标链接
  final String? leftIconUrl;

  // ****************** Events ******************

  /// 确定搜索时触发
  final ValueChanged<String>? onSearch;

  /// 输入框内容变化时触发
  final ValueChanged<String> onInput;

  /// 输入框获得焦点时触发
  final VoidCallback? onFocus;

  /// 输入框失去焦点时触发
  final VoidCallback? onBlur;

  /// 点击清除按钮后触发
  final VoidCallback? onClear;

  /// 点击取消按钮时触发
  final VoidCallback? onCancel;

  // ****************** Slots ******************

  /// 自定义左侧内容（搜索框外）
  final Widget? leftSlot;

  /// 自定义右侧内容（搜索框外），设置`showAction`属性后展示
  final Widget? actionSlot;

  /// 自定义左侧文本（搜索框内）
  final Widget? labelSlot;

  /// 自定义左侧图标（搜索框内）
  final FlanIcon? leftIconSlot;

  /// 自定义右侧图标（搜索框内）
  final FlanIcon? rightIconSlot;

  @override
  _FlanSearchState createState() => _FlanSearchState();
}

class _FlanSearchState extends State<FlanSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ThemeVars.searchPadding.copyWith(
        right: widget.showAction ? 0.0 : ThemeVars.paddingSm,
      ),
      color: widget.background ?? ThemeVars.searchBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.leftSlot ?? const SizedBox.shrink(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: ThemeVars.paddingSm),
              decoration: BoxDecoration(
                color: ThemeVars.searchContentBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    widget.shape == FlanSearchShape.round
                        ? ThemeVars.borderRadiusMax
                        : ThemeVars.borderRadiusSm,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  _buildLabel(),
                  _buildField(),
                ],
              ),
            ),
          ),
          _buildAction(context),
        ],
      ),
    );
  }

  Widget _buildLabel() {
    if (widget.labelSlot != null || widget.label != null) {
      return Padding(
        padding: ThemeVars.searchLabelPadding,
        child: DefaultTextStyle(
          style: const TextStyle(
            color: ThemeVars.searchLabelColor,
            fontSize: ThemeVars.searchLabelFontSize,
            // height: ThemeVars.searchInputHeight / ThemeVars.searchLabelFontSize,
          ),
          child: widget.labelSlot ?? Text(widget.label!),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  GlobalKey<FlanFieldState<dynamic>> inputKey = GlobalKey();

  void blur() => inputKey.currentState?.blur();
  void focus() => inputKey.currentState?.focus();

  Widget _buildField() {
    return Expanded(
      child: FlanField<String>(
        key: inputKey,
        value: widget.value,
        onInput: widget.onInput,
        type: FlanFieldType.search,
        border: false,
        padding: const EdgeInsets.only(
          top: 5.0,
          right: ThemeVars.paddingXs,
          bottom: 5.0,
        ),
        bgColor: Colors.transparent,
        leftIconName: widget.leftIconName,
        leftIconUrl: widget.leftIconUrl,
        rightIconName: widget.rightIconName,
        rightIconUrl: widget.rightIconUrl,
        clearable: widget.clearable,
        clearTrigger: widget.clearTrigger,
        onSubmitted: _onKeypress,
        onClear: widget.onClear,
        onBlur: widget.onBlur,
        onFocus: widget.onFocus,
        leftIconSlot: widget.leftIconSlot,
        rightIconSlot: widget.rightIconSlot,
        maxLength: widget.maxLength,
        disabled: widget.disabled,
        readonly: widget.readonly,
        autofocus: widget.autofocus,
        error: widget.error,
        inputAlign: widget.inputAlign,
        placeholder: widget.placeholder,
      ),
    );
  }

  Widget _buildAction(BuildContext context) {
    if (widget.showAction) {
      final String text = widget.actionText ?? FlanS.of(context).cancel;
      return Semantics(
        button: true,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Material(
            textStyle: const TextStyle(
              color: ThemeVars.searchActionTextColor,
              fontSize: ThemeVars.searchActionFontSize,
              height: 1.0,
              // height:
              //     ThemeVars.searchInputHeight / ThemeVars.searchActionFontSize,
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: ThemeVars.black.withOpacity(0.1),
              onTap: _onCancel,
              mouseCursor: SystemMouseCursors.click,
              child: Padding(
                padding: ThemeVars.searchActionPadding.copyWith(
                  top: 6.0,
                  bottom: 6.0,
                ),
                child: widget.actionSlot ?? Text(text),
              ),
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  void _onCancel() {
    if (widget.actionSlot == null) {
      widget.onInput('');

      if (widget.onCancel != null) {
        widget.onCancel!();
      }
    }
  }

  void _onKeypress(String value) {
    if (widget.onSearch != null) {
      widget.onSearch!(value);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('label', widget.label));
    properties.add(
        DiagnosticsProperty<IconData>('rightIconName', widget.rightIconName));
    properties
        .add(DiagnosticsProperty<String>('rightIconUrl', widget.rightIconUrl));
    properties.add(DiagnosticsProperty<String>('value', widget.value));
    properties
        .add(DiagnosticsProperty<String>('actionText', widget.actionText));
    properties.add(DiagnosticsProperty<Color>('background', widget.background));
    properties.add(DiagnosticsProperty<int>('maxLength', widget.maxLength));
    properties
        .add(DiagnosticsProperty<String>('placeholder', widget.placeholder));
    properties.add(DiagnosticsProperty<bool>('autofocus', widget.autofocus,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('disabled', widget.disabled,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('error', widget.error, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('readonly', widget.readonly,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('showAction', widget.showAction,
        defaultValue: false));
    properties.add(DiagnosticsProperty<FlanFieldClearTrigger>(
        'clearTrigger', widget.clearTrigger,
        defaultValue: FlanFieldClearTrigger.focus));
    properties.add(DiagnosticsProperty<FlanSearchShape>('shape', widget.shape,
        defaultValue: FlanSearchShape.square));
    properties.add(DiagnosticsProperty<bool>('clearable', widget.clearable,
        defaultValue: true));
    properties.add(DiagnosticsProperty<IconData>(
        'leftIconName', widget.leftIconName,
        defaultValue: FlanIcons.search));
    properties
        .add(DiagnosticsProperty<String>('leftIconUrl', widget.leftIconUrl));

    super.debugFillProperties(properties);
  }
}

enum FlanSearchShape {
  square,
  round,
}
