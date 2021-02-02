import 'package:flutter/material.dart';
import './01_basic_comp.dart';
import './02_form_comp.dart';
import './03_show_comp.dart';
import './04_alert_comp.dart';
import './05_navigator_comp.dart';
import './06_work_comp.dart';
import './_modals.dart';

export './_modals.dart';

class CompRouter {
  static final List<CompRoute> routes = [
    CompRoute.group("基础组件", routes: basicCompRoutes),
    CompRoute.group("表单组件", routes: formCompRoutes),
    CompRoute.group("展示组件", routes: showCompRoutes),
    CompRoute.group("反馈组件", routes: alertCompRoutes),
    CompRoute.group("导航组件", routes: navigatorCompRoutes),
    CompRoute.group("业务组件", routes: workCompRoutes),
  ];

  static Map<String, WidgetBuilder> get pathMap {
    Map<String, WidgetBuilder> map = {};
    routes.forEach((group) {
      group.routes.forEach((item) {
        map[item.path] = item.component;
      });
    });
    return map;
  }
}
