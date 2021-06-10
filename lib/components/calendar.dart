// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
// import '../styles/components/card_theme.dart';
import '../locale/l10n.dart';
import '../styles/var.dart';
import '../utils/widget.dart';
import 'button.dart';
import 'date_picker.dart' show getMonthEndDay;
import 'toast.dart';

typedef FlanCalendarDayBuilder = Widget Function(FlanCalendarDayItem item);
typedef FlanCalendarDayItemFormatter = FlanCalendarDayItem Function(
    FlanCalendarDayItem item);

typedef FlanCalendarDayVoidCallback = void Function(FlanCalendarDayItem item);

DateTime _getDefaultMaxDate() {
  final DateTime now = getToday();
  return DateTime(now.year, now.month + 6, now.day);
}

/// ### FlanCalendar 日历
/// 日历组件用于选择日期或日期区间。
class FlanCalendar extends StatefulWidget {
  FlanCalendar({
    Key? key,
    this.title = '',
    this.color,
    this.readonly = false,
    this.showMark = true,
    this.showTitle = true,
    this.formatter,
    this.rowHeight,
    this.confirmText = '',
    this.rangePrompt = '',
    this.showConfirm = true,
    this.defaultDate = const <DateTime>[],
    this.showSubtitle = true,
    this.allowSameDay = false,
    this.confirmDisabledText = '',
    this.maxRange = 0,
    DateTime? minDate,
    DateTime? maxDate,
    this.firstDayOfWeek = 0,
    this.showRangePrompt = true,
    this.type = FlanCalendarType.single,
    this.safeAreaInsetBottom = false,
    this.onSelect,
    this.onConfirm,
    this.onUnSelect,
    this.onOverRange,
    this.titleSlot,
    this.footerSlot,
    this.topInfoBuilder,
    this.bottomInfoBuilder,
  })  : minDate = minDate ?? getToday(),
        maxDate = maxDate ?? _getDefaultMaxDate(),
        super(key: key);

  // ****************** Props ******************
  final String title;
  final Color? color;
  final bool readonly;
  final bool showMark;
  final bool showTitle;
  final FlanCalendarDayItemFormatter? formatter;
  final double? rowHeight;
  final String confirmText;
  final String rangePrompt;
  final bool showConfirm;
  final List<DateTime> defaultDate;
  final bool showSubtitle;
  final bool allowSameDay;
  final String confirmDisabledText;
  final int maxRange;
  final DateTime minDate;
  final DateTime maxDate;
  final int firstDayOfWeek;
  final bool showRangePrompt;
  final FlanCalendarType type;
  final bool safeAreaInsetBottom;

  // ****************** Events ******************
  final ValueChanged<List<DateTime>>? onSelect;
  final ValueChanged<List<DateTime>>? onConfirm;
  final ValueChanged<List<DateTime>>? onUnSelect;
  final VoidCallback? onOverRange;

  // ****************** Slots ******************
  final Widget? titleSlot;
  final Widget? footerSlot;
  final FlanCalendarDayBuilder? topInfoBuilder;
  final FlanCalendarDayBuilder? bottomInfoBuilder;

  @override
  _FlanCalendarState createState() => _FlanCalendarState();
}

class _FlanCalendarState extends State<FlanCalendar> {
  String subtitle = '';
  late List<DateTime> currentDate;

  @override
  void initState() {
    currentDate = getInitialDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCalendar();
  }

  DateTime limitDateRange(
    DateTime date, [
    DateTime? minDate,
    DateTime? maxDate,
  ]) {
    minDate ??= widget.minDate;
    maxDate ??= widget.maxDate;
    if (compareDay(date, minDate) == -1) {
      return minDate;
    }
    if (compareDay(date, maxDate) == 1) {
      return maxDate;
    }
    return date;
  }

