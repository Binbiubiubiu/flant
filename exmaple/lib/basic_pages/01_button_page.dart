import 'package:flant/styles/icons.dart';
import 'package:flutter/material.dart';
import 'package:flant/components/base/button.dart';

import '../_components/main.dart';
import './02_cell_page.dart';

class ButtonPage extends CompPageLayout {
  @override
  List<Widget> renderPageContent(BuildContext context) {
    return [
      DocBlock(
        title: "按钮类型",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanButton(
                text: "主要按钮",
                type: FlanButtonType.success,
                onPressed: () {},
              ),
              FlanButton(
                text: "信息按钮",
                type: FlanButtonType.primary,
                onPressed: () {},
              ),
              FlanButton(
                text: "默认按钮",
                type: FlanButtonType.normal,
                onPressed: () {},
              ),
              FlanButton(
                text: "危险按钮",
                type: FlanButtonType.danger,
                onPressed: () {},
              ),
              FlanButton(
                text: "警告按钮",
                type: FlanButtonType.warning,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "朴素按钮",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanButton(
                text: "朴素按钮",
                plain: true,
                type: FlanButtonType.success,
                onPressed: () {},
              ),
              FlanButton(
                text: "朴素按钮",
                plain: true,
                type: FlanButtonType.primary,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "细边框",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanButton(
                text: "朴素按钮",
                plain: true,
                hairline: true,
                type: FlanButtonType.success,
                onPressed: () {},
              ),
              FlanButton(
                text: "朴素按钮",
                plain: true,
                hairline: true,
                type: FlanButtonType.primary,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "禁用状态",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanButton(
                text: "禁用按钮",
                disabled: true,
                type: FlanButtonType.success,
                onPressed: () {},
              ),
              FlanButton(
                text: "禁用按钮",
                disabled: true,
                type: FlanButtonType.primary,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "加载状态",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanButton(
                loading: true,
                type: FlanButtonType.success,
                onPressed: () {},
              ),
              FlanButton(
                loading: true,
                type: FlanButtonType.primary,
                onPressed: () {},
              ),
              FlanButton(
                loading: true,
                text: "加载中...",
                type: FlanButtonType.primary,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "按钮形状",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanButton(
                square: true,
                text: "方形按钮",
                type: FlanButtonType.success,
                onPressed: () {},
              ),
              FlanButton(
                round: true,
                text: "圆形按钮",
                type: FlanButtonType.primary,
                onPressed: () {},
              ),
              FlanButton(
                round: true,
                plain: true,
                text: "圆形按钮",
                type: FlanButtonType.primary,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "图标按钮",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanButton(
                icon: FlanIcons.plus,
                type: FlanButtonType.success,
                onPressed: () {},
              ),
              FlanButton(
                icon: FlanIcons.plus,
                text: "按钮",
                type: FlanButtonType.success,
                onPressed: () {},
              ),
              FlanButton(
                icon: "https://img01.yzcdn.cn/vant/user-active.png",
                plain: true,
                text: "按钮",
                type: FlanButtonType.primary,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "按钮尺寸",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanButton(
                size: FlanButtonSize.large,
                text: "大号按钮",
                type: FlanButtonType.success,
                onPressed: () {},
              ),
              FlanButton(
                size: FlanButtonSize.normal,
                text: "普通按钮",
                type: FlanButtonType.primary,
                onPressed: () {},
              ),
              FlanButton(
                size: FlanButtonSize.small,
                text: "小型按钮",
                type: FlanButtonType.primary,
                onPressed: () {},
              ),
              FlanButton(
                size: FlanButtonSize.mini,
                text: "迷你按钮",
                type: FlanButtonType.primary,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "块级元素",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanButton(
                text: "块级元素",
                block: true,
                type: FlanButtonType.success,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "页面导航",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanButton(
                text: "URL跳转",
                type: FlanButtonType.success,
                to: "/cell",
              ),
              FlanButton(
                text: "路由跳转",
                type: FlanButtonType.success,
                to: MaterialPageRoute(
                  builder: (BuildContext context) => CellPage(),
                  settings: RouteSettings(
                    name: "/cell",
                    arguments: {"title": "Cell"},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "自定义颜色",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanButton(
                color: Color(0xFF7232DD),
                text: "单色按钮",
                onPressed: () {},
              ),
              FlanButton(
                color: Color(0xFFFF0000),
                text: "单色按钮",
                plain: true,
                onPressed: () {},
              ),
              FlanButton(
                color: LinearGradient(
                  colors: [Colors.cyan, Colors.blue, Colors.blueAccent],
                ),
                text: "渐变色按钮",
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    ];
  }
}
