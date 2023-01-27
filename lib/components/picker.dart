import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../locale/l10n.dart';
import '../styles/var.dart';
import '../utils/format/number.dart';
import 'loading.dart';
import 'style.dart';

const Duration DEFAULT_DURATION = Duration(milliseconds: 200);

// 惯性滑动思路:
// 在手指离开屏幕时，如果和上一次 move 时的间隔小于 `MOMENTUM_LIMIT_TIME` 且 move
// 距离大于 `MOMENTUM_LIMIT_DISTANCE` 时，执行惯性滑动
// const Duration MOMENTUM_LIMIT_TIME = Duration(milliseconds: 300);
const double MOMENTUM_LIMIT_DISTANCE = 15.0;

bool isOptionDisabled(dynamic option) {
  return option is Map && option['disabled'] == true;
}

double getIndexByOffset(double offset, double itemHeight) =>
    offset / itemHeight;

/// Picker 选择器
/// 提供多个选项集合供用户选择，支持单列选择和多列级联，通常与弹出层组件配合使用。
class FlanPicker extends StatefulWidget {
  const FlanPicker({
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
    this.columnsFieldNames,
    this.columns = const <Map<String, dynamic>>[],
    this.defaultIndex = 0,
    this.toolbarPosition = FlanPickerToolbarPosition.top,
    this.valueKey = 'text',
    this.onConfirm,
    this.onCancel,
    this.onChange,
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

  /// 自定义 `columns` 结构中的字段
  final FlanPickerFieldNames? columnsFieldNames;

  /// 对象数组，配置每一列显示的数据
  final List<dynamic> columns;

  /// 单列选择时，默认选中项的索引
  final int defaultIndex;

  /// 顶部栏位置，可选值为 `bottom` `top`
  final FlanPickerToolbarPosition toolbarPosition;

  /// 选项对象中，选项文字对应的键名
  final String valueKey;

  // ****************** Events ******************
  /// 点击完成按钮时触发
  final void Function(dynamic value, dynamic index)? onConfirm;

  /// 点击取消按钮时触发
  final void Function(dynamic value, dynamic index)? onCancel;

  /// 选项改变时触发
  final void Function(dynamic value, dynamic index)? onChange;

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
  FlanPickerState createState() => FlanPickerState();
}

class FlanPickerState extends State<FlanPicker> {
  List<dynamic> formattedColumns = <dynamic>[];
  late final String textKey;
  late final String valuesKey;
  late final String childrenKey;

  late List<GlobalKey<_FlanPickerColumnState>> children;

  @override
  void initState() {
    textKey = widget.columnsFieldNames?.text ?? widget.valueKey;
    valuesKey = widget.columnsFieldNames?.values ?? 'values';
    childrenKey = widget.columnsFieldNames?.children ?? 'children';
    format();
    children = formattedColumns
        .map((dynamic e) => GlobalKey<_FlanPickerColumnState>())
        .toList();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FlanPicker oldWidget) {
    if (widget.columns != oldWidget.columns) {
      format();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: ThemeVars.pickerBackgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.toolbarPosition == FlanPickerToolbarPosition.top)
                _buildToolbar()
              else
                const SizedBox.shrink(),
              widget.columnsTopSlot ?? const SizedBox.shrink(),
              _buildColumns(),
              widget.columnsBottomSlot ?? const SizedBox.shrink(),
              if (widget.toolbarPosition == FlanPickerToolbarPosition.bottom)
                _buildToolbar()
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
        Positioned.fill(
          child: Offstage(
            offstage: !widget.loading,
            child: Container(
              alignment: Alignment.center,
              color: ThemeVars.pickerLoadingMaskColor,
              child: const FlanLoading(
                color: ThemeVars.pickerLoadingIconColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  FlanPickerDataType get dataType {
    final dynamic firstColumn =
        widget.columns.isNotEmpty ? widget.columns[0] : null;
    if (firstColumn != null && firstColumn is! String) {
      if (firstColumn[childrenKey] != null) {
        return FlanPickerDataType.cascade;
      }
      if (firstColumn[valuesKey] != null) {
        return FlanPickerDataType.object;
      }
    }
    return FlanPickerDataType.plain;
  }

  void formatCascade() {
    final List<dynamic> formatted = <dynamic>[];
    dynamic cursor = <String, dynamic>{
      childrenKey: widget.columns,
    };

    while (cursor?[childrenKey] != null) {
      final List<dynamic> children = cursor![childrenKey] as List<dynamic>;

      int defaultIndex = cursor['defaultIndex'] as int? ?? widget.defaultIndex;

      while (children[defaultIndex]['disabled'] == true) {
        if (defaultIndex < children.length - 1) {
          defaultIndex++;
        } else {
          defaultIndex = 0;
          return;
        }
      }

      formatted.add(<String, dynamic>{
        valuesKey: cursor[childrenKey],
        'defaultIndex': defaultIndex,
      });

      cursor = children[defaultIndex];
    }
    formattedColumns = formatted;
  }

  void format() {
    if (dataType == FlanPickerDataType.plain) {
      formattedColumns = <Map<String, dynamic>>[
        <String, dynamic>{valuesKey: widget.columns}
      ];
    } else if (dataType == FlanPickerDataType.cascade) {
      formatCascade();
    } else {
      formattedColumns = widget.columns;
    }
  }

  Widget _buildToolbar() {
    if (widget.showToolbar) {
      return SizedBox(
        height: ThemeVars.pickerToolbarHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildCancel(),
            _buildTitle(),
            _buildConfirm(),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  void onChange(int columnIndex) {
    if (dataType == FlanPickerDataType.cascade) {
      onCascadeChange(columnIndex);
      setState(() {});
    }

    if (widget.onChange != null) {
      if (dataType == FlanPickerDataType.plain) {
        widget.onChange!(getColumnValue(0), getColumnIndex(0));
      } else {
        widget.onChange!(getValues(), columnIndex);
      }
    }
  }

  void confirm() {
    for (int i = 0; i < children.length; i++) {
      final GlobalKey<_FlanPickerColumnState> child = children[i];
      child.currentState?.stopMomentum();
    }

    // emitAction('confirm');
    if (widget.onConfirm != null) {
      if (dataType == FlanPickerDataType.plain) {
        widget.onConfirm!(getColumnValue(0), getColumnIndex(0));
      } else {
        widget.onConfirm!(getValues(), getIndexes());
      }
    }
  }

  void cancel() {
    if (widget.onCancel != null) {
      if (dataType == FlanPickerDataType.plain) {
        widget.onConfirm!(getColumnValue(0), getColumnIndex(0));
      } else {
        widget.onConfirm!(getValues(), getIndexes());
      }
    }
  }

  // void emitAction = (event: 'confirm' | 'cancel'){
  //     if (dataType.value === 'plain') {
  //       emit(event, getColumnValue(0), getColumnIndex(0));
  //     } else {
  //       emit(event, getValues(), getIndexes());
  //     }
  //   }

  Widget _buildTitle() {
    if (widget.titleSlot != null) {
      return widget.titleSlot!;
    }

    return Container(
      width: MediaQuery.of(context).size.width / 2.0,
      // alignment: Alignment.center,
      child: Text(
        widget.title,
        style: const TextStyle(
          fontWeight: ThemeVars.fontWeightBold,
          fontSize: ThemeVars.pickerTitleFontSize,
          height:
              ThemeVars.pickerTitleLineHeight / ThemeVars.pickerTitleFontSize,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCancel() {
    final String text = widget.cancelButtonText.isEmpty
        ? FlanS.of(context).cancel
        : widget.cancelButtonText;
    return _TitleButton(
      onTap: cancel,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: ThemeVars.pickerCancelActionColor,
        ),
        child: widget.cancelSlot ?? Text(text),
      ),
    );
  }

  Widget _buildConfirm() {
    final String text = widget.confirmButtonText.isEmpty
        ? FlanS.of(context).confirm
        : widget.confirmButtonText;
    return _TitleButton(
      onTap: confirm,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: ThemeVars.pickerConfirmActionColor,
        ),
        child: widget.confirmSlot ?? Text(text),
      ),
    );
  }

  List<Widget> _buildColumnItems() {
    return List<Widget>.generate(formattedColumns.length, (int columnIndex) {
      final dynamic item = formattedColumns[columnIndex];

      return Expanded(
        child: FlanPickerColumn(
          key: children[columnIndex],
          dataType: dataType,
          optionBuilder: widget.optionBuilder,
          readonly: widget.readonly,
          textKey: textKey,
          itemHeight: widget.itemHeight,
          defaultIndex: item['defaultIndex'] as int? ?? widget.defaultIndex,
          // swipDuration: widget.swipeDuration,
          initialOptions: item[valuesKey] as List<dynamic>,
          visibleItemCount: widget.visibleItemCount,
          onChange: (int _index) => onChange(columnIndex),
        ),
      );
    });
  }

  Widget _buildColumns() {
    final double wrapHeight = widget.itemHeight * widget.visibleItemCount;
    final double maskHeight = (wrapHeight - widget.itemHeight) / 2.0;

    return Stack(
      children: <Widget>[
        SizedBox(
          height: wrapHeight,
          child: Row(
            children: _buildColumnItems(),
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: IgnorePointer(
            child: Container(
              height: maskHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color.fromRGBO(255, 255, 255, .9),
                    Color.fromRGBO(255, 255, 255, .4),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: IgnorePointer(
            child: Container(
              height: maskHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                    Color.fromRGBO(255, 255, 255, .9),
                    Color.fromRGBO(255, 255, 255, .4),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: (wrapHeight - widget.itemHeight) / 2.0,
          left: 0.0,
          right: 0.0,
          child: IgnorePointer(
            child: Container(
              height: widget.itemHeight,
              decoration: const BoxDecoration(
                border: Border(
                  top: FlanHairLine(),
                  bottom: FlanHairLine(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onCascadeChange(int columnIndex) {
    dynamic cursor = <String, dynamic>{
      childrenKey: widget.columns,
    };
    final List<int> indexes = getIndexes();

    for (int i = 0; i <= columnIndex; i++) {
      cursor = cursor[childrenKey][indexes[i]];
    }

    while (cursor?[childrenKey] != null) {
      columnIndex++;
      setColumnValues(columnIndex, cursor[childrenKey] as List<dynamic>);
      cursor = cursor[childrenKey][cursor['defaultIndex'] ?? 0];
    }
  }

  List<dynamic> getValues() => children
      .map<dynamic>((GlobalKey<_FlanPickerColumnState> child) =>
          child.currentState!.getValue())
      .toList();

  void setValues(List<String> values) {
    for (int index = 0; index < values.length; index++) {
      final String value = values[index];
      setColumnValue(index, value);
    }
  }

  List<int> getIndexes() => children
      .map<int>((GlobalKey<_FlanPickerColumnState> child) =>
          child.currentState!.index)
      .toList();

  void setIndexes(List<int> indexes) {
    for (int columnIndex = 0; columnIndex < indexes.length; columnIndex++) {
      final int optionIndex = indexes[columnIndex];
      setColumnIndex(columnIndex, optionIndex);
    }
  }

  // get column instance by index
  _FlanPickerColumnState? getChild(int index) =>
      children.length > index ? children[index].currentState : null;

  // get column value by index
  dynamic getColumnValue(int index) {
    final _FlanPickerColumnState? column = getChild(index);
    if (column != null) {
      return column.getValue();
    }
  }

  // set column value by index
  void setColumnValue(int index, String value) {
    final _FlanPickerColumnState? column = getChild(index);
    if (column != null) {
      column.setValue(value);
      if (dataType == FlanPickerDataType.cascade) {
        onCascadeChange(index);
      }
    }
  }

  // get column option index by column index
  int? getColumnIndex(int index) {
    final _FlanPickerColumnState? column = getChild(index);
    if (column != null) {
      return column.index;
    }
    return null;
  }

  // set column option index by column index
  void setColumnIndex(int columnIndex, int optionIndex) {
    final _FlanPickerColumnState? column = getChild(columnIndex);

    if (column != null) {
      column.setIndex(optionIndex, jumpToIndex: true);
      if (dataType == FlanPickerDataType.cascade) {
        onCascadeChange(columnIndex);
      }
    }
  }

  // get options of column by index
  dynamic getColumnValues(int index) {
    final _FlanPickerColumnState? column = getChild(index);
    if (column != null) {
      return column.options;
    }
  }

  // set options of column by index
  void setColumnValues(int index, List<dynamic> options) {
    final _FlanPickerColumnState? column = getChild(index);
    if (column != null) {
      column.setOptions(options);
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
    properties.add(DiagnosticsProperty<FlanPickerFieldNames>(
        'columnsFieldNames', widget.columnsFieldNames));
    properties.add(DiagnosticsProperty<List<dynamic>>('columns', widget.columns,
        defaultValue: const <dynamic>[]));
    properties.add(DiagnosticsProperty<int>('defaultIndex', widget.defaultIndex,
        defaultValue: 0));
    properties.add(DiagnosticsProperty<FlanPickerToolbarPosition>(
        'toolbarPosition', widget.toolbarPosition,
        defaultValue: FlanPickerToolbarPosition.top));
    properties.add(DiagnosticsProperty<String>('valueKey', widget.valueKey,
        defaultValue: 'text'));

    super.debugFillProperties(properties);
  }
}

enum FlanPickerDataType {
  cascade,
  object,
  plain,
}

class FlanPickerColumn extends StatefulWidget {
  const FlanPickerColumn({
    Key? key,
    this.readonly = false,
    required this.dataType,
    // this.allowHtml = false,
    required this.textKey,
    required this.itemHeight,
    // required this.swipDuration,
    required this.visibleItemCount,
    this.defaultIndex = 0,
    this.initialOptions = const <dynamic>[],
    required this.onChange,
    this.optionBuilder,
  }) : super(key: key);

  // ****************** Props ******************
  final bool readonly;
  final FlanPickerDataType dataType;

  // final bool allowHtml;
  final String textKey;
  final double itemHeight;
  // final Duration swipDuration;

  final int visibleItemCount;
  final int defaultIndex;
  final List<dynamic> initialOptions;

  // ****************** Events ******************
  final ValueChanged<int> onChange;

  // ****************** Slots ******************
  final Widget Function(dynamic)? optionBuilder;

  @override
  _FlanPickerColumnState createState() => _FlanPickerColumnState();
}

class _FlanPickerColumnState extends State<FlanPickerColumn> {
  late ScrollController scrollController;

  bool moving = false;

  late int index;
  late List<dynamic> options;
  VoidCallback? transitionEndTrigger;

  @override
  void initState() {
    options = widget.initialOptions.toList();
    index = adjustIndex(widget.defaultIndex);
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      _jumpToIndex(index);
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanPickerColumn oldWidget) {
    if (widget.initialOptions != oldWidget.initialOptions) {
      setOptions(widget.initialOptions);
    }
    if (widget.defaultIndex != oldWidget.defaultIndex) {
      setIndex(widget.defaultIndex, jumpToIndex: true);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: ThemeVars.pickerOptionFontSize,
        color: ThemeVars.pickerOptionTextColor,
      ),
      child: NotificationListener<ScrollStartNotification>(
        onNotification: (ScrollStartNotification notification) {
          moving = true;
          return true;
        },
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (ScrollEndNotification notification) {
            setIndex(
              getIndexByOffset(
                scrollController.position.pixels,
                widget.itemHeight,
              ).round(),
              emitChange: true,
            );

            stopMomentum();
            return true;
          },
          child: CustomScrollView(
            controller: scrollController,
            physics: _PickerScrollPhysics(
              itemDimension: widget.itemHeight,
              adjustIndex: adjustIndex,
            ),
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical:
                      widget.itemHeight * (widget.visibleItemCount - 1) / 2.0,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    _buildOption,
                    childCount: options.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, int index) {
    final dynamic option = options[index];
    final String text = getOptionText(option);
    final bool disabled = isOptionDisabled(option);
    return IgnorePointer(
      ignoring: disabled,
      child: MouseRegion(
        cursor:
            disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.grab,
        child: GestureDetector(
          onTap: () => onClickItem(index),
          child: Opacity(
            opacity: disabled ? ThemeVars.pickerOptionDisabledOpacity : 1.0,
            child: Container(
              width: double.infinity,
              height: widget.itemHeight,
              color: Colors.transparent,
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(horizontal: ThemeVars.paddingBase),
              child: widget.optionBuilder != null
                  ? widget.optionBuilder!(option)
                  : Text(text),
            ),
          ),
        ),
      ),
    );
  }

  int get count => options.length;
  double get baseOffset =>
      widget.itemHeight * (widget.visibleItemCount - 1) / 2.0;

  int adjustIndex(int index) {
    index = range(index, 0, count) as int;

    for (int i = index; i < count; i++) {
      if (!isOptionDisabled(options[i])) {
        return i;
      }
    }
    for (int i = index - 1; i >= 0; i--) {
      if (!isOptionDisabled(options[i])) {
        return i;
      }
    }
    return 0;
  }

  void onClickItem(int index) {
    if (moving || widget.readonly) {
      return;
    }
    scrollController.animateTo(
      widget.itemHeight * index,
      duration: DEFAULT_DURATION,
      curve: Curves.linear,
    );
    // setIndex(index, emitChange: true);
  }

  String getOptionText(dynamic option) {
    if (option is Map && option[widget.textKey] != null) {
      return option[widget.textKey] as String;
    }

    return option as String;
  }

  void setIndex(
    int index, {
    bool emitChange = false,
    bool jumpToIndex = false,
  }) {
    index = adjustIndex(index);

    // final double offset = index * widget.itemHeight;
    void trigger() {
      if (index != this.index) {
        this.index = index;
        if (emitChange) {
          widget.onChange(index);
        }
        // setState(() {});
      }
    }

    // if (offset != scrollController.position.pixels) {
    if (moving) {
      transitionEndTrigger = trigger;
    } else {
      trigger();
    }
    // }

    if (jumpToIndex) {
      _jumpToIndex(index);
    }

    // return index;
    // setState(() {});
  }

  void _jumpToIndex(int index) {
    scrollController.jumpTo(widget.itemHeight * index);
  }

  dynamic getValue() => options.length > index ? options[index] : null;
  void setValue(String value) {
    for (int i = 0; i < options.length; i++) {
      if (getOptionText(options[i]) == value) {
        setIndex(i, jumpToIndex: true);
        return;
      }
    }
  }

  void setOptions(List<dynamic> options) {
    if (jsonEncode(options) != jsonEncode(this.options)) {
      this.options = options;
      final int index = widget.dataType == FlanPickerDataType.cascade
          ? widget.defaultIndex
          : this.index;
      setIndex(index, jumpToIndex: true);
    }
  }

  void stopMomentum() {
    moving = false;
    if (transitionEndTrigger != null) {
      transitionEndTrigger!();
      transitionEndTrigger = null;
    }
  }
}

enum FlanPickerToolbarPosition {
  top,
  bottom,
}

class FlanPickerFieldNames {
  const FlanPickerFieldNames({
    this.text,
    this.values,
    this.children,
  });
  final String? text;
  final String? values;
  final String? children;
}

class _TitleButton extends StatefulWidget {
  const _TitleButton({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;

  @override
  __TitleButtonState createState() => __TitleButtonState();
}

class __TitleButtonState extends State<_TitleButton> {
  bool active = false;

  void onTouchEnd() {
    setState(() => active = false);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          setState(() => active = true);
        },
        onTapCancel: onTouchEnd,
        onTapUp: (TapUpDetails details) {
          onTouchEnd();
        },
        onTap: widget.onTap,
        child: Opacity(
          opacity: active ? ThemeVars.activeOpacity : 1.0,
          child: Container(
            height: ThemeVars.pickerToolbarHeight,
            padding: ThemeVars.pickerActionPadding,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class _PickerScrollPhysics extends ScrollPhysics {
  const _PickerScrollPhysics({
    required this.itemDimension,
    required this.adjustIndex,
    ScrollPhysics? parent,
  }) : super(parent: parent);

  final double itemDimension;
  final int Function(int index) adjustIndex;

  @override
  _PickerScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _PickerScrollPhysics(
      itemDimension: itemDimension,
      adjustIndex: adjustIndex,
      parent: buildParent(ancestor),
    );
  }

  double _getTargetPixels(
      ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page =
        getIndexByOffset(position.pixels + velocity * 0.08, itemDimension)
            .toDouble();

    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return adjustIndex(page.round()) * itemDimension;
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return null;
  }

  @override
  double? get dragStartDistanceMotionThreshold => MOMENTUM_LIMIT_DISTANCE;
}
