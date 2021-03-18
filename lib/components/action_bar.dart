import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../styles/var.dart';

/// ### ActionBar 动作栏
class FlanActionBar extends StatelessWidget {
  const FlanActionBar({
    Key? key,
    this.safeAreaInsetBottom = true,
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
        child: FlanActionBarProvider(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
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

class FlanActionBarProvider extends InheritedWidget {
  const FlanActionBarProvider({
    Key? key,
    required Row child,
  }) : super(key: key, child: child);

  static FlanActionBarProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlanActionBarProvider>();
  }

  @override
  bool updateShouldNotify(FlanActionBarProvider oldWidget) {
    return false;
  }
}
