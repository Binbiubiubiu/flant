import '../basic_pages/main.dart';

import './_modals.dart';

var workCompRoutes = [
  CompRoute(
    name: "AddressEdit",
    title: "地址编辑",
    path: "/addressedit",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "AddressList",
    title: "地址列表",
    path: "/addresslist",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Area",
    title: "省市区选择",
    path: "/area",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Card",
    title: "商品卡片",
    path: "/card",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "ContactCard",
    title: "联系人卡片",
    path: "/contactcard",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "ContactEdit",
    title: "联系人编辑",
    path: "/contactedit",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "ContactList",
    title: "联系人列表",
    path: "/contactlist",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Coupon",
    title: "优惠券",
    path: "/coupon",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "GoodsAction",
    title: "商品导航",
    path: "/goodsaction",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "SubmitBar",
    title: "提交订单栏",
    path: "/submitbar",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Sku",
    title: "商品规格",
    path: "/sku",
    component: (context) => CellPage(),
  ),
];
