import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import '../../styles/var.dart';
import '../base/icon.dart';

/// ### NoticeBar 通知栏
/// 用于循环播放展示一组消息通知。
class FlanNoticeBar extends StatefulWidget {
  const FlanNoticeBar({
    Key? key,
    this.text = "",
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

  _handelChange() => this.setState(() {});
  _handleAnimationStatusChange(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (this.widget.onReplay != null) {
        this.widget.onReplay!();
      }
    }
  }

  @override
  void initState() {
    this.controller = AnimationController(vsync: this)
      ..addStatusListener(this._handleAnimationStatusChange)
      ..addListener(_handelChange);
    this.animation =
        Tween(begin: Offset.zero, end: Offset.zero).animate(this.controller);
    this.startTimer = Timer(const Duration(seconds: 1), () {});
    WidgetsBinding.instance?.addPostFrameCallback((duration) => this.start());
    super.initState();
  }

  @override
  void dispose() {
    this.controller
      ..removeStatusListener(this._handleAnimationStatusChange)
      ..removeListener(this._handelChange)
      ..dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanNoticeBar oldWidget) {
    if (oldWidget.text != this.widget.text ||
        oldWidget.scrollable != this.widget.scrollable) {
      this.start();
    }
    super.didUpdateWidget(oldWidget);
  }

  void start() {
    final ms = Duration(milliseconds: (this.widget.delay * 1000).toInt());

    this.startTimer.cancel();

    this.startTimer = Timer(ms, () {
      if (!this.mounted || !this.widget.scrollable) {
        return;
      }

      final wrapRefWidth =
          wrapRef.currentContext!.findRenderObject()!.paintBounds.size.width;
      final contentRefWidth =
          contentRef.currentContext!.findRenderObject()!.paintBounds.size.width;
      // debugPrint(
      //     "wrapRefWidth:$wrapRefWidth --- contentRefWidth:$contentRefWidth");
      if (this.widget.scrollable || contentRefWidth > wrapRefWidth) {
        this.controller
          ..value = wrapRefWidth / (wrapRefWidth + contentRefWidth)
          ..duration = Duration(seconds: wrapRefWidth ~/ this.widget.speed);
        this.animation = Tween(
          begin: Offset(wrapRefWidth, 0.0),
          end: Offset(-contentRefWidth, 0.0),
        ).animate(
          CurvedAnimation(parent: this.controller, curve: Curves.linear),
        );
        this.controller.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final noticeBar = Material(
      color: this.widget.background ?? ThemeVars.noticeBarBackgroundColor,
      textStyle: TextStyle(
        color: this.widget.color ?? ThemeVars.noticeBarTextColor,
        height: ThemeVars.noticeBarLineHeight / ThemeVars.noticeBarFontSize,
      ),
      child: Ink(
        // height: this.widget.wrapable ? null : ThemeVars.noticeBarHeight,
        padding: this.widget.wrapable
            ? ThemeVars.noticeBarWrapablePadding
            : ThemeVars.noticeBarPadding,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: this.widget.wrapable
                ? double.infinity
                : ThemeVars.noticeBarHeight,
            minHeight: this.widget.wrapable ? 0.0 : ThemeVars.noticeBarHeight,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              this._buildLeftIcon(context),
              Expanded(child: this._buildMarquee(context)),
              this._buildRightIcon(context)
            ],
          ),
        ),
      ),
    );

    return Semantics(
      container: true,
      link: this.widget.mode == FlanNoticeBarMode.link,
      label: "alert",
      hidden: !this.show,
      child: Visibility(
        visible: this.show,
        child: noticeBar,
      ),
    );
  }

  Widget _buildMarquee(BuildContext context) {
    final ellipsis = !this.widget.scrollable && !this.widget.wrapable;
    Widget marquee = this.widget.child ??
        Text(
          this.widget.text,
          softWrap: this.widget.wrapable,
          overflow: ellipsis ? TextOverflow.ellipsis : TextOverflow.clip,
        );
    if (this.widget.scrollable) {
      marquee = ClipRect(
        key: wrapRef,
        child: Transform.translate(
          offset: this.animation.value,
          child: marquee,
        ),
      );
    }

    return Semantics(
      key: contentRef,
      container: true,
      label: "marquee",
      child: marquee,
    );
  }

  Widget _buildLeftIcon(BuildContext context) {
    if (this.widget.leftIconSlot != null) {
      return this.widget.leftIconSlot!;
    }

    if (this.widget.leftIconName != null || this.widget.leftIconUrl != null) {
      return Container(
        constraints: BoxConstraints(minWidth: ThemeVars.noticeBarIconMinWidth),
        alignment: Alignment.centerLeft,
        child: FlanIcon(
          size: ThemeVars.noticeBarIconSize,
          iconName: this.widget.leftIconName,
          iconUrl: this.widget.leftIconUrl,
          color: this.widget.color ?? ThemeVars.noticeBarTextColor,
        ),
      );
    }

    return SizedBox.shrink();
  }

  Widget _buildRightIcon(BuildContext context) {
    if (this.widget.rightIconSlot != null) {
      return this.widget.rightIconSlot!;
    }

    if (this.rightIconName > 0) {
      return Container(
        constraints: BoxConstraints(minWidth: ThemeVars.noticeBarIconMinWidth),
        alignment: Alignment.centerRight,
        child: FlanIcon(
          size: ThemeVars.noticeBarIconSize,
          iconName: this.rightIconName,
          onClick: this.onClickRightIcon,
        ),
      );
    }

    return SizedBox.shrink();
  }

  void onClickRightIcon() {
    if (this.widget.mode == FlanNoticeBarMode.closeable) {
      this.setState(() => this.show = false);
      if (this.widget.onClose != null) {
        this.widget.onClose!();
      }
    }
  }

  int get rightIconName {
    if (this.widget.mode == FlanNoticeBarMode.closeable) {
      return FlanIcons.cross;
    }

    if (this.widget.mode == FlanNoticeBarMode.link) {
      return FlanIcons.arrow;
    }

    return 0;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>("text", widget.text));
    properties.add(DiagnosticsProperty<FlanNoticeBarMode>("mode", widget.mode));
    properties.add(DiagnosticsProperty<Color>("color", widget.color));
    properties
        .add(DiagnosticsProperty<int>("leftIconName", widget.leftIconName));
    properties
        .add(DiagnosticsProperty<String>("leftIconUrl", widget.leftIconUrl));
    properties.add(DiagnosticsProperty<bool>("wrapable", widget.wrapable,
        defaultValue: false));
    properties.add(DiagnosticsProperty<Color>("background", widget.background));
    properties.add(DiagnosticsProperty<bool>("scrollable", widget.scrollable,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<double>("delay", widget.delay, defaultValue: 1.0));
    properties.add(
        DiagnosticsProperty<double>("speed", widget.speed, defaultValue: 50.0));
    super.debugFillProperties(properties);
  }
}

/// 通知栏模式
enum FlanNoticeBarMode {
  closeable,
  link,
}
