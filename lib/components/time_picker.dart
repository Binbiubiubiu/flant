// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  final List<String> Function(String type, List<String> values)? filter;

  /// 选项过滤函数 `year`、`month`、`day`、`hour`、`minute`
  final List<FlanDateTimePickerColumnType>? columnsOrder;

  /// 选项格式化函数
  final String Function(String type, String value) formatter;

  /// 显示时间
  final DateTime value;

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
  final void Function(dynamic value, dynamic index)? onConfirm;

  /// 点击取消按钮时触发
  final void Function(dynamic value, dynamic index)? onCancel;

  /// 选项改变时触发(动画结束)
  final void Function(dynamic value, dynamic index)? onChange;

  /// 值发生改变
  final void Function(dynamic value, dynamic index) onValueChange;

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
  @override
  Widget build(BuildContext context) {
    return Container();
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
    properties.add(DiagnosticsProperty<DateTime>('value', widget.value));
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
