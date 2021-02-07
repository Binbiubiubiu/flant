import 'package:flutter/material.dart';
import 'package:flant/flant.dart';
import '../_components/main.dart';

class ImagePage extends CompPageLayout {
  @override
  renderPageContent(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemWidth = (width - 16.0 * 2 - 20.0 * 2) / 3;
    final itemHeight = width * 0.27;

    return [
      DocBlock(
        title: "基础用法",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              const FlanImage(
                src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                width: 100.00,
                height: 100.0,
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "填充模式",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanImage(
                src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                width: itemWidth,
                height: itemHeight,
                fit: BoxFit.contain,
                child: ImagePageText("contain"),
              ),
              FlanImage(
                src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                width: itemWidth,
                height: itemHeight,
                fit: BoxFit.cover,
                child: ImagePageText("cover"),
              ),
              FlanImage(
                src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                width: itemWidth,
                height: itemHeight,
                fit: BoxFit.fill,
                child: ImagePageText("fill"),
              ),
              FlanImage(
                src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                width: itemWidth,
                height: itemHeight,
                fit: BoxFit.none,
                child: ImagePageText("none"),
              ),
              FlanImage(
                src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                width: itemWidth,
                height: itemHeight,
                fit: BoxFit.scaleDown,
                child: ImagePageText("scale-down"),
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "圆形图片",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  FlanImage(
                    src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                    width: itemWidth,
                    height: itemHeight,
                    fit: BoxFit.contain,
                    round: true,
                  ),
                  FlanImage(
                    src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                    width: itemWidth,
                    height: itemHeight,
                    fit: BoxFit.cover,
                  ),
                  FlanImage(
                    src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                    width: itemWidth,
                    height: itemHeight,
                    fit: BoxFit.fill,
                    round: true,
                  ),
                  FlanImage(
                    src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                    width: itemWidth,
                    height: itemHeight,
                    fit: BoxFit.none,
                    round: true,
                  ),
                  FlanImage(
                    src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                    width: itemWidth,
                    height: itemHeight,
                    fit: BoxFit.scaleDown,
                    round: true,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "加载中提示",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              FlanImage(
                // src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                width: itemWidth,
                height: itemHeight,
              ),
              FlanImage(
                // src: "https://img01.yzcdn.cn/vant/cat.jpeg",
                width: itemWidth,
                height: itemHeight,
                loadingSlot: FlanIcon(
                  name: FlanIcons.shop,
                ),
              ),
            ],
          ),
        ],
      ),
      DocBlock(
        title: "加载失败提示",
        children: [
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              const FlanImage(
                src: "https://img01.yzcdn.cn/vant/cat",
                width: 100.00,
                height: 100.0,
              ),
              const FlanImage(
                src: "https://img01.yzcdn.cn/vant/cat",
                width: 100.00,
                height: 100.0,
                errorSlot: Text("加载失败"),
              ),
            ],
          ),
        ],
      ),
    ];
  }
}

class ImagePageText extends StatelessWidget {
  const ImagePageText(this.text, {Key key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        this.text,
        style: TextStyle(
          inherit: true,
          height: 1.6,
        ),
      ),
    );
  }
}
