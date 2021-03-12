import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import '../styles/var.dart';
import 'icon.dart';

/// ### NoticeBar 通知栏
/// 用于循环播放展示一组消息通知。
class FlanNoticeBar extends StatefulWidget {
  const FlanNoticeBar({
    Key? key,
    this.text = '',
    this.mode,
    this.color,
    this.leftIconName,
    this.leftIconUrl,
    this.wrapable = false,
    this.background,
    this.scrollable = false,
    this.delay = 1.0,
    this.speed = 50.0,
    this.onClick,
    this.onClose,
    this.onReplay,
    this.child,
    this.leftIconSlot,
    this.rightIconSlot,
  })  : assert(delay > 0.0),
        assert(speed > 0.0),
        super(key: key);

  // ****************** Props ******************

  /// 通知文本内容
  final String text;

  /// 通知栏模式，可选值为 `closeable` `link`
  final FlanNoticeBarMode? mode;

  /// 通知文本颜色
  final Color? color;

  /// 左侧图标名称
  final int? leftIconName;

  /// 左侧图片链接
  final String? leftIconUrl;

  /// 是否开启文本换行，只在禁用滚动时生效
  final bool wrapable;

  /// 滚动条背景
  final Color? background;

  /// 是否开启滚动播放，内容长度溢出时默认开启
  final bool scrollable;

  /// 动画延迟时间 (s)
  final double delay;

  /// 滚动速率 (px/s)
  final double speed;

  // ****************** Events ******************

  /// 点击通知栏时触发
  final VoidCallback? onClick;

  /// 关闭通知栏时触发
  final VoidCallback? onClose;

  /// 每当滚动栏重新开始滚动时触发
  final VoidCallback? onReplay;

  // ****************** Slots ******************

  /// 通知文本内容
  final Widget? child;

  /// 自定义左侧图标
  final Widget? leftIconSlot;

  /// 自定义右侧图标
  final Widget? rightIconSlot;

  @override
  _FlanNoticeBarState createState() => _FlanNoticeBarState();
}

