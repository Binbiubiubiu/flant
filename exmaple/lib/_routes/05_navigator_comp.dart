import '../basic_pages/main.dart';

import './_modals.dart';

var navigatorCompRoutes = [
  CompRoute(
    name: "Grid 宫格",
    path: "/grid",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "IndexBar 索引栏",
    path: "/indexbar",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "NavBar 导航栏",
    path: "/navbar",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Pagination 分页",
    path: "/pagination",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Sidebar 侧边导航",
    path: "/sidebar",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Tab 标签页",
    path: "/tab",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Tabbar 标签栏",
    path: "/tabbar",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "TreeSelect 分类选择",
    path: "/treeselect",
    component: (context) => CellPage(),
  ),
];
