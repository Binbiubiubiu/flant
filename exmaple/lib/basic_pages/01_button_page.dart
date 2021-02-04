import 'package:flutter/material.dart';
import 'package:flant/components/base/button.dart';

import '../_components/main.dart';

class ButtonPage extends CompPageLayout {
  @override
  List<Widget> renderPageContent() {
    return [
      SubTitle(
        text: "按钮类型",
      ),
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
      SubTitle(
        text: "朴素按钮",
      ),
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
      SubTitle(
        text: "细边框",
      ),
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
      SubTitle(
        text: "禁用状态",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          FlanButton(
            text: "禁用按钮",
            disabled: true,
            type: FlanButtonType.success,
          ),
          FlanButton(
            text: "禁用按钮",
            disabled: true,
            type: FlanButtonType.primary,
          ),
        ],
      ),
      SubTitle(
        text: "加载状态",
      ),
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
      SubTitle(
        text: "按钮形状",
      ),
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
      SubTitle(
        text: "图标按钮",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          FlanButton(
            icon: Icons.add,
            type: FlanButtonType.success,
            onPressed: () {},
          ),
          FlanButton(
            icon: Icons.add,
            text: "按钮",
            type: FlanButtonType.success,
            onPressed: () {},
          ),
          FlanButton(
            icon: Icons.people,
            plain: true,
            text: "按钮",
            type: FlanButtonType.primary,
            onPressed: () {},
          ),
        ],
      ),
      SubTitle(
        text: "按钮尺寸",
      ),
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
      SubTitle(
        text: "块级元素",
      ),
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
      SubTitle(
        text: "页面导航",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          FlanButton(
            text: "URL跳转",
            type: FlanButtonType.success,
            onPressed: () {},
          ),
          FlanButton(
            text: "路由跳转",
            type: FlanButtonType.success,
            onPressed: () {},
          ),
        ],
      ),
      SubTitle(
        text: "自定义颜色",
      ),
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
    ];
  }
}
