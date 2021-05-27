// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/utils/format/number.dart';
import 'package:flant/utils/format/string.dart';
import 'package:flant/utils/widget.dart';
import 'picker.dart';

String kDefaultDateTimeFormate(
        FlanDateTimePickerColumnType type, String value) =>
    value;

final int kCurrentYear = DateTime.now().year;

/// Picker 选择器
/// 提供多个选项集合供用户选择，支持单列选择和多列级联，通常与弹出层组件配合使用。
class FlanDatePicker extends StatefulWidget {
  FlanDatePicker({
    Key? key,
    this.title = '',
    this.loading = false,
    this.readonly = false,
    // this.allowHtml = false,
    this.cancelButtonText = '',
    this.confirmButtonText = '',
    this.itemHeight = 44.0,
    this.showToolbar = true,
    this.visibleItemCount = 6,
    // this.swipeDuration = const Duration(seconds: 1),
    this.filter,
    this.columnsOrder,
    this.formatter = kDefaultDateTimeFormate,
    this.value,
    this.type = FlanDateTimePickerType.datetime,
    DateTime? minDate,
    DateTime? maxDate,
    this.onConfirm,
    this.onCancel,
    this.onChange,
    this.onValueChange,
    this.child,
    this.titleSlot,
    this.confirmSlot,
    this.cancelSlot,
    this.optionBuilder,
    this.columnsTopSlot,
    this.columnsBottomSlot,
  })  : minDate = minDate ?? DateTime(kCurrentYear - 10, 1, 1),
        maxDate = maxDate ?? DateTime(kCurrentYear + 10, 12, 31),
        super(key: key);

  // ****************** Props ******************
  /// 顶部栏标题
  final String title;

  /// 是否显示加载状态
  final bool loading;

  /// 是否只读
  final bool readonly;

  // /// 是否允许选项内容中渲染 HTML
  // final bool allowHtml;

  /// 取消按钮文字
  final String cancelButtonText;

  /// 确认按钮文字
  final String confirmButtonText;

  /// 选项高度
  final double itemHeight;

  /// 是否显示顶部栏
  final bool showToolbar;

  /// 可见的选项个数
  final int visibleItemCount;

  // /// 快速滑动时惯性滚动的时长
  // final Duration swipeDuration;

  /// 选项过滤函数
  final List<String> Function(
      FlanDateTimePickerColumnType type, List<String> values)? filter;

  /// 选项过滤函数 `year`、`month`、`day`、`hour`、`minute`
  final List<FlanDateTimePickerColumnType>? columnsOrder;

  /// 选项格式化函数
  final String Function(FlanDateTimePickerColumnType type, String value)
      formatter;

  /// 显示时间
  final DateTime? value;

  /// 时间类型，可选值为 `date` `time` `year-month` `month-day` `datehour` `datetime`
  final FlanDateTimePickerType type;

  /// 可选的最小时间，精确到分钟
  final DateTime minDate;

  /// 可选的最大时间，精确到分钟
  final DateTime maxDate;

  // ****************** Events ******************
  /// 点击完成按钮时触发
  final ValueChanged<DateTime?>? onConfirm;

  /// 点击取消按钮时触发
  final VoidCallback? onCancel;

  /// 选项改变时触发(动画结束)
  final ValueChanged<DateTime?>? onChange;

  /// 值发生改变
  final ValueChanged<DateTime?>? onValueChange;

  // ****************** Slots ******************
  /// 自定义整个顶部栏的内容
  final Widget? child;

  /// 自定义标题内容
  final Widget? titleSlot;

  /// 自定义确认按钮内容
  final Widget? confirmSlot;

  /// 自定义取消按钮内容
  final Widget? cancelSlot;

  /// 自定义选项内容
  final Widget Function(dynamic)? optionBuilder;

  /// 自定义选项上方内容
  final Widget? columnsTopSlot;

  /// 自定义选项下方内容
  final Widget? columnsBottomSlot;

