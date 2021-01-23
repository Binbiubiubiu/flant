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
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        this.text,
        style: TextStyle(
          color: Color(0x455A6499),
          fontSize: this.size,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
