import 'package:flutter/material.dart';

abstract class RouteStatelessWidget extends StatelessWidget {
  const RouteStatelessWidget({
    this.to,
    this.replace = false,
    Key key,
  }) : super(key: key);

  final dynamic to;
  final bool replace;

  void route(BuildContext context) {
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
