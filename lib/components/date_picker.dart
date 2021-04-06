// 🐦 Flutter imports:

import 'package:flant/utils/format/number.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'picker.dart';

String kDefaultDateTimeFormate(String type, String value) => value;

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
  })  : minDate = minDate ?? DateTime(kCurrentYear - 10, 0, 1),
        maxDate = maxDate ?? DateTime(kCurrentYear + 10, 11, 31),
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
  final List<String> Function(String type, List<String> values)? filter;

  /// 选项过滤函数 `year`、`month`、`day`、`hour`、`minute`
  final List<FlanDateTimePickerColumnType>? columnsOrder;

  /// 选项格式化函数
  final String Function(String type, String value) formatter;

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
  final void Function(dynamic value, dynamic index)? onConfirm;

  /// 点击取消按钮时触发
  final void Function(dynamic value, dynamic index)? onCancel;

  /// 选项改变时触发(动画结束)
  final void Function(dynamic value, dynamic index)? onChange;

  /// 值发生改变
  final void Function(dynamic value, dynamic index)? onValueChange;

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
  DateTime? currentDate;

  @override
  void initState() {
    currentDate = formatValue(widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  DateTime? formatValue(DateTime? value) {
    if (value != null) {
      final int timestamp = range(
        value.millisecondsSinceEpoch,
        widget.minDate.millisecondsSinceEpoch,
        widget.maxDate.millisecondsSinceEpoch,
      ) as int;
      return DateTime(timestamp);
    }
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
        List<String> Function(
            String type, List<String> values)>('filter', widget.filter));
    properties.add(DiagnosticsProperty<List<FlanDateTimePickerColumnType>>(
        'columnsOrder', widget.columnsOrder));
    properties.add(
        DiagnosticsProperty<String Function(String type, String value)>(
            'formatter', widget.formatter,
            defaultValue: kDefaultDateTimeFormate));

    super.debugFillProperties(properties);
  }
}

enum _BoundaryType {
  max,
  min,
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
  time,
  datetime,
  monthDay,
  yearMonth,
}
