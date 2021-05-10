// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/utils/widget.dart';
import 'picker.dart';

const String kEmptyCode = '000000';

bool kIsOverseaCode(String code) => code.isNotEmpty && code[0] == '9';

class FlanArea extends StatefulWidget {
  const FlanArea({
    Key? key,
    this.value,
    this.areaList = const <String, Map<String, String>>{},
    this.columnsNum = 3,
    this.isOverseaCode,
    this.columnsPlaceholder = const <String>[],
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
    this.onConfirm,
    this.onCancel,
    this.onChange,
    this.titleSlot,
    this.columnsTopSlot,
    this.columnsBottomSlot,
  }) : super(key: key);

  // ****************** Props ******************
  /// 当前选中项对应的地区码
  final String? value;

  /// 省市区数据，格式见下方
  final Map<String, Map<String, String>> areaList;

  /// 显示列数，3-省市区，2-省市，1-省
  final int columnsNum;

  /// 根据地区码校验海外地址，海外地址会划分至单独的分类
  final bool Function(String code)? isOverseaCode;

  /// 列占位提示文字
  final List<String> columnsPlaceholder;

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

  // ****************** Events ******************
  /// 点击右上方完成按钮
  final void Function(dynamic values, dynamic index)? onConfirm;

  /// 点击取消按钮时
  final VoidCallback? onCancel;

  /// 选项改变时触发
  final void Function(dynamic values, dynamic index)? onChange;

  // ****************** Slots ******************
  /// 自定义标题内容
  final Widget? titleSlot;

  /// 自定义选项上方内容
  final Widget? columnsTopSlot;

  /// 自定义选项下方内容
  final Widget? columnsBottomSlot;

  @override
  _FlanAreaState createState() => _FlanAreaState();
}

class _FlanAreaState extends State<FlanArea> {
  String? code;
  List<Map<String, dynamic>> columns = <Map<String, dynamic>>[
    <String, dynamic>{
      'values': <String>[],
    },
    <String, dynamic>{
      'values': <String>[],
    },
    <String, dynamic>{
      'values': <String>[],
    }
  ];

  GlobalKey<FlanPickerState> pickerRef = GlobalKey();

