import '../basic_pages/main.dart';

import './_modals.dart';

var navigatorCompRoutes = [
  CompRoute(
    name: "Grid",
    title: "宫格",
    path: "/grid",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "IndexBar",
    title: "索引栏",
    path: "/indexbar",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "NavBar",
    title: "导航栏",
    path: "/navbar",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Pagination",
    title: "分页",
    path: "/pagination",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Sidebar",
    title: "侧边导航",
    path: "/sidebar",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Tab",
    title: "标签页",
    path: "/tab",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Tabbar",
    title: "标签栏",
    path: "/tabbar",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "TreeSelect",
    title: "分类选择",
    path: "/treeselect",
    component: (context) => CellPage(),
  ),
];
