import 'package:flutter/material.dart';

import './style.dart';

class SubTitle extends StatelessWidget {
  const SubTitle({
    Key key,
    this.text,
    this.size = 14.0,
    this.padding = const EdgeInsets.only(top: 24.0, bottom: 16.0),
  }) : super(key: key);

  final String text;
  final double size;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding,
      child: Text(
        this.text,
        style: TextStyle(
          color: PageTheme.subTextColor,
          fontSize: this.size,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
