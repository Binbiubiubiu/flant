import 'package:flutter/material.dart';
import 'package:flant/components/badge.dart';

import '../_components/main.dart';

class BadgeChildBlock extends StatelessWidget {
  const BadgeChildBlock({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: Color(0xfff2f3f5),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
  }
}

class BadgePage extends CompPageLayout {
  @override
  renderPageContent() {
    return [
      const SubTitle(
        text: "基础用法",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          const Badge(
            content: "5",
            child: BadgeChildBlock(),
          ),
          const Badge(
            content: "10",
            child: BadgeChildBlock(),
          ),
          const Badge(
            content: "Hot",
            child: BadgeChildBlock(),
          ),
          const Badge(
            dot: true,
            child: BadgeChildBlock(),
          ),
        ],
      ),
      const SubTitle(
        text: "最大值",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          const Badge(
            content: "20",
            max: 9,
            child: BadgeChildBlock(),
          ),
          const Badge(
            content: "50",
            max: 20,
            child: BadgeChildBlock(),
          ),
          const Badge(
            content: "200",
            max: 99,
            child: BadgeChildBlock(),
          ),
        ],
      ),
      const SubTitle(
        text: "自定义颜色",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          const Badge(
            content: "5",
            color: Color(0xff1989fa),
            child: BadgeChildBlock(),
          ),
          const Badge(
            content: "10",
            color: Color(0xff1989fa),
            child: BadgeChildBlock(),
          ),
          const Badge(
            dot: true,
            color: Color(0xff1989fa),
            child: BadgeChildBlock(),
          ),
        ],
      ),
      const SubTitle(
        text: "自定义徽标内容",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          const Badge(
            contentSlot: const Icon(Icons.arrow_right),
            child: BadgeChildBlock(),
          ),
          const Badge(
            contentSlot: const Icon(Icons.arrow_right),
            child: BadgeChildBlock(),
          ),
          const Badge(
            contentSlot: const Icon(Icons.arrow_right),
            child: BadgeChildBlock(),
          ),
        ],
      ),
      const SubTitle(
        text: "独立展示",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          const Badge(
            content: "20",
          ),
          const Badge(
            content: "200",
            max: 99,
          ),
        ],
      ),
    ];
  }
}
