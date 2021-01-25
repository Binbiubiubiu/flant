import 'package:exmaple/pages/button_page.dart';
import 'package:exmaple/pages/cell_page.dart';
import 'package:flutter/material.dart';

class CompRoute {
  CompRoute({this.name = "", this.children, this.path, this.component});
  final String name;
  final String path;
  final WidgetBuilder component;
  final List<CompRoute> children;
}

class CompRouter {
  static final routes = [
    CompRoute(
      name: "基础组件",
      children: [
        CompRoute(
          name: "Button 按钮",
          path: "/button",
          component: (context) => ButtonPage(),
        ),
        CompRoute(
          name: "Cell 单元格",
          path: "/cell",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Icon 图标",
          path: "/icon",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Image 图片",
          path: "/image",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Layout 布局",
          path: "/layout",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Popup 弹出层",
          path: "/popup",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Style 内置样式",
          path: "/style",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Toast 轻提示",
          path: "/toast",
          component: (context) => CellPage(),
        ),
      ],
    ),
  ];

  static get pathMap {
    Map<String, WidgetBuilder> map = {};
    routes.forEach((group) {
      group.children.forEach((item) {
        map[item.path] = item.component;
      });
    });
    return map;
  }
}
