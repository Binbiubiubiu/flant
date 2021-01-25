import 'package:exmaple/style.dart';
import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  SubTitle({
    Key key,
    this.text,
    this.size = 14.0,
  }) : super(key: key);

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24.0, bottom: 8.0, left: 16.0),
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
