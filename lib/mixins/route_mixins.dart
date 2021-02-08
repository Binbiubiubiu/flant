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
abstract class RouteStatelessWidget extends StatelessWidget {
  const RouteStatelessWidget({
    this.to,
    this.replace = false,
    Key key,
  }) : super(key: key);

  /// 点击后跳转的目标路由对象，类型`Route`或`String`
  final dynamic to;

  /// 是否在跳转时替换当前页面历史
  final bool replace;

  void route(BuildContext context) {
    if (this.to == null) {
      return;
    }

    final navigator = Navigator.of(context);

    if (this.to is Route) {
      this.replace ? navigator.pushReplacement(to) : navigator.push(to);
      return;
    }

    if (this.to is String) {
      this.replace
          ? navigator.pushReplacementNamed(to)
          : navigator.pushNamed(to);
      return;
    }

    throw "the type of to should be Route or String";
  }
}
