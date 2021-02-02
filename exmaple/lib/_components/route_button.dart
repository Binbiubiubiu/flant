import 'package:flutter/material.dart';

class RouteButton extends StatelessWidget {
  const RouteButton({
    Key key,
    this.text,
    @required this.onPressed,
  }) : super(key: key);

  final String text;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final Widget result = Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: 40.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(this.text),
          Spacer(),
          RotatedBox(
            quarterTurns: 2,
            child: Icon(
              Icons.arrow_back_ios_sharp,
              size: 16.0,
            ),
          )
        ],
      ),
    );

    return Semantics(
      container: true,
      button: true,
      enabled: true,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        child: Material(
          textStyle: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF323233),
          ),
          type: MaterialType.button,
          color: Color(0xFFF7F8FA),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Color(0xFFEEF0F4),
            onTap: this.onPressed,
            child: result,
          ),
        ),
      ),
    );
  }
}