  List<DateTime> getInitialDate([List<DateTime>? defaultDate]) {
    defaultDate ??= widget.defaultDate;
    if (defaultDate.isEmpty) {
      return defaultDate;
    }

    final DateTime now = getToday();
    if (widget.type == FlanCalendarType.range) {
      final DateTime start = limitDateRange(
        defaultDate.isNotEmpty ? defaultDate[0] : now,
        widget.minDate,
        getPreDay(widget.maxDate),
      );
      final DateTime end = limitDateRange(
        defaultDate.length > 1 ? defaultDate[1] : now,
        getNextDay(widget.minDate),
      );
      return <DateTime>[start, end];
    }

    // if (type == FlanCalendarType.multiple) {
    return defaultDate.map((DateTime date) => limitDateRange(date)).toList();
    // }
  }

  int get dayOffset => widget.firstDayOfWeek % 7;

  List<DateTime> get months {
    final List<DateTime> _months = <DateTime>[];
    DateTime cursor = DateTime(widget.minDate.year, widget.minDate.month, 1);

    do {
      _months.add(cursor);
      cursor = DateTime(cursor.year, cursor.month + 1, 1);
    } while (compareMonth(cursor, widget.maxDate) != 1);

    return _months;
  }

  bool get buttonDisabled {
    if (currentDate.isNotEmpty) {
      if (widget.type == FlanCalendarType.range) {
        return currentDate.length == 2;
      }
      if (widget.type == FlanCalendarType.multiple) {
        return true;
      }
    }

    return currentDate.isEmpty;
  }

  void reset(List<DateTime>? date) {
    date ??= getInitialDate();
    currentDate = date;
  }

  bool checkRange(List<DateTime> date) {
    if (widget.maxRange != 0 && calcDateNum(date) > widget.maxRange) {
      if (widget.showRangePrompt) {
        FlanToast(context,
            message: widget.rangePrompt.isNotEmpty
                ? widget.rangePrompt
                : FlanS.of(context).Calendar_rangePrompt('${widget.maxRange}'));
        widget.onOverRange?.call();
        return false;
      }
    }
    return true;
  }

  void onConfirm() => widget.onConfirm?.call(cloneDates(currentDate));

  void select(List<DateTime> date, [bool complete = false]) {
    void setCurrentDate(List<DateTime> date) {
      currentDate = date;
      widget.onSelect?.call(cloneDates(currentDate));
    }

    if (complete && widget.type == FlanCalendarType.range) {
      final bool valid = checkRange(date);
      if (!valid) {
        if (widget.showConfirm) {
          setCurrentDate(<DateTime>[
            date[0],
            getDayByOffset(date[0], widget.maxRange - 1),
          ]);
        } else {
          setCurrentDate(date);
        }
        return;
      }
    }
    setCurrentDate(date);
    if (complete && !widget.showConfirm) {
      onConfirm();
    }
  }

  void onClickDay(FlanCalendarDayItem item) {
    if (widget.readonly || item.date == null) {
      return;
    }

    final DateTime date = item.date!;
    if (widget.type == FlanCalendarType.range) {
      if (currentDate.isEmpty) {
        select(<DateTime>[date]);
        return;
      }

      if (currentDate.length == 1) {
        final DateTime startDay = currentDate[0];
        final int compareToStart = compareDay(date, startDay);

        if (compareToStart == 1) {
          select(<DateTime>[startDay, date], true);
        } else if (compareToStart == -1) {
          select(<DateTime>[date]);
        } else if (widget.allowSameDay) {
          select(<DateTime>[date, date], true);
        }
      } else {
        select(<DateTime>[date]);
      }
    } else if (widget.type == FlanCalendarType.multiple) {
      if (currentDate.isEmpty) {
        select(<DateTime>[date]);
        return;
      }

      final int selectedIndex = currentDate
          .indexWhere((DateTime dateItem) => compareDay(dateItem, date) == 0);

      if (selectedIndex != -1) {
        final List<DateTime> unselectedDate =
            currentDate.sublist(selectedIndex, 1);
        widget.onUnSelect?.call(cloneDates(unselectedDate));
      } else if (widget.maxRange != 0 &&
          currentDate.length >= widget.maxRange) {
        FlanToast(
          context,
          message: FlanS.of(context).Calendar_rangePrompt('${widget.maxRange}'),
        );
      } else {
        select(<DateTime>[...currentDate, date]);
      }
    } else {
      select(<DateTime>[date], true);
    }
  }

