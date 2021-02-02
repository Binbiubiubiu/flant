import '../basic_pages/main.dart';

import './_modals.dart';

var alertCompRoutes = [
  CompRoute(
    name: "ActionSheet 动作面板",
    path: "/ActionSheet",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Dialog 弹出框",
    path: "/dialog",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "DropdownMenu 下拉菜单",
    path: "/dropdownmenu",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Loading 加载",
    path: "/loading",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Notify 消息同志",
    path: "/notify",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Overlay 遮罩层",
    path: "/overlay",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "PullRefresh 下拉刷新",
    path: "/pullRefresh",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "ShareSheet 分享面板",
    path: "/shareSheet",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "SwipeCell 滑动单元格",
    path: "/swipecell",
    component: (context) => CellPage(),
  ),
];
