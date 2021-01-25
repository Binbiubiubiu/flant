import 'package:exmaple/components/sub_title.dart';
import 'package:flant/components/button.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class CellPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic query = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(query["title"]),
      ),
      body: Container(
        padding: PageTheme.padding,
        child: ListView(
          children: [
            SubTitle(
              text: "按钮类型",
            ),
            Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: [
                Button(
                  text: "主要按钮",
                  type: ButtonType.success,
                  onPressed: () {},
                ),
                Button(
                  text: "信息按钮",
                  type: ButtonType.primary,
                  onPressed: () {},
                ),
                Button(
                  text: "默认按钮",
                  type: ButtonType.normal,
                  onPressed: () {},
                ),
                Button(
                  text: "危险按钮",
                  type: ButtonType.danger,
                  onPressed: () {},
                ),
                Button(
                  text: "警告按钮",
                  type: ButtonType.warning,
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
                Button(
                  text: "朴素按钮",
                  plain: true,
                  type: ButtonType.success,
                  onPressed: () {},
                ),
                Button(
                  text: "朴素按钮",
                  plain: true,
                  type: ButtonType.primary,
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
                Button(
                  text: "朴素按钮",
                  plain: true,
                  hairline: true,
                  type: ButtonType.success,
                  onPressed: () {},
                ),
                Button(
                  text: "朴素按钮",
                  plain: true,
                  hairline: true,
                  type: ButtonType.primary,
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
                Button(
                  text: "禁用按钮",
                  disabled: true,
                  type: ButtonType.success,
                ),
                Button(
                  text: "禁用按钮",
                  disabled: true,
                  type: ButtonType.primary,
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
                Button(
                  loading: true,
                  type: ButtonType.success,
                  onPressed: () {},
                ),
                Button(
                  loading: true,
                  type: ButtonType.primary,
                  onPressed: () {},
                ),
                Button(
                  loading: true,
                  text: "加载中...",
                  type: ButtonType.primary,
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
                Button(
                  square: true,
                  text: "方形按钮",
                  type: ButtonType.success,
                ),
                Button(
                  round: true,
                  text: "圆形按钮",
                  type: ButtonType.primary,
                ),
                Button(
                  round: true,
                  plain: true,
                  text: "圆形按钮",
                  type: ButtonType.primary,
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
                Button(
                  icon: Icons.add,
                  type: ButtonType.success,
                ),
                Button(
                  icon: Icons.add,
                  text: "按钮",
                  type: ButtonType.success,
                ),
                Button(
                  icon: Icons.people,
                  plain: true,
                  text: "按钮",
                  type: ButtonType.primary,
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
                Button(
                  size: ButtonSize.large,
                  text: "大号按钮",
                  type: ButtonType.success,
                ),
                Button(
                  size: ButtonSize.normal,
                  text: "普通按钮",
                  type: ButtonType.primary,
                ),
                Button(
                  size: ButtonSize.small,
                  text: "小型按钮",
                  type: ButtonType.primary,
                ),
                Button(
                  size: ButtonSize.mini,
                  text: "迷你按钮",
                  type: ButtonType.primary,
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
                Button(
                  text: "块级元素",
                  block: true,
                  type: ButtonType.success,
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
                Button(
                  text: "URL跳转",
                  type: ButtonType.success,
                ),
                Button(
                  text: "路由跳转",
                  type: ButtonType.success,
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
                Button(
                  color: Color(0xFF7232DD),
                  text: "单色按钮",
                ),
                Button(
                  color: Color(0xFFFF0000),
                  text: "单色按钮",
                  plain: true,
                ),
                Button(
                  color: Color(0xFFFF0000),
                  text: "渐变色按钮",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
