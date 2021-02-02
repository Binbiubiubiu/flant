import '../basic_pages/main.dart';

import './_modals.dart';

var basicCompRoutes = [
  CompRoute(
    name: "Button",
    title: "按钮",
    path: "/button",
    component: (context) => ButtonPage(),
  ),
  CompRoute(
    name: "Cell",
    title: "单元格",
    path: "/cell",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Icon",
    title: "图标",
    path: "/icon",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Image",
    title: "图片",
    path: "/image",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Layout",
    title: "布局",
    path: "/layout",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Popup",
    title: "弹出层",
    path: "/popup",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Style",
    title: "内置样式",
    path: "/style",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Toast",
    title: "轻提示",
    path: "/toast",
    component: (context) => CellPage(),
  ),
];