class _FlanNoticeBarState extends State<FlanNoticeBar>
    with TickerProviderStateMixin {
  bool show = true;

  late AnimationController controller;
  late Animation<Offset> animation;

  late Timer startTimer;

  GlobalKey wrapRef = GlobalKey();
  GlobalKey contentRef = GlobalKey();

  void _handelChange() => setState(() {});
  void _handleAnimationStatusChange(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (widget.onReplay != null) {
        widget.onReplay!();
      }
    }
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this)
      ..addStatusListener(_handleAnimationStatusChange)
      ..addListener(_handelChange);
    animation =
        Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(controller);
    startTimer = Timer(const Duration(seconds: 1), () {});
    WidgetsBinding.instance
        ?.addPostFrameCallback((Duration duration) => start());
    super.initState();
  }

  @override
  void dispose() {
    controller
      ..removeStatusListener(_handleAnimationStatusChange)
      ..removeListener(_handelChange)
      ..dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanNoticeBar oldWidget) {
    if (oldWidget.text != widget.text ||
        oldWidget.scrollable != widget.scrollable) {
      start();
    }
    super.didUpdateWidget(oldWidget);
  }

  void start() {
    final Duration ms = Duration(milliseconds: (widget.delay * 1000).toInt());

    startTimer.cancel();

    startTimer = Timer(ms, () {
      if (!mounted || !widget.scrollable) {
        return;
      }

      final double wrapRefWidth =
          wrapRef.currentContext!.findRenderObject()!.paintBounds.size.width;
      final double contentRefWidth =
          contentRef.currentContext!.findRenderObject()!.paintBounds.size.width;
      // debugPrint(
      //     "wrapRefWidth:$wrapRefWidth --- contentRefWidth:$contentRefWidth");
      if (widget.scrollable || contentRefWidth > wrapRefWidth) {
        controller
          ..value = wrapRefWidth / (wrapRefWidth + contentRefWidth)
          ..duration = Duration(seconds: wrapRefWidth ~/ widget.speed);
        animation = Tween<Offset>(
          begin: Offset(wrapRefWidth, 0.0),
          end: Offset(-contentRefWidth, 0.0),
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.linear),
        );
        controller.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Material noticeBar = Material(
      color: widget.background ?? ThemeVars.noticeBarBackgroundColor,
      textStyle: TextStyle(
        color: widget.color ?? ThemeVars.noticeBarTextColor,
        height: ThemeVars.noticeBarLineHeight / ThemeVars.noticeBarFontSize,
      ),
      child: Ink(
        // height: this.widget.wrapable ? null : ThemeVars.noticeBarHeight,
        padding: widget.wrapable
            ? ThemeVars.noticeBarWrapablePadding
            : ThemeVars.noticeBarPadding,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight:
                widget.wrapable ? double.infinity : ThemeVars.noticeBarHeight,
            minHeight: widget.wrapable ? 0.0 : ThemeVars.noticeBarHeight,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildLeftIcon(context),
              Expanded(child: _buildMarquee(context)),
              _buildRightIcon(context)
            ],
          ),
        ),
      ),
    );

    return Semantics(
      container: true,
      link: widget.mode == FlanNoticeBarMode.link,
      label: 'alert',
      hidden: !show,
      child: Visibility(
        visible: show,
        child: noticeBar,
      ),
    );
  }

  Widget _buildMarquee(BuildContext context) {
    final bool ellipsis = !widget.scrollable && !widget.wrapable;
    Widget marquee = widget.child ??
        Text(
          widget.text,
          softWrap: widget.wrapable,
          overflow: ellipsis ? TextOverflow.ellipsis : TextOverflow.clip,
        );
    if (widget.scrollable) {
      marquee = ClipRect(
        key: wrapRef,
        child: Transform.translate(
          offset: animation.value,
          child: marquee,
        ),
      );
    }

    return Semantics(
      key: contentRef,
      container: true,
      label: 'marquee',
      child: marquee,
    );
  }

  Widget _buildLeftIcon(BuildContext context) {
    if (widget.leftIconSlot != null) {
      return widget.leftIconSlot!;
    }

    if (widget.leftIconName != null || widget.leftIconUrl != null) {
      return Container(
        constraints: const BoxConstraints(
          minWidth: ThemeVars.noticeBarIconMinWidth,
        ),
        alignment: Alignment.centerLeft,
        child: FlanIcon(
          size: ThemeVars.noticeBarIconSize,
          iconName: widget.leftIconName,
          iconUrl: widget.leftIconUrl,
          color: widget.color ?? ThemeVars.noticeBarTextColor,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildRightIcon(BuildContext context) {
    if (widget.rightIconSlot != null) {
      return widget.rightIconSlot!;
    }

    if (rightIconName > 0) {
      return Container(
        constraints: const BoxConstraints(
          minWidth: ThemeVars.noticeBarIconMinWidth,
        ),
        alignment: Alignment.centerRight,
        child: FlanIcon(
          size: ThemeVars.noticeBarIconSize,
          iconName: rightIconName,
          onClick: onClickRightIcon,
          color: widget.color ?? ThemeVars.noticeBarTextColor,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  void onClickRightIcon() {
    if (widget.mode == FlanNoticeBarMode.closeable) {
      setState(() => show = false);
      if (widget.onClose != null) {
        widget.onClose!();
      }
    }
  }

  int get rightIconName {
    if (widget.mode == FlanNoticeBarMode.closeable) {
      return FlanIcons.cross;
    }

    if (widget.mode == FlanNoticeBarMode.link) {
      return FlanIcons.arrow;
    }

    return 0;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('text', widget.text));
    properties.add(DiagnosticsProperty<FlanNoticeBarMode>('mode', widget.mode));
    properties.add(DiagnosticsProperty<Color>('color', widget.color));
    properties
        .add(DiagnosticsProperty<int>('leftIconName', widget.leftIconName));
    properties
        .add(DiagnosticsProperty<String>('leftIconUrl', widget.leftIconUrl));
    properties.add(DiagnosticsProperty<bool>('wrapable', widget.wrapable,
        defaultValue: false));
    properties.add(DiagnosticsProperty<Color>('background', widget.background));
    properties.add(DiagnosticsProperty<bool>('scrollable', widget.scrollable,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<double>('delay', widget.delay, defaultValue: 1.0));
    properties.add(
        DiagnosticsProperty<double>('speed', widget.speed, defaultValue: 50.0));
    super.debugFillProperties(properties);
  }
}

/// 通知栏模式
enum FlanNoticeBarMode {
  closeable,
  link,
}
