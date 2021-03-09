import 'package:flant/flant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import '../styles/var.dart';

/// Overlay 遮罩层
class FlanOverlay extends StatefulWidget {
  FlanOverlay({
    Key? key,
    this.show = false,
    this.duration = const Duration(milliseconds: 200),
    this.color,
    this.onClick,
    this.child,
  }) : super(key: key);

  // ****************** Props ******************
  /// 是否展示遮罩层
  final bool show;

  /// 动画时长，单位秒
  final Duration duration;

  /// 自定义样式
  final Color? color;

  // ****************** Events ******************

  /// 点击时触发
  final VoidCallback? onClick;

  // ****************** Slots ******************

  /// 默认插槽
  final Widget? child;

  @override
  _FlanOverlayState createState() => _FlanOverlayState();
}

class _FlanOverlayState extends State<FlanOverlay> {
  OverlayEntry? overlayEntry;
  bool animating = false;

  @override
  void initState() {
    if (widget.show) {
      _nextTick(open);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FlanOverlay oldWidget) {
    if (widget.show != oldWidget.show) {
      _nextTick(() {
        widget.show ? open() : overlayEntry?.markNeedsBuild();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  _onOverlayClick() {
    if (widget.onClick != null) {
      this.widget.onClick!();
    }
  }

  open() {
    overlayEntry = OverlayEntry(builder: (context) {
      return MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: FlanTransition.fade(
          duration: widget.duration,
          onDismissed: () {
            close();
          },
          child: Visibility(
            visible: widget.show,
            child: GestureDetector(
              onTap: _onOverlayClick,
              child: Container(
                color: widget.color ?? ThemeVars.overlayBackgroundColor,
                child: widget.child ?? SizedBox.shrink(),
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(context)?.insert(overlayEntry!);
  }

  close() {
    overlayEntry?.remove();
  }

  _nextTick(cb) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      cb();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<bool>("show", widget.show, defaultValue: false));
    properties.add(DiagnosticsProperty<Duration>("duration", widget.duration,
        defaultValue: const Duration(milliseconds: 200)));
    properties.add(DiagnosticsProperty<Color>("color", widget.color));
    super.debugFillProperties(properties);
  }
}
