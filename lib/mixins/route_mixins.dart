// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 带有路由功能组件的抽象类
/// {@tool snippet}
///
/// ``` dart
/// class FlanButton extends RouteStatelessWidget {
///   const FlanButton({
///      Key key,
///      dynamic to,
///      bool replace
///   }):super(key:key,to:to,replace:replace);
///
///   final dynamic to;
///   final bool replace;
///
///   @override
///   Widget build(BuildContext context) {
///     return Button(
///       onPressed:(){this.route(context)},
///       child:Text("跳转"),
///     );
///   }
/// }
/// ```
/// {@end-tool}
///
/// 通过继承的`to`和`replace`属性设置跳转条件
///
abstract class FlanRouteStatelessWidget extends StatelessWidget {
  const FlanRouteStatelessWidget({
    this.toRoute,
    this.toName,
    this.replace = false,
    Key? key,
  }) : super(key: key);

  /// 点击后跳转的目标路由对象
  final PageRoute<Object?>? toRoute;

  /// 点击后跳转的目标路由对象name
  final String? toName;

  /// 是否在跳转时替换当前页面历史
  final bool replace;

  void route(BuildContext context) {
    if (toRoute == null && toName == null) {
      return;
    }

    final NavigatorState navigator = Navigator.of(context);

    if (toRoute != null) {
      replace
          ? navigator.pushReplacement<Object?, Object?>(toRoute!)
          : navigator.push<Object?>(toRoute!);
      return;
    }

    if (toName != null) {
      replace
          ? navigator.pushReplacementNamed(toName!)
          : navigator.pushNamed(toName!);
      return;
    }

    throw 'to 属性类型必须是 Route 或者 String';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('toName', toName));
    properties.add(DiagnosticsProperty<PageRoute<Object?>>('toRoute', toRoute));
    properties.add(
        DiagnosticsProperty<bool>('replace', replace, defaultValue: false));
    super.debugFillProperties(properties);
  }
}
