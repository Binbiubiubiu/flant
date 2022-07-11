import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../mixins/link_field_mixins.dart';
import '../styles/components/switch_theme.dart';
import 'loading.dart';

/// ### FlanSwitch
/// 用于在打开和关闭状态之间进行切换。
@optionalTypeArgs
class FlanSwitch<T extends dynamic> extends StatefulWidget {
  const FlanSwitch({
    Key? key,
    this.modalValue,
    this.loading = false,
    this.disabled = false,
    this.size,
    this.activeColor,
    this.inActiveColor,
    T? activeValue,
    T? inActiveValue,
    this.onChange,
  })  : activeValue = activeValue ?? true as T,
        inActiveValue = inActiveValue ?? false as T,
        super(key: key);

  // ****************** Props ******************
  /// 开关选中状态
  final ValueNotifier<T>? modalValue;

  /// 是否为加载状态
  final bool loading;

  /// 是否为禁用状态
  final bool disabled;

  /// 开关尺寸
  final double? size;

  /// 打开时的背景色
  final Color? activeColor;

  /// 关闭时的背景色
  final Color? inActiveColor;

  /// 打开时对应的值
  final T activeValue;

  /// 关闭时对应的值
  final T inActiveValue;

  // ****************** Events ******************

  /// 开关状态切换时触发
  final ValueChanged<T>? onChange;

  @override
  _FlanSwitchState<T> createState() => _FlanSwitchState<T>();
}

class _FlanSwitchState<T> extends State<FlanSwitch<T>> with FlanLinkFieldMixin {
  late ValueNotifier<T> modalValue;

  @override
  void initState() {
    modalValue = widget.modalValue ?? ValueNotifier<T>(widget.inActiveValue);
    modalValue.addListener(_onChange);
    super.initState();
  }

  @override
  void dispose() {
    modalValue.removeListener(_onChange);
    if (widget.modalValue == null) {
      modalValue.dispose();
    }
    super.dispose();
  }

  void _onChange() {
    widget.onChange?.call(modalValue.value);

    validateChangedValue();
  }

  @override
  Widget build(BuildContext context) {
    linkField(modalValue);
    final FlanSwitchThemeData themeData = FlanSwitchTheme.of(context);
    final double em = widget.size ?? themeData.size;

    final Container node = Container(
      width: themeData.nodeSize * em,
      height: themeData.nodeSize * em,
      decoration: BoxDecoration(
        color: themeData.nodeBackgroundColor,
        shape: BoxShape.circle,
        boxShadow: themeData.nodeBoxShadow,
      ),
      child: _buildLoading(themeData),
    );

    final Color begin = widget.inActiveColor ?? themeData.backgroundColor;
    final Color end = widget.activeColor ?? themeData.onBackgroundColor;

    final Widget sWidget = ValueListenableBuilder<T>(
      valueListenable: modalValue,
      builder: (BuildContext context, T? value, Widget? child) {
        return AnimatedContainer(
          duration: themeData.transitionDuration,
          width: themeData.width * em + themeData.border.width * 2,
          height: themeData.height * em + themeData.border.width * 2,
          decoration: BoxDecoration(
            color: isChecked ? end : begin,
            border: Border.fromBorderSide(themeData.border),
            borderRadius: BorderRadius.circular(
              themeData.nodeSize * em,
            ),
          ),
          child: AnimatedAlign(
            alignment: isChecked ? Alignment.centerRight : Alignment.centerLeft,
            duration: themeData.transitionDuration,
            child: child,
          ),
        );
      },
      child: node,
    );

    return Semantics(
      child: MouseRegion(
        cursor: _cursor,
        child: IgnorePointer(
          ignoring: widget.disabled || widget.loading,
          child: GestureDetector(
            onTap: onClick,
            child: Opacity(
              opacity: widget.disabled ? themeData.disabledOpacity : 1.0,
              child: RepaintBoundary(
                child: sWidget,
              ),
            ),
          ),
        ),
      ),
      button: true,
      enabled: !widget.disabled,
      label: 'switch',
      checked: isChecked,
    );
  }

  void onClick() {
    modalValue.value = isChecked ? widget.inActiveValue : widget.activeValue;
  }

  SystemMouseCursor get _cursor {
    if (widget.disabled) {
      return SystemMouseCursors.forbidden;
    }
    if (widget.loading) {
      return SystemMouseCursors.basic;
    }

    return SystemMouseCursors.click;
  }

  bool get isChecked => modalValue.value == widget.activeValue;

  Widget? _buildLoading(FlanSwitchThemeData themeData) {
    if (widget.loading) {
      final Color color =
          (isChecked ? widget.activeColor : widget.inActiveColor) ??
              themeData.onBackgroundColor;
      return FractionallySizedBox(
        widthFactor: .5,
        // heightFactor: .5,
        child: FlanLoading(color: color),
      );
    }
    return null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<dynamic>('modalValue', widget.modalValue,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('loading', widget.loading,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('disabled', widget.disabled,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<double>('size', widget.size, defaultValue: 30.0));
    properties.add(DiagnosticsProperty<Color>('activeColor', widget.activeColor,
        defaultValue: const Color(0xff1989fa)));
    properties.add(DiagnosticsProperty<Color>(
        'inActiveColor', widget.inActiveColor,
        defaultValue: Colors.white));
    properties.add(DiagnosticsProperty<dynamic>(
        'activeValue', widget.activeValue,
        defaultValue: true));
    properties.add(DiagnosticsProperty<dynamic>(
        'inActiveValue', widget.inActiveValue,
        defaultValue: false));
    super.debugFillProperties(properties);
  }
}
