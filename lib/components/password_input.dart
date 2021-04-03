// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/var.dart';
import 'style.dart';

/// ### FlanPasswordInput 密码输入框
/// 带网格的输入框组件，可以用于输入密码、短信验证码等场景，通常与数字键盘组件配合使用。
class FlanPasswordInput extends StatelessWidget {
  const FlanPasswordInput({
    Key? key,
    this.info = '',
    this.gutter = 0.0,
    this.focused = false,
    this.errorInfo = '',
    this.mask = true,
    this.value = '',
    this.length = 6,
    this.onFocus,
  })  : assert(length > 0),
        super(key: key);

  // ****************** Props ******************
  /// 输入框下方文字提示
  final String info;

  /// 入框格子之间的间距
  final double gutter;

  /// 是否已聚焦，聚焦时会显示光标
  final bool focused;

  /// 输入框下方错误提示
  final String errorInfo;

  /// 是否隐藏密码内容
  final bool mask;

  /// 密码值
  final String value;

  /// 密码最大长度
  final int length;

  // ****************** Events ******************
  final VoidCallback? onFocus;

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    final String info = errorInfo.isNotEmpty ? errorInfo : this.info;

    final List<Widget> children = _buildPoints();
    final List<Widget> result = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      if (i != 0 && gutter != 0.0) {
        result.add(SizedBox(width: gutter));
      }
      result.add(children[i]);
    }

    return Padding(
      padding: ThemeVars.passwordInputMargin,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTapDown: _onTouchStart,
            child: Container(
              height: ThemeVars.passwordInputHeight,
              decoration: BoxDecoration(
                border: gutter == 0.0
                    ? const Border.fromBorderSide(FlanHairLine())
                    : null,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: result,
              ),
            ),
          ),
          if (info.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(top: ThemeVars.paddingMd),
              alignment: Alignment.center,
              child: Text(
                info,
                style: TextStyle(
                  fontSize: ThemeVars.passwordInputInfoFontSize,
                  color: errorInfo.isNotEmpty
                      ? ThemeVars.passwordInputErrorInfoColor
                      : ThemeVars.passwordInputInfoColor,
                ),
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  void _onTouchStart(TapDownDetails details) {
    if (onFocus != null) {
      onFocus!();
    }
  }

  List<Widget> _buildPoints() {
    final List<Widget> points = <Widget>[];
    for (int i = 0; i < length; i++) {
      final String? char = i < value.length ? value[i] : null;
      final bool showBorder = i != 0 && gutter == 0.0;
      final bool showCursor = focused && i == value.length;

      Widget child;
      if (mask) {
        child = Visibility(
          visible: char != null,
          child: Container(
            width: ThemeVars.passwordInputDotSize,
            height: ThemeVars.passwordInputDotSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ThemeVars.passwordInputDotColor,
            ),
          ),
        );
      } else {
        child = Text(char ?? '');
      }

      if (showCursor) {
        child = const _InputCursor();
      }

      points.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: ThemeVars.passwordInputBackgroundColor,
              border: showBorder ? const Border(left: FlanHairLine()) : null,
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      );
    }

    return points;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('info', info));
    properties
        .add(DiagnosticsProperty<double>('gutter', gutter, defaultValue: 0.0));
    properties.add(
        DiagnosticsProperty<bool>('focused', focused, defaultValue: false));

    properties.add(DiagnosticsProperty<String>('errorInfo', errorInfo));
    properties.add(DiagnosticsProperty<bool>('mask', mask, defaultValue: true));
    properties
        .add(DiagnosticsProperty<String>('value', value, defaultValue: ''));
    properties.add(DiagnosticsProperty<int>('length', length, defaultValue: 6));

    super.debugFillProperties(properties);
  }
}

class _InputCursor extends StatefulWidget {
  const _InputCursor({Key? key}) : super(key: key);

  @override
  __InputCursorState createState() => __InputCursorState();
}

class __InputCursorState extends State<_InputCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      duration: ThemeVars.passwordInputCursorAnimationDuration ~/ 2,
      vsync: this,
    );
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: FractionallySizedBox(
        heightFactor: ThemeVars.passwordInputCursorHeight,
        child: Container(
          width: ThemeVars.passwordInputCursorWidth,
          color: ThemeVars.passwordInputCursorColor,
        ),
      ),
    );
  }
}
