// 🎯 Dart imports:
import 'dart:math' as math;

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// 🌎 Project imports:
import '../styles/components/count_down_theme.dart';
import '../styles/var.dart';
import '../utils/format/string.dart';

/// ### FlanCountDown 倒计时
/// 用于实时展示倒计时数值，支持毫秒精度。
class FlanCountDown extends StatefulWidget {
  const FlanCountDown({
    Key? key,
    this.time = 0,
    this.format = 'HH:mm:ss',
    this.autoStart = true,
    this.millisecond = false,
    this.onFinish,
    this.onChange,
    this.builder,
  }) : super(key: key);

  // ****************** Props ******************
  /// 倒计时时长，单位毫秒
  final int time;

  /// 时间格式
  final String format;

  /// 是否自动开始倒计时
  final bool autoStart;

  /// 是否开启毫秒级渲染
  final bool millisecond;

  // ****************** Events ******************
  final VoidCallback? onFinish;

  final ValueChanged<CurrentTime>? onChange;

  // ****************** Slots ******************
  // 自定义内容
  final Widget Function(CurrentTime)? builder;

  @override
  FlanCountDownState createState() => FlanCountDownState();
}

class FlanCountDownState extends State<FlanCountDown>
    with WidgetsBindingObserver {
  Ticker? rafId;
  int endTime = 0;
  bool counting = false;
  bool deactivated = false;
  int remain = 0;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    resetTime();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FlanCountDown oldWidget) {
    if (widget.time != oldWidget.time) {
      resetTime();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    pause();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (deactivated) {
          counting = true;
          deactivated = false;
          // setState(() {});
          tick();
        }
        break;
      case AppLifecycleState.inactive:
        if (counting) {
          pause();
          deactivated = true;
          // setState(() {});
        }
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final FlanCountDownThemeData themeData = FlanCountDownTheme.of(context);
    final TextStyle textStyle = TextStyle(
      fontSize: themeData.fontSize,
      color: themeData.textColor,
      height: themeData.lineHeight,
    );

    return DefaultTextStyle(
      style: textStyle,
      child: widget.builder?.call(current) ??
          Text(
            timeText,
            textHeightBehavior: FlanThemeVars.textHeightBehavior,
          ),
    );
  }

  CurrentTime get current => parseTime(remain);

  String get timeText => parseFormat(widget.format, current);

  void resetTime() {
    reset(totalTime: widget.time);
    if (widget.autoStart) {
      start();
    }
  }

  void pause() {
    counting = false;
    rafId?.dispose();
  }

  int getCurrentRemain() =>
      math.max(endTime - DateTime.now().millisecondsSinceEpoch, 0);

  void setRemain(int value) {
    remain = value;
    widget.onChange?.call(current);

    if (value == 0) {
      pause();
      widget.onFinish?.call();
    }
    setState(() {});
  }

  void microTick() {
    rafId = Ticker(
      (Duration duration) {
        if (counting) {
          setRemain(getCurrentRemain());

          if (remain <= 0) {
            rafId?.dispose();
          }
        }
      },
    )..start();
  }

  void macroTick() {
    rafId = Ticker(
      (Duration duration) {
        if (counting) {
          final int remainRemain = getCurrentRemain();

          if (!isSameSecond(remainRemain, remain) || remainRemain == 0) {
            setRemain(remainRemain);
          }

          if (remain <= 0) {
            rafId?.dispose();
          }
        }
      },
    )..start();
  }

  void tick() {
    if (widget.millisecond) {
      microTick();
    } else {
      macroTick();
    }
  }

  void start() {
    if (!counting) {
      endTime = DateTime.now().millisecondsSinceEpoch + remain;
      counting = true;
      setState(() {});
      tick();
    }
  }

  void reset({int totalTime = 0}) {
    if (totalTime == 0) {
      totalTime = widget.time;
    }

    pause();
    remain = totalTime;
    setState(() {});
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<int>('time', widget.time, defaultValue: 0));
    properties.add(DiagnosticsProperty<String>('format', widget.format,
        defaultValue: 'HH:mm:ss'));
    properties.add(DiagnosticsProperty<bool>('autoStart', widget.autoStart,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('millisecond', widget.millisecond,
        defaultValue: true));
    super.debugFillProperties(properties);
  }
}

class CurrentTime {
  const CurrentTime({
    this.days = 0,
    this.hours = 0,
    this.total = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.milliseconds = 0,
  });

  final int days;
  final int hours;
  final int total;
  final int minutes;
  final int seconds;
  final int milliseconds;

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      days,
      hours,
      total,
      minutes,
      seconds,
      milliseconds,
    ];

    return hashList(values);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CurrentTime &&
        other.days == days &&
        other.hours == hours &&
        other.total == total &&
        other.minutes == minutes &&
        other.seconds == seconds &&
        other.milliseconds == milliseconds;
  }
}

String parseFormat(String format, CurrentTime currentTime) {
  final int days = currentTime.days;

  int hours = currentTime.hours;
  int minutes = currentTime.minutes;
  int seconds = currentTime.seconds;
  int milliseconds = currentTime.milliseconds;

  if (format.contains('DD')) {
    format = format.replaceAll('DD', padZero(days));
  } else {
    hours += days * 24;
  }

  if (format.contains('HH')) {
    format = format.replaceAll('HH', padZero(hours));
  } else {
    minutes += hours * 60;
  }

  if (format.contains('mm')) {
    format = format.replaceAll('mm', padZero(minutes));
  } else {
    seconds += minutes * 60;
  }

  if (format.contains('ss')) {
    format = format.replaceAll('ss', padZero(seconds));
  } else {
    milliseconds += seconds * 1000;
  }

  if (format.contains('S')) {
    final String ms = padZero(milliseconds, targetLength: 3);

    if (format.contains('SSS')) {
      format = format.replaceAll('SSS', ms);
    } else if (format.contains('SS')) {
      format = format.replaceAll('SS', ms.substring(0, 2));
    } else {
      format = format.replaceAll('S', ms[0]);
    }
  }

  return format;
}

const int SECOND = 1000;
const int MINUTE = 60 * SECOND;
const int HOUR = 60 * MINUTE;
const int DAY = 24 * HOUR;

CurrentTime parseTime(int time) {
  final int days = (time / DAY).floor();
  final int hours = (time % DAY / HOUR).floor();
  final int minutes = (time % HOUR / MINUTE).floor();
  final int seconds = (time % MINUTE / SECOND).floor();
  final int milliseconds = (time % SECOND).floor();
  return CurrentTime(
    total: time,
    days: days,
    hours: hours,
    minutes: minutes,
    seconds: seconds,
    milliseconds: milliseconds,
  );
}

bool isSameSecond(int time1, int time2) =>
    (time1 / 1000).floor() == (time2 / 1000).floor();
