import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import '../styles/var.dart';

/// ### FlanCountDown 倒计时
/// 用于实时展示倒计时数值，支持毫秒精度。
class FlanCountDown extends StatefulWidget {
  FlanCountDown({
    Key? key,
    this.time = 0,
    this.format = "HH:mm:ss",
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
      this.resetTime();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    pause();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (deactivated) {
          counting = true;
          deactivated = false;
          this.setState(() {});
          tick();
        }
        break;
      case AppLifecycleState.inactive:
        if (counting) {
          pause();
          deactivated = true;
          this.setState(() {});
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
    final textStyle = TextStyle(
      fontSize: ThemeVars.countDownFontSize,
      color: ThemeVars.countDownTextColor,
      height: ThemeVars.countDownLineHeight / ThemeVars.countDownFontSize,
    );

    return DefaultTextStyle(
      style: textStyle,
      child:
          widget.builder != null ? widget.builder!(current) : Text("$timeText"),
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
    if (widget.onChange != null) {
      widget.onChange!(current);
    }

    if (value == 0) {
      pause();
      if (widget.onFinish != null) {
        widget.onFinish!();
      }
    }
    this.setState(() {});
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
          var remainRemain = getCurrentRemain();

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
      this.setState(() {});
      tick();
    }
  }

  void reset({int totalTime = 0}) {
    if (totalTime == 0) {
      totalTime = widget.time;
    }

    pause();
    remain = totalTime;
    this.setState(() {});
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<int>("time", widget.time, defaultValue: 0));
    properties.add(DiagnosticsProperty<String>("format", widget.format,
        defaultValue: "HH:mm:ss"));
    properties.add(DiagnosticsProperty<bool>("autoStart", widget.autoStart,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>("millisecond", widget.millisecond,
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
}

String padZero(int num, {int targetLength = 2}) {
  var str = "$num";

  while (str.length < targetLength) {
    str = '0' + str;
  }

  return str;
}

String parseFormat(String format, CurrentTime currentTime) {
  final days = currentTime.days;

  var hours = currentTime.hours;
  var minutes = currentTime.minutes;
  var seconds = currentTime.seconds;
  var milliseconds = currentTime.milliseconds;

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
    final ms = padZero(milliseconds, targetLength: 3);

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

const SECOND = 1000;
const MINUTE = 60 * SECOND;
const HOUR = 60 * MINUTE;
const DAY = 24 * HOUR;

CurrentTime parseTime(int time) {
  var days = (time / DAY).floor();
  var hours = (time % DAY / HOUR).floor();
  var minutes = (time % HOUR / MINUTE).floor();
  var seconds = (time % MINUTE / SECOND).floor();
  var milliseconds = (time % SECOND).floor();
  return CurrentTime(
    total: time,
    days: days,
    hours: hours,
    minutes: minutes,
    seconds: seconds,
    milliseconds: milliseconds,
  );
}

bool isSameSecond(time1, time2) =>
    (time1 / 1000).floor() == (time2 / 1000).floor();
