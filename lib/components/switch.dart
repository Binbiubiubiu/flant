// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/components/loading.dart';
import 'package:flant/mixins/field_mixins.dart';
import '../styles/var.dart';

/// ### FlanSwitch
/// 用于在打开和关闭状态之间进行切换。
class FlanSwitch<T> extends StatefulWidget {
  const FlanSwitch({
    Key? key,
    required T value,
    this.loading = false,
    this.disabled = false,
    this.size,
    this.activeColor,
    this.inActiveColor,
    T? activeValue,
    T? inActiveValue,
    required this.onChange,
  })   : value = value ?? false as T,
        activeValue = activeValue ?? true as T,
        inActiveValue = inActiveValue ?? false as T,
        super(key: key);

  // ****************** Props ******************
  /// 开关选中状态
  final T value;

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
  final ValueChanged<T> onChange;

  @override
  _FlanSwitchState<T> createState() => _FlanSwitchState<T>();
}

class _FlanSwitchState<T> extends State<FlanSwitch<T>>
    with TickerProviderStateMixin, LinkFieldMixin {
  late Animation<Color?> bgColorAnimation;
  late AnimationController bgColorAnimationController;

  late Animation<double> nodeAnimation;
  late AnimationController nodeAnimationCotroller;

  @override
  void initState() {
    bgColorAnimationController = AnimationController(
      value: isChecked ? 1.0 : 0.0,
      duration: ThemeVars.switchTransitionDuration,
      vsync: this,
    )..addListener(_handleChange);

    bgColorAnimation = ColorTween(
            begin: widget.inActiveColor ?? ThemeVars.switchBackgroundColor,
            end: widget.activeColor ?? ThemeVars.switchOnBackgroundColor)
        .animate(bgColorAnimationController);

    nodeAnimationCotroller = AnimationController(
      value: isChecked ? 1.0 : 0.0,
      duration: ThemeVars.switchTransitionDuration,
      vsync: this,
    );
    nodeAnimation = Tween<double>(
      begin: 0.0,
      end: ThemeVars.switchWidth * em - ThemeVars.switchNodeSize * em,
    ).animate(nodeAnimationCotroller);
    super.initState();
  }

  @override
  void dispose() {
    bgColorAnimationController.removeListener(_handleChange);
    bgColorAnimationController.dispose();
    nodeAnimationCotroller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanSwitch<T> oldWidget) {
    useLinkField(widget, oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  void _handleChange() => setState(() {});

  double get em => widget.size ?? ThemeVars.switchSize;

  @override
  Widget build(BuildContext context) {
    final Container node = Container(
      width: ThemeVars.switchNodeSize * em,
      height: ThemeVars.switchNodeSize * em,
      decoration: BoxDecoration(
        color: ThemeVars.switchNodeBackgroundColor,
        shape: BoxShape.circle,
        boxShadow: ThemeVars.switchNodeBoxShadow,
      ),
      child: _buildLoading(context),
    );

    final Container sWidget = Container(
      width: ThemeVars.switchWidth * em + ThemeVars.switchBorder.width * 2,
      height: ThemeVars.switchHeight * em + ThemeVars.switchBorder.width * 2,
      decoration: BoxDecoration(
        color: bgColorAnimation.value,
        border: const Border.fromBorderSide(ThemeVars.switchBorder),
        borderRadius: BorderRadius.circular(
          ThemeVars.switchNodeSize * em,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Transform.translate(
              offset: Offset(nodeAnimation.value, 0.0),
              child: node,
            ),
          ),
        ],
      ),
    );

    return Semantics(
      child: GestureDetector(
        onTap: onClick,
        child: Opacity(
          opacity: widget.disabled ? ThemeVars.switchDisabledOpacity : 1.0,
          child: sWidget,
        ),
      ),
      button: true,
      enabled: !widget.disabled,
      label: 'switch',
      checked: isChecked,
    );
  }

  void onClick() {
    if (!widget.disabled && !widget.loading) {
      if (isChecked) {
        nodeAnimationCotroller.reverse();
        bgColorAnimationController.reverse();
        widget.onChange(widget.inActiveValue);
      } else {
        nodeAnimationCotroller.forward();
        bgColorAnimationController.forward();
        widget.onChange(widget.activeValue);
      }
    }
  }

  bool get isChecked => widget.value == widget.activeValue;

  Widget _buildLoading(BuildContext context) {
    if (widget.loading) {
      final Color color =
          (isChecked ? widget.activeColor : widget.inActiveColor) ??
              ThemeVars.switchOnBackgroundColor;
      return FractionallySizedBox(
        widthFactor: .5,
        // heightFactor: .5,
        child: FlanLoading(color: color),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<dynamic>('value', widget.value,
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
