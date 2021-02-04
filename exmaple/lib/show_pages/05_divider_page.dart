import 'package:flutter/material.dart';
import 'package:flant/flant.dart';

import '../_components/main.dart';

class DividerPage extends CompPageLayout {
  @override
  renderPageContent() {
    return [
      const SubTitle(
        text: "基础用法",
      ),
      const FlanDivider(),
      const SubTitle(
        text: "展示文本",
      ),
      const FlanDivider(
        child: Text("文本"),
      ),
      const SubTitle(
        text: "内容位置",
      ),
      const FlanDivider(
        contentPosition: FlanDividerContentPosition.left,
        child: Text("文本"),
      ),
      const FlanDivider(
        contentPosition: FlanDividerContentPosition.right,
        child: Text("文本"),
      ),
      const SubTitle(
        text: "虚线",
      ),
      const FlanDivider(
        dashed: true,
        child: Text("文本"),
      ),
      const SubTitle(
        text: "自定义样式",
      ),
      FlanDivider(
        style: const FlanDividerStyle(
          borderColor: Color(0xff1989fa),
          color: Color(0xff1989fa),
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        ),
        child: Text("文本"),
      ),
    ];
  }
}
