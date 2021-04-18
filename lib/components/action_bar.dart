// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/var.dart';

/// ### ActionBar 动作栏
class FlanActionBar extends StatelessWidget {
  const FlanActionBar({
    Key? key,
    this.safeAreaInsetBottom = false,
    this.children = const <Widget>[],
  }) : super(key: key);

  // ****************** Props ******************
  /// 是否开启底部安全区适配
  final bool safeAreaInsetBottom;

  // ****************** Events ******************

  // ****************** Slots ******************
  /// 内容
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ThemeVars.actionBarHeight,
      color: ThemeVars.actionBarBackgroundColor,
      child: SafeArea(
        bottom: safeAreaInsetBottom,
        top: false,
        left: false,
        right: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<bool>(
        'safeAreaInsetBottom', safeAreaInsetBottom,
        defaultValue: true));
    super.debugFillProperties(properties);
  }
}
