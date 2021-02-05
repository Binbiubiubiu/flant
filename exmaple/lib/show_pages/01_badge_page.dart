import 'package:flutter/material.dart';
import 'package:flant/styles/icons.dart';
import 'package:flant/components/base/icon.dart';
import 'package:flant/components/show/badge.dart';
import '../_components/main.dart';

class FlanBadgeChildBlock extends StatelessWidget {
  const FlanBadgeChildBlock({Key key}) : super(key: key);

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
  renderPageContent(BuildContext context) {
    return [
      const SubTitle(
        text: "基础用法",
      ),
      Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          const FlanBadge(
            content: "5",
            child: FlanBadgeChildBlock(),
          ),
          const FlanBadge(
            content: "10",
            child: FlanBadgeChildBlock(),
          ),
          const FlanBadge(
            content: "Hot",
            child: FlanBadgeChildBlock(),
          ),
          const FlanBadge(
            dot: true,
            child: FlanBadgeChildBlock(),
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
          const FlanBadge(
            content: "20",
            max: 9,
            child: FlanBadgeChildBlock(),
          ),
          const FlanBadge(
            content: "50",
            max: 20,
            child: FlanBadgeChildBlock(),
          ),
          const FlanBadge(
            content: "200",
            max: 99,
            child: FlanBadgeChildBlock(),
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
          const FlanBadge(
            content: "5",
            color: Color(0xff1989fa),
            child: FlanBadgeChildBlock(),
          ),
          const FlanBadge(
            content: "10",
            color: Color(0xff1989fa),
            child: FlanBadgeChildBlock(),
          ),
          const FlanBadge(
            dot: true,
            color: Color(0xff1989fa),
            child: FlanBadgeChildBlock(),
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
          const FlanBadge(
            contentSlot: const FlanIcon(
              name: FlanIcons.success,
              size: 12.0,
              height: 16.0,
            ),
            child: FlanBadgeChildBlock(),
          ),
          const FlanBadge(
            contentSlot: const FlanIcon(
              name: FlanIcons.cross,
              size: 12.0,
              height: 16.0,
            ),
            child: FlanBadgeChildBlock(),
          ),
          const FlanBadge(
            contentSlot: const FlanIcon(
              name: FlanIcons.down,
              size: 12.0,
              height: 16.0,
            ),
            child: FlanBadgeChildBlock(),
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
          const FlanBadge(
            content: "20",
          ),
          const FlanBadge(
            content: "200",
            max: 99,
          ),
        ],
      ),
    ];
  }
}