  @override
  _FlanDatePickerState createState() => _FlanDatePickerState();
}

class _FlanDatePickerState extends State<FlanDatePicker> {
  GlobalKey<FlanPickerState> picker = GlobalKey<FlanPickerState>();
  late ValueNotifier<DateTime?> currentDate;
  late List<Map<String, dynamic>> columns;

  @override
  void initState() {
    currentDate = ValueNotifier<DateTime?>(_formatValue(widget.value))
      ..addListener(_onValueChange);

    columns = getColumns();
    nextTick(() {
      _updateColumnValue();
      nextTick(() {
        _updateInnerValue();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    currentDate
      ..removeListener(_onValueChange)
      ..dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanDatePicker oldWidget) {
    final List<Map<String, dynamic>> newColumns = getColumns();
    if (newColumns != columns) {
      columns = newColumns;
      _updateColumnValue();
    }
    if (widget.filter != oldWidget.filter ||
        widget.minDate != oldWidget.minDate ||
        widget.maxDate != oldWidget.maxDate) {
      _updateInnerValue();
    }

    if (widget.value != oldWidget.value) {
      final DateTime? value = _formatValue(widget.value);
      if (value != null &&
          value.millisecondsSinceEpoch !=
              currentDate.value?.millisecondsSinceEpoch) {
        currentDate.value = value;
        // _updateColumnValue();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FlanPicker(
      child: widget.child,
      titleSlot: widget.titleSlot,
      cancelSlot: widget.cancelSlot,
      confirmSlot: widget.confirmSlot,
      columnsTopSlot: widget.columnsTopSlot,
      columnsBottomSlot: widget.columnsBottomSlot,
      columns: columns,
      key: picker,
      onChange: (dynamic value, dynamic index) {
        _onChange();
      },
      onCancel: (dynamic value, dynamic index) {
        _onCancel();
      },
      onConfirm: (dynamic value, dynamic index) {
        _onConfirm();
      },
      title: widget.title,
      loading: widget.loading,
      readonly: widget.readonly,
      cancelButtonText: widget.cancelButtonText,
      confirmButtonText: widget.confirmButtonText,
      itemHeight: widget.itemHeight,
      showToolbar: widget.showToolbar,
      visibleItemCount: widget.visibleItemCount,
    );
  }

  void _onValueChange() {
    widget.onValueChange?.call(currentDate.value);
  }

  void _updateColumnValue() {
    final DateTime value = currentDate.value ?? widget.minDate;
    final List<String> values =
        originColumns.map((FlanDateTimePickerColumn column) {
      switch (column.type) {
        case FlanDateTimePickerColumnType.year:
          return widget.formatter(
              FlanDateTimePickerColumnType.year, '${value.year}');
        case FlanDateTimePickerColumnType.month:
          return widget.formatter(
              FlanDateTimePickerColumnType.month, padZero(value.month));
        case FlanDateTimePickerColumnType.day:
          return widget.formatter(
              FlanDateTimePickerColumnType.day, padZero(value.day));
        case FlanDateTimePickerColumnType.hour:
          return widget.formatter(
              FlanDateTimePickerColumnType.hour, padZero(value.hour));
        case FlanDateTimePickerColumnType.minute:
          return widget.formatter(
              FlanDateTimePickerColumnType.minute, padZero(value.minute));
        default:
          return '';
      }
    }).toList();
    nextTick(() {
      picker.currentState?.setValues(values);
    });
  }

  void _updateInnerValue() {
    final List<int>? indexes = picker.currentState?.getIndexes();
    int getValue(FlanDateTimePickerColumnType type) {
      int index = 0;
      for (int columnIndex = 0;
          columnIndex < originColumns.length;
          columnIndex++) {
        final FlanDateTimePickerColumn column = originColumns[columnIndex];

        if (type == column.type) {
          index = columnIndex;
        }
      }
      final List<String> values = originColumns[index].values;
      return int.tryParse(values[indexes![index]])!;
    }

    int year;
    int month;
    int day;
    if (widget.type == FlanDateTimePickerType.monthDay) {
      year = (currentDate.value ?? widget.minDate).year;
      month = getValue(FlanDateTimePickerColumnType.month);
      day = getValue(FlanDateTimePickerColumnType.day);
    } else {
      year = getValue(FlanDateTimePickerColumnType.year);
      month = getValue(FlanDateTimePickerColumnType.month);
      day = widget.type == FlanDateTimePickerType.yearMonth
          ? 1
          : getValue(FlanDateTimePickerColumnType.day);
    }

    final int maxDay = getMonthEndDay(year, month);
    day = day > maxDay ? maxDay : day;

    int hour = 0;
    int minute = 0;

    if (widget.type == FlanDateTimePickerType.datehour) {
      hour = getValue(FlanDateTimePickerColumnType.hour);
    }

    if (widget.type == FlanDateTimePickerType.datetime) {
      hour = getValue(FlanDateTimePickerColumnType.hour);
      minute = getValue(FlanDateTimePickerColumnType.minute);
    }

    final DateTime value = DateTime(year, month, day, hour, minute);
    currentDate.value = _formatValue(value);
  }

  void _onConfirm() {
    widget.onValueChange?.call(currentDate.value);

    widget.onConfirm?.call(currentDate.value);
  }

  void _onCancel() {
    widget.onCancel?.call();
  }

  void _onChange() {
    _updateInnerValue();
    // nextTick((Duration timestamp){
    //    nextTick((Duration timestamp){

    widget.onChange?.call(currentDate.value);

    // });
    // });
  }

  DateTime? _formatValue(DateTime? value) {
    if (value != null) {
      final int timestamp = range(
        value.millisecondsSinceEpoch,
        widget.minDate.millisecondsSinceEpoch,
        widget.maxDate.millisecondsSinceEpoch,
      ) as int;
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
  }

  List<int> getBoundary(String type, DateTime value) {
    final DateTime boundary = type == 'max' ? widget.maxDate : widget.minDate;
    final int year = boundary.year;
    int month = 1;
    int date = 1;
    int hour = 0;
    int minute = 0;
    if (type == 'max') {
      month = 12;
      date = getMonthEndDay(value.year, value.month);
      hour = 23;
      minute = 59;
    }

    if (value.year == year) {
      month = boundary.month;
      if (value.month == month) {
        date = boundary.day;
        if (value.day == date) {
          hour = boundary.hour;
          if (value.hour == hour) {
            minute = boundary.minute;
          }
        }
      }
    }
    return <int>[
      year,
      month,
      date,
      hour,
      minute,
    ];
  }

  List<FlanDateTimePickerRange> get ranges {
    final List<int> maxValues =
        getBoundary('max', currentDate.value ?? widget.maxDate);
    final List<int> minValues =
        getBoundary('min', currentDate.value ?? widget.minDate);
    List<FlanDateTimePickerRange> result = <FlanDateTimePickerRange>[
      FlanDateTimePickerRange(
        type: FlanDateTimePickerColumnType.year,
        range: <int>[minValues[0], maxValues[0]],
      ),
      FlanDateTimePickerRange(
        type: FlanDateTimePickerColumnType.month,
        range: <int>[minValues[1], maxValues[1]],
      ),
      FlanDateTimePickerRange(
        type: FlanDateTimePickerColumnType.day,
        range: <int>[minValues[2], maxValues[2]],
      ),
      FlanDateTimePickerRange(
        type: FlanDateTimePickerColumnType.hour,
        range: <int>[minValues[3], maxValues[3]],
      ),
      FlanDateTimePickerRange(
        type: FlanDateTimePickerColumnType.minute,
        range: <int>[minValues[4], maxValues[4]],
      ),
    ];

    switch (widget.type) {
      case FlanDateTimePickerType.date:
        result = result.sublist(0, 3);
        break;
      // case FlanDateTimePickerType.time:
      //   break;
      case FlanDateTimePickerType.datehour:
        result = result.sublist(0, 4);
        break;
      case FlanDateTimePickerType.datetime:
        break;
      case FlanDateTimePickerType.monthDay:
        result = result.sublist(1, 3);
        break;
      case FlanDateTimePickerType.yearMonth:
        result = result.sublist(0, 2);
        break;
    }

    if (widget.columnsOrder != null) {
      final List<FlanDateTimePickerColumnType> columnsOrder = result
          .map((FlanDateTimePickerRange column) => column.type)
          .toList()
            ..insertAll(0, widget.columnsOrder!);

      result.sort(
        (FlanDateTimePickerRange a, FlanDateTimePickerRange b) =>
            columnsOrder.indexOf(a.type) - columnsOrder.indexOf(b.type),
      );
    }
    return result;
  }

  List<FlanDateTimePickerColumn> get originColumns {
    return ranges.map((FlanDateTimePickerRange item) {
      final FlanDateTimePickerColumnType type = item.type;
      final List<int> rangeArr = item.range;
      List<String> values = times(rangeArr[1] - rangeArr[0] + 1,
          (int index) => padZero(rangeArr[0] + index));
      if (widget.filter != null) {
        values = widget.filter!(type, values);
      }
      return FlanDateTimePickerColumn(
        type: type,
        values: values,
      );
    }).toList();
  }

  List<Map<String, dynamic>> getColumns() {
    return originColumns.map((FlanDateTimePickerColumn column) {
      return <String, dynamic>{
        'values': column.values
            .map((String value) => widget.formatter(column.type!, value))
            .toList(),
      };
    }).toList();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<String>('title', widget.title, defaultValue: ''));
    properties.add(DiagnosticsProperty<bool>('loading', widget.loading,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('readonly', widget.readonly,
        defaultValue: false));
    //  properties
    //     .add(DiagnosticsProperty<bool>('allowHtml', widget.allowHtml, defaultValue: false));
    properties.add(DiagnosticsProperty<String>(
        'cancelButtonText', widget.cancelButtonText,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<String>(
        'confirmButtonText', widget.confirmButtonText,
        defaultValue: ''));
    properties.add(DiagnosticsProperty<double>('itemHeight', widget.itemHeight,
        defaultValue: 44.0));
    properties.add(DiagnosticsProperty<bool>('showToolbar', widget.showToolbar,
        defaultValue: true));
    properties.add(DiagnosticsProperty<int>(
        'visibleItemCount', widget.visibleItemCount,
        defaultValue: 6));

    properties.add(DiagnosticsProperty<
        List<String> Function(FlanDateTimePickerColumnType type,
            List<String> values)>('filter', widget.filter));
    properties.add(DiagnosticsProperty<List<FlanDateTimePickerColumnType>>(
        'columnsOrder', widget.columnsOrder));
    properties.add(DiagnosticsProperty<
            String Function(FlanDateTimePickerColumnType type, String value)>(
        'formatter', widget.formatter,
        defaultValue: kDefaultDateTimeFormate));

    super.debugFillProperties(properties);
  }
}

enum FlanDateTimePickerColumnType {
  year,
  month,
  day,
  hour,
  minute,
}

enum FlanDateTimePickerType {
  date,
  // time,
  datetime,
  datehour,
  monthDay,
  yearMonth,
}

class FlanDateTimePickerRange {
  const FlanDateTimePickerRange({
    required this.type,
    required this.range,
  });

  final FlanDateTimePickerColumnType type;
  final List<int> range;
}

class FlanDateTimePickerColumn {
  const FlanDateTimePickerColumn({
    this.type,
    required this.values,
  });

  final FlanDateTimePickerColumnType? type;
  final List<String> values;
}

List<T> times<T>(int n, T Function(int index) iteratee) {
  return List<T>.generate(n, (int index) => iteratee(index));
}

int getMonthEndDay(int year, int month) {
  return 32 - DateTime(year, month, 32).day;
}
