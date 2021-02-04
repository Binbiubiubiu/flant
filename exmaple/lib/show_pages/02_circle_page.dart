import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flant/components/show/circle.dart';
import 'package:flant/components/base/button.dart';
import '../_components/main.dart';

double formatRate(double rate) => math.min(math.max(rate, 0), 100);

class CirclePage extends CompPageLayout {
  @override
  Widget renderPageContent() {
    return CircleExample();
  }
}

class CircleExample extends StatefulWidget {
  CircleExample({Key key}) : super(key: key);

  @override
  _CircleExampleState createState() => _CircleExampleState();
}

class _CircleExampleState extends State<CircleExample> {
  double rate = 70.0;
  double currentRate1 = 70;
  double currentRate2 = 70;
  double currentRate3 = 70;
  double currentRate4 = 70;

  add() {
    setState(() {
      this.rate = formatRate(this.rate + 20);
    });
  }

  sub() {
    setState(() {
      this.rate = formatRate(this.rate - 20);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SubTitle(
          text: "基础用法",
        ),
        Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          children: [
            Circle(
              key: const ValueKey("基础用法"),
              currentRate: this.currentRate1,
              rate: this.rate,
              speed: 100.0,
              text: "${currentRate1.round()}%",
              onChange: (val) {
                setState(() {
                  this.currentRate1 = val;
                });
              },
            ),
          ],
        ),
        const SubTitle(
          text: "样式定制",
        ),
        Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          children: [
            Circle(
              key: const ValueKey("宽度定制"),
              currentRate: this.currentRate2,
              rate: this.rate,
              speed: 100.0,
              strokeWidth: 6.0,
              text: "宽度定制",
              onChange: (val) {
                print("onChange");
                setState(() {
                  this.currentRate2 = val;
                });
              },
            ),
            Circle(
              key: const ValueKey("颜色定制"),
              currentRate: this.currentRate3,
              rate: this.rate,
              speed: 100.0,
              layerColor: Color(0xffebedf0),
              color: Color(0xFFEE0A24),
              text: "颜色定制",
              onChange: (val) {
                setState(() {
                  this.currentRate3 = val;
                });
              },
            ),
            Circle(
              key: const ValueKey("渐变色"),
              currentRate: this.currentRate4,
              rate: this.rate,
              speed: 100.0,
              color: LinearGradient(
                colors: [
                  Color(0xff3fecff),
                  Color(0xff6149f6),
                ],
              ),
              text: "渐变色",
              onChange: (val) {
                setState(() {
                  this.currentRate4 = val;
                });
              },
            ),
            Circle(
              key: const ValueKey("逆时针"),
              currentRate: this.currentRate4,
              rate: this.rate,
              speed: 100.0,
              color: Color(0xff07c160),
              clockwise: false,
              text: "逆时针",
              onChange: (val) {
                setState(() {
                  this.currentRate4 = val;
                });
              },
            ),
            Circle(
              key: const ValueKey("大小定制"),
              currentRate: this.currentRate4,
              rate: this.rate,
              speed: 100.0,
              color: Color(0xff7232dd),
              clockwise: false,
              size: 120.0,
              text: "大小定制",
              onChange: (val) {
                setState(() {
                  this.currentRate4 = val;
                });
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Row(
            children: [
              Button(
                type: ButtonType.success,
                size: ButtonSize.small,
                text: "增加",
                onPressed: this.add,
              ),
              SizedBox(width: 10.0),
              Button(
                type: ButtonType.danger,
                size: ButtonSize.small,
                text: "减少",
                onPressed: this.sub,
              ),
            ],
          ),
        )
      ],
    );
  }
}
