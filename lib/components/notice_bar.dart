// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flant/styles/components/notice_bar_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// 🌎 Project imports:
import '../styles/theme.dart';
import '../utils/widget.dart';
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
    this.scrollable,
    this.delay = 1.0,
    this.speed = 50.0,
    this.onClick,
    this.onClose,
    this.onReplay,
    this.child,
    this.leftIconSlot,
    this.rightIconSlot,
  })  : assert(delay >= 0.0),
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
  final IconData? leftIconName;

  /// 左侧图片链接
  final String? leftIconUrl;

  /// 是否开启文本换行，只在禁用滚动时生效
  final bool wrapable;

  /// 滚动条背景
  final Color? background;

  /// 是否开启滚动播放，内容长度溢出时默认开启
  final bool? scrollable;

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

  Timer? startTimer;

  GlobalKey textRef = GlobalKey();
  GlobalKey contentRef = GlobalKey();

  void _handleAnimationStatusChange() {
    if (1.0 - controller.value < 0.001) {
      if (widget.onReplay != null) {
        widget.onReplay!();
      }
    }
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this)
      ..addListener(_handleAnimationStatusChange);
    animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(controller);

    nextTick(start);
    super.initState();
  }

  @override
  void dispose() {
    controller
      ..removeListener(_handleAnimationStatusChange)
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

    startTimer?.cancel();

    startTimer = Timer(ms, () {
      if (textRef.currentContext == null ||
          contentRef.currentContext == null ||
          widget.scrollable == false) {
        return;
      }

      final double textRefWidth = textRef.currentContext?.size?.width ?? 0.0;
      final double contentRefWidth =
          contentRef.currentContext?.size?.width ?? 0.0;

      if (widget.scrollable == true || contentRefWidth < textRefWidth) {
        final double fullWidth = contentRefWidth + textRefWidth;
        // print('contentRefWidth:$contentRefWidth');
        // print('textRefWidth$textRefWidth');
        controller
          ..value = contentRefWidth / fullWidth
          ..duration = Duration(seconds: fullWidth ~/ widget.speed);
        animation = controller.drive(
          Tween<Offset>(
            begin: Offset(contentRefWidth, 0.0),
            end: Offset(-textRefWidth, 0.0),
          ),
        );
        controller.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final FlanNoticeBarThemeData themeData =
        FlanTheme.of(context).noticeBarTheme;

    final Widget noticeBar = DefaultTextStyle(
      style: TextStyle(
        color: widget.color ?? themeData.textColor,
        // height: themeData.lineHeight / themeData.fontSize,
      ),
      child: Container(
        color: widget.background ?? themeData.backgroundColor,
        // height: this.widget.wrapable ? null : ThemeVars.noticeBarHeight,
        padding:
            widget.wrapable ? themeData.wrapablePadding : themeData.padding,

        constraints: BoxConstraints(
          maxHeight: widget.wrapable ? double.infinity : themeData.height,
          minHeight: widget.wrapable ? 0.0 : themeData.height,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget?>[
            _buildLeftIcon(themeData),
            Expanded(child: _buildMarquee(context)),
            _buildRightIcon(themeData)
          ].noNull,
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
    final bool ellipsis = widget.scrollable == false && !widget.wrapable;
    Widget marquee = Builder(
      key: textRef,
      builder: (BuildContext context) {
        return widget.child ??
            Text(
              widget.text,
              softWrap: widget.wrapable,
              maxLines: widget.wrapable ? null : 1,
              overflow: ellipsis ? TextOverflow.ellipsis : TextOverflow.visible,
            );
      },
    );

    if (widget.scrollable != false) {
      marquee = ClipRect(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          child: AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return Transform.translate(
                offset: animation.value,
                child: child,
              );
            },
            child: marquee,
          ),
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

  Widget _buildIcon(
    FlanNoticeBarThemeData themeData, {
    Alignment align = Alignment.centerLeft,
    Widget? child,
  }) {
    return Container(
      constraints: BoxConstraints(
        minWidth: themeData.iconMinWidth,
      ),
      alignment: align,
      child: child,
    );
  }

  Widget? _buildLeftIcon(FlanNoticeBarThemeData themeData) {
    if (widget.leftIconSlot != null) {
      return widget.leftIconSlot!;
    }

    if (widget.leftIconName != null || widget.leftIconUrl != null) {
      return _buildIcon(
        themeData,
        align: Alignment.centerLeft,
        child: FlanIcon(
          size: themeData.iconSize,
          iconName: widget.leftIconName,
          iconUrl: widget.leftIconUrl,
          color: widget.color ?? themeData.textColor,
        ),
      );
    }
  }

  Widget? _buildRightIcon(FlanNoticeBarThemeData themeData) {
    if (widget.rightIconSlot != null) {
      return widget.rightIconSlot!;
    }

    if (rightIconName != null) {
      return _buildIcon(
        themeData,
        align: Alignment.centerRight,
        child: FlanIcon(
          size: themeData.iconSize,
          iconName: rightIconName,
          onClick: onClickRightIcon,
          color: widget.color ?? themeData.textColor,
        ),
      );
    }
  }

  void onClickRightIcon() {
    if (widget.mode == FlanNoticeBarMode.closeable) {
      setState(() => show = false);
      if (widget.onClose != null) {
        widget.onClose!();
      }
    }
  }

  IconData? get rightIconName {
    if (widget.mode == FlanNoticeBarMode.closeable) {
      return FlanIcons.cross;
    }

    if (widget.mode == FlanNoticeBarMode.link) {
      return FlanIcons.arrow;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('text', widget.text));
    properties.add(DiagnosticsProperty<FlanNoticeBarMode>('mode', widget.mode));
    properties.add(DiagnosticsProperty<Color>('color', widget.color));
    properties.add(
        DiagnosticsProperty<IconData>('leftIconName', widget.leftIconName));
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