  @override
  void initState() {
    nextTick(() {
      setValues();
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FlanArea oldWidget) {
    if (widget.value != oldWidget.value) {
      code = widget.value;
      setValues();
    }

    if (widget.areaList != oldWidget.areaList) {
      setValues();
    }
    if (widget.columnsNum != oldWidget.columnsNum) {
      setValues();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> columns =
        this.columns.sublist(0, widget.columnsNum);
    return FlanPicker(
      key: pickerRef,
      titleSlot: widget.titleSlot,
      columnsTopSlot: widget.columnsTopSlot,
      columnsBottomSlot: widget.columnsBottomSlot,
      columns: columns,
      valueKey: 'name',
      onChange: onChange,
      onConfirm: onConfirm,
      title: widget.title,
      loading: widget.loading,
      readonly: widget.readonly,
      itemHeight: widget.itemHeight,
      visibleItemCount: widget.visibleItemCount,
      cancelButtonText: widget.cancelButtonText,
      confirmButtonText: widget.confirmButtonText,
    );
  }

  Map<String, Map<String, String>> get areaList {
    return <String, Map<String, String>>{
      'province': widget.areaList['province_list'] ?? <String, String>{},
      'city': widget.areaList['city_list'] ?? <String, String>{},
      'county': widget.areaList['county_list'] ?? <String, String>{},
    };
  }

  Map<String, String> get placeholderMap {
    return <String, String>{
      'province': widget.columnsPlaceholder.isNotEmpty
          ? widget.columnsPlaceholder[0]
          : '',
      'city': widget.columnsPlaceholder.length > 1
          ? widget.columnsPlaceholder[1]
          : '',
      'county': widget.columnsPlaceholder.length > 2
          ? widget.columnsPlaceholder[2]
          : '',
    };
  }

  String getDefaultCode() {
    if (widget.columnsPlaceholder.isNotEmpty) {
      return kEmptyCode;
    }

    final List<String>? countyCodes = areaList['county']?.keys.toList();

    if (countyCodes != null && countyCodes.isNotEmpty) {
      return countyCodes[0];
    }
    final List<String>? cityCodes = areaList['city']?.keys.toList();
    if (cityCodes != null && cityCodes.isNotEmpty) {
      return cityCodes[0];
    }
    return '';
  }

  List<Map<String, String>> getColumnValues(String type, {String code = ''}) {
    List<Map<String, String>> column = <Map<String, String>>[];

    if (type != 'province' && code.isEmpty) {
      return column;
    }
    final Map<String, String> list = areaList[type]!;
    column = list.keys
        .map((String listCode) => <String, String>{
              'code': listCode,
              'name': list[listCode] ?? '',
            })
        .toList();
    if (code.isNotEmpty) {
      if (type == 'city' && isOverseaCode(code)) {
        code = '9';
      }
      column = column
          .where((Map<String, String> item) => item['code']?.indexOf(code) == 0)
          .toList();
    }

    if (placeholderMap[type] != null &&
        placeholderMap[type]!.isNotEmpty &&
        column.isNotEmpty) {
      String codeFill = '';
      if (type == 'city') {
        codeFill = kEmptyCode.substring(2, 4);
      } else if (type == 'county') {
        codeFill = kEmptyCode.substring(4, 6);
      }
      column.insert(0, <String, String>{
        'code': code + codeFill,
        'name': placeholderMap[type] ?? '',
      });
    }
    return column;
  }

  int getIndex(String type, String code) {
    int compareNum = code.length;
    if (type == 'province') {
      compareNum = isOverseaCode(code) ? 1 : 2;
    }
    if (type == 'city') {
      compareNum = 4;
    }

    code = code.length >= compareNum ? code.substring(0, compareNum) : '';
    final List<Map<String, String>> list = getColumnValues(type,
        code: compareNum > 2 && code.length >= compareNum - 2
            ? code.substring(0, compareNum - 2)
            : '');
    for (int i = 0; i < list.length; i++) {
      final String? item = list[i]['code'];
      if (item != null &&
          ((item.length >= compareNum ? item.substring(0, compareNum) : '') ==
              code)) {
        return i;
      }
    }
    return 0;
  }

  void setValues() {
    String code = this.code ?? getDefaultCode();

    final FlanPickerState? picker = pickerRef.currentState;
    final List<Map<String, String>> province = getColumnValues('province');

    final List<Map<String, String>> city = getColumnValues('city',
        code: code.length >= 2 ? code.substring(0, 2) : '');
    if (picker == null) {
      return;
    }

    picker.setColumnValues(0, province);
    picker.setColumnValues(1, city);
    if (city.isNotEmpty &&
        ((code.length >= 4 ? code.substring(2, 4) : '') == '00') &&
        !isOverseaCode(code)) {
      code = city[0]['code']!;
    }
    picker.setColumnValues(
        2,
        getColumnValues('county',
            code: code.length >= 4 ? code.substring(0, 4) : ''));

    picker.setIndexes(<int>[
      getIndex('province', code),
      getIndex('city', code),
      getIndex('county', code),
    ]);
    setState(() {});
  }

  // parse output columns data
  List<Map<String, String>> parseValues(List<Map<String, String>> values) {
    return List<Map<String, String>>.generate(values.length, (int index) {
      Map<String, String> value = values[index];

      value = <String, String>{
        'code': value['code'] ?? '',
        'name': value['name'] ?? '',
      };

      if (value['code']!.isNotEmpty ||
          value['name'] == widget.columnsPlaceholder[index]) {
        value['code'] = '';
        value['namae'] = '';
      }

      return value;
    });
  }

  List<Map<String, String>> getValues() {
    if (pickerRef.currentState != null) {
      final List<Map<String, String>> values =
          pickerRef.currentState?.getValues() as List<Map<String, String>>;
      return parseValues(values);
    }
    return <Map<String, String>>[];
  }

  Map<String, String> getArea() {
    final List<Map<String, String>> values = getValues();
    final Map<String, String> area = <String, String>{
      'code': '',
      'country': '',
      'province': '',
      'city': '',
      'county': '',
    };

    if (values.isEmpty) {
      return area;
    }

    final List<String> names =
        values.map((Map<String, String> item) => item['name'] ?? '').toList();
    final List<Map<String, String>> validValues = values
        .where((Map<String, String> value) => value['code']!.isNotEmpty)
        .toList();

    area['code'] = validValues.isNotEmpty
        ? validValues[validValues.length - 1]['code']!
        : '';

    if (isOverseaCode(area['code']!)) {
      area['country'] = names.length > 1 ? names[1] : '';
      area['province'] = names.length > 2 ? names[2] : '';
    } else {
      area['province'] = names.isNotEmpty ? names[0] : '';
      area['city'] = names.length > 1 ? names[1] : '';
      area['county'] = names.length > 2 ? names[2] : '';
    }

    return area;
  }

  void reset({String newCode = ''}) {
    code = newCode;
    setValues();
  }

  void onChange(dynamic values, dynamic index) {
    code = (values[index as int] as Map<String, String>)['code'];
    setValues();
    // final List<Map<String, String>> parsedValues = parseValues(
    //     pickerRef.currentState!.getValues() as List<Map<String, String>>);
    // if (widget.onChange != null) {
    //   widget.onChange!(parsedValues, index);
    // }
  }

  void onConfirm(dynamic values, dynamic index) {
    setValues();
    // emit('confirm', parseValues(values), index);
    if (widget.onConfirm != null) {
      widget.onConfirm!(
          parseValues(values as List<Map<String, String>>), index);
    }
  }

  bool Function(String code) get isOverseaCode =>
      widget.isOverseaCode ?? kIsOverseaCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('value', widget.value));
    properties.add(DiagnosticsProperty<Map<String, Map<String, String>>>(
        'areaList', widget.areaList,
        defaultValue: const <String, Map<String, String>>{}));
    properties.add(DiagnosticsProperty<int>('columnsNum', widget.columnsNum,
        defaultValue: 3));

    properties.add(DiagnosticsProperty<bool Function(String code)>(
        'isOverseaCode', widget.isOverseaCode));

    properties.add(DiagnosticsProperty<List<String?>>(
        'columnsPlaceholder', widget.columnsPlaceholder,
        defaultValue: const <String>[]));

    properties.add(DiagnosticsProperty<String>('value', widget.value));
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
    super.debugFillProperties(properties);
  }
}
