import 'dart:async';

import 'package:flutter/material.dart';

Widget _defaultLayoutBuilder(BuildContext context, Widget child) => child;

class CustomOverlayEntry extends OverlayEntry {
  factory CustomOverlayEntry({
    bool initVisiable = true,
    bool lockScroll = true,
    Widget Function(BuildContext context, Widget child) layoutBuilder =
        _defaultLayoutBuilder,
    required Widget child,
    required ValueWidgetBuilder<bool> transitionBuilder,
  }) {
    final ValueNotifier<bool> visiable = ValueNotifier<bool>(initVisiable);
    late CustomOverlayEntry entry;
    entry = CustomOverlayEntry.raw(
      visiable: visiable,
      child: child,
      builder: (BuildContext context) {
        Widget content = ValueListenableBuilder<bool>(
          valueListenable: entry.visiable,
          builder: transitionBuilder,
          child: entry.child,
        );
        content = layoutBuilder(context, content);
        if (lockScroll) {
          content = Material(
            color: Colors.transparent,
            child: content,
          );
        }
        return content;
      },
    );
    return entry;
  }

  CustomOverlayEntry.raw({
    required this.visiable,
    required this.child,
    required WidgetBuilder builder,
  }) : super(builder: builder);

  ValueNotifier<bool> visiable;

  Widget child;

  Timer? timer;

  void update(Widget child, Duration duration) {
    clearTimer();

    this.child = child;
    markNeedsBuild();
    if (duration != Duration.zero) {
      timer = Timer(duration, close);
    }
  }

  void clearTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  void close() {
    visiable.value = false;
    clearTimer();
  }

  // @override
  // void remove() {
  //   visiable.dispose();
  //   super.remove();
  // }
}