  Widget _buildMonth(DateTime date, int index) {
    final bool showMonthTitle = index != 0 || !widget.showSubtitle;
    return FlanCalendarMonth(
      topInfoBuilder: widget.topInfoBuilder,
      bottomInfoBuilder: widget.bottomInfoBuilder,
      date: date,
      currentDate: currentDate,
      showMonthTitle: showMonthTitle,
      firstDayOfWeek: dayOffset,
      maxDate: widget.maxDate,
      minDate: widget.minDate,
      type: widget.type,
      color: widget.color,
      showMark: widget.showMark,
      formatter: widget.formatter,
      rowHeight: widget.rowHeight,
      showSubtitle: widget.showSubtitle,
      allowSameDay: widget.allowSameDay,
      onClick: onClickDay,
    );
  }

  Widget _buildFooterButton() {
    if (widget.footerSlot != null) {
      return widget.footerSlot!;
    }
    final String text =
        buttonDisabled ? widget.confirmDisabledText : widget.confirmText;
    return Visibility(
      child: FlanButton(
        round: true,
        block: true,
        type: FlanButtonType.danger,
        color: widget.color,
        disabled: buttonDisabled,
        onClick: onConfirm,
        child: Text(text.isNotEmpty ? text : FlanS.of(context).confirm),
      ),
    );
  }

  Widget _buildFooter() {
    return SafeArea(
      bottom: widget.safeAreaInsetBottom,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ThemeVars.paddingMd) +
            ThemeVars.calendarConfirmButtonMargin,
        child: SizedBox(
          height: ThemeVars.calendarConfirmButtonHeight,
          child: _buildFooterButton(),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Column(
      children: <Widget>[
        FlanCalendarHeader(
          titleSlot: widget.titleSlot,
          title: widget.title,
          showTitle: widget.showTitle,
          subTitle: subtitle,
          showSubTitles: widget.showSubtitle,
          firstDayOfWeek: dayOffset,
        ),
        // _buildMonth(months[0], 0),
        Expanded(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: List<Widget>.generate(months.length, (int index) {
              return _buildMonth(months[index], index);
            }).toList(),
          ),
        ),
        _buildFooter(),
      ],
    );
  }
}

class FlanCalendarMonth extends StatefulWidget {
  const FlanCalendarMonth({
    Key? key,
    required this.type,
    this.color,
    this.showMark = false,
    this.rowHeight,
    this.formatter,
    this.currentDate = const <DateTime>[],
    this.allowSameDay = false,
    this.showSubtitle = false,
    this.showMonthTitle = false,
    this.firstDayOfWeek,
    required this.date,
    required this.minDate,
    required this.maxDate,
    this.onClick,
    this.onUpdateHeight,
    this.topInfoBuilder,
    this.bottomInfoBuilder,
  }) : super(key: key);

  // ****************** Props ******************
  final FlanCalendarType type;
  final Color? color;
  final bool showMark;
  final double? rowHeight;
  final FlanCalendarDayItemFormatter? formatter;
  final List<DateTime> currentDate;
  final bool allowSameDay;
  final bool showSubtitle;
  final bool showMonthTitle;
  final int? firstDayOfWeek;
  final DateTime date;
  final DateTime minDate;
  final DateTime maxDate;

  // ****************** Events ******************
  final FlanCalendarDayVoidCallback? onClick;
  final VoidCallback? onUpdateHeight;

  // ****************** Slots ******************
  final FlanCalendarDayBuilder? topInfoBuilder;
  final FlanCalendarDayBuilder? bottomInfoBuilder;

  @override
  _FlanCalendarMonthState createState() => _FlanCalendarMonthState();
}

