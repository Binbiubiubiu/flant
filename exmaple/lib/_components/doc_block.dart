import 'package:flutter/material.dart';

const defaultDocBlockPadding = EdgeInsets.only(left: 16.0, right: 16.0);
const defaultSubTitlePadding = EdgeInsets.only(top: 24.0, bottom: 16.0);

class DocBlock extends StatelessWidget {
  const DocBlock({
    Key key,
    this.title,
    this.size = 14.0,
    this.padding = defaultDocBlockPadding,
    this.children = const [],
  }) : super(key: key);

  final String title;
  final double size;
  final EdgeInsets padding;
  final List<Widget> children;

  factory DocBlock.noPadding({
    Key key,
    String title,
    double size,
    List<Widget> children,
  }) {
    return DocBlock(
      key: key,
      title: title,
      size: size,
      children: children,
      padding: EdgeInsets.zero,
    );
  }

  EdgeInsets get subTitlePadding {
    if (this.padding == EdgeInsets.zero) {
      return defaultSubTitlePadding.add(defaultDocBlockPadding);
    }
    return defaultSubTitlePadding;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubTitle(
            size: this.size,
            text: this.title,
            padding: this.subTitlePadding,
          )
        ]..addAll(this.children),
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle({
    Key key,
    this.text,
    this.size = 14.0,
    this.padding = defaultSubTitlePadding,
  }) : super(key: key);

  final String text;
  final double size;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: Text(
        this.text,
        style: TextStyle(
          color: const Color.fromRGBO(69, 90, 100, 0.6),
          fontSize: this.size,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
