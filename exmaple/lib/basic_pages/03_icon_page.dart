import 'package:flutter/material.dart';
import 'package:flant/flant.dart';
import '../_components/main.dart';

class IconPage extends CompPageLayout {
  @override
  renderPageContent(BuildContext context) {
    return [
      const SubTitle(
        text: "基础用法",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          const FlanIcon(
            name: FlanIcons.chat_o,
            size: 32.0,
          ),
          const FlanIcon(
            name: "https://b.yzcdn.cn/vant/icon-demo-1126.png",
            size: 32.0,
          ),
        ],
      ),
      const SubTitle(
        text: "徽标提示",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          const FlanIcon(
            name: FlanIcons.chat_o,
            dot: true,
            size: 32.0,
          ),
          const FlanIcon(
            name: FlanIcons.chat_o,
            badge: "9",
            size: 32.0,
          ),
          const FlanIcon(
            name: FlanIcons.chat_o,
            badge: "99+",
            size: 32.0,
          ),
        ],
      ),
      const SubTitle(
        text: "图标颜色",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          const FlanIcon(
            name: FlanIcons.cart_o,
            color: Colors.blue,
            size: 32.0,
          ),
          const FlanIcon(
            name: FlanIcons.fire_o,
            color: Colors.green,
            size: 32.0,
          ),
        ],
      ),
      const SubTitle(
        text: "图标大小",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          const FlanIcon(
            name: FlanIcons.chat_o,
            size: 40.0,
          ),
          const FlanIcon(
            name: FlanIcons.chat_o,
            size: 48.0,
          ),
        ],
      ),
    ];
  }
}
