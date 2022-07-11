import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/format/number.dart';
import '../utils/format/string.dart';
import '../utils/widget.dart';
import 'date_picker.dart';
import 'picker.dart';

/// Picker 选择器
/// 提供多个选项集合供用户选择，支持单列选择和多列级联，通常与弹出层组件配合使用。
class FlanTimePicker extends StatefulWidget {
  const FlanTimePicker({
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
    required this.value,
    this.minHour = 0,
    this.maxHour = 23,
    this.minMinute = 0,
    this.maxMinute = 59,
    this.onConfirm,
    this.onCancel,
    this.onChange,
    required this.onValueChange,
    this.child,
    this.titleSlot,
    this.confirmSlot,
    this.cancelSlot,
    this.optionBuilder,
    this.columnsTopSlot,
    this.columnsBottomSlot,
  }) : super(key: key);

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
  final String value;

  /// 可选的最小小时
  final int minHour;

  /// 可选的最大小时
  final int maxHour;

  /// 可选的最大小时
  final int minMinute;

  /// 可选的最大分钟
  final int maxMinute;

  // ****************** Events ******************
  /// 点击完成按钮时触发
  final ValueChanged<String>? onConfirm;

  /// 点击取消按钮时触发
  final VoidCallback? onCancel;

  /// 选项改变时触发(动画结束)
  final ValueChanged<String>? onChange;

  /// 值发生改变
  final ValueChanged<String> onValueChange;

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
  _FlanTimePickerState createState() => _FlanTimePickerState();
}

class _FlanTimePickerState extends State<FlanTimePicker> {
  late ValueNotifier<String> currentDate;
  late List<Map<String, dynamic>> columns;
  GlobalKey<FlanPickerState> picker = GlobalKey();

  FlanPickerState? getPicker() => picker.currentState;

  @override
  void initState() {
    currentDate = ValueNotifier<String>(_formatValue(value: widget.value))
      ..addListener(_onValueChange);
    columns = getColumns();
    nextTick(() {
      _updateColumnValue();
      _updateInnerValue();
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
  void didUpdateWidget(covariant FlanTimePicker oldWidget) {
    final List<Map<String, dynamic>> newColumns = getColumns();
    if (newColumns != columns) {
      columns = newColumns;
      _updateColumnValue();
    }
    if (widget.filter != oldWidget.filter ||
        widget.minHour != oldWidget.minHour ||
        widget.maxHour != oldWidget.maxHour ||
        widget.minMinute != oldWidget.minMinute ||
        widget.maxMinute != oldWidget.maxMinute) {
      _updateInnerValue();
    }

    if (widget.value != oldWidget.value) {
      final String value = _formatValue(value: widget.value);
      if (value != currentDate.value) {
        currentDate.value = value;
        _updateColumnValue();
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
    widget.onValueChange(currentDate.value);
  }

  void _updateColumnValue() {
    final List<String> pair = currentDate.value.split(':');
    final List<String> values = <String>[
      widget.formatter(FlanDateTimePickerColumnType.hour, pair[0]),
      widget.formatter(FlanDateTimePickerColumnType.minute, pair[1]),
    ];

    // nextTick((Duration timestamp){
    picker.currentState?.setValues(values);
    // });
  }

  void _updateInnerValue() {
    final List<int>? indexes = picker.currentState?.getIndexes();
    final int hourIndex = indexes?[0] ?? 0;
    final int minuteIndex = indexes?[1] ?? 0;
    final List<FlanDateTimePickerColumn> columns = originColumns;
    final FlanDateTimePickerColumn hourColumn = columns[0];
    final FlanDateTimePickerColumn minuteColumn = columns[1];

    final String hour = hourColumn.values[hourIndex];
    final String minute = minuteColumn.values[minuteIndex];

    currentDate.value = _formatValue(value: '$hour:$minute');
    _updateColumnValue();
  }

  void _onConfirm() {
    widget.onConfirm?.call(currentDate.value);
  }

  void _onCancel() {
    widget.onCancel?.call();
  }

  void _onChange() {
    _updateInnerValue();
    widget.onChange?.call(currentDate.value);
  }

  String _formatValue({String value = ''}) {
    if (value.isEmpty) {
      value = '${padZero(widget.minHour)}:${padZero(widget.minMinute)}';
    }
    final List<String> arr = value.split(':');
    String hour = arr[0];
    String minute = arr[1];
    hour =
        padZero(range(int.tryParse(hour) ?? 0, widget.minHour, widget.maxHour));
    minute = padZero(
        range(int.tryParse(minute) ?? 0, widget.minMinute, widget.maxMinute));
    return '$hour:$minute';
  }

  List<FlanDateTimePickerRange> get ranges {
    return <FlanDateTimePickerRange>[
      FlanDateTimePickerRange(
        type: FlanDateTimePickerColumnType.hour,
        range: <int>[widget.minHour, widget.maxHour],
      ),
      FlanDateTimePickerRange(
        type: FlanDateTimePickerColumnType.minute,
        range: <int>[widget.minMinute, widget.maxMinute],
      ),
    ];
  }

  List<FlanDateTimePickerColumn> get originColumns {
    final List<FlanDateTimePickerColumn> content = <FlanDateTimePickerColumn>[];
    for (int i = 0; i < ranges.length; i++) {
      final FlanDateTimePickerRange item = ranges[i];
      final FlanDateTimePickerColumnType type = item.type;
      final List<int> rangeArr = item.range;
      List<String> values = times(rangeArr[1] - rangeArr[0] + 1,
          (int index) => padZero(rangeArr[0] + index));
      if (widget.filter != null) {
        values = widget.filter!(type, values);
      }
      content.add(FlanDateTimePickerColumn(
        type: type,
        values: values,
      ));
    }
    return content;
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
    properties.add(DiagnosticsProperty<String>('value', widget.value));
    properties.add(
        DiagnosticsProperty<int>('minHour', widget.minHour, defaultValue: 0));
    properties.add(
        DiagnosticsProperty<int>('maxHour', widget.maxHour, defaultValue: 23));
    properties.add(DiagnosticsProperty<int>('minMinute', widget.minMinute,
        defaultValue: 0));
    properties.add(DiagnosticsProperty<int>('maxMinute', widget.maxMinute,
        defaultValue: 59));

    super.debugFillProperties(properties);
  }
}
