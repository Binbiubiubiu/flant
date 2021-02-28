import 'package:flant/components/alert/loading.dart';
import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
import '../../styles/var.dart';

/// ### FlanSwitch
/// 用于在打开和关闭状态之间进行切换。
class FlanSwitch<T extends dynamic> extends StatefulWidget {
  const FlanSwitch({
    Key key,
    T value,
    this.loading = false,
    this.disabled = false,
    this.size,
    this.activeColor,
    this.inActiveColor,
    T activeValue,
    T inActiveValue,
    this.onChange,
  })  : assert(loading != null),
        assert(disabled != null),
        value = value ?? false,
        activeValue = activeValue ?? true,
        inActiveValue = inActiveValue ?? false,
        super(key: key);

  // ****************** Props ******************
  /// 开关选中状态
  final T value;

  /// 是否为加载状态
  final bool loading;

  /// 是否为禁用状态
  final bool disabled;

  /// 开关尺寸
  final double size;

  /// 打开时的背景色
  final Color activeColor;

  /// 关闭时的背景色
  final Color inActiveColor;

  /// 打开时对应的值
  final T activeValue;

  /// 关闭时对应的值
  final T inActiveValue;

  // ****************** Events ******************

  /// 开关状态切换时触发
  final ValueChanged<T> onChange;

  @override
  _FlanSwitchState createState() => _FlanSwitchState();
}

class _FlanSwitchState extends State<FlanSwitch> with TickerProviderStateMixin {
  Animation<Color> bgColorAnimation;
  AnimationController bgColorAnimationController;

  Animation<double> nodeAnimation;
  AnimationController nodeAnimationCotroller;

  @override
  void initState() {
    this.bgColorAnimationController = AnimationController(
      value: this.widget.value ? 1.0 : 0.0,
      duration: ThemeVars.switchTransitionDuration,
      vsync: this,
    )..addListener(this._handleChange);

    this.bgColorAnimation = ColorTween(
            begin: this.widget.inActiveColor ?? ThemeVars.switchBackgroundColor,
            end: this.widget.activeColor ?? ThemeVars.switchOnBackgroundColor)
        .animate(this.bgColorAnimationController);

    this.nodeAnimationCotroller = AnimationController(
      value: this.widget.value ? 1.0 : 0.0,
      duration: ThemeVars.switchTransitionDuration,
      vsync: this,
    );
    this.nodeAnimation = Tween(
      begin: 0.0,
      end: ThemeVars.switchWidth * this.em - ThemeVars.switchNodeSize * this.em,
    ).animate(this.nodeAnimationCotroller);
    super.initState();
  }

  @override
  void dispose() {
    this.bgColorAnimationController?.removeListener(this._handleChange);
    this.bgColorAnimationController?.dispose();
    this.nodeAnimationCotroller?.dispose();
    super.dispose();
  }

  _handleChange() => this.setState(() {});

  get em => this.widget.size ?? ThemeVars.switchSize;

  @override
  Widget build(BuildContext context) {
    final node = Container(
      width: ThemeVars.switchNodeSize * this.em,
      height: ThemeVars.switchNodeSize * this.em,
      decoration: BoxDecoration(
        color: ThemeVars.switchNodeBackgroundColor,
        shape: BoxShape.circle,
        boxShadow: ThemeVars.switchNodeBoxShadow,
      ),
      child: this._buildLoading(context),
    );

    final sWidget = Container(
      width: ThemeVars.switchWidth * this.em + ThemeVars.switchBorder.width * 2,
      height:
          ThemeVars.switchHeight * this.em + ThemeVars.switchBorder.width * 2,
      decoration: BoxDecoration(
        color: this.bgColorAnimation.value,
        border: Border.fromBorderSide(ThemeVars.switchBorder),
        borderRadius: BorderRadius.circular(
          ThemeVars.switchNodeSize * this.em,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Transform.translate(
              offset: Offset(this.nodeAnimation.value, 0.0),
              child: node,
            ),
          ),
        ],
      ),
    );

    return Semantics(
      child: GestureDetector(
        onTap: this.onClick,
        child: Opacity(
          opacity: this.widget.disabled ? ThemeVars.switchDisabledOpacity : 1.0,
          child: sWidget,
        ),
      ),
      button: true,
      enabled: !this.widget.disabled,
      label: "switch",
      checked: this.widget.value,
    );
  }

  void onClick() {
    if (!this.widget.disabled && !this.widget.loading) {
      if (this.isChecked) {
        this.nodeAnimationCotroller.reverse();
        this.bgColorAnimationController.reverse();
        this.widget.onChange(this.widget.inActiveValue);
      } else {
        this.nodeAnimationCotroller.forward();
        this.bgColorAnimationController.forward();
        this.widget.onChange(this.widget.activeValue);
      }
    }
  }

  bool get isChecked => this.widget.value == this.widget.activeValue;

  Widget _buildLoading(BuildContext context) {
    if (this.widget.loading) {
      final color = (this.isChecked
              ? this.widget.activeColor
              : this.widget.inActiveColor) ??
          ThemeVars.switchOnBackgroundColor;
      return FractionallySizedBox(
        widthFactor: .5,
        // heightFactor: .5,
        child: FlanLoading(color: color),
      );
    }
    return SizedBox.shrink();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<dynamic>("value", widget.value,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>("loading", widget.loading,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>("disabled", widget.disabled,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<double>("size", widget.size, defaultValue: 30.0));
    properties.add(DiagnosticsProperty<Color>("activeColor", widget.activeColor,
        defaultValue: const Color(0xff1989fa)));
    properties.add(DiagnosticsProperty<Color>(
        "inActiveColor", widget.inActiveColor,
        defaultValue: Colors.white));
    properties.add(DiagnosticsProperty<dynamic>(
        "activeValue", widget.activeValue,
        defaultValue: true));
    properties.add(DiagnosticsProperty<dynamic>(
        "inActiveValue", widget.inActiveValue,
        defaultValue: false));
    super.debugFillProperties(properties);
  }
}
