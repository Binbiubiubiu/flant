import 'package:flutter/material.dart';

class CompRoute {
  CompRoute({
    this.name = "",
    this.title = "",
    this.routes,
    this.path,
    this.component,
  });
  final String name;
  final String title;
  final String path;
  final WidgetBuilder component;
  final List<CompRoute> routes;

  static group(String gName, {List<CompRoute> routes = const []}) =>
      CompRoute(title: gName, routes: routes);
}
