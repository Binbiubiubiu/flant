import 'package:flutter/material.dart';
import 'package:flant/flant.dart';
import '../_components/main.dart';
import './01_button_page.dart';

class CellPage extends CompPageLayout {
  @override
  renderPageContent(BuildContext context) {
    return [
      DocBlock.noPadding(
        title: "基础用法",
        children: [
          FlanCellGroup(
            children: [
              const FlanCell(
                title: "单元格",
                value: "内容",
              ),
              const FlanCell(
                title: "单元格",
                value: "内容",
                label: "描述信息",
              ),
            ],
          )
        ],
      ),
      DocBlock.noPadding(
        title: "单元格大小",
        children: [
          FlanCellGroup(
            children: [
              const FlanCell(
                title: "单元格",
                value: "内容",
                size: FlanCellSize.large,
              ),
              const FlanCell(
                title: "单元格",
                value: "内容",
                label: "描述信息",
                size: FlanCellSize.large,
              ),
            ],
          )
        ],
      ),
      DocBlock.noPadding(
        title: "展示图标",
        children: [
          const FlanCell(
            title: "单元格",
            value: "内容",
            icon: FlanIcons.location_o,
          ),
        ],
      ),
      DocBlock.noPadding(
        title: "只设置value",
        children: [
          const FlanCell(
            value: "内容",
          )
        ],
      ),
      DocBlock.noPadding(
        title: "展示箭头",
        children: [
          FlanCellGroup(
            children: [
              const FlanCell(
                title: "单元格",
                isLink: true,
              ),
              const FlanCell(
                title: "单元格",
                value: "内容",
                isLink: true,
              ),
              const FlanCell(
                title: "单元格",
                value: "内容",
                arrowDirection: FlanCellArrowDirection.down,
                isLink: true,
              ),
            ],
          )
        ],
      ),
      DocBlock.noPadding(
        title: "页面导航",
        children: [
          FlanCellGroup(
            children: [
              const FlanCell(
                title: "URL 跳转",
                isLink: true,
                to: "/button",
              ),
              FlanCell(
                title: "路由跳转",
                isLink: true,
                to: MaterialPageRoute(
                  builder: (BuildContext context) => ButtonPage(),
                  settings: RouteSettings(
                    name: "/button",
                    arguments: {"title": "Button"},
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      DocBlock.noPadding(
        title: "分组标题",
        children: [
          FlanCellGroup(
            title: "分组1",
            children: [
              const FlanCell(
                title: "单元格",
                value: "内容",
              ),
            ],
          ),
          FlanCellGroup(
            title: "分组2",
            children: [
              const FlanCell(
                title: "单元格",
                value: "内容",
              ),
            ],
          ),
        ],
      ),
      DocBlock.noPadding(
        title: "使用插槽",
        children: [
          FlanCellGroup(
            children: [
              FlanCell(
                titleSlot: Wrap(
                  children: [
                    Text("单元格"),
                  ],
                ),
                value: "内容",
                isLink: true,
              ),
              const FlanCell(
                title: "单元格",
                icon: FlanIcons.shop_o,
                rightIconSlot: FlanIcon(name: FlanIcons.search),
              ),
            ],
          ),
        ],
      ),
      DocBlock.noPadding(
        title: "垂直居中",
        children: [
          FlanCell(
            center: true,
            title: "单元格",
            value: "内容",
            label: "描述信息",
          ),
        ],
      ),
    ];
  }
}
