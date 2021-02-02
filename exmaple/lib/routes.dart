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
    CompRoute(
      name: "表单组件",
      children: [
        CompRoute(
          name: "Calendar 日历",
          path: "/calendar",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Cascader 级联选择",
          path: "/cascader",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Checkbox 复选框",
          path: "/checkbox",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "DatetimePick 时间选择",
          path: "/datetimepick",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Field 输入框",
          path: "/field",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Form 表单",
          path: "/form",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "NumberKeyboard 数字键盘",
          path: "/numberkeyboard",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "PasswordInput 密码输入框",
          path: "/passwordinput",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Picker 选择器",
          path: "/picker",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Radio 单选框",
          path: "/radio",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Rate 评分",
          path: "/rate",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Search 搜索",
          path: "/search",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Slider 滑块",
          path: "/slider",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Stepper 步进器",
          path: "/Stepper",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Switch 开关",
          path: "/switch",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Uploader 文件上传",
          path: "/uploader",
          component: (context) => CellPage(),
        ),
      ],
    ),
    CompRoute(
      name: "反馈组件",
      children: [
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
      ],
    ),
    CompRoute(
      name: "展示组件",
      children: [
        CompRoute(
          name: "Badge 徽标",
          path: "/badge",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Circle 环形进度条",
          path: "/circle",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Collapse 折叠面板",
          path: "/collapse",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "CountDown 倒计时",
          path: "/countdown",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Divider 分割线",
          path: "/divider",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Empty 空状态",
          path: "/empty",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "ImagePreview 图片预览",
          path: "/imagepreview",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Lazyload 懒加载",
          path: "/lazyload",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "List 列表",
          path: "/list",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "NoticeBar 通知栏",
          path: "/noticebar",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Popover 气泡弹框",
          path: "/popover",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Progress 进度条",
          path: "/progress",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Skeleton 骨架屏",
          path: "/skeleton",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Steps 步骤条",
          path: "/steps",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Sticky 粘性布局",
          path: "/sticky",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Swipe 轮播",
          path: "/swipe",
          component: (context) => CellPage(),
        ),
        CompRoute(
          name: "Tag 标签",
          path: "/tag",
          component: (context) => CellPage(),
        ),
      ],
    ),
    CompRoute(
      name: "导航组件",
      children: [
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
      ],
    ),
    CompRoute(
      name: "业务组件",
      children: [
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
