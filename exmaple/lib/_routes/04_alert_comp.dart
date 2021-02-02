import '../basic_pages/main.dart';

import './_modals.dart';

var alertCompRoutes = [
  CompRoute(
    name: "ActionSheet",
    title: "动作面板",
    path: "/ActionSheet",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Dialog",
    title: "弹出框",
    path: "/dialog",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "DropdownMenu",
    title: "下拉菜单",
    path: "/dropdownmenu",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Loading",
    title: "加载",
    path: "/loading",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Notify",
    title: "消息通知",
    path: "/notify",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Overlay",
    title: "遮罩层",
    path: "/overlay",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "PullRefresh",
    title: "下拉刷新",
    path: "/pullRefresh",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "ShareSheet",
    title: "分享面板",
    path: "/shareSheet",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "SwipeCell",
    title: "滑动单元格",
    path: "/swipecell",
    component: (context) => CellPage(),
  ),
];
