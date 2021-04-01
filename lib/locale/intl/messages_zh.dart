// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

// 📦 Package imports:
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static m0(year, month) => "${year}年${month}月";

  static m1(maxRange) => "选择天数不能超过 ${maxRange} 天";

  static m2(count) => "${count}张可用";

  static m3(condition) => "满${condition}元可用";

  static m4(discount) => "${discount}折";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "AddressEditDetail_label" : MessageLookupByLibrary.simpleMessage("详细地址"),
    "AddressEditDetail_placeholder" : MessageLookupByLibrary.simpleMessage("街道门牌、楼层房间号等信息"),
    "AddressList_add" : MessageLookupByLibrary.simpleMessage("新增地址"),
    "Calendar_end" : MessageLookupByLibrary.simpleMessage("结束"),
    "Calendar_monthTitle" : m0,
    "Calendar_rangePrompt" : m1,
    "Calendar_start" : MessageLookupByLibrary.simpleMessage("开始"),
    "Calendar_startEnd" : MessageLookupByLibrary.simpleMessage("开始/结束"),
    "Calendar_title" : MessageLookupByLibrary.simpleMessage("日期选择"),
    "Calendar_weekdays_Fri" : MessageLookupByLibrary.simpleMessage("五"),
    "Calendar_weekdays_Mon" : MessageLookupByLibrary.simpleMessage("一"),
    "Calendar_weekdays_Sat" : MessageLookupByLibrary.simpleMessage("六"),
    "Calendar_weekdays_Sun" : MessageLookupByLibrary.simpleMessage("日"),
    "Calendar_weekdays_Thu" : MessageLookupByLibrary.simpleMessage("四"),
    "Calendar_weekdays_Tue" : MessageLookupByLibrary.simpleMessage("二"),
    "Calendar_weekdays_Wed" : MessageLookupByLibrary.simpleMessage("三"),
    "Cascader_select" : MessageLookupByLibrary.simpleMessage("请选择"),
    "ContactCard_addText" : MessageLookupByLibrary.simpleMessage("添加联系人"),
    "ContactList_addText" : MessageLookupByLibrary.simpleMessage("新建联系人"),
    "CouponCell_count" : m2,
    "CouponCell_tips" : MessageLookupByLibrary.simpleMessage("暂无可用"),
    "CouponCell_title" : MessageLookupByLibrary.simpleMessage("优惠券"),
    "CouponList_close" : MessageLookupByLibrary.simpleMessage("不使用优惠券"),
    "CouponList_disabled" : MessageLookupByLibrary.simpleMessage("不可用"),
    "CouponList_empty" : MessageLookupByLibrary.simpleMessage("暂无优惠券"),
    "CouponList_enable" : MessageLookupByLibrary.simpleMessage("可用"),
    "CouponList_exchange" : MessageLookupByLibrary.simpleMessage("兑换"),
    "CouponList_placeholder" : MessageLookupByLibrary.simpleMessage("请输入优惠码"),
    "Coupon_condition" : m3,
    "Coupon_discount" : m4,
    "Coupon_unlimited" : MessageLookupByLibrary.simpleMessage("无使用门槛"),
    "Pagination_next" : MessageLookupByLibrary.simpleMessage("下一页"),
    "Pagination_prev" : MessageLookupByLibrary.simpleMessage("上一页"),
    "PullRefresh_loosing" : MessageLookupByLibrary.simpleMessage("释放即可刷新..."),
    "PullRefresh_pulling" : MessageLookupByLibrary.simpleMessage("下拉即可刷新..."),
    "SubmitBar_label" : MessageLookupByLibrary.simpleMessage("合计："),
    "cancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "complete" : MessageLookupByLibrary.simpleMessage("完成"),
    "confirm" : MessageLookupByLibrary.simpleMessage("确认"),
    "confirmDelete" : MessageLookupByLibrary.simpleMessage("确定要删除吗"),
    "delete" : MessageLookupByLibrary.simpleMessage("删除"),
    "loading" : MessageLookupByLibrary.simpleMessage("加载中..."),
    "name" : MessageLookupByLibrary.simpleMessage("姓名"),
    "nameEmpty" : MessageLookupByLibrary.simpleMessage("请填写姓名"),
    "nameInvalid" : MessageLookupByLibrary.simpleMessage("请输入正确的姓名"),
    "save" : MessageLookupByLibrary.simpleMessage("保存"),
    "tel" : MessageLookupByLibrary.simpleMessage("电话"),
    "telEmpty" : MessageLookupByLibrary.simpleMessage("请填写电话"),
    "telInvalid" : MessageLookupByLibrary.simpleMessage("请输入正确的手机号")
  };
}
