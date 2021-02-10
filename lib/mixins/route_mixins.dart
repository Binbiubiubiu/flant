import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
abstract class RouteStatelessWidget extends StatelessWidget {
  const RouteStatelessWidget({
    this.toRoute,
    this.toName,
    this.replace = false,
    Key key,
  })  : assert(replace != null),
        super(key: key);

  /// 点击后跳转的目标路由对象
  final PageRoute toRoute;

  /// 点击后跳转的目标路由对象name
  final String toName;

  /// 是否在跳转时替换当前页面历史
  final bool replace;

  void route(BuildContext context) {
    if (this.toRoute == null && this.toName == null) {
      return;
    }

    final navigator = Navigator.of(context);

    if (this.toRoute != null) {
      this.replace
          ? navigator.pushReplacement(this.toRoute)
          : navigator.push(this.toRoute);
      return;
    }

    if (this.toName != null) {
      this.replace
          ? navigator.pushReplacementNamed(this.toName)
          : navigator.pushNamed(this.toName);
      return;
    }

    throw "to 属性类型必须是 Route 或者 String";
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>("toName", toName));
    properties.add(DiagnosticsProperty<PageRoute>("toRoute", toRoute));
    properties.add(
        DiagnosticsProperty<bool>("replace", replace, defaultValue: false));
    super.debugFillProperties(properties);
  }
}
