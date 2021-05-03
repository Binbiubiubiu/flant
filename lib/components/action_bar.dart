// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../styles/components/action_bar_theme.dart';
import '../styles/theme.dart';

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
    final FlanActionBarThemeData themeData =
        FlanTheme.of(context).actionBarTheme;

    return Container(
      height: themeData.height,
      color: themeData.backgroundColor,
      child: SafeArea(
        bottom: safeAreaInsetBottom,
        top: false,
        left: false,
        right: false,
        child: FlanActionBarScope(
          parent: this,
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

class FlanActionBarScope extends InheritedWidget {
  const FlanActionBarScope({
    Key? key,
    required this.parent,
    required Widget child,
  }) : super(key: key, child: child);

  final FlanActionBar parent;

  static FlanActionBarScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlanActionBarScope>();
  }

  @override
  bool updateShouldNotify(FlanActionBarScope oldWidget) {
    return parent != oldWidget.parent;
  }
}
