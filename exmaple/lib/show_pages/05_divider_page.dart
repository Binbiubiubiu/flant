import 'package:flutter/material.dart';
import 'package:flant/flant.dart';

import '../_components/main.dart';

class DividerPage extends CompPageLayout {
  @override
  renderPageContent(BuildContext context) {
    return [
      DocBlock.noPadding(
        title: "基础用法",
        children: [
          const FlanDivider(),
        ],
      ),
      DocBlock.noPadding(
        title: "展示文本",
        children: [
          const FlanDivider(
            child: Text("文本"),
          ),
        ],
      ),
      DocBlock.noPadding(
        title: "内容位置",
        children: [
          const FlanDivider(
            contentPosition: FlanDividerContentPosition.left,
            child: Text("文本"),
          ),
          const FlanDivider(
            contentPosition: FlanDividerContentPosition.right,
            child: Text("文本"),
          ),
        ],
      ),
      DocBlock.noPadding(
        title: "虚线",
        children: [
          const FlanDivider(
            dashed: true,
            child: Text("文本"),
          ),
        ],
      ),
      DocBlock.noPadding(
        title: "自定义样式",
        children: [
          FlanDivider(
            style: const FlanDividerStyle(
              borderColor: Color(0xff1989fa),
              color: Color(0xff1989fa),
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            ),
            child: Text("文本"),
          ),
        ],
      ),
    ];
  }
}