class _FlanCalendarMonthState extends State<FlanCalendarMonth> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildTitle(),
        _buildDays(),
      ],
    );
  }

  String get title => FlanS.of(context)
      .Calendar_monthTitle(widget.date.year, widget.date.month);

  FlanCalendarDayType getMultipleDayType(DateTime day) {
    bool isSelected(DateTime date) =>
        widget.currentDate.any((DateTime item) => compareDay(item, day) == 0);

    if (isSelected(day)) {
      final DateTime preDay = getPreDay(day);
      final DateTime nextDay = getNextDay(day);
      final bool prevSelected = isSelected(preDay);
      final bool nextSelected = isSelected(nextDay);

      if (prevSelected && nextSelected) {
        return FlanCalendarDayType.multipleMiddle;
      }

      if (prevSelected) {
        return FlanCalendarDayType.end;
      }

      if (nextSelected) {
        return FlanCalendarDayType.start;
      }

      return FlanCalendarDayType.multipleSelected;
    }

    return FlanCalendarDayType.normal;
  }

  FlanCalendarDayType getRangeDayType(DateTime day) {
    if (widget.currentDate.isEmpty) {
      return FlanCalendarDayType.normal;
    }

    final DateTime startDay = widget.currentDate[0];
    final int compareToStart = compareDay(day, startDay);

    if (widget.currentDate.length < 2) {
      return compareToStart == 0
          ? FlanCalendarDayType.start
          : FlanCalendarDayType.normal;
    }

    final DateTime endDay = widget.currentDate[1];
    final int compareToEnd = compareDay(day, endDay);
    if (widget.allowSameDay && compareToStart == 0 && compareToEnd == 0) {
      return FlanCalendarDayType.startEnd;
    }

    if (compareToStart == 0) {
      return FlanCalendarDayType.start;
    }

    if (compareToEnd == 0) {
      return FlanCalendarDayType.end;
    }
    if (compareToStart > 0 && compareToEnd < 0) {
      return FlanCalendarDayType.middle;
    }

    return FlanCalendarDayType.normal;
  }

  FlanCalendarDayType getDayType(DateTime day) {
    if (compareDay(day, widget.minDate) < 0 ||
        compareDay(day, widget.maxDate) > 0) {
      return FlanCalendarDayType.disabled;
    }

    if (widget.currentDate.isEmpty) {
      return FlanCalendarDayType.normal;
    }

    if (widget.currentDate.length > 1) {
      if (widget.type == FlanCalendarType.multiple) {
        return getMultipleDayType(day);
      }
      if (widget.type == FlanCalendarType.range) {
        return getRangeDayType(day);
      }
    } else if (widget.type == FlanCalendarType.single) {
      return compareDay(day, widget.currentDate[0]) == 0
          ? FlanCalendarDayType.selected
          : FlanCalendarDayType.normal;
    }

    return FlanCalendarDayType.normal;
  }

  String getBottomInfo(FlanCalendarDayType dayType) {
    if (widget.type == FlanCalendarType.range) {
      if (dayType == FlanCalendarDayType.start) {
        return FlanS.of(context).Calendar_start;
      }
      if (dayType == FlanCalendarDayType.end) {
        return FlanS.of(context).Calendar_end;
      }
      if (dayType == FlanCalendarDayType.startEnd) {
        return FlanS.of(context).Calendar_startEnd;
      }
    }
    return '';
  }

  Widget _buildTitle() {
    return Visibility(
      visible: widget.showMonthTitle,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: ThemeVars.calendarMonthTitleFontSize,
          height: ThemeVars.calendarHeaderTitleHeight /
              ThemeVars.calendarMonthTitleFontSize,
          fontWeight: ThemeVars.fontWeightBold,
        ),
        textAlign: TextAlign.center,
        textHeightBehavior: FlanThemeVars.textHeightBehavior,
      ),
    );
  }

  Widget _buildMark() {
    return Visibility(
      visible: widget.showMark,
      child: Center(
        child: Text(
          '${widget.date.month}',
          style: TextStyle(
            fontSize: ThemeVars.calendarMonthMarkFontSize,
            color: ThemeVars.calendarMonthMarkColor,
          ),
          textAlign: TextAlign.center,
          textHeightBehavior: FlanThemeVars.textHeightBehavior,
        ),
      ),
    );
  }

  int get offset {
    final int realDay = widget.date.day;
    if (widget.firstDayOfWeek != null) {
      return (realDay + 7 - widget.firstDayOfWeek!) % 7;
    }
    return realDay;
  }

  int get totalDay => getMonthEndDay(widget.date.year, widget.date.month);

  List<FlanCalendarDayItem> get placeholders {
    final int count = (totalDay + offset) ~/ 7;
    return List<FlanCalendarDayItem>.generate(count, (_) {
      return FlanCalendarDayItem(type: FlanCalendarDayType.placeholder);
    });
  }

  List<FlanCalendarDayItem> get days {
    final List<FlanCalendarDayItem> days = <FlanCalendarDayItem>[];
    final int year = widget.date.year;
    final int month = widget.date.month;

    for (int day = 0; day <= totalDay; day++) {
      final DateTime date = DateTime(year, month, day);
      final FlanCalendarDayType type = getDayType(date);
      FlanCalendarDayItem config = FlanCalendarDayItem(
        date: date,
        type: type,
        text: '$day',
        bottomInfo: getBottomInfo(type),
      );
      if (widget.formatter != null) {
        config = widget.formatter!(config);
      }
      days.add(config);
    }
    return days;
  }

  Widget _buildDay(FlanCalendarDayItem item, int index) {
    return FlanCalendarDay(
      topInfoBuilder: widget.topInfoBuilder,
      bottomInfoBuilder: widget.bottomInfoBuilder,
      item: item,
      index: index,
      color: widget.color,
      offset: offset,
      // rowHeight: widget.rowHeight,
      onClick: widget.onClick,
    );
  }

  Widget _buildDays() {
    return Stack(
      children: <Widget>[
        _buildMark(),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Wrap(
              children: List<Widget>.generate(days.length, (int index) {
                return SizedBox(
                  width: constraints.maxWidth / 7,
                  height: widget.rowHeight ?? ThemeVars.calendarDayHeight,
                  child: _buildDay(days[index], index),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class FlanCalendarHeader extends StatelessWidget {
  const FlanCalendarHeader({
    Key? key,
    this.title = '',
    this.subTitle = '',
    this.showTitle = false,
    this.showSubTitles = false,
    this.firstDayOfWeek = 0,
    this.titleSlot,
  }) : super(key: key);

  // ****************** Props ******************
  final String title;
  final String subTitle;
  final bool showTitle;
  final bool showSubTitles;
  final int firstDayOfWeek;

  // ****************** Events ******************

  // ****************** Slots ******************
  final Widget? titleSlot;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: ThemeVars.calendarHeaderBoxShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildTitle(context),
          _buildSubTitle(context),
          _buildWeekDays(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final String title =
        this.title.isNotEmpty ? this.title : FlanS.of(context).Calendar_title;
    return Visibility(
      visible: showTitle,
      child: Container(
        height: FlanThemeVars.calendarHeaderTitleHeight,
        alignment: Alignment.center,
        child: DefaultTextHeightBehavior(
          textHeightBehavior: FlanThemeVars.textHeightBehavior,
          child: DefaultTextStyle.merge(
            style: const TextStyle(
              inherit: true,
              fontSize: ThemeVars.calendarHeaderTitleFontSize,
              fontWeight: ThemeVars.fontWeightBold,
              // height: FlanThemeVars.calendarHeaderTitleHeight,
            ),
            child: titleSlot ?? Text(title),
          ),
        ),
      ),
    );
  }

  Widget _buildSubTitle(BuildContext context) {
    return Visibility(
      visible: showSubTitles,
      child: Container(
        height: FlanThemeVars.calendarHeaderTitleHeight,
        alignment: Alignment.center,
        child: Text(
          subTitle,
          style: const TextStyle(
            fontSize: ThemeVars.calendarHeaderSubtitleFontSize,
            fontWeight: ThemeVars.fontWeightBold,
            // height: FlanThemeVars.calendarHeaderTitleHeight,
          ),
          textHeightBehavior: FlanThemeVars.textHeightBehavior,
        ),
      ),
    );
  }

  Widget _buildWeekDays(BuildContext context) {
    final FlanS S = FlanS.of(context);
    final List<String> weekdays = <String>[
      S.Calendar_weekdays_Sun,
      S.Calendar_weekdays_Mon,
      S.Calendar_weekdays_Tue,
      S.Calendar_weekdays_Wed,
      S.Calendar_weekdays_Thu,
      S.Calendar_weekdays_Fri,
      S.Calendar_weekdays_Sat,
    ];

    final List<String> renderWeekdays = <String>[
      ...weekdays.sublist(firstDayOfWeek, 7),
      ...weekdays.sublist(0, firstDayOfWeek),
    ];

    return Row(
      children: renderWeekdays.map((String day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: const TextStyle(
                fontSize: ThemeVars.calendarWeekdaysFontSize,
                height: ThemeVars.calendarWeekdaysHeight /
                    ThemeVars.calendarWeekdaysFontSize,
              ),
              textHeightBehavior: FlanThemeVars.textHeightBehavior,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class FlanCalendarDay extends StatelessWidget {
  const FlanCalendarDay({
    Key? key,
    this.color,
    this.index,
    // this.rowHeight,
    this.offset = 0,
    required this.item,
    this.onClick,
    this.topInfoBuilder,
    this.bottomInfoBuilder,
  }) : super(key: key);

  // ****************** Props ******************
  final Color? color;
  final int? index;
  // final double? rowHeight;
  final int offset;
  final FlanCalendarDayItem item;

  // ****************** Events ******************
  final FlanCalendarDayVoidCallback? onClick;

  // ****************** Slots ******************
  final FlanCalendarDayBuilder? topInfoBuilder;

  final FlanCalendarDayBuilder? bottomInfoBuilder;

  @override
  Widget build(BuildContext context) {
    final bool isSmallSize = MediaQuery.of(context).size.width <= 350.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _onClick,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Text(item.text),
            ),
            _buildTopInfo(isSmallSize),
            _buildBottomInfo(isSmallSize),
          ],
        ),
      ),
    );
  }

  Widget _buildTopInfo(bool isSmallSize) {
    if (item.topInfo.isNotEmpty || topInfoBuilder != null) {
      return Positioned(
          top: 6.0.rpx,
          right: 0.0,
          left: 0.0,
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: isSmallSize ? 9.0.rpx : ThemeVars.calendarInfoFontSize,
              // height: ThemeVars.calendarInfoLineHeight,
            ),
            child: topInfoBuilder?.call(item) ?? Text(item.topInfo),
          ));
    }
    return const SizedBox.shrink();
  }

  Widget _buildBottomInfo(bool isSmallSize) {
    if (item.bottomInfo.isNotEmpty || bottomInfoBuilder != null) {
      return Positioned(
          bottom: 6.0.rpx,
          right: 0.0,
          left: 0.0,
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: isSmallSize ? 9.0.rpx : ThemeVars.calendarInfoFontSize,
              // height: ThemeVars.calendarInfoLineHeight,
            ),
            child: bottomInfoBuilder?.call(item) ?? Text(item.bottomInfo),
          ));
    }
    return const SizedBox.shrink();
  }

  // double get height {
  //   switch (item.type) {
  //     case FlanCalendarDayType.selected:
  //       return rowHeight ?? ThemeVars.calendarSelectedDaySize;
  //     default:
  //       return ThemeVars.calendarSelectedDaySize;
  //   }
  // }

  // double? get width {
  //   switch (item.type) {
  //     case FlanCalendarDayType.placeholder:
  //       return double.infinity;
  //     case FlanCalendarDayType.selected:
  //       return rowHeight ?? ThemeVars.calendarSelectedDaySize;
  //     default:
  //       return double.infinity;
  //   }
  // }

  Color? get backgroundColor {
    switch (item.type) {
      case FlanCalendarDayType.end:
      case FlanCalendarDayType.start:
      case FlanCalendarDayType.startEnd:
      case FlanCalendarDayType.multipleMiddle:
      case FlanCalendarDayType.multipleSelected:
        return color ?? ThemeVars.calendarRangeEdgeBackgroundColor;

      case FlanCalendarDayType.middle:
        return ThemeVars.calendarRangeMiddleColor
            .withOpacity(ThemeVars.calendarRangeMiddleBackgroundOpacity);
      case FlanCalendarDayType.selected:
        return ThemeVars.calendarSelectedDayBackgroundColor;
      case FlanCalendarDayType.disabled:
        break;
      case FlanCalendarDayType.placeholder:
        break;
      case FlanCalendarDayType.normal:
        break;
    }
  }

  Color? get textColor {
    switch (item.type) {
      case FlanCalendarDayType.end:
      case FlanCalendarDayType.start:
      case FlanCalendarDayType.startEnd:
      case FlanCalendarDayType.multipleMiddle:
      case FlanCalendarDayType.multipleSelected:
        return ThemeVars.calendarRangeEdgeColor;
      case FlanCalendarDayType.middle:
        return color ?? ThemeVars.calendarRangeMiddleColor;
      case FlanCalendarDayType.selected:
        return ThemeVars.calendarSelectedDayColor;

      case FlanCalendarDayType.disabled:
        return ThemeVars.calendarDayDisabledColor;
      case FlanCalendarDayType.placeholder:
        break;
      case FlanCalendarDayType.normal:
        break;
    }
  }

  void _onClick() {
    if (item.type != FlanCalendarDayType.disabled) {
      onClick?.call(item);
    }
  }
}

class FlanCalendarDayItem {
  FlanCalendarDayItem({
    this.date,
    this.text = '',
    this.type = FlanCalendarDayType.normal,
    this.topInfo = '',
    this.bottomInfo = '',
  });

  final DateTime? date;
  final String text;
  final FlanCalendarDayType type;
  final String topInfo;
  final String bottomInfo;
}

enum FlanCalendarType {
  single,
  range,
  multiple,
}

enum FlanCalendarDayType {
  normal,
  start,
  startEnd,
  middle,
  end,
  selected,
  multipleMiddle,
  multipleSelected,
  disabled,
  placeholder
}

int compareMonth(DateTime date1, DateTime date2) {
  final int year1 = date1.year;
  final int year2 = date2.year;

  if (year1 == year2) {
    final int month1 = date1.month;
    final int month2 = date2.month;

    return month1 == month2
        ? 0
        : month1 > month2
            ? 1
            : -1;
  }
  return year1 > year2 ? 1 : -1;
}

int compareDay(DateTime day1, DateTime day2) {
  final int compareMonthResult = compareMonth(day1, day2);
  if (compareMonthResult == 0) {
    final int date1 = day1.day;
    final int date2 = day2.day;
    return date1 == date2
        ? 0
        : date1 > date2
            ? 1
            : -1;
  }

  return compareMonthResult;
}

DateTime cloneDate(DateTime date) =>
    DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);

List<DateTime> cloneDates(List<DateTime> dates) =>
    dates.map(cloneDate).toList();

DateTime getDayByOffset(DateTime date, int offset) {
  final DateTime cloned = date.add(Duration(days: offset));
  return cloned;
}

DateTime getPreDay(DateTime date) => getDayByOffset(date, -1);
DateTime getNextDay(DateTime date) => getDayByOffset(date, -1);
DateTime getToday() {
  final DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

int calcDateNum(List<DateTime> date) {
  return date[1].difference(date[0]).inDays;
}
