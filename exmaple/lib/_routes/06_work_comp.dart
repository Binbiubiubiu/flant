import '../basic_pages/main.dart';

import './_modals.dart';

var workCompRoutes = [
  CompRoute(
    name: "AddressEdit 地址编辑",
    path: "/addressedit",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "AddressList 地址列表",
    path: "/addresslist",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Area 省市区选择",
    path: "/area",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Card 商品卡片",
    path: "/card",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "ContactCard 联系人卡片",
    path: "/contactcard",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "ContactEdit 联系人编辑",
    path: "/contactedit",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "ContactList 联系人列表",
    path: "/contactlist",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Coupon 优惠券",
    path: "/coupon",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "GoodsAction 商品导航",
    path: "/goodsaction",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "SubmitBar 提交订单栏",
    path: "/submitbar",
    component: (context) => CellPage(),
  ),
  CompRoute(
    name: "Sku 商品规格",
    path: "/sku",
    component: (context) => CellPage(),
  ),
];
