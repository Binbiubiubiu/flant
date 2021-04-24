import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FlanActiveResponse extends StatefulWidget {
  const FlanActiveResponse({
    Key? key,
    this.disabled = false,
    this.onClick,
    this.cursorBuilder,
    required this.builder,
  }) : super(key: key);

  final bool disabled;
  final VoidCallback? onClick;
  final SystemMouseCursor Function(SystemMouseCursor cursor)? cursorBuilder;
  final Widget Function(BuildContext contenxt, bool active) builder;

  @override
  _FlanActiveResponseState createState() => _FlanActiveResponseState();
}

class _FlanActiveResponseState extends State<FlanActiveResponse> {
  bool _active = false;

  void setActive(bool active) {
    setState(() => _active = active);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.cursorBuilder != null
          ? widget.cursorBuilder!(_cursor)
          : _cursor,
      child: IgnorePointer(
        ignoring: widget.disabled,
        child: GestureDetector(
          onTap: widget.onClick,
          onTapDown: (TapDownDetails e) => setActive(true),
          onTapCancel: () => setActive(false),
          onTapUp: (TapUpDetails e) => setActive(false),
          child: widget.builder(context, _active),
        ),
      ),
    );
  }

  SystemMouseCursor get _cursor =>
      widget.disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click;
}
